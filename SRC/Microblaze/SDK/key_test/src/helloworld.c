/***************************** Include Files *********************************/
#include <stdio.h>
#include "xparameters.h"
#include "xgpio.h"
#include "platform.h"

/************************** Variable Defintions ******************************/
XGpio Gpio_leds;
XGpio Gpio_keys;

int main()
{
	 int Status;
	 int i;
	 u32 Delay;
	 u32 DataRead;

	 init_platform();

	 Status = XGpio_Initialize(&Gpio_keys, XPAR_KEY_4B_DEVICE_ID);
	 if (Status != XST_SUCCESS) {
		  return XST_FAILURE;
	 }

	 XGpio_SetDataDirection(&Gpio_keys, 1, 0xFFFFFFFF);    //set Gpio_keys is input

	 Status = XGpio_Initialize(&Gpio_leds, XPAR_LED_4B_DEVICE_ID);
	 if (Status != XST_SUCCESS) {
		  return XST_FAILURE;
	 }

	 XGpio_SetDataDirection(&Gpio_leds, 1, 0x0);         //set Gpio_leds is output

 while(1)
  {
	 DataRead = XGpio_DiscreteRead(&Gpio_keys, 1);

	 if((DataRead & 0x0f)!=0x0f){                      //if key is pushed
		for (Delay = 0; Delay < 2000; Delay++);
		DataRead = XGpio_DiscreteRead(&Gpio_keys, 1);  //read again
	 	if((DataRead & 0x0f)!=0x0f)
	 	{
 	 	      XGpio_DiscreteWrite(&Gpio_leds, 1, DataRead);
	 	}
	 }
	 else{                                             //if key is not pushed
			for (Delay = 0; Delay < 2000; Delay++);
			DataRead = XGpio_DiscreteRead(&Gpio_keys, 1);  //read again
		 	if((DataRead & 0x0f)==0x0f)
		 	{
	 	 	      XGpio_DiscreteWrite(&Gpio_leds, 1, DataRead);
		 	}
	 }
  }
    return 0;
}

