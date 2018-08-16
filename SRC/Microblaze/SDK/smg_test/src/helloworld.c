/*smg display test */

#include <stdio.h>
#include "platform.h"
#include "xparameters.h"
#include "smg_ip.h"

void delay(unsigned int dly)
{
	for(;dly>0;dly--);
}


int main()
{
    init_platform();
    u32 smg_data=0;
    u32 i;

    SMG_IP_mReset(XPAR_SMG_IP_0_BASEADDR);	// Reset SMG IP

	while (1)
	{
		for(i=0;i<=9;i++)
		{
			delay(5000000);                                                    //wait time
			SMG_IP_mWriteSlaveReg0(XPAR_SMG_IP_0_BASEADDR,0,smg_data);         //write smg_data to register0 of smg_ip
			smg_data=(i<<20) + (i<<16) + (i<<12) + (i<<8) + (i<<4) + i;        //six SMG value is increase
		}

	}


    return 0;
}
