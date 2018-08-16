/*-------------------------------------------------------------------------
Filename			:		sd_sdram_vga.v
Description		:		read picture from sd, and store in sdram, display on VGA.
===========================================================================*/
`timescale 1ns / 1ps
module sd_sdram_vga
(
	//global clock 50MHz
	input			   CLOCK,	

	input          rst_n,
	
   output [3:0]   led,                  //led灯指示	
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
	
	//VGA port	
	output			vga_hs,			   //horizontal sync 
	output			vga_vs,			   //vertical sync
//	output			vga_de,			   //vertical sync
	output	[4:0]	vga_red,		      //LCD R data
	output	[5:0]	vga_green,		   //LCD G data
	output	[4:0]	vga_blue,		   //LCD B data

	
	//SD SPI控制信号
	output         SD_clk,
	output 			SD_cs,
	output 			SD_datain,
	input 			SD_dataout
	
);

//---------------------------------------------
wire	clk_vga;		   //vga clock
wire	clk_ref;		   //sdram ctrl clock
wire	clk_refout;		//sdram clock output
wire	sys_rst_n;		//global reset

wire			sys_we; 						   //system data write enable
wire	[15:0]	sys_data_in; 				//system data input
wire			sdram_init_done;			                        //sdram init done

wire init_o;                                     //sd卡初始化完成信号
wire pic_read_done;                              //sd卡读图像完成信号  

wire	[15:0]	lcd_rgb; 				//VGA data

assign vga_red = lcd_rgb[15:11];
assign vga_green = lcd_rgb[10:5];
assign vga_blue = lcd_rgb[4:0];

assign led[0]=init_o?1'b1:1'b0;                    //led0为ddr calibrate完成指示信号,亮说明初始化完成
assign led[1]=pic_read_done?1'b1:1'b0;             //led1为图像已存入DDR中完成指示信号,亮说明存储已完成
assign led[2]=1'b1;             
assign led[3]=1'b1;           

system_ctrl	u_system_ctrl
(
	.clk				   (CLOCK),			//global clock  50MHZ
	.rst_n				(rst_n),		   //external reset
	
	.sys_rst_n			(sys_rst_n),	//global reset
	.clk_c0				(clk_vga),		//65MHz vga clock
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

	.sdram_init_done  (sdram_init_done),//sdram init done	
	//SD SPI Interface
	.SD_clk			   (SD_clk),         //SD SPI clock 
	.SD_cs			   (SD_cs),          //SD SPI CS	
	.SD_datain			(SD_datain),		//SD SPI data in	
	.SD_dataout			(SD_dataout),		//SD SPI data out

	//Ouput SD Data                 
	.sd_valid		   (sys_we),			//sdram we enable
	.sd_data			   (sys_data_in),  	//sd data
	.init_o			   (init_o),	
	.pic_read_done    (pic_read_done)
);


//-------------------------------------
//sdram vga ctrl system
sdram_vga_top	u_sdram_vga_top
(
	//global clock
	.clk_vga			   (clk_vga),			//vga clock
	.clk_ref			   (clk_ref),			//sdram ctrl clock
	.clk_refout			(clk_refout),		//sdram clock output
	.rst_n				(sys_rst_n),		//global reset

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
		
	//vga port
	.lcd_hs				(vga_hs),		   //vga horizontal sync 
	.lcd_vs				(vga_vs),		   //vga vertical sync
	.lcd_blank			(),		         //vga Display Enable
	.lcd_rgb			   (lcd_rgb),			//vga red data
	
	//user interface
	.sys_we				(sys_we),			//fifo write enable
	.sys_data_in		(sys_data_in),		//fifo data input
	.sdram_init_done	(sdram_init_done)	//sdram init done

);


endmodule


