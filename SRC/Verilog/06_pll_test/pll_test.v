`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name:    pll_test 
//////////////////////////////////////////////////////////////////////////////////
module pll_test(
                input clk,
                input rst_n,
					 output clk_out           //pll clock output

    );

wire locked;
wire pll_clk_o;

/////////////////////PLL IP 调用////////////////////////////
pll_ip pll_ip_inst
   (// Clock in ports
    .CLK_IN1(clk),            // IN 50Mhz
    // Clock out ports
    .CLK_OUT1(),     // OUT 25Mhz
    .CLK_OUT2(pll_clk_o),              // OUT 50Mhz
    .CLK_OUT3(),              // OUT 75Mhz
    .CLK_OUT4(),              // OUT 100Mhz	 
    // Status and control signals	 
    .RESET(~rst_n),// IN
    .LOCKED(locked));      // OUT
	 

///////////////调用ODDR2使时钟信号通过普通IO输出//////////////////	  
ODDR2 #(
      .DDR_ALIGNMENT("NONE"),     // Sets output alignment to "NONE", "C0" or "C1"
      .INIT(1'b0),                // Sets initial state of the Q output to 1'b0 or 1'b1
      .SRTYPE("SYNC")             // Specifies "SYNC" or "ASYNC" set/reset
       ) ODDR2_inst (
      .Q(clk_out),                // 1-bit DDR output data
      .C0(pll_clk_o),             // 1-bit clock input
      .C1(~pll_clk_o),            // 1-bit clock input
      .CE(1'b1),                  // 1-bit clock enable input
      .D0(1'b1),                  // 1-bit data input (associated with C0)
      .D1(1'b0),                  // 1-bit data input (associated with C1)
      .R(1'b0),                   // 1-bit reset input
      .S(1'b0)                    // 1-bit set input
    );	  
	  

endmodule
