
/***************************** Include Files *********************************/

#include "xparameters.h"	/* EDK generated parameters */
#include "xintc.h"		/* Interrupt controller device driver */
#include "xspi.h"		/* SPI device driver */
#include "xil_exception.h"
#include "sd_header.h"

/************************** Constant Definitions *****************************/

/*
 * The following constants map to the XPAR parameters created in the
 * xparameters.h file. They are defined here such that a user can easily
 * change all the needed parameters in one place.
 */
#define SPI_DEVICE_ID		XPAR_SPI_SD_DEVICE_ID
#define INTC_DEVICE_ID		XPAR_INTC_0_DEVICE_ID
#define SPI_IRPT_INTR		XPAR_INTC_0_SPI_1_VEC_ID

/*
 * The following constant defines the slave select signal that is used to
 * to select the Flash device on the SPI bus, this signal is typically
 * connected to the chip select of the device.
 */
#define SD_SPI_SELECT 0x01

/************************** Constant Definitions ******************************/
#define BlockAdress 2

/************************** Function Prototypes *******************************/
static int SpiSetupIntrSystem(XIntc *IntcInstancePtr, XSpi *SpiInstancePtr,
					 u16 SpiIntrId);
void SpiIntrHandler(void *CallBackRef, u32 StatusEvent, u32 ByteCount);
int Do_SD_Initialize();
void SPI_CS_Assert(XSpi *InstancePtr);
void SPI_CS_Disassert(XSpi *InstancePtr);
void SD_Delay(char number);
int SD_Read_Block(u32 blockaddr, unsigned char *data);
int SD_Write_Block(u32 blockaddr, unsigned char *data);
int SD_Send_Command(unsigned char cmd, unsigned char response_type,
        unsigned char *response, unsigned char *argument,unsigned char CRC);
int SPI_Send_Byte(XSpi *InstancePtr, unsigned char input);
unsigned char SPI_Rcv_Byte(XSpi *InstancePtr);

int Spi_setup(XIntc *IntcInstancePtr, XSpi *SpiInstancePtr,
			u16 SpiDeviceId, u16 SpiIntrId);


/************************** Variable Definitions *****************************/

/*
 * The instances to support the device drivers are global such that they
 * are initialized to zero each time the program runs. They could be local
 * but should at least be static so they are zeroed.
 */
static XIntc IntcInstance;	 /* The instance of the Interrupt Controller */
static XSpi  SpiInstance;	 /* The instance of the SPI device */

/*
 * The following variables are shared between non-interrupt processing and
 * interrupt processing such that they must be global.
 */
volatile static int TransferInProgress;

/*
 * The following variable tracks any errors that occur during interrupt
 * processing
 */
int Error;

/*
 * Buffers used during read and write transactions.
 */
u8 ReadBuffer[512];
u8 WriteBuffer[512];
static unsigned char SD_rd_data[512];
static unsigned char SD_wr_data[512];
static unsigned char response[5];
static unsigned char argument[4];

int main()
{
    int j,ok;

	int Status;

	Status = Spi_setup(&IntcInstance,
				&SpiInstance,
				SPI_DEVICE_ID,
				SPI_IRPT_INTR);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

    ok=0;
    for (j =0; j < 50 && ok != 1; j++)
    {
    	ok = Do_SD_Initialize ();
  	  if (ok == 1)
  		   print("---SD card initial sucessed---\n\r");

    }

	for (j=0; j<512; j++)
	{
		SD_wr_data[j] = j;
		SD_rd_data[j] = 0;
	}

	ok = SD_Write_Block (BlockAdress, SD_wr_data);
	ok = SD_Read_Block (BlockAdress, SD_rd_data);

	for (j=0; j<512; j++)
	{
		if (SD_rd_data[j] != SD_wr_data[j])
			return XST_FAILURE;
	}
	print("---SD card read/write sucessed---\n\r");

	return XST_SUCCESS;

}



