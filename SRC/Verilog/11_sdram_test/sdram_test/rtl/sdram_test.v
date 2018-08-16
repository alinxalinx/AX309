module sdram_test(
   input clk_50m,
	input reset_n,
	
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


wire system_clk;
       
reg			   sys_rd;        		//fifo read enable
wire	[15:0]	sys_data_out;  		//fifo data output

reg			   sys_we;        		//fifo write enable
reg	[15:0]	sys_data_in;  		   //fifo data input

reg			wr_load;			                           //sdram write address reset
reg			rd_load;			                           //sdram read address reset

reg [3:0] i;
reg [9:0] counter;
/*******************************/
//SDRAM读写测试程序	
/*******************************/
always @ ( negedge system_clk or negedge sys_rst_n )
begin
    if( !sys_rst_n ) begin
			i <= 4'd0;
			counter<=0;
			wr_load<=1'b1;
			rd_load<=1'b1;	
         sys_rd<=1'b0;	
         sys_we<=1'b0;		
         sys_data_in<=0;		
	 end
	 else 
	     case( i )
	      4'd0://等待SDRAM初始化完成
			if( sdram_init_done ) begin i <= i + 1'b1; wr_load<=1'b0; end   
			else begin i <= 4'd0; wr_load<=1'b1; rd_load<=1'b1; end	
		  
	      4'd1://写512个16bit数据到SDRAM
			if( sys_data_in==16'd511 ) begin i <= i + 1'b1;counter <= 0; sys_we<=1'b0;rd_load<=1'b0;end
			else begin  sys_we<=1'b1; sys_data_in<=counter; counter<=counter+1'b1;i <= 4'd1;end
			
	      4'd2://从SDRAM读取512个16bit数据
			if( counter==16'd511 ) begin i <= i + 1'b1; sys_rd<=1'b0; end
			else begin sys_rd<=1'b1; counter<=counter+1'b1; i <= 4'd2; end	

			4'd3://idle
			i <= 4'd3;

	      endcase
end

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
	.wr_max_addr		(22'h200000),		//sdram max write address 
	.wr_load			   (wr_load),			//sdram write address reset
	.rd_addr			   (22'd0),			   //sdram start read address
	.rd_max_addr		(22'h200000),		//sdram max read address 
	.rd_load			   (rd_load),			//sdram read address reset
	
	//  interface
	.sdram_init_done	(sdram_init_done),	//sdram init done
	.sys_we				(sys_we),			   //fifo write enable
	.sys_data_in		(sys_data_in),		   //fifo data input
	.sys_rd				(sys_rd),			   //fifo read enable
	.sys_data_out		(sys_data_out)	   	//fifo data output

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

endmodule
