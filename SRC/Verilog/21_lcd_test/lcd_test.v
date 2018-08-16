`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: ALINX 
// Additional Comments: 
//////////////////////////////////////////////////////////////////////////////////
module lcd_test(
	 input clk_50M,                 //FPGA的系统时钟输入
	 input reset_n,                 
	 input key1,                    //按键1控制LCD显示模式
 
	 output lcd_dclk,
	 output [7:0] lcd_r,
    output [7:0] lcd_g,
    output [7:0] lcd_b,
    output lcd_hsync,
    output lcd_vsync,
    output lcd_de
	     );


//-----------------------------------------------------------//
// 水平扫描参数的设定480*272 60Hz LCD
//-----------------------------------------------------------//
parameter LinePeriod =525;           //行周期数
parameter H_SyncPulse=41;            //行同步脉冲（Sync a）
parameter H_BackPorch=2;             //显示后沿（Back porch b）
parameter H_ActivePix=480;           //显示时序段（Display interval c）
parameter H_FrontPorch=2;            //显示前沿（Front porch d）
parameter Hde_start=43;
parameter Hde_end=523;

//-----------------------------------------------------------//
// 垂直扫描参数的设定480*272 60Hz LCD
//-----------------------------------------------------------//
parameter FramePeriod =286;           //列周期数
parameter V_SyncPulse=10;             //列同步脉冲（Sync o）
parameter V_BackPorch=2;              //显示后沿（Back porch p）
parameter V_ActivePix=272;            //显示时序段（Display interval q）
parameter V_FrontPorch=2;             //显示前沿（Front porch r）
parameter Vde_start=12;
parameter Vde_end=284;


  reg[10 : 0] x_cnt;
  reg[9 : 0]  y_cnt;
  reg[7 : 0] grid_data_1;
  reg[7 : 0] grid_data_2;
  reg[23 : 0] bar_data;
  reg[3 : 0] lcd_dis_mode;
  reg[7 : 0]  lcd_r_reg;
  reg[7 : 0]  lcd_g_reg;
  reg[7 : 0]  lcd_b_reg;  
  reg hsync_r;
  reg vsync_r; 
  reg hsync_de;
  reg vsync_de;
  
  reg [15:0] key1_counter;                 //按键检测寄存器
  
  wire lcd_clk;
  
  wire [12:0]  bar_interval;

 //LCD输出信号赋值
  assign lcd_dclk = ~lcd_clk;
  assign lcd_hsync = hsync_r;
  assign lcd_vsync = vsync_r;
  assign lcd_de = hsync_de & vsync_de;
  assign lcd_r = (hsync_de & vsync_de)?lcd_r_reg:8'b00000000;
  assign lcd_g = (hsync_de & vsync_de)?lcd_g_reg:8'b00000000;
  assign lcd_b = (hsync_de & vsync_de)?lcd_b_reg:8'b00000000;
 
  assign	bar_interval 	= H_ActivePix[15: 3];         //彩条宽度=H_ActivePix/8

//----------------------------------------------------------------
////////// 水平扫描计数
//----------------------------------------------------------------
always @ (posedge lcd_clk)
       if(1'b0)    x_cnt <= 1;
       else if(x_cnt == LinePeriod) x_cnt <= 1;
       else x_cnt <= x_cnt+ 1;
		 
//----------------------------------------------------------------
////////// 水平扫描信号hsync,hsync_de产生
//----------------------------------------------------------------
always @ (posedge lcd_clk)
   begin
       if(~reset_n) hsync_r <= 1'b1;
       else if(x_cnt == 1) hsync_r <= 1'b0;            //产生hsync信号
       else if(x_cnt == H_SyncPulse) hsync_r <= 1'b1;
		 
		 		 
	    if(1'b0) hsync_de <= 1'b0;
       else if(x_cnt == Hde_start) hsync_de <= 1'b1;    //产生hsync_de信号
       else if(x_cnt == Hde_end) hsync_de <= 1'b0;	
	end

//----------------------------------------------------------------
////////// 垂直扫描计数
//----------------------------------------------------------------
always @ (posedge lcd_clk)
       if(~reset_n) y_cnt <= 1;
       else if(y_cnt == FramePeriod) y_cnt <= 1;
       else if(x_cnt == LinePeriod) y_cnt <= y_cnt+1;

//----------------------------------------------------------------
////////// 垂直扫描信号vsync, vsync_de产生
//----------------------------------------------------------------
always @ (posedge lcd_clk)
  begin
       if(~reset_n) vsync_r <= 1'b1;
       else if(y_cnt == 1) vsync_r <= 1'b0;    //产生vsync信号
       else if(y_cnt == V_SyncPulse) vsync_r <= 1'b1;
		 
	    if(~reset_n) vsync_de <= 1'b0;
       else if(y_cnt == Vde_start) vsync_de <= 1'b1;    //产生vsync_de信号
       else if(y_cnt == Vde_end) vsync_de <= 1'b0;	 
  end
		 

//----------------------------------------------------------------
////////// 格子测试图像产生
//----------------------------------------------------------------
 always @(posedge lcd_clk)   
   begin
     if ((x_cnt[4]==1'b1) ^ (y_cnt[4]==1'b1))            //产生格子1图像
			    grid_data_1<= 8'h00;
	  else
			    grid_data_1<= 8'hff;
				 
	  if ((x_cnt[6]==1'b1) ^ (y_cnt[6]==1'b1))            //产生格子2图像 
			    grid_data_2<=8'h00;
	  else
				 grid_data_2<=8'hff; 
   
	end
	
//----------------------------------------------------------------
////////// 彩色条测试图像产生
//----------------------------------------------------------------
 always @(posedge lcd_clk)   
   begin
     if (x_cnt==Hde_start)            
			    bar_data<=24'hff0000;              //红色彩条
	  else if (x_cnt==Hde_start + bar_interval)
			    bar_data<=24'h00ff00;              //绿色彩条				 
	  else if (x_cnt==Hde_start + bar_interval*2)            
			    bar_data<=24'h0000ff;               //蓝色彩条
	  else if (x_cnt==Hde_start + bar_interval*3)         
			    bar_data<=24'hff00ff;               //紫色彩条
	  else if (x_cnt==Hde_start + bar_interval*4)           
			    bar_data<=24'hffff00;               //黄色彩条
	  else if (x_cnt==Hde_start + bar_interval*5)            
			    bar_data<=24'h00ffff;               //青色彩条
	  else if (x_cnt==Hde_start + bar_interval*6)             
			    bar_data<=24'hffffff;               //白色彩条
	  else if (x_cnt==Hde_start + bar_interval*7)            
			    bar_data<=24'h000000;               //黑色彩条
	  else              
			    bar_data<=bar_data;               //其余
   
	end
	
//----------------------------------------------------------------
////////// LCD图像选择输出
//----------------------------------------------------------------
 //LCD数据信号选择 
 always @(posedge lcd_clk)  
    if(~reset_n) begin 
	    lcd_r_reg<=0; 
	    lcd_g_reg<=0;
	    lcd_b_reg<=0;		 
	end
   else
     case(lcd_dis_mode)
         4'b0000:begin
			        lcd_r_reg<=0;                        //LCD显示全黑
                 lcd_g_reg<=0;
                 lcd_b_reg<=0;
			end
			4'b0001:begin
			        lcd_r_reg<=8'b11111111;                 //LCD显示全白
                 lcd_g_reg<=8'b11111111;
                 lcd_b_reg<=8'b11111111;
			end
			4'b0010:begin
			        lcd_r_reg<=8'b11111111;                //LCD显示全红
                 lcd_g_reg<=0;
                 lcd_b_reg<=0;  
         end			  
	      4'b0011:begin
			        lcd_r_reg<=0;                          //LCD显示全绿
                 lcd_g_reg<=8'b11111111;
                 lcd_b_reg<=0; 
         end					  
         4'b0100:begin     
			        lcd_r_reg<=0;                         //LCD显示全蓝
                 lcd_g_reg<=0;
                 lcd_b_reg<=8'b11111111;
			end
         4'b0101:begin     
			        lcd_r_reg<=grid_data_1;               // LCD显示方格1
                 lcd_g_reg<=grid_data_1;
                 lcd_b_reg<=grid_data_1;
         end					  
         4'b0110:begin     
			        lcd_r_reg<=grid_data_2;              // LCD显示方格2
                 lcd_g_reg<=grid_data_2;
                 lcd_b_reg<=grid_data_2;
			end
		   4'b0111:begin     
			        lcd_r_reg<=x_cnt[7:0];              //LCD显示水平渐变色
                 lcd_g_reg<=x_cnt[7:0];
                 lcd_b_reg<=x_cnt[7:0];
			end
		   4'b1000:begin     
			        lcd_r_reg<=y_cnt[8:1];                 //LCD显示垂直渐变色
                 lcd_g_reg<=y_cnt[8:1];
                 lcd_b_reg<=y_cnt[8:1];
			end
		   4'b1001:begin     
			        lcd_r_reg<=x_cnt[7:0];                //LCD显示红水平渐变色
                 lcd_g_reg<=0;
                 lcd_b_reg<=0;
			end
		   4'b1010:begin     
			        lcd_r_reg<=0;                         //LCD显示绿水平渐变色
                 lcd_g_reg<=x_cnt[7:0];
                 lcd_b_reg<=0;
			end
		   4'b1011:begin     
			        lcd_r_reg<=0;                            //LCD显示蓝水平渐变色
                 lcd_g_reg<=0;
                 lcd_b_reg<=x_cnt[7:0];			
			end
		   4'b1100:begin     
			        lcd_r_reg<=bar_data[23:16];              //LCD显示彩色条
                 lcd_g_reg<=bar_data[15:8];
                 lcd_b_reg<=bar_data[7:0];			
			end
		   default:begin
			        lcd_r_reg<=8'b11111111;                 //LCD显示全白
                 lcd_g_reg<=8'b11111111;
                 lcd_b_reg<=8'b11111111;
			end					  
         endcase

 //按钮处理程序	
  always @(posedge lcd_clk)
	  begin
	    if (key1==1'b0)                               //如果按钮没有按下，寄存器为0
	       key1_counter<=0;
	    else if ((key1==1'b1)& (key1_counter<=16'hc350))      //如果按钮按下并按下时间少于1ms,计数      
          key1_counter<=key1_counter+1'b1;
  	  
       if (key1_counter==16'hc349)                //一次按钮有效，改变显示模式
		    begin
		      if(lcd_dis_mode==4'b1101)
			      lcd_dis_mode<=4'b0000;
			   else
			      lcd_dis_mode<=lcd_dis_mode+1'b1; 
          end	
     end		
	  
 //产生LCD的时钟
	  pll pll_inst
   (// Clock in ports
    .CLK_IN1(clk_50M),      // IN
    // Clock out ports
    .CLK_OUT1(lcd_clk),     // OUT: 9Mhz lcd clock 
    // Status and control signals
    .RESET(~reset_n),// IN
    .LOCKED(LOCKED));      // OUT
			
endmodule