/*****************************************************************************/
/**
*
* This function does a minimal test on the Spi device and driver as a
* design example. The purpose of this function is to illustrate how to use
* the XSpi component using the interrupt mode.
*
* This function sends data and expects to receive the same data.
*
*
* @param	IntcInstancePtr is a pointer to the instance of the INTC
* 		component.
* @param	SpiInstancePtr is a pointer to the instance of Spi component.
* @param	SpiDeviceId is the Device ID of the Spi Device and is the
*		XPAR_<SPI_instance>_DEVICE_ID value from xparameters.h.
* @param	SpiIntrId is the interrupt Id and is typically
*		XPAR_<INTC_instance>_<SPI_instance>_VEC_ID value from
*		xparameters.h .
*
* @return	XST_SUCCESS if successful, otherwise XST_FAILURE.
*
* @note
*
* This function contains an infinite loop such that if interrupts are not
* working it may never return.
*
******************************************************************************/
int Spi_setup(XIntc *IntcInstancePtr, XSpi *SpiInstancePtr,
			u16 SpiDeviceId, u16 SpiIntrId)
{
	int Status;
	u32 Count;
	u8 Test;
	XSpi_Config *ConfigPtr;	/* Pointer to Configuration data */

	/*
	 * Initialize the SPI driver so that it is  ready to use.
	 */
	ConfigPtr = XSpi_LookupConfig(SpiDeviceId);
	if (ConfigPtr == NULL) {
		return XST_DEVICE_NOT_FOUND;
	}

	Status = XSpi_CfgInitialize(SpiInstancePtr, ConfigPtr,
				  ConfigPtr->BaseAddress);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/*
	 * Perform a self-test to ensure that the hardware was built correctly.
	 */
	Status = XSpi_SelfTest(SpiInstancePtr);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/*
	 * Run loopback test only in case of standard SPI mode.
	 */
	if (SpiInstancePtr->SpiMode != XSP_STANDARD_MODE) {
		return XST_SUCCESS;
	}

	/*
	 * Connect the Spi device to the interrupt subsystem such that
	 * interrupts can occur. This function is application specific.
	 */
	Status = SpiSetupIntrSystem(IntcInstancePtr,
					SpiInstancePtr,
				 	SpiIntrId);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/*
	 * Setup the handler for the SPI that will be called from the interrupt
	 * context when an SPI status occurs, specify a pointer to the SPI
	 * driver instance as the callback reference so the handler is able to
	 * access the instance data.
	 */
	XSpi_SetStatusHandler(SpiInstancePtr, SpiInstancePtr,
		 		(XSpi_StatusHandler) SpiIntrHandler);

	/*
	 * Set the Spi device as a master and in loopback mode.
	 */
	Status = XSpi_SetOptions(SpiInstancePtr, XSP_MASTER_OPTION |
			XSP_MANUAL_SSELECT_OPTION);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}


	/*
	 * Select the WINBOND Serial Flash device,  so that it can be
	 * read and written using the SPI bus.
	 */
	Status = XSpi_SetSlaveSelect(SpiInstancePtr, SD_SPI_SELECT);
	if(Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/*
	 * Start the SPI driver so that interrupts and the device are enabled.
	 */
	XSpi_Start(SpiInstancePtr);

	return XST_SUCCESS;
}


