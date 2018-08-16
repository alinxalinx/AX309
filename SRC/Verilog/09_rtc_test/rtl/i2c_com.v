/*****************************/
/*i2c 通信程序
/*****************************/ 


 module i2c_com
(
    input CLK,
	 input RSTn,
	 input [1:0] Start_Sig,
	 input [7:0] Words_Addr,
	 input [7:0] Write_Data,
	 output [7:0] Read_Data,
	 output Done_Sig,
	 output RST,                   //rtc复位
	 output SCLK,                  //rtc SCLK
	 inout SIO                     //rtc SIO
);


	 
	 
parameter T0P5US = 5'd24;          //50M*(0.5e-6)-1=24
	 
reg [4:0] Count1;
	 
always @ ( posedge CLK or negedge RSTn )
   if( !RSTn )
	     Count1 <= 5'd0;
	else if( Count1 == T0P5US )  
	     Count1 <= 5'd0;
	else if( Start_Sig[0] == 1'b1 || Start_Sig[1] == 1'b1 )      //如果有读或写的命令
	     Count1 <= Count1 + 1'b1;
	else
	     Count1 <= 5'd0;
 	 
/*****************************/
	 
reg [5:0]i;
reg [7:0]rData;
reg rSCLK;
reg rRST;
reg rSIO;
reg isOut;
reg isDone;
   	
always @ ( posedge CLK or negedge RSTn )	
   if( !RSTn ) begin
		i <= 6'd0;
		rData <= 8'd0;
		rSCLK <= 1'b0;
		rRST <= 1'b0;
		rSIO <= 1'b0;
		isOut <= 1'b0;
		isDone <= 1'b0;
	end
	else if( Start_Sig[1] )                  //如果是写操作
	    case( i )
		 
		 0 :
		 begin rSCLK <= 1'b0; rData <= Words_Addr; rRST <= 1'b1; isOut <= 1'b1; i <= i + 1'b1; end            //CE信号为高, 读写操作的时候CE信号需为高
		 
		 1, 3, 5, 7, 9, 11, 13, 15 :
		 if( Count1 == T0P5US ) i <= i + 1'b1;
		 else begin rSIO <= rData[ (i >> 1) ]; rSCLK <= 1'b0; end                        //SCLK变低的时候,地址数据输出           
		 
		 2, 4, 6, 8, 10, 12, 14, 16 :
		 if( Count1 == T0P5US ) i <= i + 1'b1;
		 else begin rSCLK <= 1'b1; end                                                    //SCLK变高的时候数据不变                                     
		 
		 17 :
		 begin rData <= Write_Data; i <= i + 1'b1; end                                    //赋值写数据                           
		 
		 18, 20, 22, 24, 26, 28, 30, 32 :
		 if( Count1 == T0P5US ) i <= i + 1'b1;
		 else begin rSIO <= rData[ (i >> 1) - 9 ]; rSCLK <= 1'b0; end                     //SCLK变低的时候,数据输出  
		 
		 19, 21, 23, 25, 27, 29, 31, 33 :
		 if( Count1 == T0P5US ) i <= i + 1'b1;
		 else begin rSCLK <= 1'b1; end                                                    //SCLK变高的时候数据不变  
		 
		 34 :
		 begin rRST <= 1'b0; i <= i + 1'b1; end                                           //CE信号为低
		 
		 35 :
		 begin isDone <= 1'b1; i <= i + 1'b1; end                                         //I2C写完成
		 
		 36 :
		 begin isDone <= 1'b0; i <= 6'd0; end
		 endcase
		 
   else if( Start_Sig[0] )             //如果是读操作
	    case( i )
		 
	    0 :
	    begin rSCLK <= 1'b0; rData <= Words_Addr; rRST <= 1'b1; isOut <= 1'b1; i <= i + 1'b1; end       //CE信号为高, 读写操作的时候CE信号需为高
		 
		 1, 3, 5, 7, 9, 11, 13, 15 :
		 if( Count1 == T0P5US ) i <= i + 1'b1;
		 else begin rSIO <= rData[ (i >> 1) ]; rSCLK <= 1'b0; end                                        //SCLK变低的时候,地址数据输出 
		 
		 2, 4, 6, 8, 10, 12, 14, 16 :
		 if( Count1 == T0P5US ) i <= i + 1'b1;
		 else begin rSCLK <= 1'b1; end                                                                   //SCLK变高的时候数据不变 
		 
  	    17 :
		 begin isOut <= 1'b0; i <= i + 1'b1; end                                                  //SIO改为输入
		 
		 18, 20, 22, 24, 26, 28, 30, 32 :
		 if( Count1 == T0P5US ) i <= i + 1'b1;
		 else begin rSCLK <= 1'b1; end
				  
		 19, 21, 23, 25, 27, 29, 31, 33 :
		 if( Count1 == T0P5US ) begin i <= i + 1'b1; end
		 else begin rSCLK <= 1'b0; rData[ (i >> 1) - 9 ] <= SIO; end                                     //SCLK的时钟的下降沿, 读取数据                                    
				  
		 34 :
		 begin rRST <= 1'b0; isOut <= 1'b1; i <= i + 1'b1; end                                          //CE信号为低
				  
		 35 :
		 begin isDone <= 1'b1; i <= i + 1'b1; end                                                        //I2C写完成
					  
		 36 :
		 begin isDone <= 1'b0; i <= 6'd0; end
					  
		 endcase
				/********************************/
		
		assign Read_Data = rData;
		assign Done_Sig = isDone;
		
		assign RST = rRST;
		assign SCLK = rSCLK;
		assign SIO = isOut ? rSIO : 1'bz;
		
		/********************************/

endmodule


