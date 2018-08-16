`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:28:51 01/05/2013 
// Design Name: 
// Module Name:    testuart 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module testdata(clk, dataout, wrsig);
input clk;
output[7:0] dataout;
output wrsig;
reg [7:0] dataout;
reg wrsig;
reg [7:0] cnt;
reg [4:0] i;

reg [7:0] volt [8:0];                       //存储字符voltage:

	 initial
	 begin
	 //定义发送的字符
	 volt[0]<=118;                          //存储字符v                          
	 volt[1]<=111;                          //存储字符o 
	 volt[2]<=108;                          //存储字符l
	 volt[3]<=116;                          //存储字符t
	 volt[4]<=97;                           //存储字符a
	 volt[5]<=103;                          //存储字符g
	 volt[6]<=101;                          //存储字符e
	 volt[7]<=58;                           //存储字符:
	 volt[8]<=10;                           //换行符
	 end

always @(posedge clk)
begin
  if(cnt == 254)
  begin
    dataout <= volt[i];         //每次数据加"1"
    wrsig <= 1'b1;                //产生发送命令
	 cnt<=0;
    i <= i+1'b1;
	 if (i == 8)
	     i<=0;
  end
  else
  begin
    wrsig <= 1'b0;
    cnt <= cnt + 8'd1;
  end
end
endmodule

