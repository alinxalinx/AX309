`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
module uart(
           input clk50,                     //50Mhz clock
			  input reset_n,
			  
			  input [19:0] ch1_dec,
			  input [19:0] ch2_dec,
            
           input [7:0] ch1_sig,
           input [7:0] ch2_sig,

           output tx			  
    );


/********************************************/
//存储待发送的串口信息
/********************************************/
reg [7:0] uart_ad [25:0];                        //存储发送字符
always @(clk)
begin     //定义发送的字符
   if(uart_stat==3'b000) begin
		 uart_ad[0]<=65;                           //存储字符 A 
		 uart_ad[1]<=68;                           //存储字符 D
		 uart_ad[2]<=49;                           //存储字符 1
		 uart_ad[3]<=58;                           //存储字符 : 
		 uart_ad[4]<=ch1_sig;                      //存储字符 正负   	 
		 uart_ad[5]<=ch1_dec[15:12] + 48;          //存储字符 个位                          
		 uart_ad[6]<=46;                           //存储字符 . 
		 uart_ad[7]<=ch1_dec[11:8] + 48;           //存储字符 小数点后一位
		 uart_ad[8]<=ch1_dec[7:4] + 48;            //存储字符 小数点后二位
		 uart_ad[9]<=ch1_dec[3:0] + 48;            //存储字符 小数点后三位
		 uart_ad[10]<=86;                          //存储字符 V
		 uart_ad[11]<=32;                          //存储字符 空格
		 uart_ad[12]<=32;                          //存储字符 空格
		 uart_ad[13]<=65;                          //存储字符 A 
		 uart_ad[14]<=68;                          //存储字符 D
		 uart_ad[15]<=50;                          //存储字符 2
		 uart_ad[16]<=58;                          //存储字符 : 
		 uart_ad[17]<=ch2_sig;                     //存储字符 正负   	 
		 uart_ad[18]<=ch2_dec[15:12] + 48;         //存储字符 个位                          
		 uart_ad[19]<=46;                          //存储字符 . 
		 uart_ad[20]<=ch2_dec[11:8] + 48;          //存储字符 小数点后一位
		 uart_ad[21]<=ch2_dec[7:4] + 48;           //存储字符 小数点后二位
		 uart_ad[22]<=ch2_dec[3:0] + 48;           //存储字符 小数点后三位
		 uart_ad[23]<=86;                          //存储字符 V 
		 uart_ad[24]<=10;                          //换行符
		 uart_ad[25]<=13;                          //回车符 
	end	 
end 

/********************************************/
//串口发送时间字符串
/********************************************/
reg [15:0] uart_cnt;
reg [2:0] uart_stat;

reg  [7:0]  txdata;             //串口发送字符
reg         wrsig;               //串口发送有效信号

reg [8:0] k;

reg [15:0] Time_wait;                  

always @(posedge clk )
begin
  if(!reset_n) begin   
		uart_cnt<=0;
		uart_stat<=3'b000;	
		k<=0;
  end
  else begin
  	 case(uart_stat)
	 3'b000: begin               
       if (Time_wait == 16'hffff) begin          //如果秒数据有变化
		    uart_stat<=3'b001; 
			 Time_wait<=0;
		 end
		 else begin
			 uart_stat<=3'b000; 
			 Time_wait<=Time_wait + 1'b1;
		 end
	 end	
	 3'b001: begin                        
         if (k == 25 ) begin          	//发送第26个字符 	 
				 if(uart_cnt ==0) begin
					txdata <= uart_ad[25]; 
					uart_cnt <= uart_cnt + 1'b1;
					wrsig <= 1'b1;                			
				 end	
				 else if(uart_cnt ==254) begin
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
	    else begin                      //发送前25个字符 
				 if(uart_cnt ==0) begin      
					txdata <= uart_ad[k]; 
					uart_cnt <= uart_cnt + 1'b1;
					wrsig <= 1'b1;                			
				 end	
				 else if(uart_cnt ==254) begin
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
		.clk50                   (clk50),                           
		.clkout                  (clk)             //串口发送时钟                 
 );

/*************串口发送程序************/
uarttx u1 (
		.clk                     (clk),                           
		.datain                  (txdata),
      .wrsig                   (wrsig), 
      .idle                    (idle), 	
	   .tx                      (tx)		
 );



endmodule
