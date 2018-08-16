module iic_com
(
    input CLK,
	 input RSTn,
	 
	 input [1:0] Start_Sig,             //read or write command
	 input [7:0] Addr_Sig,              //eeprom words address
	 input [7:0] WrData,                //eeprom write data
	 output [7:0] RdData,               //eeprom read data
	 output Done_Sig,                   //eeprom read/write finish
	 
	 output SCL,
	 inout SDA
	 
);

parameter F250K = 9'd200;                //250Khz的时钟分频系数              
	 
reg [4:0]i;
reg [4:0]Go;
reg [8:0]C1;
reg [7:0]rData;
reg rSCL;
reg rSDA;
reg isAck;
reg isDone;
reg isOut;	
 
assign Done_Sig = isDone;
assign RdData = rData;
assign SCL = rSCL;
assign SDA = isOut ? rSDA : 1'bz;        //SDA数据输出选择

//****************************************// 
//*             I2C读写处理程序            *// 
//****************************************// 
always @ ( posedge CLK or negedge RSTn )
	 if( !RSTn )  begin
			i <= 5'd0;
			Go <= 5'd0;
			C1 <= 9'd0;
			rData <= 8'd0;
			rSCL <= 1'b1;
			rSDA <= 1'b1;
			isAck <= 1'b1;
			isDone <= 1'b0;
			isOut <= 1'b1;
	 end
	 else if( Start_Sig[0] )                     //I2C 数据写
	     case( i )
				    
		    0: //发送IIC开始信号
			 begin
					isOut <= 1;                         //SDA端口输出
					
					if( C1 == 0 ) rSCL <= 1'b1;
					else if( C1 == 200 ) rSCL <= 1'b0;       //SCL由高变低
							  
					if( C1 == 0 ) rSDA <= 1'b1; 
					else if( C1 == 100 ) rSDA <= 1'b0;        //SDA先由高变低 
							  
					if( C1 == 250 -1) begin C1 <= 9'd0; i <= i + 1'b1; end
					else C1 <= C1 + 1'b1;
			 end
					  
			 1: // Write Device Addr
			 begin rData <= {4'b1010, 3'b000, 1'b0}; i <= 5'd7; Go <= i + 1'b1; end         
				 
			 2: // Wirte Word Addr
			 begin rData <= Addr_Sig; i <= 5'd7; Go <= i + 1'b1; end
					
			 3: // Write Data
			 begin rData <= WrData; i <= 5'd7; Go <= i + 1'b1; end
	 
			 4: //发送IIC停止信号
			 begin
			    isOut <= 1'b1;
						  
			    if( C1 == 0 ) rSCL <= 1'b0;
			    else if( C1 == 50 ) rSCL <= 1'b1;     //SCL先由低变高       
		
				 if( C1 == 0 ) rSDA <= 1'b0;
				 else if( C1 == 150 ) rSDA <= 1'b1;     //SDA由低变高  
					 	  
				 if( C1 == 250 -1 ) begin C1 <= 9'd0; i <= i + 1'b1; end
				 else C1 <= C1 + 1'b1; 
			 end
					 
			 5:
			 begin isDone <= 1'b1; i <= i + 1'b1; end       //写I2C 结束
					 
			 6: 
			 begin isDone <= 1'b0; i <= 5'd0; end
				 
			 7,8,9,10,11,12,13,14:                         //发送Device Addr/Word Addr/Write Data
			 begin
			     isOut <= 1'b1;
				  rSDA <= rData[14-i];                      //高位先发送
					  
				  if( C1 == 0 ) rSCL <= 1'b0;
			     else if( C1 == 50 ) rSCL <= 1'b1;         //SCL高电平100个时钟周期,低电平100个时钟周期
				  else if( C1 == 150 ) rSCL <= 1'b0; 
						  
				  if( C1 == F250K -1 ) begin C1 <= 9'd0; i <= i + 1'b1; end     //产生250Khz的IIC时钟
				  else C1 <= C1 + 1'b1;
			 end
					 
			 15:                                          // waiting for acknowledge
			 begin
			     isOut <= 1'b0;                            //SDA端口改为输入
			     if( C1 == 100 ) isAck <= SDA;             //读取IIC 从设备的应答信号
						  
				  if( C1 == 0 ) rSCL <= 1'b0;
				  else if( C1 == 50 ) rSCL <= 1'b1;         //SCL高电平100个时钟周期,低电平100个时钟周期
				  else if( C1 == 150 ) rSCL <= 1'b0;
						  
				  if( C1 == F250K -1 ) begin C1 <= 9'd0; i <= i + 1'b1; end    //产生250Khz的IIC时钟
				  else C1 <= C1 + 1'b1; 
			 end
					 
			 16:
			 if( isAck != 0 ) i <= 5'd0;
			 else i <= Go; 
					
  		    endcase
	
	  else if( Start_Sig[1] )                     //I2C 数据读
		    case( i )
				
			 0: // Start
			 begin
			      isOut <= 1;                      //SDA端口输出
					      
			      if( C1 == 0 ) rSCL <= 1'b1;
			 	   else if( C1 == 200 ) rSCL <= 1'b0;      //SCL由高变低
						  
					if( C1 == 0 ) rSDA <= 1'b1; 
					else if( C1 == 100 ) rSDA <= 1'b0;     //SDA先由高变低 
						  
					if( C1 == 250 -1 ) begin C1 <= 9'd0; i <= i + 1'b1; end
					 else C1 <= C1 + 1'b1;
			 end
					  
			 1: // Write Device Addr(设备地址)
			 begin rData <= {4'b1010, 3'b000, 1'b0}; i <= 5'd9; Go <= i + 1'b1; end
					 
			 2: // Wirte Word Addr(EEPROM的写地址)
			 begin rData <= Addr_Sig; i <= 5'd9; Go <= i + 1'b1; end
					
			 3: // Start again
			 begin
			     isOut <= 1'b1;
					      
			     if( C1 == 0 ) rSCL <= 1'b0;
				  else if( C1 == 50 ) rSCL <= 1'b1; 
				  else if( C1 == 250 ) rSCL <= 1'b0;
						  
			     if( C1 == 0 ) rSDA <= 1'b0; 
				  else if( C1 == 50 ) rSDA <= 1'b1;
				  else if( C1 == 150 ) rSDA <= 1'b0;  
						  
				  if( C1 == 300 -1 ) begin C1 <= 9'd0; i <= i + 1'b1; end
				  else C1 <= C1 + 1'b1;
			 end
					 
			 4: // Write Device Addr ( Read )
			 begin rData <= {4'b1010, 3'b000, 1'b1}; i <= 5'd9; Go <= i + 1'b1; end
					
			 5: // Read Data
			 begin rData <= 8'd0; i <= 5'd19; Go <= i + 1'b1; end
				 
			 6: //发送IIC停止信号
			 begin
			     isOut <= 1'b1;
			     if( C1 == 0 ) rSCL <= 1'b0;
				  else if( C1 == 50 ) rSCL <= 1'b1; 
		
				  if( C1 == 0 ) rSDA <= 1'b0;
				  else if( C1 == 150 ) rSDA <= 1'b1;
					 	  
				  if( C1 == 250 -1 ) begin C1 <= 9'd0; i <= i + 1'b1; end
				  else C1 <= C1 + 1'b1; 
			 end
					 
			 7:                                                       //写I2C 结束
			 begin isDone <= 1'b1; i <= i + 1'b1; end
					 
			 8: 
			 begin isDone <= 1'b0; i <= 5'd0; end
				 
					
			 9,10,11,12,13,14,15,16:                                  //发送Device Addr(write)/Word Addr/Device Addr(read)
			 begin
			      isOut <= 1'b1;					      
			 	   rSDA <= rData[16-i];                                //高位先发送
						  
				   if( C1 == 0 ) rSCL <= 1'b0;
					else if( C1 == 50 ) rSCL <= 1'b1;                   //SCL高电平100个时钟周期,低电平100个时钟周期
					else if( C1 == 150 ) rSCL <= 1'b0; 
						  
					if( C1 == F250K -1 ) begin C1 <= 9'd0; i <= i + 1'b1; end   //产生250Khz的IIC时钟
					else C1 <= C1 + 1'b1;
			 end
			       
			 17: // waiting for acknowledge
			 begin
			      isOut <= 1'b0;                                       //SDA端口改为输入
					     
			 	   if( C1 == 100 ) isAck <= SDA;                        //读取IIC 的应答信号
						  
					if( C1 == 0 ) rSCL <= 1'b0;
					else if( C1 == 50 ) rSCL <= 1'b1;                 //SCL高电平100个时钟周期,低电平100个时钟周期
					else if( C1 == 150 ) rSCL <= 1'b0;
						  
					if( C1 == F250K -1 ) begin C1 <= 9'd0; i <= i + 1'b1; end     //产生250Khz的IIC时钟
					else C1 <= C1 + 1'b1; 
			 end
					 
			 18:
			      if( isAck != 0 ) i <= 5'd0;
					else i <= Go;
					 
					 
			 19,20,21,22,23,24,25,26: // Read data
			 begin
			     isOut <= 1'b0;
			     if( C1 == 100 ) rData[26-i] <= SDA;                              //高位先接收
						  
				  if( C1 == 0 ) rSCL <= 1'b0;
				  else if( C1 == 50 ) rSCL <= 1'b1;                  //SCL高电平100个时钟周期,低电平100个时钟周期
				  else if( C1 == 150 ) rSCL <= 1'b0; 
						  
				  if( C1 == F250K -1 ) begin C1 <= 9'd0; i <= i + 1'b1; end     //产生250Khz的IIC时钟
				  else C1 <= C1 + 1'b1;
			 end	  
					 
			 27: // no acknowledge
			 begin
			     isOut <= 1'b1;
					  
				  if( C1 == 0 ) rSCL <= 1'b0;
				  else if( C1 == 50 ) rSCL <= 1'b1;                  //SCL高电平100个时钟周期,低电平100个时钟周期
				  else if( C1 == 150 ) rSCL <= 1'b0;
						  
				  if( C1 == F250K -1 ) begin C1 <= 9'd0; i <= Go; end    //产生250Khz的IIC时钟
				  else C1 <= C1 + 1'b1; 
			end
				
			endcase		
		

	
				
endmodule
