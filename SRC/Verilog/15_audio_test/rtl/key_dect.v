`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name:    key_dect 
//////////////////////////////////////////////////////////////////////////////////
module key_dect(
	input clk50M,
	input reset_n,
	input  key1,

 	output reg record_en,
	output reg play_en,  	
	output reg sdr_raddr_set,
	output reg sdr_waddr_set

    );

reg [15:0] down_counter;                 //按键按下寄存器
reg [15:0] up_counter;                 //按键松开寄存器

//按键按下处理程序
always @(posedge clk50M)
begin
   if (reset_n==1'b0) begin
	    down_counter<=0;
		 sdr_waddr_set<=1'b0;
		 record_en<=1'b0; 
	end
	else begin
	    if (key1==1'b1) begin                             //如果按钮没有按下，寄存器为0
	       down_counter<=0;
		    record_en<=1'b0;
          sdr_waddr_set<=1'b0;  
       end 			 
	    else if ((key1==1'b0)& (down_counter<=16'hc350)) begin            
         sdr_waddr_set<=1'b1;                     //sdr的写地址复位           
			down_counter<=down_counter+1'b1;         //如果按钮按下并按下,计数  
			record_en<=1'b0;
		 end	
  	    else if (down_counter==16'hc351) begin                //按钮已按下，开始录音   
			down_counter<=down_counter;
		   record_en<=1'b1;
         sdr_waddr_set<=1'b0;  			
       end
   end 
end

//按键松开处理程序
always @(posedge clk50M)
begin
   if (reset_n==1'b0) begin
	    up_counter<=0;
		 sdr_raddr_set<=1'b0;
		 play_en<=1'b0; 
	end
	else begin
	    if (key1==1'b0) begin                              //如果按钮没有松开，寄存器为0
	       up_counter<=0;
			 play_en<=1'b0;
          sdr_raddr_set<=1'b0;    
		 end
	    else if ((key1==1'b1)& (up_counter<=16'hc350)) begin            
         sdr_raddr_set<=1'b1;                     //sdr的写地址复位           
			up_counter<=up_counter+1'b1;             //如果按钮按下并按下,计数  
			play_en<=1'b0;
		 end
       else if (up_counter==16'hc351) begin                 //按钮已松开，开始播放
			up_counter<=up_counter;	
			play_en<=1'b1;	
         sdr_raddr_set<=1'b0;                               //ddr的写地址复位 			
		 end
    end 
end

endmodule
