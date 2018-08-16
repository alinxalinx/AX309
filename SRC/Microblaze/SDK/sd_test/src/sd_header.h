/* $Id: spi_header.h,v 1.1.2.2 2010/09/16 10:26:02 svemula Exp $ */
/******************************************************************************
*
* (c) Copyright 2007-2010 Xilinx, Inc. All rights reserved.
*
* This file contains confidential and proprietary information of Xilinx, Inc.
* and is protected under U.S. and international copyright and other
* intellectual property laws.
*
* DISCLAIMER
* This disclaimer is not a license and does not grant any rights to the
* materials distributed herewith. Except as otherwise provided in a valid
* license issued to you by Xilinx, and to the maximum extent permitted by
* applicable law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND WITH ALL
* FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES AND CONDITIONS, EXPRESS,
* IMPLIED, OR STATUTORY, INCLUDING BUT NOT LIMITED TO WARRANTIES OF
* MERCHANTABILITY, NON-INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE;
* and (2) Xilinx shall not be liable (whether in contract or tort, including
* negligence, or under any other theory of liability) for any loss or damage
* of any kind or nature related to, arising under or in connection with these
* materials, including for any direct, or any indirect, special, incidental,
* or consequential loss or damage (including loss of data, profits, goodwill,
* or any type of loss or damage suffered as a result of any action brought by
* a third party) even if such damage or loss was reasonably foreseeable or
* Xilinx had been advised of the possibility of the same.
*
* CRITICAL APPLICATIONS
* Xilinx products are not designed or intended to be fail-safe, or for use in
* any application requiring fail-safe performance, such as life-support or
* safety devices or systems, Class III medical devices, nuclear facilities,
* applications related to the deployment of airbags, or any other applications
* that could lead to death, personal injury, or severe property or
* environmental damage (individually and collectively, "Critical
* Applications"). Customer assumes the sole risk and liability of any use of
* Xilinx products in Critical Applications, subject only to applicable laws
* and regulations governing limitations on product liability.
*
* THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS PART OF THIS FILE
* AT ALL TIMES.
*
******************************************************************************/
#ifndef SPI_HEADER_H		/* prevent circular inclusions */
#define SPI_HEADER_H		/* by using protection macros */

#include "xil_types.h"
#include "xil_assert.h"
#include "xstatus.h"

/*number of times to retry the probe cycle during initialization*/

typedef struct
{
	unsigned long int timeout_write;
	unsigned long int timeout_read;
	char busyflag;
} sd_context_t;

#define R1 1
#define R1B 2
#define R2 3
#define R3 4
/******************************** Basic command set **************************/
/* Reset cards to idle state */
#define CMD0 0
#define CMD0_R R1
/* Read the OCR (MMC mode, do not use for SD cards) */
#define CMD1 1
#define CMD1_R R1

/* Card sends the CSD */
#define CMD8 8
#define CMD8_R R3
/* Card sends the CSD */
#define CMD9 9
#define CMD9_R R1
/* Card sends CID */
#define CMD10 10
#define CMD10_R R1
/* Stop a multiple block (stream) read/write operation */
#define CMD12 12
#define CMD12_R R1B
/* Get the addressed card's status register */
#define CMD13 13
#define CMD13_R R2
/***************************** Application-specific commands ****************/
/* Flag that the next command is application-specific */
#define CMD55 55
#define CMD55_R R1
/* General purpose I/O for application-specific commands */
#define CMD56 56
#define CMD56_R R1
/* Read the OCR (SPI mode only) */
#define CMD58 58
#define CMD58_R R3
/* Turn CRC on or off */
#define CMD59 59
#define CMD59_R R1
/***************************** Application-specific commands ***************/
/* Get the SD card's status */
#define ACMD13 13
#define ACMD13_R R2
/* Get the number of written write blocks (Minus errors ) */
#define ACMD22 22
#define ACMD22_R R1
/* Set the number of write blocks to be pre-erased before writing */
#define ACMD23 23
#define ACMD23_R R1
/* Get the card's OCR (SD mode) */
#define ACMD41 41
#define ACMD41_R R1
/* Connect or disconnect the 50kOhm internal pull-up on CD/DAT[3] */
#define ACMD42 42
#define ACMD42_R R1
/* Get the SD configuration register */
#define ACMD51 42
#define ACMD51_R R1
/* Hardcoded timeout for commands. 8 words, or 64 clocks. Do 10
* words instead */
#define SD_INIT_TRY 50
#define SD_CMD_TIMEOUT 200
/* Number of tries to wait for the card to go idle during initialization */
#define SD_IDLE_WAIT_MAX 200

#define MSK_IDLE 0x01
#define MSK_ERASE_RST 0x02
#define MSK_ILL_CMD 0x04
#define MSK_CRC_ERR 0x08
#define MSK_ERASE_SEQ_ERR 0x10
#define MSK_ADDR_ERR 0x20
#define MSK_PARAM_ERR 0x40

/***************************** Block read commands **************************/
/* Set the block length */

#define CMD16 16
#define CMD16_R R1
/* Read a single block */
#define CMD17 17
#define CMD17_R R1
/* Read multiple blocks until a CMD12 */
#define CMD18 18
#define CMD18_R R1

/***************************** Block write commands *************************/
/* Write a block of the size selected with CMD16 */
#define CMD24 24
#define CMD24_R R1
/* Multiple block write until a CMD12 */
#define CMD25 25
#define CMD25_R R1
/* Program the programmable bits of the CSD */
#define CMD27 27
#define CMD27_R R1
/* Mask off the bits in the OCR corresponding to voltage range 3.2V to
* 3.4V, OCR bits 20 and 21 */
#define MSK_OCR_33 0xC0
#define SD_BLOCKSIZE 512
#define SD_BLOCKSIZE_NBITS 9

/* Error token is 111XXXXX */
#define MSK_TOK_DATAERROR 0xE0

#endif


