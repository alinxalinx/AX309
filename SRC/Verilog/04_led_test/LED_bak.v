//-----------------------------------------------------------------------------
//-- $Id: LED.v, v 0.1 2012/06/28 10:28:54 Aku
//------------------------------------------------------------------------------
//-- Title         : Siga-S16 Verilog Examble
//-- File          : LED.v
//-- Project       : Siga-S16
//-- Author        : Aku  <sigadsp@126.com>
//-- Created       : 4.7.2012
//------------------------------------------------------------------------------
//-- Description   : Siga-S16 led example 
//------------------------------------------------------------------------------
//-- History       : 
//------------------------------------------------------------------------------
//-- Copyright (C) SigaDSP
//-- All rights reserved. Reproduction in whole or part is prohibited 
//-- without a written permission of the copyright owner.
//------------------------------------------------------------------------------


`timescale 1ns / 1ps


module led (
               // inputs:
                  clk,
                  rst,
                  LED
             );
             
//===========================================================================
// PORT declarations
//===========================================================================
input clk;
input rst;
output [3:0] LED;

reg [31:0] timer;
reg [3:0] LED_reg;



assign LED = LED_reg;

  always @(posedge clk or posedge rst)
    begin
      if (rst)
          timer[31:0] <= 0;
      else if (timer[31:0] == 200000000)
          timer[31:0] <= 0;		 
      else
          timer[31:0] <= timer[31:0] + 1;  
	 end


  always @(posedge clk or posedge rst)
    begin
      if (rst)
          LED_reg[2:0] <= 4'b1111;
      else if (timer == 50000000)
		begin
		    LED_reg[0] = 1'b1;
		    LED_reg[1] = 1'b1;
		    LED_reg[2] = 1'b1;
			 LED_reg[3] = 1'b0;
      end			 
      else if (timer == 100000000)
		begin
		    LED_reg[0] = 1'b1;
		    LED_reg[1] = 1'b1;
		    LED_reg[2] = 1'b0;
			 LED_reg[3] = 1'b1;
	   end
      else if (timer == 150000000)
		begin
		    LED_reg[0] = 1'b1;
		    LED_reg[1] = 1'b0;
		    LED_reg[2] = 1'b1; 
			 LED_reg[3] = 1'b1;
      end			 
      else if (timer == 200000000)
		begin
		    LED_reg[0] = 1'b0;
		    LED_reg[1] = 1'b1;
		    LED_reg[2] = 1'b1;
			 LED_reg[3] = 1'b1;
      end			 
    end
    
endmodule