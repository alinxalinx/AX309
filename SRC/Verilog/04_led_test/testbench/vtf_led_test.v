`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:48:23 07/30/2015
// Design Name:   led_test
// Module Name:   E:/Project/AX309/CD/09_VERILOG/02_led_test/testbench/vtf_led_test.v
// Project Name:  led_test
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: led_test
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
module vtf_led_test;
	// Inputs
	reg clk;
	reg rst_n;

	// Outputs
	wire [3:0] led;

	// Instantiate the Unit Under Test (UUT)
	led_test uut (
		.clk(clk), 
		.rst_n(rst_n), 
		.led(led)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst_n = 0;

		// Wait 100 ns for global reset to finish
		#100;
          rst_n = 1;        
		// Add stimulus here
         #2000;
         $stop;
	 end
   
    always #10 clk = ~ clk; //产生50MHz时钟源
   
endmodule
