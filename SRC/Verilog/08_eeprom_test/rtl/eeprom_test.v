`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name:    eeprom_test 
// Function: write and read eeprom using I2C bus
//////////////////////////////////////////////////////////////////////////////////
module eeprom_test
(
    input CLK_50M,
	 input RSTn,
	 output [3:0]LED,
	 
	 output SCL,          //EEPROM IIC clock
	 inout SDA            //EEPROM IIC data
);
  
  
wire [7:0] RdData;       //EEPROM 读出数据寄存器
wire Done_Sig;           //IIC通信完成信号

reg [3:0] i;
reg [3:0] rLED;

reg [7:0] rAddr;
reg [7:0] rData;
reg [1:0] isStart;

assign LED = rLED;

/***************************/
/*   EEPROM write and read */
/***************************/	  
always @ ( posedge CLK_50M or negedge RSTn )	
	 if( !RSTn ) begin
			i <= 4'd0;
			rAddr <= 8'd0;
			rData <= 8'd0;
			isStart <= 2'b00;
         rLED <= 4'b0000;
	 end
	 else
		case( i )
				
	     0:
		  if( Done_Sig ) begin isStart <= 2'b00; i <= i + 1'b1; end                    //等待IIC写操作完成, 完成i状态变为1
		  else begin isStart <= 2'b01; rData <= 8'h12; rAddr <= 8'd0; end              //eeprom 写数据(0x12)到addr 0
					 
		  1:
		  if( Done_Sig ) begin isStart <= 2'b00; i <= i + 1'b1; end                    //等待IIC读操作完成, 完成i状态变为2
		  else begin isStart <= 2'b10; rAddr <= 8'd0; end                              //eeprom 读 addr 0的数据
					 
		  2:
		  begin rLED <= RdData[3:0]; end		                 //led灯赋值 
		
		endcase	
	 
/***************************/
//I2C通信程序//
/***************************/				
iic_com U1
	 (
	     .CLK( CLK_50M ),
		  .RSTn( RSTn ),
		  .Start_Sig( isStart ),                //iic读写命令: 2'b01为IIC写; 2'b10为IIC读
		  .Addr_Sig( rAddr ),                   //EEPROM的iic读写地址
		  .WrData( rData ),                     //EEPROM的iic写数据
		  .RdData( RdData ),                    //EEPROM的iic读数据
		  .Done_Sig( Done_Sig ),                //IIC读写完成信号,高IIC读写操作完成
	     .SCL( SCL ),
		  .SDA( SDA )
);

/***************************/
//chipscope icon和ila, 用于观察信号//
/***************************/	
wire [35:0]   CONTROL0;
wire [255:0]  TRIG0;
chipscope_icon icon_debug (
    .CONTROL0(CONTROL0) // INOUT BUS [35:0]
);

chipscope_ila ila_filter_debug (
    .CONTROL(CONTROL0), // INOUT BUS [35:0]
   // .CLK(dma_clk),    // IN
    .CLK(CLK_50M),      // IN, chipscope的采样时钟
    .TRIG0(TRIG0)       // IN BUS [255:0], 采样的信号
    //.TRIG_OUT(TRIG_OUT0)
);                                                     

assign  TRIG0[7:0]=RdData;    //采样RdData信号                                           


endmodule
