/*
 * Copyright (c) 2010-2017 Xilinx, Inc.  All rights reserved.
 * Xilinx, Inc.
 * XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS" AS A
 * COURTESY TO YOU.  BY PROVIDING THIS DESIGN, CODE, OR INFORMATION AS
 * ONE POSSIBLE   IMPLEMENTATION OF THIS FEATURE, APPLICATION OR
 * STANDARD, XILINX IS MAKING NO REPRESENTATION THAT THIS IMPLEMENTATION
 * IS FREE FROM ANY CLAIMS OF INFRINGEMENT, AND YOU ARE RESPONSIBLE
 * FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE FOR YOUR IMPLEMENTATION
 * XILINX EXPRESSLY DISCLAIMS ANY WARRANTY WHATSOEVER WITH RESPECT TO
 * THE ADEQUACY OF THE IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO
 * ANY WARRANTIES OR REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE
 * FROM CLAIMS OF INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY
 * AND FITNESS FOR A PARTICULAR PURPOSE.
 */
/**
* Ver	Who  Date	  Changes
* ----- ---- -------- -----------------------------------------------
* 1.0   gpk 20/04/17  Initial release
*/

/***************************** Include Files ********************************/

#include <stdio.h>
#include "xparameters.h"
#include "xil_cache.h"
#include "xil_types.h"
#include "xgpio.h"
#include "gpio_header.h"
#include "xhwicap.h"



extern int READ_ID(void);

/******************************************************************************/
/**
*
* Main function  performs blinking LED pattern
* IDCODE Readout functionality based on the DIPSW13 setting on KCU116
* Current DIPSW setting is displayed via UART
*
* @note	  	None.
*
******************************************************************************/

int main()
{


   Xil_ICacheEnable();
   Xil_DCacheEnable();

   u32 status;
   u32 DataRead;
   u32 DataRead_temp;

   status = GpioOutputExample(XPAR_AXI_GPIO_1_DEVICE_ID,8);
   status = GpioInputExample(XPAR_AXI_GPIO_0_DEVICE_ID, &DataRead);
   xil_printf("\r\n**************MULTI BOOT IMAGE*****************\n\r");

if (status == 0) {
	 	 	 xil_printf("DIPSW[1] Setting for IDCODE Read is : 1 \n\r");
	         xil_printf("Current DIPSW Setting is            : 0x%X\r\n", DataRead);
	         xil_printf("***********************************************\n\r\n\r");
			}

while (1)
{
	status = GpioOutputExample(XPAR_AXI_GPIO_1_DEVICE_ID,8);
	status = GpioInputExample(XPAR_AXI_GPIO_0_DEVICE_ID, &DataRead);
  if (status == 0) {
			 if ( (DataRead & 0x00000001) == 0x00000000 ) //DIPSW[1] = 1
	 			{
	   			READ_ID(); //Read the FPPGA ID Code
	   			DataRead_temp = 1;
	 			}
   		else {
  			if (DataRead_temp !=  DataRead) {
  			xil_printf("Current DIPSW setting is not for IDCODE READ.\r\n");
      		xil_printf("Current DIPSW Setting is            : 0x%X\r\n", DataRead);
      		DataRead_temp =  DataRead;
   			}
			}
	}
}
   Xil_DCacheDisable();
   Xil_ICacheDisable();

   return 0;
}
