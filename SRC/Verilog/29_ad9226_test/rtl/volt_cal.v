`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name:    volt_cal 
//////////////////////////////////////////////////////////////////////////////////
module volt_cal(
   input        ad_clk,                  //
	
	input [11:0] ad_ch1,              //AD第1通道的数据
	input [11:0] ad_ch2,              //AD第2通道的数据


	output [19:0] ch1_dec,              //AD第1通道的数据(十进制)
	output [19:0] ch2_dec,              //AD第2通道的数据(十进制)
   
	output reg [7:0] ch1_sig,               //AD第1通道的数据正负字符
	output reg [7:0] ch2_sig                //AD第2通道的数据正负字符	

    );

reg [31:0] ch1_data_reg;
reg [31:0] ch2_data_reg;


reg [12:0] ch1_reg;
reg [12:0] ch2_reg;

reg [31:0] ch1_vol;              //AD第1通道的数据(16进制)
reg [31:0] ch2_vol;              //AD第2通道的数据(16进制)

//AD 电压换算
always @(posedge ad_clk)
begin
    if(ad_ch1[11]==1'b1) begin                     //如果是负电压
	    ch1_reg<=12'hfff - ad_ch1 + 1'b1;
		 ch1_sig <= 45;                                //'-' asic码
	 end
	 else begin
       ch1_reg<=ad_ch1;
		 ch1_sig<=43;                                //'-' asic码
	 end	 
		 
    if(ad_ch2[11]==1'b1) begin                     //如果是负电压
	    ch2_reg<=12'hfff - ad_ch2 + 1'b1;
		 ch2_sig<=45;                               //'-' asic码	 
	 end	 
	 else begin
	    ch2_reg<=ad_ch2;
		 ch2_sig<=43;                                //'-' asic码
	 end	
	 
 
end 		 


//AD 电压换算(1 LSB = 5V / 2048 = 2.44mV
always @(posedge ad_clk)
begin
	ch1_data_reg<=ch1_reg * 5000;			
	ch2_data_reg<=ch2_reg * 5000;
			
   ch1_vol<=ch1_data_reg >>11;
   ch2_vol<=ch2_data_reg >>11;

end	

//16进制转化为十进制的  
bcd bcd1_ist(         
               .hex           (ch1_vol[15:0]),
					.dec           (ch1_dec),
					.clk           (ad_clk)
					);

//16进制转化为十进制的  
bcd bcd2_ist(         
               .hex           (ch2_vol[15:0]),
					.dec           (ch2_dec),
					.clk           (ad_clk)
					);
  
  
endmodule


  