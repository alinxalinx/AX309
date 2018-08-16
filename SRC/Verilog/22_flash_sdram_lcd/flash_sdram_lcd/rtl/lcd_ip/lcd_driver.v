`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name:    lcd_driver 
//////////////////////////////////////////////////////////////////////////////////
module lcd_driver(
	 input clk_lcd,                 //LCD的时钟输入
	 input lcd_rst,                 
	 input key1,                    //按键1控制LCD显示模式
 
	 output lcd_dclk,
	 output [7:0] lcd_r,
    output [7:0] lcd_g,
    output [7:0] lcd_b,
    output lcd_hsync,
    output lcd_vsync,
    output lcd_de,

	 input [95:0] lcd_data,          //lcd显示数据	 
	 output reg sdr_addr_set,        //sdram读地址复位信号
	 output lcd_framesync,
	 output lcd_rden
);

  reg[10 : 0] x_cnt;
  reg[9 : 0]  y_cnt;
  reg[7 : 0] grid_data_1;
  reg[7 : 0] grid_data_2;
  reg[23 : 0] bar_data;
  reg[3 : 0] lcd_dis_mode=4'b1101;         //默认显示flash图片
  reg[7 : 0]  lcd_r_reg;
  reg[7 : 0]  lcd_g_reg;
  reg[7 : 0]  lcd_b_reg;  
  reg hsync_r;
  reg vsync_r; 
  reg hsync_de;
  reg vsync_de;

reg [95:0] lcd_data_reg;    //sdram图像数据寄存器
reg [2:0] num_counter;       

reg [7:0] lcd_data_r;        //sdram 图像数据red
reg [7:0] lcd_data_g;        //sdram 图像数据green
reg [7:0] lcd_data_b;        //sdram 图像数据blue

reg lcd_vsync_buf1;
reg lcd_vsync_buf2; 

reg sdr_rd_req;               //sdram读请求

reg [15:0] key1_counter;      //按键检测

 //LCD输出信号赋值
  assign lcd_dclk=~clk_lcd;
  assign lcd_hsync = hsync_r;
  assign lcd_vsync = vsync_r;
  assign lcd_de = hsync_de & vsync_de;
  assign lcd_r = (hsync_de & vsync_de)?lcd_r_reg:8'b00000000;
  assign lcd_g = (hsync_de & vsync_de)?lcd_g_reg:8'b00000000;
  assign lcd_b = (hsync_de & vsync_de)?lcd_b_reg:8'b00000000;
  
  assign lcd_rden=sdr_rd_req;  
  assign lcd_framesync=vsync_de;
  
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
	
//----------------------------------------------------------------
////////// 水平扫描计数
//----------------------------------------------------------------
always @ (posedge clk_lcd)
       if(1'b0)    x_cnt <= 1;
       else if(x_cnt == LinePeriod) x_cnt <= 1;
       else x_cnt <= x_cnt+ 1;
		 
//----------------------------------------------------------------
////////// 水平扫描信号hsync,hsync_de产生
//----------------------------------------------------------------
always @ (posedge clk_lcd)
   begin
       if(1'b0) hsync_r <= 1'b1;
       else if(x_cnt == 1) hsync_r <= 1'b0;            //产生hsync信号
       else if(x_cnt == H_SyncPulse) hsync_r <= 1'b1;
		 
		 		 
	    if(1'b0) hsync_de <= 1'b0;
       else if(x_cnt == Hde_start) hsync_de <= 1'b1;    //产生hsync_de信号
       else if(x_cnt == Hde_end) hsync_de <= 1'b0;	
	end

//----------------------------------------------------------------
////////// 垂直扫描计数
//----------------------------------------------------------------
always @ (posedge clk_lcd)
       if(1'b0) y_cnt <= 1;
       else if(y_cnt == FramePeriod) y_cnt <= 1;
       else if(x_cnt == LinePeriod) y_cnt <= y_cnt+1;

//----------------------------------------------------------------
////////// 垂直扫描信号vsync, vsync_de产生
//----------------------------------------------------------------
always @ (posedge clk_lcd)
  begin
       if(1'b0) vsync_r <= 1'b1;
       else if(y_cnt == 1) vsync_r <= 1'b0;    //产生vsync信号
       else if(y_cnt == V_SyncPulse) vsync_r <= 1'b1;
		 
	    if(1'b0) vsync_de <= 1'b0;
       else if(y_cnt == Vde_start) vsync_de <= 1'b1;    //产生vsync_de信号
       else if(y_cnt == Vde_end) vsync_de <= 1'b0;	 
  end
		 

//----------------------------------------------------------------
////////// 格子测试图像产生
//----------------------------------------------------------------
 always @(posedge clk_lcd)   
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
 always @(posedge clk_lcd)   
   begin
     if (x_cnt==43)            
			    bar_data <= 24'hff0000;               //红色
	  else if (x_cnt==103)
			    bar_data <= 24'h00ff00;               //红色				 
	  else if (x_cnt==163)            
			    bar_data <= 24'h0000ff;               //蓝色
	  else if (x_cnt==223)            
			    bar_data <= 24'hff00ff;               //紫色
	  else if (x_cnt==283)            
			    bar_data <= 24'hffff00;               //黄色
	  else if (x_cnt==363)            
			    bar_data <= 24'h00ffff;               //青色
	  else if (x_cnt==423)            
			    bar_data <= 24'hffffff;               //黑色
	  else if (x_cnt==483)            
			    bar_data <= 24'h000000;               //白色
	  else          
			    bar_data <= bar_data;
   
	end
	
//----------------------------------------------------------------
////////// LCD图像选择输出
//----------------------------------------------------------------
 //LCD数据信号选择 
 always @(posedge clk_lcd)  
    if(1'b0) begin 
	    lcd_r_reg<=0; 
	    lcd_g_reg<=0;
	    lcd_b_reg<=0;		 
	end
   else
     case(lcd_dis_mode)
         4'b0000:begin
			        lcd_r_reg<=0;                          //LCD显示全黑
                 lcd_g_reg<=0;
                 lcd_b_reg<=0;
			end
			4'b0001:begin
			        lcd_r_reg<=8'b11111111;                //LCD显示全白
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
			        lcd_r_reg<=0;                          //LCD显示全蓝
                 lcd_g_reg<=0;
                 lcd_b_reg<=8'b11111111;
			end
         4'b0101:begin     
			        lcd_r_reg<=grid_data_1;                // LCD显示方格1
                 lcd_g_reg<=grid_data_1;
                 lcd_b_reg<=grid_data_1;
         end					  
         4'b0110:begin     
			        lcd_r_reg<=grid_data_2;                // LCD显示方格2
                 lcd_g_reg<=grid_data_2;
                 lcd_b_reg<=grid_data_2;
			end
		   4'b0111:begin     
			        lcd_r_reg<=x_cnt[7:0];                 //LCD显示水平渐变色
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
			        lcd_r_reg<=0;                         //LCD显示蓝水平渐变色
                 lcd_g_reg<=0;
                 lcd_b_reg<=x_cnt[7:0];			
			end
		   4'b1100:begin     
			        lcd_r_reg<=bar_data[23:16];           //LCD显示彩色条
                 lcd_g_reg<=bar_data[15:8];
                 lcd_b_reg<=bar_data[7:0];			
			end
			4'b1101:begin     
			        lcd_r_reg<=lcd_data_r;                //LCD显示图片
                 lcd_g_reg<=lcd_data_g;
                 lcd_b_reg<=lcd_data_b;
					  end
		   default:begin
			        lcd_r_reg<=8'b11111111;               //LCD显示全白
                 lcd_g_reg<=8'b11111111;
                 lcd_b_reg<=8'b11111111;
			end					  
         endcase;

 //按钮处理程序	
  always @(posedge clk_lcd)
	  begin
	    if (key1==1'b1)                               //如果按钮没有按下，寄存器为0
	       key1_counter<=0;
	    else if ((key1==1'b0)& (key1_counter<=16'hc350))      //如果按钮按下并按下时间少于1ms,计数      
          key1_counter<=key1_counter+1'b1;
  	  
       if (key1_counter==16'hc349)                //一次按钮有效，改变显示模式
		    begin
		      if(lcd_dis_mode==4'b1101)
			      lcd_dis_mode<=4'b0000;
			   else
			      lcd_dis_mode<=lcd_dis_mode+1'b1; 
          end	
     end		

 //产生sdram地址复位信号	
  always @(posedge clk_lcd)
   if (lcd_rst) begin
	    lcd_vsync_buf1<=1'b0;
		 lcd_vsync_buf2<=1'b0;
	    sdr_addr_set<=1'b0;
     end
   else begin
		 lcd_vsync_buf1<=lcd_vsync;
		 lcd_vsync_buf2<=lcd_vsync_buf1;
       if (lcd_vsync_buf2&~lcd_vsync_buf1)      //如果检测到vsync信号为下降沿,sdram地址复位
		   sdr_addr_set<=1'b1;
		 else
		   sdr_addr_set<=1'b0;		   
	end
	
 //96位的图像分4个像数输出
 always @(posedge clk_lcd)
 begin
   if (lcd_rst) begin
		 lcd_data_reg<=96'd0;
		 lcd_data_r<=8'd0;
		 lcd_data_g<=8'd0;
		 lcd_data_b<=8'd0;
		 num_counter<=3'b000;
		 sdr_rd_req<=1'b0;   
   end
   else begin
       if (hsync_de && vsync_de)              //hsync_de和vsync_de有效时输出图像数据
		   begin
			  case(num_counter)
			    3'b000:begin 
                  lcd_data_b<=lcd_data[95:88];           //输出第1个像数
                  lcd_data_g<=lcd_data[87:80];
                  lcd_data_r<=lcd_data[79:72];	
						num_counter<=3'b001;
						lcd_data_reg<=lcd_data;
				      sdr_rd_req<=1'b0;  						
						end
			    3'b001:begin                                  //输出第2个像数
                  lcd_data_b<=lcd_data_reg[71:64];
                  lcd_data_g<=lcd_data_reg[63:56];
                  lcd_data_r<=lcd_data_reg[55:48];
						num_counter<=3'b010;
						sdr_rd_req<=1'b0; 
                  end						
			    3'b010:begin                                 //输出第3个像数
                  lcd_data_b<=lcd_data_reg[47:40];
                  lcd_data_g<=lcd_data_reg[39:32];
                  lcd_data_r<=lcd_data_reg[31:24];
						num_counter<=3'b011;	
						sdr_rd_req<=1'b1;                       //产生一次sdram读,读取96bit                     
						end
			    3'b011:begin                                //输出第4个像数
                  lcd_data_b<=lcd_data_reg[23:16];
                  lcd_data_g<=lcd_data_reg[15:8];
                  lcd_data_r<=lcd_data_reg[7:0];
						num_counter<=3'b000;	
						sdr_rd_req<=1'b0;	
                  end		
            default:begin
					  lcd_data_b<=8'd0;                    
                 lcd_data_g<=8'd0;
                 lcd_data_r<=8'd0;
					  num_counter<=3'b000;	
					  sdr_rd_req<=1'b0;
					  end
				endcase;
			end
		else begin
			  lcd_data_b<=8'd0;                    
           lcd_data_g<=8'd0;
           lcd_data_r<=8'd0;
		     sdr_rd_req<=1'b0;
			  num_counter<=3'b000;	
			  lcd_data_reg<=lcd_data;                 //sdram数据锁存
		end
	end
end


endmodule
