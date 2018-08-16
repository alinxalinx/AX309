`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name:    vga_driver
//
//////////////////////////////////////////////////////////////////////////////////
module vga_driver(
			input CLK,            //Bus2IP clk
			input RSTn,
			
			input [31:0] reg0,
			input [31:0] reg1,
			input [31:0] reg2,
			input [31:0] reg3,
			
   		output vga_hs,
			output vga_vs,
			output [4:0] vga_r,
			output [5:0] vga_g,
			output [4:0] vga_b

    );
//-----------------------------------------------------------//
// 水平扫描参数的设定640*480 60Hz VGA
//-----------------------------------------------------------//
parameter LinePeriod =800;            //行周期数
parameter H_SyncPulse=96;             //行同步脉冲（Sync a）
parameter H_BackPorch=48;             //显示后沿（Back porch b）
parameter H_ActivePix=640;            //显示时序段（Display interval c）
parameter H_FrontPorch=16;             //显示前沿（Front porch d）
parameter Hde_start=144;
parameter Hde_end=784;

//-----------------------------------------------------------//
// 垂直扫描参数的设定640*480 60Hz VGA
//-----------------------------------------------------------//
parameter FramePeriod =525;           //列周期数
parameter V_SyncPulse=2;              //列同步脉冲（Sync o）
parameter V_BackPorch=33;             //显示后沿（Back porch p）
parameter V_ActivePix=480;            //显示时序段（Display interval q）
parameter V_FrontPorch=10;             //显示前沿（Front porch r）
parameter Vde_start=35;
parameter Vde_end=515;


wire vga_clk;

reg[10 : 0] x_cnt;
reg[9 : 0]  y_cnt;

reg[4 : 0]  vga_r_reg;
reg[5 : 0]  vga_g_reg;
reg[4 : 0]  vga_b_reg;  
reg hsync_r;
reg vsync_r; 
reg hsync_de;
reg vsync_de;
  
  
reg [1:0] vga_div;  

//----------------------------------------------------------------
////////// 产生VGA clock 25Mhz
//----------------------------------------------------------------

assign vga_clk=vga_div[1];
 
always @(negedge CLK)  
    if(RSTn==1'b0)
		 vga_div<=0;
	 else 
	    vga_div<=vga_div+1'b1;
 
  
//----------------------------------------------------------------
////////// 水平扫描计数
//----------------------------------------------------------------
always @ (posedge vga_clk)
       if(1'b0)    x_cnt <= 1;
       else if(x_cnt == LinePeriod) x_cnt <= 1;
       else x_cnt <= x_cnt+ 1;
		 
//----------------------------------------------------------------
////////// 水平扫描信号hsync,hsync_de产生
//----------------------------------------------------------------
always @ (posedge vga_clk)
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
always @ (posedge vga_clk)
       if(1'b0) y_cnt <= 1;
       else if(y_cnt == FramePeriod) y_cnt <= 1;
       else if(x_cnt == LinePeriod) y_cnt <= y_cnt+1;

//----------------------------------------------------------------
////////// 垂直扫描信号vsync, vsync_de产生
//----------------------------------------------------------------
always @ (posedge vga_clk)
  begin
       if(1'b0) vsync_r <= 1'b1;
       else if(y_cnt == 1) vsync_r <= 1'b0;    //产生vsync信号
       else if(y_cnt == V_SyncPulse) vsync_r <= 1'b1;
		 
	    if(1'b0) vsync_de <= 1'b0;
       else if(y_cnt == Vde_start) vsync_de <= 1'b1;    //产生vsync_de信号
       else if(y_cnt == Vde_end) vsync_de <= 1'b0;	 
  end
		 
	
//----------------------------------------------------------------
////////// 彩色条测试图像产生
//----------------------------------------------------------------
 always @(negedge vga_clk)   
   begin
     if (x_cnt==144) begin                       //第1个彩条      
			    vga_r_reg<= reg0[31:27];
			    vga_g_reg<= reg0[26:21];
			    vga_b_reg<= reg0[20:16];				 
	  end			 
	  else if (x_cnt==224) begin                   //第2个彩条   
			    vga_r_reg<= reg0[15:11];
			    vga_g_reg<= reg0[10:5];
			    vga_b_reg<= reg0[4:0];
	  end						 
	  else if (x_cnt==304) begin                    //第3个彩条           
			    vga_r_reg<= reg1[31:27];
			    vga_g_reg<= reg1[26:21];
			    vga_b_reg<= reg1[20:16];	
	  end		
	  else if (x_cnt==384) begin                   //第4个彩条         
			    vga_r_reg<= reg1[15:11];
			    vga_g_reg<= reg1[10:5];
			    vga_b_reg<= reg1[4:0];
	  end						 
	  else if (x_cnt==464) begin                   //第5个彩条          
			    vga_r_reg<= reg2[31:27];
			    vga_g_reg<= reg2[26:21];
			    vga_b_reg<= reg2[20:16];
	  end						 
	  else if (x_cnt==544) begin                   //第6个彩条          
			    vga_r_reg<= reg2[15:11];
			    vga_g_reg<= reg2[10:5];
			    vga_b_reg<= reg2[4:0];	
	  end		
	  else if (x_cnt==624) begin                   //第7个彩条            
			    vga_r_reg<= reg3[31:27];
			    vga_g_reg<= reg3[26:21];
			    vga_b_reg<= reg3[20:16];	
	  end		
	  else if (x_cnt==704) begin                   //第8个彩条           
			    vga_r_reg<= reg3[15:11];
			    vga_g_reg<= reg3[10:5];
			    vga_b_reg<= reg3[4:0];	
	  end		
	  else if (x_cnt==784) begin           
			    vga_r_reg<= 0;
			    vga_g_reg<= 0;
			    vga_b_reg<= 0;	
	  end		
   
	end			  


  assign vga_hs = hsync_r;
  assign vga_vs = vsync_r;  
  assign vga_r = vga_r_reg;
  assign vga_g = vga_g_reg;
  assign vga_b = vga_b_reg;

	  

endmodule
