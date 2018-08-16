/***************************** Include Files *********************************/

#include <stdio.h>
#include "xparameters.h"
#include "xuartlite_l.h"
#include "xuartlite.h"
#include "platform.h"

/* ------------------------------------------------------------ */
/*              main function                                   */
/* ------------------------------------------------------------ */

int main()
{
	unsigned char rxdb;
	unsigned char i;

	init_platform();

    while(1)
    {

        if(!XUartLite_IsReceiveEmpty(XPAR_UARTLITE_0_BASEADDR))   //check receiver buffer is empty or not
       {
        	for (i=100;i>0;i--);
        	rxdb = XUartLite_RecvByte(XPAR_UARTLITE_0_BASEADDR);    //receive one byte
        	for (i=100;i>0;i--);
        	XUartLite_SendByte(XPAR_UARTLITE_0_BASEADDR,rxdb);      //send one byte
        	for (i=100;i>0;i--);
       }
    }
    return 0;
}

