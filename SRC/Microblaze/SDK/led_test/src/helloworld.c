
/***************************** Include Files *********************************/
#include "xparameters.h"
#include "xgpio.h"
#include "platform.h"

/************************** Variable Defintions ******************************/
/* Instance For GPIO */
XGpio GpioOutput;

int main(void)
{
  Xuint32 Delay;
  Xuint32 Ledwidth;

  XGpio_Initialize(&GpioOutput, XPAR_LED_4B_DEVICE_ID);   //initialize GPIO IP
  XGpio_SetDataDirection(&GpioOutput, 1, 0x0);            //set GPIO as output
  XGpio_DiscreteWrite(&GpioOutput, 1, 0x0);               //set GPIO output value to 0

  while (1)
  {
      for (Ledwidth = 0x0; Ledwidth < 4; Ledwidth++)
      {
            XGpio_DiscreteWrite(&GpioOutput, 1, 1 << Ledwidth);
            for (Delay = 0; Delay < 3000000; Delay++);
            XGpio_DiscreteClear(&GpioOutput, 1, 1 << Ledwidth);
      }
  }
}

