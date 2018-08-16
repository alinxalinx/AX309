module ds1302_module
(
    input CLK,
	 input RSTn,
	 
	 input [7:0]Start_Sig,
	 output Done_Sig,
	 
	 input [7:0]Time_Write_Data,
	 output [7:0]Time_Read_Data,
	 
	 output RST,
	 output SCLK,
	 inout SIO

);


	 
/***************************/
	 
wire [7:0]Words_Addr;
wire [7:0]Write_Data;
wire [1:0]Access_Start_Sig;
	 
wire [7:0]Read_Data;
wire Access_Done_Sig;
	 	 
cmd_control U1
(
	     .CLK( CLK ),
		  .RSTn( RSTn ),
		  .Start_Sig( Start_Sig ),               // 寄存器读写命令/地址：input - from top
		  .Done_Sig( Done_Sig ),                 // 寄存器读写完成信号：output - to top
		  .Time_Write_Data( Time_Write_Data ),   // input - from top
		  .Time_Read_Data( Time_Read_Data ),     // output - to top
		  .Access_Done_Sig( Access_Done_Sig ),   // I2C读写完成信号: input - from U2
		  .Access_Start_Sig( Access_Start_Sig ), // 读写命令: output - to U2
		  .Read_Data( Read_Data ),               // 读到的寄存器数据: input - from U2         
		  .Words_Addr( Words_Addr ),             // 寄存器的地址: output - to U2
		  .Write_Data( Write_Data )              // 写入的寄存器的数据: output - to U2
);
	 
	 /*****************************/
  
	 
i2c_com U2
(
	     .CLK( CLK ),
		  .RSTn( RSTn ),
		  .Start_Sig( Access_Start_Sig ),  // input - from  U1
		  .Words_Addr( Words_Addr ),       // input - from U1
		  .Write_Data( Write_Data ),       // input - from U1
		  .Read_Data( Read_Data ),         // output - to U1
		  .Done_Sig( Access_Done_Sig ),    // output - to U1
		  .RST( RST ),                     // DS1302的CE信号：output - to top
		  .SCLK( SCLK ),                   // DS1302的SCLK信号：output - to top
		  .SIO( SIO )                      // DS1302的SIO信号：output - to top
);
	 
	 /*****************************/
	 
endmodule
