`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name:    rtc_test 
// set and read the time from rtc, and send the time to uart port 
//////////////////////////////////////////////////////////////////////////////////

module rtc_test
(
    input          CLK_50M,
	 input          RSTn,
	 
	 input          rx,                  //uart rx
    output         tx,                  //uart tx 
	
	 output         DS1302_RST,                 //ds1302 CE/RST
	 output         DS1302_SCLK,                //ds1302 SCLK
	 inout          DS1302_SIO                  //ds1302 SIO
	 

);


	 
/*******************************/
wire [7:0] Time_second;
wire [7:0] Time_munite;
wire [7:0] Time_hour;

reg [7:0] Time_second_reg;

wire clk;

reg [7:0] time_disp [17:0];                        //存储发送字符

reg [15:0] uart_cnt;
reg [2:0] uart_stat;

reg  [7:0]  txdata;             //串口发送字符
reg         wrsig;               //串口发送有效信号

reg [8:0] k;
			  
/********************************************/
//存储待发送的时间字符
/********************************************/
always @(*)
begin     //定义发送的字符
	 time_disp[0]<=84;                           //存储字符T 
	 time_disp[1]<=105;                          //存储字符i
    time_disp[2]<=109;                          //存储字符m
	 time_disp[3]<=101;                          //存储字符e 	 
	 time_disp[4]<=32;                           //存储字符空格                           
	 time_disp[5]<=105;                          //存储字符i 
	 time_disp[6]<=115;                          //存储字符s
	 time_disp[7]<=32;                           //存储字符空格 
	 time_disp[8]<=Time_hour[7:4]+48;            //存储字符小时十位
	 time_disp[9]<=Time_hour[3:0]+48;            //存储字符小时
	 time_disp[10]<=58;                           //存储字符:
	 time_disp[11]<=Time_munite[7:4]+48;         //存储字符分钟十位
	 time_disp[12]<=Time_munite[3:0]+48;         //存储字符分钟
	 time_disp[13]<=58;                          //存储字符:
	 time_disp[14]<=Time_second[7:4]+48;         //存储字符秒钟十位
	 time_disp[15]<=Time_second[3:0]+48;         //存储字符秒钟
	 time_disp[16]<=10;                          //换行符
	 time_disp[17]<=13;                          //回车符 
end 

/********************************************/
//串口发送时间字符串
/********************************************/
always @(posedge clk )
begin
  if(!RSTn) begin   
		uart_cnt <= 0;
		uart_stat <= 3'b000;	
		k<=0;
  end
  else begin
  	 case(uart_stat)
	 3'b000: begin               
       if (Time_second_reg != Time_second) begin          //如果秒数据有变化,向串口发送时间信息time_disp[0]~time_disp[17]
		    uart_stat <= 3'b001; 
			 Time_second_reg<=Time_second;
		 end
		 else begin
			 uart_stat <= 3'b000; 
			 Time_second_reg<=Time_second;
		 end
	 end	
	 3'b001: begin                      //发送第18个字符time_disp[17]  
         if (k == 17 ) begin          		 
				 if(uart_cnt ==0) begin
					txdata <= time_disp[17]; 
					uart_cnt <= uart_cnt + 1'b1;
					wrsig <= 1'b1;                	//uart发送有效			
				 end	
				 else if(uart_cnt ==254) begin      //发送一个字符的等待时间为255个时钟,等待时间只要大于168个时钟(一个字节发送的时间)
					uart_cnt <= 0;
					wrsig <= 1'b0; 				
					uart_stat <= 3'b010; 
					k <= 0;
				 end
				 else	begin			
					 uart_cnt <= uart_cnt + 1'b1;
					 wrsig <= 1'b0;  
				 end
		 end
	    else begin
				 if(uart_cnt ==0) begin      //发送前17个字符 
					txdata <= time_disp[k]; 
					uart_cnt <= uart_cnt + 1'b1;
					wrsig <= 1'b1;                			
				 end	
				 else if(uart_cnt ==254) begin //发送一个字符的等待时间为255个时钟,等待时间只要大于168个时钟(一个字节发送的时间)
					uart_cnt <= 0;
					wrsig <= 1'b0; 
					k <= k + 1'b1;				
				 end
				 else	begin			
					 uart_cnt <= uart_cnt + 1'b1;
					 wrsig <= 1'b0;  
				 end
		 end	 
	 end
	 3'b010: begin       //发送finish	 
		 	uart_stat <= 3'b000; 
	 end
	 default:uart_stat <= 3'b000;
    endcase 
  end
end
	 
/**********产生串口时钟***********/
clkdiv u0 (
		.clk50                   (CLK_50M),                           
		.clkout                  (clk)             //串口发送时钟                 
 );

/**********串口发送程序***********/
uarttx u1 (
		.clk                     (clk),                           
		.datain                  (txdata),
      .wrsig                   (wrsig), 
      .idle                    (idle), 	
	   .tx                      (tx)		
 );
 
/**********RTC时钟控制程序***********/	 
rtc_time U2 (

      .CLK( CLK_50M ), 
	   .RSTn( RSTn ),
		 
	   .Time_second( Time_second ),             //DS1302读到的秒数据
	   .Time_munite( Time_munite ),             //DS1302读到的分数据
	   .Time_hour( Time_hour ),                 //DS1302读到的时数据

	   .RST( DS1302_RST ),
	   .SCLK( DS1302_SCLK ),
	   .SIO( DS1302_SIO )	 

);
	 

wire [35:0]   CONTROL0;
wire [255:0]  TRIG0;
chipscope_icon icon_debug (
    .CONTROL0(CONTROL0) // INOUT BUS [35:0]
);

chipscope_ila ila_filter_debug (
    .CONTROL(CONTROL0), // INOUT BUS [35:0]
   // .CLK(dma_clk),      // IN
    .CLK(CLK_50M),      // IN
    .TRIG0(TRIG0)      // IN BUS [255:0]
    //.TRIG_OUT(TRIG_OUT0)
);                                                     

assign  TRIG0[7:0]=Time_second;                                               
assign  TRIG0[15:8]=Time_munite;           
assign  TRIG0[23:16]=Time_hour;           

assign  TRIG0[24]=DS1302_RST; 
assign  TRIG0[25]=DS1302_SCLK; 
assign  TRIG0[26]=DS1302_SIO; 
	 

endmodule
