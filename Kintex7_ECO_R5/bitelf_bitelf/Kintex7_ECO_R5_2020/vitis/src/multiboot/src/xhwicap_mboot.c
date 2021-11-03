/******************************************************************************
*
* Copyright (c) 2010-2017 Xilinx, Inc.  All rights reserved.
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* Use of the Software is limited solely to applications:
* (a) running on a Xilinx device, or
* (b) that interact with a Xilinx device through a bus or interconnect.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* XILINX  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
* OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*
* Except as contained in this notice, the name of the Xilinx shall not be used
* in advertising or otherwise to promote the sale, use or other dealings in
* this Software without prior written authorization from Xilinx.
*
******************************************************************************/
/*****************************************************************************/
/**
*
* This File is derived from xhwicap_low_level_example.c provided in the Xilinx SDK 
* Original source file xhwicap_low_level_example.c
*
* Ver	Who  Date	  Changes
* ----- ---- -------- -----------------------------------------------
* 1.0   gpk 20/04/17  Initial release
*
*
******************************************************************************/

/***************************** Include Files *********************************/

#include <xparameters.h>
#include <xstatus.h>
#include <xil_types.h>
#include <xil_assert.h>
#include <xhwicap_i.h>
#include <xhwicap_l.h>
#include <stdio.h>

/************************** Constant Definitions *****************************/

/*
 * The following constants map to the XPAR parameters created in the
 * xparameters.h file. They are defined here such that a user can easily
 * change all the needed parameters in one place.
 */
#define HWICAP_BASEADDR         XPAR_HWICAP_0_BASEADDR

/*
 * Number of words to Read for getting Id code.
 */
#define HWICAP_IDCODE_SIZE		    1

/*
 * Bitstream that reads back ID Code Register
 */
#define HWICAP_EXAMPLE_BITSTREAM_LENGTH     6

static u32 ReadId[HWICAP_EXAMPLE_BITSTREAM_LENGTH] =
{
	XHI_DUMMY_PACKET,   /* Dummy Word */
	XHI_SYNC_PACKET,    /* Sync Word*/
	XHI_NOOP_PACKET,    /* Type 1 NO OP */
	XHI_NOOP_PACKET,    /* Type 1 NO OP */
	XHI_DEVICE_ID_READ, /* Read Product ID Code Register */
	XHI_NOOP_PACKET,    /* Type 1 NO OP */
};

#define printf  xil_printf           /* A smaller footprint printf */

/**************************** Type Definitions *******************************/


/***************** Macros (Inline Functions) Definitions *********************/


/************************** Function Prototypes ******************************/

u32 HwIcapLowLevelExample(u32 BaseAddress, u32 *IdCode);


/************************** Variable Definitions *****************************/


/*****************************************************************************/
/**
* READ_ID function to call the HWICAP Low Level example.
*
* @param    None
*
* @return   XST_SUCCESS if successful, otherwise XST_FAILURE
*
* @note     None
*
******************************************************************************/

int READ_ID(void)
{
	int Status;
	u32 IdCode;

	/*
	 * Run the HwIcap Low Level example, specify the Base Address
	 * generated in xparameters.h.
	 */
	Status = HwIcapLowLevelExample(HWICAP_BASEADDR, &IdCode);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	xil_printf("FPGA IDCODE is    :  %x \r\n\n", IdCode);


	return XST_SUCCESS;

}


/*****************************************************************************/
/**
*
* This function returns the IDCODE of the target device.
*
* @param	BaseAddress is the base address of the HwIcap instance.
* @param	IdCode is the IDCODE of the part this code is running on.
*
* @return	XST_SUCCESS if successful, otherwise XST_FAILURE
*
* @note		None
*
******************************************************************************/
u32 HwIcapLowLevelExample(u32 BaseAddress, u32 *IdCode)
{

	u32 Index;
	u32 Retries;

	/*
	 * Write command sequence to the FIFO
	 */
	for (Index = 0; Index < HWICAP_EXAMPLE_BITSTREAM_LENGTH; Index++) {
		XHwIcap_WriteReg(BaseAddress, XHI_WF_OFFSET, ReadId[Index]);
	}

	/*
	 * Start the transfer of the data from the FIFO to the ICAP device.
	 */
	XHwIcap_WriteReg(BaseAddress, XHI_CR_OFFSET, XHI_CR_WRITE_MASK);

	/*
	 * Poll for done, which indicates end of transfer
	 */
	Retries = 0;
	while ((XHwIcap_ReadReg(BaseAddress, XHI_SR_OFFSET) &
			XHI_SR_DONE_MASK) != XHI_SR_DONE_MASK) {
		Retries++;
		if (Retries > XHI_MAX_RETRIES) {

			/*
			 * Waited to long. Exit with error.
			 */
			printf("\r\nHwIcapLowLevelExample failed- retries  \
			failure. \r\n\r\n");

			return XST_FAILURE;
		}
	}

	/*
	 * Wait till the Write bit is cleared in the CR register.
	 */
	while ((XHwIcap_ReadReg(BaseAddress, XHI_CR_OFFSET)) &
					XHI_CR_WRITE_MASK);
	/*
	 * Write to the SIZE register. We want to readback one word.
	 */
	XHwIcap_WriteReg(BaseAddress, XHI_SZ_OFFSET, HWICAP_IDCODE_SIZE);


	/*
	 * Start the transfer of the data from ICAP to the FIFO.
	 */
	XHwIcap_WriteReg(BaseAddress, XHI_CR_OFFSET, XHI_CR_READ_MASK);

	/*
	 * Poll for done, which indicates end of transfer
	 */
	Retries = 0;
	while ((XHwIcap_ReadReg(BaseAddress, XHI_SR_OFFSET) &
			XHI_SR_DONE_MASK) != XHI_SR_DONE_MASK) {
		Retries++;
		if (Retries > XHI_MAX_RETRIES) {

			/*
			 * Waited to long. Exit with error.
			 */

			return XST_FAILURE;
		}
	}

	/*
	 * Wait till the Read bit is cleared in the CR register.
	 */
	while ((XHwIcap_ReadReg(BaseAddress, XHI_CR_OFFSET)) &
					XHI_CR_READ_MASK);
	/*
	 * Return the IDCODE value
	 */
	*IdCode =   XHwIcap_ReadReg(BaseAddress, XHI_RF_OFFSET);

	return XST_SUCCESS;
}