/*****************************************************************************/
/**
* This function does a initial for SD card through the SPI interface

* @param	sdc is the point of instruct sd_context_t
*
* @return	XST_SUCCESS if successful, XST_FAILURE if unsuccessful
*
* @note		None
*
****************************************************************************/
int Do_SD_Initialize()
{
	unsigned char i,j;
	int SD_type;

	/* pull CS to low for 200 clock*/
    SPI_CS_Assert(&SpiInstance);
	SD_Delay(200);
	/* Pull CS to High for 200 clock*/
    SPI_CS_Disassert(&SpiInstance);
	SD_Delay(200);


	for (i=0;i<4;i++)
	  argument[i] = 0;


	/* Send CMD0 to SD Card, put it to Idle state*/
	j = 0;
	do
	{
		j++;
		if (SD_Send_Command(CMD0, CMD0_R, response, argument, 0x95) == 0)
			return 0;

	}while ((response[0] & MSK_IDLE) != MSK_IDLE && j < SD_IDLE_WAIT_MAX);

	/* Send CMD8 to SD Card, CMD8 is only support by SD2.0 Card*/
	  argument[3] = 0;
	  argument[2] = 0;
	  argument[1] = 0x01;
	  argument[0] = 0xAA;
	do
	{
		j++;
		if (SD_Send_Command(CMD8, CMD8_R, response, argument, 0x87) == 0)
			return 0;

	}while ((response[4] & MSK_IDLE) != MSK_IDLE && j < SD_IDLE_WAIT_MAX);

	/*Check SD card is V2.0 standard or not*/
	if (response[4]  == 0x01)
	{
	   print("---SD card is V2.0 standard---\n\r");
	   SD_type = 1;
	}
	else
	{
		print("---SD card does not support V2.0 standard---\n\r");
		SD_type = 0;
	}

	/*send CMD55 and CMD41 until SD card initial success*/
	argument[3] = 0;
	argument[2] = 0;
	argument[1] = 0;
	argument[0] = 0;
	j = 0;
	do
	{
		j++;
		/* Flag the next command as an application-specific command */
		argument[3] = 0;
		if (SD_Send_Command(CMD55, CMD55_R, response, argument, 0xff) == 1)
		{
			/* Tell the card to send its OCR */
			if (SD_type == 1) {
			  argument[3] = 0x40;
			}
			SD_Send_Command(ACMD41, ACMD41_R, response, argument, 0xff);
		}
		else
		{
			/* No response, bail early */
			j = SD_IDLE_WAIT_MAX;
		}
	}while ((response[0] & MSK_IDLE) == MSK_IDLE );

	argument[3] = 0;
	argument[2] = 0;
	argument[1] = 0;
	argument[0] = 0;
	/*if time is over, initial is not success */
	if (j >= SD_IDLE_WAIT_MAX)
		return 0;
	/* send CMD58 to SD card, check SD card support 3.3V or not */
	if (SD_Send_Command(CMD58, CMD58_R, response, argument, 0xff) == 0)
		return 0;
	if ((response[2] & MSK_OCR_33) != MSK_OCR_33)
		return 0;
	/* Set the length of Block write and read */
	argument[3] = (unsigned char)(SD_BLOCKSIZE >> 24);
	argument[2] = (unsigned char)(SD_BLOCKSIZE >> 16);
	argument[1] = (unsigned char)(SD_BLOCKSIZE >> 8);
	argument[0] = (unsigned char)(SD_BLOCKSIZE);
	if (SD_Send_Command(CMD16, CMD16_R, response, argument,0xff) == 0)
		return 0;

	/*Initial is success*/
	return 1;

}


/*****************************************************************************/
/*
* SD card Block read: read a block data from SD
* @param	*sdc is the point of SD device
*		     blockaddr is block address will be read
*		     *data is point read data
*
******************************************************************************/

