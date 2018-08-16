/*-------------------------------------------------------------------------
Description			:		generate system reset and clock for sdram.
===========================================================================
15/02/1
--------------------------------------------------------------------------*/
`timescale 1 ns / 1 ns
module system_ctrl
(
	input 		clk,		//50MHz
	input 		rst_n,		//global reset

	output 		sys_rst_n,	//system reset
	output 		clk_c0,		
	output 		clk_c1,
	output		clk_c2,	//-75deg
	output		clk_c3	//-75deg
);

//----------------------------------------------
reg  [9:0]   delay_cnt;
reg  delay_done;
always @(posedge clk_c0 or negedge rst_n)
begin
	if(!rst_n)
		begin
		delay_cnt <= 0;
		delay_done <= 1'b0;
		end
	else
		begin
		  if (delay_cnt== 1000)
			 delay_done <= 1'b1;
        else
          delay_cnt <= delay_cnt +1'b1;
		end
end

assign sys_rst_n=delay_done;
//----------------------------------------------
//Component instantiation
wire 	locked;
wire clk_c3_oddr;	
sdram_pll	u_sdram_pll
(
	.CLK_IN1	(clk),
	.RESET	(~rst_n),
	.LOCKED	(locked),
			
	.CLK_OUT1      (clk_c0),
	.CLK_OUT2		(clk_c1),
	.CLK_OUT3		(clk_c2),
	.CLK_OUT4		(clk_c3)
);


endmodule
