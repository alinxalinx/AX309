`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
module adda_test(
    input clk,            //fpga clock
	 
	 output daclk,
    output [7:0] dadata,       //DA data
	 
	 output adclk,
	 input [7:0] addata        //AD data

    );


reg [8:0] rom_addr;
reg [7:0] ad_data;

wire [7:0] rom_data;
wire clk_25;
wire clk_50;

assign dadata=rom_data;
assign daclk=clk_50;
assign adclk=clk_25;

//DA output sin waveform
always @(negedge clk_50)
begin
     rom_addr <= rom_addr + 1'b1 ; 
end 

always @(posedge clk_25)
begin
      ad_data <= addata ;  
end 


ROM ROM_inst (
  .clka(clk_50), // input clka
  .addra(rom_addr), // input [8 : 0] addra
  .douta(rom_data) // output [7 : 0] douta
);


PLL PLL_inst
   (// Clock in ports
    .CLK_IN1(clk),      // IN
    // Clock out ports
    .CLK_OUT1(clk_50),     // 50Mhz DA OUT clock
    .CLK_OUT2(clk_25),     // 25Mhz AD IN CLOCK
    // Status and control signals
    .RESET(1'b0),// IN
    .LOCKED());      // OUT


wire [35:0]   CONTROL0;
wire [255:0]  TRIG0;
chipscope_icon icon_debug (
    .CONTROL0(CONTROL0) // INOUT BUS [35:0]
);

chipscope_ila ila_filter_debug (
    .CONTROL(CONTROL0), // INOUT BUS [35:0]
   // .CLK(dma_clk),      // IN
    .CLK(clk_50),      // IN
    .TRIG0(TRIG0)      // IN BUS [255:0]
    //.TRIG_OUT(TRIG_OUT0)
);                                                     

assign  TRIG0[7:0]=ad_data;                                               
assign  TRIG0[15:8]=dadata;    

endmodule