int SD_Read_Block(u32 blockaddr, unsigned char *data)
{
	unsigned long int i = 0;
	unsigned char tmp;

	/* set the block address: 1 Block = 512bytes */
	blockaddr <<= SD_BLOCKSIZE_NBITS;

	/* send single blcok read command CMD17*/
	argument[3] = (unsigned char)(blockaddr >> 24);
	argument[2] = (unsigned char)(blockaddr >> 16);
	argument[1] = (unsigned char)(blockaddr >> 8);
	argument[0] = (unsigned char)(blockaddr);
	if (SD_Send_Command(CMD17, CMD17_R, response, argument, 0xff) == 0)
		return 0;

	/* if first respond byte is not 0, return error */
	if (response[0] != 0)
		return 0;

	/* set CS low to continue read process */
	SPI_CS_Assert(&SpiInstance);

	/* waitting receive start token 0xfe */
	i=0;
	do
	{
		tmp = SPI_Rcv_Byte(&SpiInstance);
		i++;
	}while ((tmp != 0xFE) && i < 100 );

	/* Receive 512 byte from SD card*/
	for (i=0;i<512;i++)
	    data[i] = SPI_Rcv_Byte(&SpiInstance);

	/*Receive 2 byte CRC*/
	SPI_Send_Byte(&SpiInstance, 0xFF);
	SPI_Send_Byte(&SpiInstance, 0xff);

	return 1;
}
/*****************************************************************************/
/*
* SD card Block write: write a block data to SD
* @param	*sdc is the point of SD device
*		     blockaddr is block address will be written
*		     *data is point write data
* return
******************************************************************************/
int SD_Write_Block(u32 blockaddr, unsigned char *data)
{
	unsigned long int i = 0;
	unsigned char tmp;

	/* set the block address: Block = 512bytes */
	blockaddr <<= SD_BLOCKSIZE_NBITS;

	/*Send single Block Write command CMD24*/
	argument[3] = (unsigned char)(blockaddr >> 24);
	argument[2] = (unsigned char)(blockaddr >> 16);
	argument[1] = (unsigned char)(blockaddr >> 8);
	argument[0] = (unsigned char)(blockaddr);
	if (SD_Send_Command(CMD24, CMD24_R, response, argument, 0xff) == 0)
		return 0;

	/* if first respond byte is not 0, return error */
	if (response[0] != 0)
		return 0;

	/*set CS low to continue write process */
	SPI_CS_Assert(&SpiInstance);

	/*wait 8 clock before write block data to sd card */
	SPI_Rcv_Byte(&SpiInstance);

	/*send the data write token: 0xfe*/
	SPI_Send_Byte(&SpiInstance, 0xfe);

	/*write 512 byte data to SD card*/
	for (i=0; i<512; i++)
	{
		SPI_Send_Byte(&SpiInstance, data[i]);
	}

	/*send two byte CRC data*/
	SPI_Send_Byte(&SpiInstance, 0xff);
	SPI_Send_Byte(&SpiInstance, 0xff);

	/*wait SPI send is finish*/
	i=0;
	do
	{
		tmp = SPI_Rcv_Byte(&SpiInstance);
		i++;
	}while (tmp != 0xff);

	return 1;
}
/*****************************************************************************/
/*
* Send Command 0
*
******************************************************************************/
int SD_Send_Command(unsigned char cmd, unsigned char response_type,
        unsigned char *response, unsigned char *argument,unsigned char CRC)
{

		int i;
		char response_length;
		unsigned char tmp;

		/*set CS to low*/
		SPI_CS_Assert(&SpiInstance);

		/*send SD command, cmd[7:6]=01, cmd[5:0] is command  */
		SPI_Send_Byte(&SpiInstance, (cmd & 0x3F) | 0x40);

		/*send 4 bytes arguments */
		for (i=3; i>=0; i--)
		{
			SPI_Send_Byte(&SpiInstance, argument[i]);
		}
		/*send CRC*/
		SPI_Send_Byte(&SpiInstance,CRC);

		/*decide the response length*/
		response_length = 0;
		switch (response_type)
		{
			case R1:
			case R1B:
				response_length = 1;
				break;
			case R2:
				response_length = 2;
				break;
			case R3:
				response_length = 5;
				break;
			default:
				break;
		}

		do
		{
			tmp = SPI_Rcv_Byte(&SpiInstance);
			i++;
		}while (((tmp & 0x80) != 0) && i < SD_CMD_TIMEOUT); //receive response byte


		/* if time is out*/
		if (i >= SD_CMD_TIMEOUT)
		{
			SPI_CS_Assert(&SpiInstance);
			return 0;
		}

		/* receive other response bytes */
		for (i=response_length-1; i>=0; i--)
		{
			response[i] = tmp;
			tmp = SPI_Rcv_Byte(&SpiInstance);
		}
		/* if SD response is busy(R1B), wait until SPI bus is 0xff)*/
		i=0;
		if (response_type == R1B)
		{
			do
			{
				i++;
				tmp = SPI_Rcv_Byte(&SpiInstance);
			}while (tmp != 0xFF);
			SPI_Send_Byte(&SpiInstance, 0xFF);
		}

		/*set CS is high*/
		SPI_CS_Disassert(&SpiInstance);

		return 1;

}

/*****************************************************************************/
/**
* This function sends one byte to SD card through SPI
*
* @param	InstancePtr is the point of XSPI device
*		    input is the byte will send
*
* @return	XST_SUCCESS if successful, XST_FAILURE if unsuccessful
*
****************************************************************************/
int SPI_Send_Byte(XSpi *InstancePtr, unsigned char input)
{
	int Status;

	WriteBuffer[0] = input;
	Status = XSpi_Transfer(InstancePtr, WriteBuffer, ReadBuffer, 1);
	if(Status != XST_SUCCESS) {
		return 0;
	}
	while(TransferInProgress);
	if(Error != 0) {
		Error = 0;
			return 0;
	}


	return XST_SUCCESS;
}

/*****************************************************************************/
/*
* Receive a byte. Output an 0xFF (the bus idles high) to receive the byte
*
******************************************************************************/
unsigned char SPI_Rcv_Byte(XSpi *InstancePtr)
{
	int Status;
	u8 RxData;

	WriteBuffer[0] = 0xff;
	Status = XSpi_Transfer(InstancePtr, WriteBuffer, ReadBuffer, 1);
	if(Status != XST_SUCCESS) {
		return 0;
	}
	while(TransferInProgress);
	if(Error != 0) {
		Error = 0;
			return 0;
	}

	RxData = ReadBuffer[0];
	return RxData;
}


