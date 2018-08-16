`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module name    uartctrl.v
// 说明：          如果串口接收到数据，发送接收到的数据到串口，如果没有接收到数据，默认不断的发送
//                存储的字符串
//////////////////////////////////////////////////////////////////////////////////
module uartctrl(
      input                   clk,
		input                   rdsig,                //串口接收数据有效信号
		input      [7:0]        rxdata,               //串口接收数据
	   output                  wrsig,                //串口发送指示信号
		output     [7:0]        dataout               //串口发送数据

);

reg [17:0] uart_wait;
reg [15:0] uart_cnt;
reg rx_data_valid;
reg [7:0] store [19:0];                        //存储发送字符
reg [2:0] uart_stat;                           //uart状态机
reg [8:0] k;                                   //用于指示发送的第几个数据
reg [7:0] dataout_reg;
reg data_sel;
reg wrsig_reg;

  
assign dataout = data_sel ?  dataout_reg : rxdata ;            //发送数据选择：data_sel高，选择存储的字符串，data_sel：低，选择接收的数据
assign wrsig = data_sel ?  wrsig_reg : rdsig;                  //发送请求选择：data_sel高，发送存储的字符串，data_sel：低，发送接收的数据


//存储串口要发送的字符串
always @(*)
begin     //定义发送的字符
	 store[0]<=72;                           //存储字符H
	 store[1]<=101;                          //存储字符e
	 store[2]<=108;                          //存储字符l
	 store[3]<=108;                          //存储字符l
	 store[4]<=111;                          //存储字符o                         
	 store[5]<=32;                           //存储字符空格
	 store[6]<=65;                           //存储字符A
	 store[7]<=76;                           //存储字符L
	 store[8]<=73;                           //存储字符I
	 store[9]<=78;                           //存储字符N
	 store[10]<=88;                          //存储字符X
	 store[11]<=32;                          //存储字符空格
	 store[12]<=65;                          //存储字符A
	 store[13]<=88;                          //存储字符X
	 store[14]<=53;                          //存储字符5
	 store[15]<=49;                          //存储字符1
	 store[16]<=54;                          //存储字符6
	 store[17]<=32;                          //存储字符空格
	 store[18]<=10;                          //换行符
	 store[19]<=13;                          //回车符
  end 
  
//串口发送控制，每隔一段时间产生一个发送字符串的命令  
always @(negedge clk)
begin
  if(rdsig == 1'b1) begin   //如果串口有接收到数据，停止发送字符串                        
		uart_wait <= 0;
		rx_data_valid <=1'b0;
  end
  else begin
    if (uart_wait ==18'h3ffff) begin                //等待一段时间(每隔一段时间发送字符串）,调整这参数可以改变发送字符串之间的时间间隔。
		uart_wait <= 0;
		rx_data_valid <=1'b1;	                      //等待时间结束，产生一个发送字符串有效信号脉冲
    end		
	 else begin
		uart_wait <= uart_wait+1'b1;
		rx_data_valid <=1'b0;
	 end
  end
end 
 
//////////////////////////////////////// 
//串口发送字符串控制程序，依次发送存储的字符串//
////////////////////////////////////////	
always @(posedge clk)
begin
  if(rdsig == 1'b1) begin   
		uart_cnt <= 0;
		uart_stat <= 3'b000; 
		data_sel<=1'b0;
		k<=0;
  end
  else begin
  	 case(uart_stat)
	 3'b000: begin               
       if (rx_data_valid == 1'b1) begin  //发送字符串有效信号为高，开始发送字符串
		    uart_stat <= 3'b001; 
			 data_sel<=1'b1; 
		 end
	 end	
	 3'b001: begin                      //发送19个字符   
         if (k == 18 ) begin           //发送第19个字符      		 
				 if(uart_cnt ==0) begin
					dataout_reg <= store[18]; 
					uart_cnt <= uart_cnt + 1'b1;
					wrsig_reg <= 1'b1;      //发送字符使能脉冲             			
				 end	
				 else if(uart_cnt ==254) begin    //等待一个字符发送完成，发送一个字符的时间为168个时钟，所以这里等待的时间需要大于168
					uart_cnt <= 0;
					wrsig_reg <= 1'b0; 				
					uart_stat <= 3'b010; 
					k <= 0;
				 end
				 else	begin			
					 uart_cnt <= uart_cnt + 1'b1;
					 wrsig_reg <= 1'b0;  
				 end
		  end
	     else begin                      //发送前18个字符   
				 if(uart_cnt ==0) begin      
					dataout_reg <= store[k]; 
					uart_cnt <= uart_cnt + 1'b1;
					wrsig_reg <= 1'b1;           //发送使能           			
				 end	
				 else if(uart_cnt ==254) begin    //等待一个数据发送完成，发送一个字符的时间为168个时钟，所以这里等待的时间需要大于168
					uart_cnt <= 0;
					wrsig_reg <= 1'b0; 
					k <= k + 1'b1;	               //k加1，发送下一个字符        			
				 end
				 else	begin			
					 uart_cnt <= uart_cnt + 1'b1;
					 wrsig_reg <= 1'b0;  
				 end
		 end	 
	 end
	 3'b010: begin       //发送finish	 
		 	uart_stat <= 3'b000;
			data_sel<=1'b0;	
	 end
	 default:uart_stat <= 3'b000;
    endcase 
  end
end

 
endmodule
