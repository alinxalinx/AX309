`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////
// Module Name:    sd_test
///////////////////////////////////////////////////////////////////
module sd_test(
					input  clk,     //50Mhz input clock      
					input rst_n,
					
					output SD_clk,					
					output SD_cs,
					output SD_datain,
					input  SD_dataout
					
    );

wire CLKFB;
wire CLK0;
wire CLKDV;
wire CLKFX;
wire CLK2X;
wire clock100M;

wire SD_datain_i;
wire SD_datain_w;
wire SD_datain_r;
reg SD_datain_o;

wire SD_cs_i;
wire SD_cs_w;
wire SD_cs_r;
reg SD_cs_o;


reg [31:0]read_sec;
reg read_req;

reg [31:0]write_sec;
reg write_req;

wire [7:0]mydata_o;
wire myvalid_o;

wire init_o;             //SD 初始化完成标识
wire write_o;            //SD blcok写完成标识
wire read_o;             //SD blcok读完成标识

reg [3:0] sd_state;

wire [3:0] initial_state;
wire [3:0] write_state;
wire [3:0] read_state;

wire rx_valid;

parameter STATUS_INITIAL=4'd0;
parameter STATUS_WRITE=4'd1;
parameter STATUS_READ=4'd2;
parameter STATUS_IDLE=4'd3;

assign SD_cs=SD_cs_o;
assign SD_datain=SD_datain_o;

/*******************************/
//SD卡初始化,block写,block读	
/*******************************/
always @ ( posedge SD_clk or negedge rst_n )
    if( !rst_n ) begin
			sd_state <= STATUS_INITIAL;
			read_req <= 1'b0;
			read_sec <= 32'd0;
			write_req <= 1'b0;
			write_sec <= 32'd0;			
	 end
	 else 
	     case( sd_state )

	      STATUS_INITIAL:      // 等待sd卡初始化结束
			if( init_o ) begin sd_state <= STATUS_WRITE; write_sec <= 32'd0; write_req<=1'b1; end
			else begin sd_state <= STATUS_INITIAL; end	
		  
	      STATUS_WRITE:        //等待sd卡block写结束
			if( write_o ) begin sd_state <= STATUS_READ; read_sec <= 32'd0; read_req<=1'b1; end
			else begin write_req<=1'b0; sd_state <= STATUS_WRITE; end
	
			STATUS_READ:        //等待sd卡block读结束
			if( read_o ) begin sd_state <= STATUS_IDLE; end
			else begin read_req<=1'b0; sd_state <= STATUS_READ;  end
			
	      STATUS_IDLE:        //空闲状态
			sd_state <= STATUS_IDLE;
			
			default: sd_state <= STATUS_IDLE;
	      endcase

//SD卡初始化程序				
sd_initial	sd_initial_inst(					
						.rst_n(rst_n),
						.SD_clk(SD_clk),
						.SD_cs(SD_cs_i),
						.SD_datain(SD_datain_i),
						.SD_dataout(SD_dataout),
						.rx(),
						.init_o(init_o),
						.state(initial_state)

);


//SD卡block读程序, 写512个0~255,0~255的数据			 
sd_write	sd_write_inst(   
						.SD_clk(SD_clk),
						.SD_cs(SD_cs_w),
						.SD_datain(SD_datain_w),
						.SD_dataout(SD_dataout),
						
						.init(init_o),
						.sec(write_sec),
						.write_req(write_req),
						.mystate(write_state),
						.rx_valid(rx_valid),

						.write_o(write_o)			
						
    );

//SD卡block读程序, 读512个数据			 
sd_read	sd_read_inst(   
						.SD_clk(SD_clk),
						.SD_cs(SD_cs_r),
						.SD_datain(SD_datain_r),
						.SD_dataout(SD_dataout),
						
						.init(init_o),
						.sec(read_sec),
						.read_req(read_req),
						
						.mydata_o(mydata_o),
						.myvalid_o(myvalid_o),
		
						.data_come(data_come),
						.mystate(read_state),
						
						.read_o(read_o)
						
    );

always @(*)
begin
	 case( sd_state )
	 STATUS_INITIAL: begin SD_cs_o<=SD_cs_i;SD_datain_o<=SD_datain_i; end
	 STATUS_WRITE: begin SD_cs_o<=SD_cs_w;SD_datain_o<=SD_datain_w; end
	 STATUS_READ: begin SD_cs_o<=SD_cs_r;SD_datain_o<=SD_datain_r; end
	 default: begin SD_cs_o<=1'b1;SD_datain_o<=1'b1; end	 
	 endcase
end

DCM_SP #(
      .CLKDV_DIVIDE(2),                   // CLKDV divide value
                                            // (1.5,2,2.5,3,3.5,4,4.5,5,5.5,6,6.5,7,7.5,8,9,10,11,12,13,14,15,16).
      .CLKFX_DIVIDE(4),                     // Divide value on CLKFX outputs - D - (1-32)
      .CLKFX_MULTIPLY(2),                   // Multiply value on CLKFX outputs - M - (2-32)
      .CLKIN_DIVIDE_BY_2("FALSE"),          // CLKIN divide by two (TRUE/FALSE)
      .CLKIN_PERIOD(20.0),                  // Input clock period specified in nS
      .CLKOUT_PHASE_SHIFT("NONE"),          // Output phase shift (NONE, FIXED, VARIABLE)
      .CLK_FEEDBACK("1X"),                  // Feedback source (NONE, 1X, 2X)
      .DESKEW_ADJUST("SYSTEM_SYNCHRONOUS"), // SYSTEM_SYNCHRNOUS or SOURCE_SYNCHRONOUS
      .DFS_FREQUENCY_MODE("LOW"),           // Unsupported - Do not change value
      .DLL_FREQUENCY_MODE("LOW"),           // Unsupported - Do not change value
      .DSS_MODE("NONE"),                    // Unsupported - Do not change value
      .DUTY_CYCLE_CORRECTION("TRUE"),       // Unsupported - Do not change value
      .FACTORY_JF(16'hc080),                // Unsupported - Do not change value
      .PHASE_SHIFT(0),                      // Amount of fixed phase shift (-255 to 255)
      .STARTUP_WAIT("FALSE")                // Delay config DONE until DCM_SP LOCKED (TRUE/FALSE)
   )
   DCM_SP_inst (
      .CLK0(CLK0),         // 1-bit output: 0 degree clock output
      .CLK180(CLK180),     // 1-bit output: 180 degree clock output
      .CLK270(CLK270),     // 1-bit output: 270 degree clock output
      .CLK2X(CLK2X),       // 1-bit output: 2X clock frequency clock output
      .CLK2X180(CLK2X180), // 1-bit output: 2X clock frequency, 180 degree clock output
      .CLK90(CLK90),       // 1-bit output: 90 degree clock output
      .CLKDV(CLKDV),       // 1-bit output: Divided clock output
      .CLKFX(CLKFX),       // 1-bit output: Digital Frequency Synthesizer output (DFS)
      .CLKFX180(CLKFX180), // 1-bit output: 180 degree CLKFX output
      .LOCKED(LOCKED),     // 1-bit output: DCM_SP Lock Output

      .CLKFB(CLKFB),       // 1-bit input: Clock feedback input
      .CLKIN(clk),       // 1-bit input: Clock input
      .PSEN(1'b0),
      .RST(1'b0)            // 1-bit input: Active high reset input
   ); 

BUFG bufg_inst(
					.I(CLK0),
					.O(CLKFB)
					);
  
BUFG bufg_insta(
					.I(CLKDV),
					.O(SD_clk)
					);

BUFG bufg_instb(
					.I(CLK2X),
					.O(clock100M)
					);
	 
wire [35:0]   CONTROL0;
wire [255:0]  TRIG0;
chipscope_icon icon_debug (
    .CONTROL0(CONTROL0) // INOUT BUS [35:0]
);

chipscope_ila ila_filter_debug (
    .CONTROL(CONTROL0), // INOUT BUS [35:0]
   // .CLK(dma_clk),      // IN
    .CLK(clock100M),      // IN
    .TRIG0(TRIG0)      // IN BUS [255:0]
    //.TRIG_OUT(TRIG_OUT0)
);                                                     

assign  TRIG0[3:0]=sd_state;     
assign  TRIG0[4]=init_o;  
assign  TRIG0[5]=write_o;  
assign  TRIG0[6]=read_o;  
assign  TRIG0[10:7]=initial_state;
    
assign  TRIG0[11]=SD_clk;                                                
assign  TRIG0[12]=SD_cs;          
assign  TRIG0[13]=SD_datain;       
assign  TRIG0[14]=SD_dataout;    

assign  TRIG0[18:15]=write_state; 
assign  TRIG0[19]=write_req;     
assign  TRIG0[20]=rx_valid;

assign  TRIG0[21]=read_req;
assign  TRIG0[25:22]=read_state;

assign TRIG0[26]=data_come;
assign TRIG0[27]=myvalid_o;
assign TRIG0[35:28]=mydata_o;

endmodule
