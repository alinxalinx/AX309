/*-------------------------------------------------------------------------
Filename			:		sdram_2fifo_top.v
Description		:		sdram fifo controller with sd read and lcd display.
==========================================================================*/
`timescale 1ns/1ns
module	sdram_2fifo_top
(
	//global clock
	input				clk_ref,			//sdram	reference clock
	input				clk_refout,			//sdram clk	input 
	input				clk_read,			//fifo data read clock
	input				clk_write,			//fifo data write clock
	input				rst_n,				//global reset
			
	//sdram control		
	output				sdram_clk,			//sdram clock
	output				sdram_cke,			//sdram clock enable
	output				sdram_cs_n,			//sdram chip select
	output				sdram_we_n,			//sdram write enable
	output				sdram_cas_n,		//sdram column address strobe
	output				sdram_ras_n,		//sdram row address strobe
	output				sdram_udqm,			//sdram data enable (H:8)
	output				sdram_ldqm,			//sdram data enable (L:8)
	output		[1:0]	sdram_ba,			//sdram bank address
	output		[11:0]	sdram_addr,			//sdram address
	inout		[15:0]	sdram_data,			//sdram data��
	
	//user interface		
	//sdram burst and addr
	input		[8:0]	wr_length,			//sdram write burst length
	input		[8:0]	rd_length,			//sdram read burst length
	input				wr_load,			//sdram write address reset
	input		[21:0]	wr_addr,			//sdram start write address
	input		[21:0]	wr_max_addr,		//sdram max write address
	input				rd_load,			//sdram read address reset
	input		[21:0]	rd_addr,			//sdram start read address
	input		[21:0]	rd_max_addr,		//sdram max read address
	
	//dcfifo interface
	output				sdram_init_done,	//sdram init done
	input				sys_we,				//fifo write enable
	input		[15:0]	sys_data_in,		//fifo data input
	input				sys_rd,				//fifo read enable
	output		[15:0]	sys_data_out,		//fifo data output
	
	output         voice_write_done
	
);

//-----------------------------------------------
assign	sdram_udqm = 0;						//sdram high 8bit data
assign	sdram_ldqm = 0;						//sdram low 8bit data
assign	sdram_clk = clk_refout;				//sdram clock

//------------------------------------------------
//sdram module instantiation
wire			sdram_wr_req;				//sdram write request
wire			sdram_wr_ack;				//sdram write ack
wire			sdram_rd_req;				//sdram read request
wire			sdram_rd_ack;				//sdram read ack
wire	[21:0]	sdram_wraddr;				//sdram write address 
wire	[21:0]	sdram_rdaddr;				//sdram read address
wire	[15:0]	sdram_din;					//fifo 2 sdram data input
wire	[15:0]	sdram_dout;					//sdram 2 fifo data input
sdram_top		u_sdramtop
(
	//global clock
	.clk				(clk_ref),			//sdram reference clock
	.rst_n				(rst_n),			//global reset
		
	//internal interface	
	.sdram_wr_req		(sdram_wr_req), 	//sdram write request
	.sdram_rd_req		(sdram_rd_req), 	//sdram write ack
	.sdram_wr_ack		(sdram_wr_ack), 	//sdram read request
	.sdram_rd_ack		(sdram_rd_ack),		//sdram read ack
	.sys_wraddr			(sdram_wraddr), 	//sdram write address 
	.sys_rdaddr			(sdram_rdaddr), 	//sdram read address
	.sys_data_in		(sdram_din),    	//fifo 2 sdram data input
	.sys_data_out		(sdram_dout),   	//sdram 2 fifo data input
	.sdram_init_done	(sdram_init_done),	//sdram init done

	//burst length
	.sdwr_byte			(wr_length),		//sdram write burst length
	.sdrd_byte			(rd_length),		//sdram read burst length
	
	//sdram interface
//	.sdram_clk			(sdram_clk),		//sdram clock	
	.sdram_cke			(sdram_cke),		//sdram clock enable	
	.sdram_cs_n			(sdram_cs_n),		//sdram chip select	
	.sdram_we_n			(sdram_we_n),		//sdram write enable	
	.sdram_ras_n		(sdram_ras_n),		//sdram column address strobe	
	.sdram_cas_n		(sdram_cas_n),		//sdram row address strobe	
	.sdram_ba			(sdram_ba),			//sdram data enable (H:8)    
	.sdram_addr			(sdram_addr),		//sdram data enable (L:8)	
	.sdram_data			(sdram_data)		//sdram bank address	
//	.sdram_udqm			(sdram_udqm),		//sdram address	
//	.sdram_ldqm			(sdram_ldqm)		//sdram data	
);
					
//------------------------------------------------
//dcfifo_ctrl module instantiation
dcfifo_ctrl u_dcfifo_ctrl
(
	//global clock
	.clk_ref			   (clk_ref),			//sdram	reference clock
	.rst_n				(rst_n),			//global reset
	.clk_read			(clk_read),     	//fifo data read clock	
	.clk_write			(clk_write),     	//fifo data write clock	
	
	//brust length	
	.wr_length			(wr_length),		//sdram write burst length
	.rd_length			(rd_length),		//sdram read burst length
	.wr_addr			   (wr_addr),			//sdram start write address
	.wr_max_addr		(wr_max_addr),		//sdram max write address
	.wr_load			   (wr_load),			//sdram write address reset
	.rd_addr			   (rd_addr),			//sdram start read address
	.rd_max_addr		(rd_max_addr),		//sdram max read address
	.rd_load			   (rd_load),			//sdram read address reset
	
	//wrfifo:  fifo 2 sdram
	.wrf_wrreq			(sys_we),			//fifo write enable		
	.wrf_din			   (sys_data_in),		//fifo data input
	.sdram_wr_req		(sdram_wr_req),		//sdram write request
	.sdram_wr_ack		(sdram_wr_ack),	    //sdram write ack
	.sdram_din			(sdram_din),		//fifo 2 sdram data input	
	.sdram_wraddr		(sdram_wraddr),		//sdram write address

	//rdfifo: sdram 2 fifo
	.rdf_rdreq			(sys_rd),			//fifo read enable	
	.rdf_dout			(sys_data_out),		//fifo data output
	.sdram_rd_req		(sdram_rd_req),		//sdram read request
	.sdram_rd_ack		(sdram_rd_ack),	    //sdram read ack
	.sdram_dout			(sdram_dout),		//sdram 2 fifo data input	
	.sdram_rdaddr		(sdram_rdaddr),		//sdram read address
		
	//sdram address control	
	.sdram_init_done	(sdram_init_done),	//sdram init done
	.voice_write_done	(voice_write_done)	//voice store done	
	

);

endmodule
