`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name:    sd_audio 
//////////////////////////////////////////////////////////////////////////////////
module sd_audio(
					input  clk,
					input rst_n,
					output SD_clk,
					
					output SD_cs,
					output SD_datain,
					input  SD_dataout,
					
					input DACLRC,
					input BCLK,
					output DACDAT,
					
					input ADCLRC,                    //WM8731 左右声道输入
					input ADCDAT,					      //WM8731 语音输入
	
					output I2C_SCLK,
					inout I2C_SDAT
				   
					
    );

wire CLKFB;
wire CLK0;
wire CLKDV;
wire CLKFX;
reg SD_cs;
reg SD_datain;

wire [15:0] wav_data;
wire wav_rden;

wire [31:0]read_sec;
wire read_SD;

wire [7:0]mydata_o;
wire myvalid_o;

wire clk_50m;

wire [7:0]rx_o;
wire init_o;
wire read_o;

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

					
/*BUFG bufg_instb(
					.I(CLK0),
					.O(clk_50m)
					);*/
					
					assign clk_50m=CLK0;
sd_initial	sd_initial_inst(
					
						.rst_n,
						.SD_clk(SD_clk),
						.SD_cs(SD_cs_i),
						.SD_datain(SD_datain_i),
						.SD_dataout(SD_dataout),
						.rx(),
						.init_o(init_o),
						.state()

);


	 
sd_read	sd_read_inst(   
						.SD_clk(SD_clk),
						.SD_cs(SD_cs_r),
						.SD_datain(SD_datain_r),
						.SD_dataout(SD_dataout),
						
						.sec(read_sec),
						.read_req(read_SD),
						
						.mydata_o(mydata_o),
						.myvalid_o(myvalid_o),
		
						.data_come(data_come),
						
						.init(init_o),
					
						.mystate()
						
						
    );

always @(*)
begin
	if(!init_o)
		begin
			SD_cs<=SD_cs_i;
			SD_datain<=SD_datain_i;
		end
	else
		begin
			SD_cs<=SD_cs_r;
			SD_datain<=SD_datain_r;
		end
end

//驱动wm8731的部分
mywav	mywav_inst(
	.clk50M(clk_50m),
	
	.wav_data(wav_data),
	.myvalid(wav_rden),
	
	.DACLRC(DACLRC),
	.BCLK(BCLK),
	.DACDAT(DACDAT),
	
	.I2C_SCLK(I2C_SCLK),
	.I2C_SDAT(I2C_SDAT)
);


ram_rw_control ram_rw_control_inst(
	.clk_50M(clk_50m),
	.SD_clk(SD_clk),
	.init(init_o),
	.data_come(data_come),
	
	
	
	.read_sec(read_sec),
	
	.read_SD(read_SD),
	
	.mydata(mydata_o),
	.myvalid(myvalid_o),
	
	
	.wav_rden(wav_rden),
	.wav_data(wav_data)
    );
	 
wire [35:0]   CONTROL0;
wire [255:0]  TRIG0;
chipscope_icon icon_debug (
    .CONTROL0(CONTROL0) // INOUT BUS [35:0]
);

chipscope_ila ila_filter_debug (
    .CONTROL(CONTROL0), // INOUT BUS [35:0]
   // .CLK(dma_clk),      // IN
    .CLK(clk),      // IN
    .TRIG0(TRIG0)      // IN BUS [255:0]
    //.TRIG_OUT(TRIG_OUT0)
);                                                     

assign  TRIG0[0]=init_o;                                               
assign  TRIG0[1]=BCLK;  
assign  TRIG0[2]=DACLRC;  
assign  TRIG0[3]=DACDAT;  
assign  TRIG0[19:4]=wav_data;        	 
	 
endmodule
