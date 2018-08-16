
/***************************** Include Files *********************************/
#include "xparameters.h"
#include "xgpio.h"
#include "xintc.h"
#include "xtmrctr.h"
#include "mb_interface.h"
#include "platform.h"

/************************** Constant Definitions *****************************/
unsigned int count = 0;
XGpio GpioOutput;

/************************** interrupt handler process****************************/
void timer_int_handler(void * baseaddr_p)
{
	unsigned int csr;

	csr = XTmrCtr_GetControlStatusReg(XPAR_AXI_TIMER_0_BASEADDR,0);	// read control/status register

	if(csr &XTC_CSR_INT_OCCURED_MASK)      // if interrupt is occurred
	{
		count++;
	}
	XTmrCtr_SetControlStatusReg(XPAR_AXI_TIMER_0_BASEADDR,0, csr);   //clear interrupt indication
}

int main()
{
	init_platform();

	XIntc_RegisterHandler(XPAR_INTC_0_BASEADDR,      //register timer0 interrupt and handler process
			              XPAR_AXI_INTC_0_AXI_TIMER_0_INTERRUPT_INTR,
			              (XInterruptHandler) timer_int_handler,
			              (void *)XPAR_AXI_TIMER_0_BASEADDR);

	microblaze_enable_interrupts();             //enable microblaze interrupt

	XIntc_MasterEnable(XPAR_INTC_0_BASEADDR);                                      //enable interrupt 0
	XIntc_EnableIntr(XPAR_INTC_0_BASEADDR, XPAR_AXI_TIMER_0_INTERRUPT_MASK);    //enable timer0 interrupt

	XTmrCtr_SetLoadReg(XPAR_AXI_TIMER_0_BASEADDR, 0, 50000000);      //set timer0 reload value

	XTmrCtr_EnableIntr(XPAR_AXI_TIMER_0_BASEADDR, 0);       //enable timer0 generate interrupt signal

	//set timer0 work mode and start counter
	XTmrCtr_SetControlStatusReg(XPAR_AXI_TIMER_0_BASEADDR, 0, XTC_CSR_ENABLE_TMR_MASK |
			                                             XTC_CSR_ENABLE_INT_MASK |
	                                                	 XTC_CSR_AUTO_RELOAD_MASK |
	                                                	 XTC_CSR_DOWN_COUNT_MASK);

	XGpio_Initialize(&GpioOutput, XPAR_LED_4B_DEVICE_ID);
	XGpio_SetDataDirection(&GpioOutput, 1, 0x0);

	while(1)
	{
		XGpio_DiscreteWrite(&GpioOutput,1,count);    //display the value on the led
		if(count==16)
			count=0;
	}
	return 0;
}

