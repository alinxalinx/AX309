`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name:    uarttx 
// 说明：16个clock发送一个bit,
//////////////////////////////////////////////////////////////////////////////////
module uarttx(clk, datain, wrsig, idle, tx);
input clk;                //UART时钟
input [7:0] datain;       //需要发送的数据
input wrsig;              //发送命令，上升沿有效
output idle;              //线路状态指示，高为线路忙，低为线路空闲
output tx;                //发送数据信号
reg idle, tx;
reg send;
reg wrsigbuf, wrsigrise;
reg presult;
reg[7:0] cnt;             //计数器
parameter paritymode = 1'b0;

//检测发送命令是否有效，判断wrsig的上升沿
always @(posedge clk)
begin
   wrsigbuf <= wrsig;
   wrsigrise <= (~wrsigbuf) & wrsig;
end

always @(posedge clk)
begin
  if (wrsigrise &&  (~idle))  //当发送命令有效且线路为空闲时，启动新的数据发送进程
  begin
     send <= 1'b1;
  end
  else if(cnt == 8'd168)      //一帧资料发送结束
  begin
     send <= 1'b0;
  end
end

/////////////////////////////////////////////////////////////////////////
//使用168个时钟发送一个数据（起始位、8位数据、奇偶校验位、停止位），每位占用16个时钟//
////////////////////////////////////////////////////////////////////////
always @(posedge clk)
begin
  if(send == 1'b1)  begin
    case(cnt)                 //tx变低电平产生起始位，0~15个时钟为发送起始位
    8'd0: begin
         tx <= 1'b0;
         idle <= 1'b1;
         cnt <= cnt + 8'd1;
    end
    8'd16: begin
         tx <= datain[0];    //发送数据位的低位bit0,占用第16~31个时钟
         presult <= datain[0]^paritymode;
         idle <= 1'b1;
         cnt <= cnt + 8'd1;
    end
    8'd32: begin
         tx <= datain[1];    //发送数据位的第2位bit1,占用第47~32个时钟
         presult <= datain[1]^presult;
         idle <= 1'b1;
         cnt <= cnt + 8'd1;
    end
    8'd48: begin
         tx <= datain[2];    //发送数据位的第3位bit2,占用第63~48个时钟
         presult <= datain[2]^presult;
         idle <= 1'b1;
         cnt <= cnt + 8'd1;
    end
    8'd64: begin
         tx <= datain[3];    //发送数据位的第4位bit3,占用第79~64个时钟
         presult <= datain[3]^presult;
         idle <= 1'b1;
         cnt <= cnt + 8'd1;
    end
    8'd80: begin 
         tx <= datain[4];   //发送数据位的第5位bit4,占用第95~80个时钟
         presult <= datain[4]^presult;
         idle <= 1'b1;
         cnt <= cnt + 8'd1;
    end
    8'd96: begin
         tx <= datain[5];    //发送数据位的第6位bit5,占用第111~96个时钟
         presult <= datain[5]^presult;
         idle <= 1'b1;
         cnt <= cnt + 8'd1;
    end
    8'd112: begin
         tx <= datain[6];    //发送数据位的第7位bit6,占用第127~112个时钟
         presult <= datain[6]^presult;
         idle <= 1'b1;
         cnt <= cnt + 8'd1;
    end
    8'd128: begin 
         tx <= datain[7];    //发送数据位的第8位bit7,占用第143~128个时钟
         presult <= datain[7]^presult;
         idle <= 1'b1;
         cnt <= cnt + 8'd1;
    end
    8'd144: begin
         tx <= presult;      //发送奇偶校验位，占用第159~144个时钟
         presult <= datain[0]^paritymode;
         idle <= 1'b1;
         cnt <= cnt + 8'd1;
    end
    8'd160: begin
         tx <= 1'b1;         //发送停止位，占用第160~167个时钟            
         idle <= 1'b1;
         cnt <= cnt + 8'd1;
    end
    8'd168: begin
         tx <= 1'b1;             
         idle <= 1'b0;       //一帧资料发送结束
         cnt <= cnt + 8'd1;
    end
    default: begin
          cnt <= cnt + 8'd1;
    end
   endcase
  end
  else  begin
    tx <= 1'b1;
    cnt <= 8'd0;
    idle <= 1'b0;
  end
end
endmodule

