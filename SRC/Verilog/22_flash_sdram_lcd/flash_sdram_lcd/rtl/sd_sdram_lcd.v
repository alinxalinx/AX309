/*-------------------------------------------------------------------------
Filename			:		sd_sdram_lcd.v
Description		:		read picture from sd, and store in sdram, display on lcd.
===========================================================================*/
`timescale 1ns / 1ps
module sd_sdram_lcd
(
	//global clock 50MHz
	input			CLOCK,	
	input			key1,			   //key1
	
	input       rst_n,
	
	//sdram control
	output			S_CLK,		//sdram clock
	output			S_CKE,		//sdram clock enable
	output			S_NCS,		//sdram chip select
	output			S_NWE,		//sdram write enable
	output			S_NCAS,	   //sdram column address strobe
	output			S_NRAS,	   //sdram row address strobe
	output [1:0] 	S_DQM,		//sdram data enable 
	output [1:0]	S_BA,		   //sdram bank address
	output [12:0]	S_A,		   //sdram address
	inout	[15:0]	S_DB,		   //sdram data
	
	//LCD port	
   output         lcd_dclk,			//lcd pixel clock
	output			lcd_hs,			   //horizontal sync 
	output			lcd_vs,			   //vertical sync
	output			lcd_de,			   //vertical sync
	output	[7:0]	lcd_red,		      //LCD R data
	output	[7:0]	lcd_green,		   //LCD G data
	output	[7:0]	lcd_blue,		   //LCD B data
	
	//SD卡SPI接口信号
	output         SD_clk,
	output 			SD_cs,
	output 			SD_datain,
	input 			SD_dataout
	
);

//---------------------------------------------
wire	clk_lcd;		   //lcd clock
wire	clk_ref;		   //sdram ctrl clock
wire	clk_refout;		//sdram clock output
wire	sys_rst_n;		//global reset

system_ctrl	u_system_ctrl
(
	.clk				   (CLOCK),			//global clock  50MHZ
	.rst_n				(rst_n),		   //external reset
	
	.sys_rst_n			(sys_rst_n),	//global reset
	.clk_c0				(clk_lcd),		//9MHz lcd clock
	.clk_c1				(clk_ref),		//100MHz -45deg
	.clk_c2				(clk_refout),	//100MHz
	.clk_c3			   (SD_clk)       //25Mhz SD SPI clock 
);
 


//-----------------------------------------------               
//SD card ctrl system

SD_TOP	u_SD_TOP
(
	//Global Clock
	.clk			      (clk_ref),			//sdram ctrl clock
	
	.sd_rst_n  		   (sys_rst_n),	   //global reset
	
	//SD SPI Interface
	.SD_clk			   (SD_clk),         //SD SPI clock 
	.SD_cs			   (SD_cs),          //SD SPI CS	
	.SD_datain			(SD_datain),		//SD SPI data in	
	.SD_dataout			(SD_dataout),		//SD SPI data out

	//Ouput SD Data                 
	.sd_valid		   (sys_we),			//sdram we enable
	.sd_data			   (sys_data_in)  	//sd data

);


//-------------------------------------
//sdram vga ctrl system
wire			sys_we/* synthesis keep */; 						   //system data write enable
wire	[15:0]	sys_data_in/* synthesis keep */; 				//system data input
wire			sdram_init_done;			                        //sdram init done
sdram_lcd_top	u_sdram_lcd_top
(
	//global clock
	.clk_lcd			   (clk_lcd),			//lcd clock
	.clk_ref			   (clk_ref),			//sdram ctrl clock
	.clk_refout			(clk_refout),		//sdram clock output
	.rst_n				(sys_rst_n),		//global reset
	.key1				   (key1),	

	//sdram control
	.sdram_clk			(S_CLK),		   //sdram clock
	.sdram_cke			(S_CKE),		   //sdram clock enable
	.sdram_cs_n			(S_NCS),		   //sdram chip select
	.sdram_we_n			(S_NWE),		   //sdram write enable
	.sdram_cas_n		(S_NCAS),		//sdram column address strobe
	.sdram_ras_n		(S_NRAS),		//sdram row address strobe
	.sdram_udqm			(S_DQM[1]),		//sdram data enable (H:8)
	.sdram_ldqm			(S_DQM[0]),		//sdram data enable (L:8)
	.sdram_ba			(S_BA),			//sdram bank address
	.sdram_addr			(S_A),		   //sdram address
	.sdram_data			(S_DB),		   //sdram data
		
	//lcd port
	.lcd_dclk			(lcd_dclk),			//lcd pixel clock			
	.lcd_hs				(lcd_hs),		   //lcd horizontal sync 
	.lcd_vs				(lcd_vs),		   //lcd vertical sync
	.lcd_de			   (lcd_de),		   //lcd Display Enable
	.lcd_red			   (lcd_red),			//lcd red data
	.lcd_green			(lcd_green),		//lcd green data
	.lcd_blue			(lcd_blue),			//lcd blue data
	
	//user interface
	.sys_we				(sys_we),			//fifo write enable
	.sys_data_in		(sys_data_in),		//fifo data input
	.sdram_init_done	(sdram_init_done)	//sdram init done

);


endmodule


