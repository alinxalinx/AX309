//wm8731中寄存器的配置程序
 module reg_config(clock_50m,i2c_sclk,i2c_sdat,reset_n);
 input clock_50m;
 input reset_n;
 output i2c_sclk;
 inout i2c_sdat;
    
reg clock_20k;
reg [15:0]clock_20k_cnt;
reg [1:0]config_step;
reg [3:0]reg_index;
reg [23:0]i2c_data;
reg [15:0]reg_data;
reg start;
    
i2c_com u1(.clock_i2c(clock_20k),
           .reset_n(reset_n),
           .ack(ack),
           .i2c_data(i2c_data),
           .start(start),
           .tr_end(tr_end),
           .i2c_sclk(i2c_sclk),
           .i2c_sdat(i2c_sdat));
					
//产生i2c控制时钟-20khz  
always@(posedge clock_50m or negedge reset_n)   
begin
   if(!reset_n) begin
      clock_20k<=0;
      clock_20k_cnt<=0;
   end
   else if(clock_20k_cnt<1249)
      clock_20k_cnt<=clock_20k_cnt+1;
   else begin
      clock_20k<=!clock_20k;
      clock_20k_cnt<=0;
   end
end
    
//寄存器IIC配置过程控制	 
always@(posedge clock_20k or negedge reset_n)    
begin
   if(!reset_n) begin
       config_step<=0;
       start<=0;
       reg_index<=0;
   end
   else begin
     if(reg_index<10) begin
        case(config_step)
        0:begin
            i2c_data<={8'h34,reg_data};           //IIC Device address is 0x34
            start<=1;                             //开始IIC数据传输
            config_step<=1;
        end
        1:begin
           if(tr_end) begin                           //IIC发送结束
               if(!ack)                            //如果接收到IIC的应答信号
                  config_step<=2;
               else
                 config_step<=0;
               start<=0;
           end
        end
        2:begin
           reg_index<=reg_index+1;            //配置下一个寄存器
           config_step<=0;
        end
        endcase
      end
   end
end
			
//WM8731的寄存器赋值	
always@(reg_index)   
begin
        case(reg_index)
			  0:reg_data<=16'h0097;       //Reg0(Left Line In) = 0x97: left line in mute
			  1:reg_data<=16'h0297;       //Reg1(Right Line In) = 0x97: right line in mute
			  2:reg_data<=16'h047f;       //Reg2(Left Headphone out) = 0x7f :left headphone +6dB
			  3:reg_data<=16'h067f;       //Reg3(right Headphone out) = 0x7f :right headphone +6dB
			  4:reg_data<=16'h0815;       //Reg4(analogue audio path control) = 0x15 : MIC select to DAC
			  5:reg_data<=16'h0a06;       //Reg5(digital Audio path control) = 0x00
			  6:reg_data<=16'h0c00;       //Reg6(Power down control) = 0x00
			  7:reg_data<=16'h0e40;       //Reg7(Digital Audio interface format) = 0x40 : right channel DAC when DACLRC low
			  8:reg_data<=16'h1000;       //Reg8(Sampling control) = 0x00  
			  9:reg_data<=16'h1201;       //Reg9(Active control) = 0x00  
      default:reg_data<=16'h001a;
      endcase
end
endmodule

