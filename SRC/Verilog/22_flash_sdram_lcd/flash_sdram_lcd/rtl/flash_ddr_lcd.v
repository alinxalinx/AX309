`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name:    flash_sdram_lcd
// Description:    read picture from SPI flash and display in 4.3' LCD 
//////////////////////////////////////////////////////////////////////////////////
module flash_sdram_lcd(
   input         clk_50M,
	input         reset_n,
	input         key1,                        //按键key1

	//flash卡SPI接口信号
   output        flash_clk,
	output        flash_cs,
	output        flash_datain,
	input         flash_dataout,

	//sdram 控制信号
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
	
	 //LCD的接口信号
    output                  lcd_dclk,
	 output [7:0]            lcd_r,
    output [7:0]            lcd_g,
    output [7:0]            lcd_b,
    output                  lcd_hsync,
    output                  lcd_vsync,
    output                  lcd_de
		
    );




//-------------时钟和系统复位产生电路--------------
wire	clk_lcd;		   //lcd clock
wire	clk_ref;		   //sdram ctrl clock
wire	clk_refout;		//sdram clock output
wire	sys_rst_n;		//global reset
wire			sys_we; 						   //system data write enable
wire	[15:0]	sys_data_in; 				//system data input
wire			sdram_init_done;			    //sdram init done
wire  frame_write_done;

system_ctrl	u_system_ctrl
(
	.clk				   (clk_50M),			//global clock  50MHZ
	.rst_n				(reset_n),		   //external reset
	
	.sys_rst_n			(sys_rst_n),	//global reset
	.clk_c0				(clk_lcd),		//9MHz lcd clock
	.clk_c1				(clk_ref),		//100MHz -45deg
	.clk_c2				(clk_refout),	//100MHz
	.clk_c3			   (spi_clk)      //25Mhz FLASH SPI clock 
);

//-------------flash图像数据读部分-------------

flash_read	flash_read_inst(
	.clk_ref			          (clk_ref),			//sdram ctrl clock
	.clock                   (spi_clk),	         //SPI clock
	.flash_rstn              (sys_rst_n),	      //flash reset
	.sdram_init_done	       (sdram_init_done),	//sdram init done
	
	.flash_clk               (flash_clk),	     //flash SPI clock output          
	.flash_cs                (flash_cs),
	.flash_datain            (flash_datain),	
	.flash_dataout           (flash_dataout),
	
	.mydata_o                (sys_data_in),	   //sdram write data
	.myvalid_o               (sys_we),	         //sdram write enable
	.frame_write_done        (frame_write_done)	//picture is store in sdram
	
);

//-------------------------------------
//sdram lcd ctrl system
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
	.lcd_dclk			(lcd_dclk),		//lcd pixel clock			
	.lcd_hsync			(lcd_hsync),	//lcd horizontal sync 
	.lcd_vsync			(lcd_vsync),	//lcd vertical sync
	.lcd_de			   (lcd_de),		//lcd Display Enable
	.lcd_red			   (lcd_r),			//lcd red data
	.lcd_green			(lcd_g),		   //lcd green data
	.lcd_blue			(lcd_b),			//lcd blue data
	
	//user interface
	.sys_we				(sys_we),			//fifo write enable
	.sys_data_in		(sys_data_in),		//fifo data input
	.sdram_init_done	(sdram_init_done),	//sdram init done
	.frame_write_done	(frame_write_done)	//sdram init done
	
);





endmodule
