`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name:    key_dect 
//////////////////////////////////////////////////////////////////////////////////
module key_dect(
	input clk50M,
	input reset_n,
	input  key1,

 	output reg record_start,
	
//	output reg sdr_raddr_set,
	output reg sdr_waddr_set

    );

reg [15:0] down_counter;                 //按键按下寄存器
reg [15:0] up_counter;                 //按键松开寄存器

reg voice_en;

//按键按下处理程序
always @(negedge clk50M)
begin
   if (reset_n==1'b0) begin
	    down_counter<=0;
		 sdr_waddr_set<=1'b1;
		 record_start<=1'b0; 

	end
	else begin
	    if (key1==1'b1) begin                             //如果按钮没有按下，寄存器为0
	       down_counter<=0;
		    record_start<=1'b0;
       end 			 
	    else begin                                       //如果按钮按下
          if(down_counter<=16'h0350) begin            
              sdr_waddr_set<=1'b1;                     //sdr的写地址复位           
			     down_counter<=down_counter+1'b1;         //如果按钮按下并按下,计数  
			     record_start<=1'b0;
		    end	
  	       else if (down_counter==16'h0351) begin                  
			    down_counter<=down_counter+1'b1;
		       record_start<=1'b1;                      //一次按键有效开始录音                   
             sdr_waddr_set<=1'b0;
			 end
			 else
			    record_start<=1'b0;
       end
   end 
end


endmodule
