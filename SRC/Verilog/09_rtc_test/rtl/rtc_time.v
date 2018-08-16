module rtc_time
(
    input          CLK,
	 input          RSTn,


	 output reg [7:0] Time_second,
	 output reg [7:0] Time_munite,
	 output reg [7:0] Time_hour,
	
	 output         RST,                 //ds1302 CE/RST
	 output         SCLK,                //ds1302 SCLK
	 inout          SIO                  //ds1302 SIO
	 

);


	 
/*******************************/
	 
reg [3:0] i;
reg [7:0] isStart;
reg [7:0] rData;


wire Done_Sig;
wire [7:0] Time_Read_Data;


/*******************************/
//DS1302 时钟设置和读取程序	
/*******************************/
always @ ( posedge CLK or negedge RSTn )
    if( !RSTn ) begin
			      i <= 4'd0;
			      isStart <= 8'd0;
					rData <= 8'd0;
	 end
	 else 
	     case( i )
			  
	      0://设置Write unprotect
			if( Done_Sig ) begin isStart <= 8'd0; i <= i + 1'b1; end
			else begin isStart <= 8'b1000_0000; rData <= 8'h00; end 
					
			1://设置hour
			if( Done_Sig ) begin isStart <= 8'd0; i <= i + 1'b1; end
			else begin isStart <= 8'b0100_0000; rData <= { 4'd1, 4'd2 }; end
					
			2://设置munite
			if( Done_Sig ) begin isStart <= 8'd0; i <= i + 1'b1; end
			else begin isStart <= 8'b0010_0000; rData <= { 4'd2, 4'd2 }; end
					
			3://设置second
			if( Done_Sig ) begin isStart <= 8'd0; i <= i + 1'b1; end
			else begin isStart <= 8'b0001_0000; rData <= { 4'd2, 4'd2 }; end
					
			4://读second
			if( Done_Sig ) begin Time_second <= Time_Read_Data; isStart <= 8'd0; i <= i + 1'b1; end
			else begin isStart <= 8'b0000_0001; end

			5://读munite
			if( Done_Sig ) begin Time_munite <= Time_Read_Data; isStart <= 8'd0; i <= i + 1'b1; end
			else begin isStart <= 8'b0000_0010; end

			6://读hour
			if( Done_Sig ) begin Time_hour <= Time_Read_Data; isStart <= 8'd0; i <= 4'd4; end
			else begin isStart <= 8'b0000_0100; end
					
	      endcase
			  

	 
ds1302_module U1
(
        .CLK( CLK ), 
	     .RSTn( RSTn ),
	     .Start_Sig( isStart ),
	     .Done_Sig( Done_Sig ),
	     .Time_Write_Data( rData ),
	     .Time_Read_Data( Time_Read_Data ),
	     .RST( RST ),
	     .SCLK( SCLK ),
	     .SIO( SIO )
);
	 
	 

endmodule
