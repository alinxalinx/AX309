//===========================================================================
// Module name: key_test.v
// 描述: 检测开发板上的四个按键KEY1~KEY4, 当检测到按键按下时,相应的LED灯翻转
//===========================================================================
`timescale 1ns / 1ps
module key_test  (
							clk,              // 开发板上输入时钟: 50Mhz
							rst_n,            // 开发板上输入复位按键
							key_in,           // 输入按键信号(KEY1~KEY4)
							led_out           // 输出LED灯,用于控制开发板上四个LED(LED1~LED4)
						);

//===========================================================================
// PORT declarations
//===========================================================================						
input        clk; 
input        rst_n;
input  [3:0] key_in;
output [3:0] led_out;

//寄存器定义
reg [19:0] count;
reg [3:0] key_scan; //按键扫描值KEY

//===========================================================================
// 采样按键值，20ms扫描一次,采样频率小于按键毛刺频率，相当于滤除掉了高频毛刺信号。
//===========================================================================
always @(posedge clk or negedge rst_n)     //检测时钟的上升沿和复位的下降沿
begin
   if(!rst_n)                //复位信号低有效
      count <= 20'd0;        //计数器清0
   else
      begin
         if(count ==20'd999_999)   //20ms扫描一次按键,20ms计数(50M/50-1=999_999)
            begin
               count <= 20'b0;     //计数器计到20ms，计数器清零
               key_scan <= key_in; //采样按键输入电平
            end
         else
            count <= count + 20'b1; //计数器加1
     end
end
//===========================================================================
// 按键信号锁存一个时钟节拍
//===========================================================================
reg [3:0] key_scan_r;
always @(posedge clk)
    key_scan_r <= key_scan;       
    
wire [3:0] flag_key = key_scan_r[3:0] & (~key_scan[3:0]);  //当检测到按键有下降沿变化时，代表该按键被按下，按键有效 

//===========================================================================
// LED灯控制,按键按下时,相关的LED输出翻转
//===========================================================================
reg [3:0] temp_led;
always @ (posedge clk or negedge rst_n)      //检测时钟的上升沿和复位的下降沿
begin
    if (!rst_n)                 //复位信号低有效
         temp_led <= 4'b1111;   //LED灯控制信号输出为低, LED灯全亮
    else
         begin            
             if ( flag_key[0] ) temp_led[0] <= ~temp_led[0];   //按键KEY1值变化时，LED1将做亮灭翻转
             if ( flag_key[1] ) temp_led[1] <= ~temp_led[1];   //按键KEY2值变化时，LED2将做亮灭翻转
             if ( flag_key[2] ) temp_led[2] <= ~temp_led[2];   //按键KEY3值变化时，LED3将做亮灭翻转
             if ( flag_key[3] ) temp_led[3] <= ~temp_led[3];   //按键KEY4值变化时，LED4将做亮灭翻转
         end
end
 
 assign led_out[0] = temp_led[0];
 assign led_out[1] = temp_led[1];
 assign led_out[2] = temp_led[2];
 assign led_out[3] = temp_led[3];
            
endmodule
