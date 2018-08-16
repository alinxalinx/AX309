`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name:    audio_test
// function: Key1 push down-record the voice to sdram, after record finish,
//           play the voice from sdram
//////////////////////////////////////////////////////////////////////////////////
module audio_test(
   input clk_50m,
	input reset_n,
   input  key1,                 //KEY按键	
	
	input BCLK,
	input DACLRC,                    //WM8731 左右声道输出
	output DACDAT,                   //WM8731 语音输出
					
	input ADCLRC,                    //WM8731 左右声道输入
	input ADCDAT,					      //WM8731 语音输入
	
	output I2C_SCLK,
	inout I2C_SDAT,

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
	inout	[15:0]	S_DB		   //sdram data
		
    );


wire [15:0] wav_out_data;
wire [15:0] wav_in_data;
wire wav_rden;
wire wav_wren;

wire sdr_waddr_set;
wire sdr_raddr_set;

wire record_start;


wire system_clk;
       
wire			sys_rd;        		   //fifo read enable
wire	[15:0]	sys_data_out;  		//fifo data output

wire			sys_we;        		   //fifo write enable
wire	[15:0]	sys_data_in;  		//fifo data input

wire        voice_write_done;

wire			wr_load;			                           //sdram write address reset
wire			rd_load;			                           //sdram read address reset

assign sys_rd=wav_rden;
assign wav_out_data=sys_data_out;

assign sys_we=wav_wren;
assign sys_data_in=wav_in_data;

assign rd_load=sdr_waddr_set;
assign wr_load=sdr_waddr_set;


//PLL时钟
system_ctrl	u_system_ctrl
(
	.clk				   (clk_50m),		//global clock  50MHZ
	.rst_n				(reset_n),		   //external reset
	
	.sys_rst_n			(sys_rst_n),	//global reset
	.clk_c0				(system_clk),	//50MHz clock
	.clk_c1				(clk_ref),		//100MHz -45deg
	.clk_c2				(clk_refout),	//100MHz
	.clk_c3			   ()             //25Mhz clock 
);

//驱动wm8731的部分
mywav	mywav_inst(
	.clk50M(system_clk),
	
	.wav_out_data(wav_out_data),
	.wav_rden(wav_rden),
	.wav_in_data(wav_in_data),
	.wav_wren(wav_wren),
	
 	.record_start(record_start),
	.voice_write_done(voice_write_done),   //voice store done	
	
	.wr_load(wr_load), 	
	.rd_load(rd_load), 		

	.BCLK(BCLK),	
	.DACLRC(DACLRC),
	.DACDAT(DACDAT),	
	.ADCLRC(ADCLRC),
	.ADCDAT(ADCDAT),	
	
	.I2C_SCLK(I2C_SCLK),
	.I2C_SDAT(I2C_SDAT)
);

//按键KEY1检测程序
key_dect	key_dect_inst(
	.clk50M(system_clk),
	.key1(key1),
	.reset_n(sys_rst_n),
	
 	.record_start(record_start),
	.sdr_waddr_set(sdr_waddr_set)
	
);
//SDR读写控制部分
//----------------------------------------------

sdram_2fifo_top	u_sdram_2fifo_top
(
	//global clock
	.clk_ref			   (clk_ref),			   //sdram	reference clock
	.clk_refout			(clk_refout),	   	//sdram clk	input 
	.clk_read			(system_clk),			//fifo data read clock
	.clk_write			(system_clk),			//fifo data write clock	
	.rst_n				(sys_rst_n),			//global reset
	
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

	
	//user interface
	//burst and addr
	.wr_length			(9'd256),			//sdram write burst length
	.rd_length			(9'd256),			//sdram read burst length
	.wr_addr		  	   (22'd0),			   //sdram start write address
	.wr_max_addr		(22'h100000),		//sdram max write address 
	.wr_load			   (wr_load),			//sdram write address reset
	.rd_addr			   (22'd0),			   //sdram start read address
	.rd_max_addr		(22'h100000),		//sdram max read address 
	.rd_load			   (rd_load),			//sdram read address reset
	
	//  interface
	.sdram_init_done	(sdram_init_done),	//sdram init done
	.sys_we				(sys_we),			   //fifo write enable
	.sys_data_in		(sys_data_in),		   //fifo data input
	.sys_rd				(sys_rd),			   //fifo read enable
	.sys_data_out		(sys_data_out),	   //fifo data output
	
	.voice_write_done (voice_write_done)   //voice store done

);

wire [35:0]   CONTROL0;
wire [63:0]  TRIG0;
chipscope_icon icon_debug (
    .CONTROL0(CONTROL0) // INOUT BUS [35:0]
);

chipscope_ila ila_filter_debug (
    .CONTROL(CONTROL0), // INOUT BUS [35:0]
   // .CLK(dma_clk),      // IN
    .CLK(system_clk),      // IN
    .TRIG0(TRIG0)      // IN BUS [255:0]
    //.TRIG_OUT(TRIG_OUT0)
);                                                     

assign  TRIG0[15:0]=sys_data_out;                                               
assign  TRIG0[16]=sys_rd; 
    
assign  TRIG0[32:17]=sys_data_in;   
assign  TRIG0[33]=sys_we;   
assign  TRIG0[34]=BCLK;  
assign  TRIG0[35]=DACLRC;  
assign  TRIG0[36]=DACDAT;  
assign  TRIG0[37]=ADCLRC;
assign  TRIG0[38]=ADCDAT;
assign  TRIG0[39]=rd_load;
assign  TRIG0[40]=wr_load;
assign  TRIG0[41]=voice_write_done;


endmodule