/*****************************************************************************/
/*
* Set the CS to Low
*
******************************************************************************/
void SPI_CS_Assert(XSpi *InstancePtr)
{

	XSpi_SetSlaveSelectReg(InstancePtr, 0);
}

/*****************************************************************************/
/*
* set the CS to high
*
******************************************************************************/
void SPI_CS_Disassert(XSpi *InstancePtr)
{

	XSpi_SetSlaveSelectReg(InstancePtr, 1);

}

/*****************************************************************************/
/*
* Wait number clock
*
******************************************************************************/
void SD_Delay(char number)
{
	char i;

	for (i=0; i<number; i++)
	{
		WriteBuffer[0]=0xff;
		XSpi_Transfer(&SpiInstance, WriteBuffer, ReadBuffer, 1);
		while(TransferInProgress);
		if(Error != 0) {
			Error = 0;
		}
	}
}


/*****************************************************************************/
/**
*
* This function is the handler which performs processing for the SPI driver.
* It is called from an interrupt context such that the amount of processing
* performed should be minimized. It is called when a transfer of SPI data
* completes or an error occurs.
*
* This handler provides an example of how to handle SPI interrupts and
* is application specific.
*
* @param	CallBackRef is the upper layer callback reference passed back
*		when the callback function is invoked.
* @param	StatusEvent is the event that just occurred.
* @param	ByteCount is the number of bytes transferred up until the event
*		occurred.
*
* @return	None.
*
* @note		None.
*
******************************************************************************/
void SpiIntrHandler(void *CallBackRef, u32 StatusEvent, u32 ByteCount)
{
	/*
	 * Indicate the transfer on the SPI bus is no longer in progress
	 * regardless of the status event.
	 */
	TransferInProgress = FALSE;

	/*
	 * If the event was not transfer done, then track it as an error.
	 */
	if (StatusEvent != XST_SPI_TRANSFER_DONE) {
		Error++;
	}
}

/*****************************************************************************/
/**
*
* This function setups the interrupt system such that interrupts can occur
* for the Spi device. This function is application specific since the actual
* system may or may not have an interrupt controller. The Spi device could be
* directly connected to a processor without an interrupt controller.  The
* user should modify this function to fit the application.
*
* @param	IntcInstancePtr is a pointer to the instance of the Intc device.
* @param	SpiInstancePtr is a pointer to the instance of the Spi device.
* @param	SpiIntrId is the interrupt Id and is typically
*		XPAR_<INTC_instance>_<SPI_instance>_VEC_ID value from
*		xparameters.h
*
* @return	XST_SUCCESS if successful, otherwise XST_FAILURE.
*
* @note		None
*
******************************************************************************/
static int SpiSetupIntrSystem(XIntc *IntcInstancePtr, XSpi *SpiInstancePtr,
					 u16 SpiIntrId)
{
	int Status;

#ifndef TESTAPP_GEN
	/*
	 * Initialize the interrupt controller driver so that it is ready to
	 * use.
	 */
	Status = XIntc_Initialize(IntcInstancePtr, INTC_DEVICE_ID);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}
#endif

	/*
	 * Connect a device driver handler that will be called when an interrupt
	 * for the device occurs, the device driver handler performs the
	 * specific interrupt processing for the device.
	 */
	Status = XIntc_Connect(IntcInstancePtr, SpiIntrId,
	 			(XInterruptHandler) XSpi_InterruptHandler,
				(void *)SpiInstancePtr);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

#ifndef TESTAPP_GEN
	/*
	 * Start the interrupt controller such that interrupts are enabled for
	 * all devices that cause interrupts, specific real mode so that
	 * the SPI can cause interrupts through the interrupt controller.
	 */
	Status = XIntc_Start(IntcInstancePtr, XIN_REAL_MODE);
	if (Status != XST_SUCCESS) {
 	   return XST_FAILURE;
	}
#endif

	/*
	 * Enable the interrupt for the SPI device.
	 */
	XIntc_Enable(IntcInstancePtr, SpiIntrId);

#ifndef TESTAPP_GEN


	/*
 	* Initialize the exception table.
	 */
	Xil_ExceptionInit();

	/*
	 * Register the interrupt controller handler with the exception table.
	 */
	Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_INT,
			 	(Xil_ExceptionHandler)
			 	XIntc_InterruptHandler,
			 	IntcInstancePtr);

	/*
	 * Enable non-critical exceptions.
	 */
	Xil_ExceptionEnable();



#endif /* TESTAPP_GEN */

	return XST_SUCCESS;
}
