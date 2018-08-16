module sos_module
(
     CLK, RSTn, Pin_Out, SOS_En_Sig
);

    input CLK;
	 input RSTn;
	 input SOS_En_Sig;
	 output Pin_Out;
	 
	 /****************************************/
	 
	 parameter T1MS = 16'd49_999;//AX309开发板使用的晶振为50MHz，50M*0.001-1=49_999
	 
	 /***************************************/
	 
	 reg [15:0]Count1;

	 always @ ( posedge CLK or negedge RSTn )
	     if( !RSTn )
		      Count1 <= 16'd0;
		  else if( isCount && Count1 == T1MS )       //1ms的计数器
		      Count1 <= 16'd0;
		  else if( isCount )
		      Count1 <= Count1 + 1'b1;
		  else if( !isCount )
		      Count1 <= 16'd0;
	
    /****************************************/	
				
    reg [9:0]Count_MS;
	    
	 always @ ( posedge CLK or negedge RSTn )
        if( !RSTn )
		      Count_MS <= 10'd0;
		  else if( isCount && Count1 == T1MS )
		      Count_MS <= Count_MS + 1'b1;
		  else if( !isCount )
		      Count_MS <= 10'd0;
	
	/******************************************/
	
	reg isCount;
	reg rPin_Out;
	reg [4:0]i;
	
	always @ ( posedge CLK or negedge RSTn )
	    if( !RSTn )
		     begin
		         isCount <= 1'b0;
					rPin_Out <= 1'b0;
					i <= 5'd0;
			  end
		 else 
	        case( i )
			  
			    5'd0 : 
					if( SOS_En_Sig ) i <= 5'd1;
					
					5'd1, 5'd3, 5'd5, 
					5'd13, 5'd15, 5'd17 :  
					if( Count_MS == 10'd100 ) begin isCount <= 1'b0; rPin_Out <= 1'b0; i <= i + 1'b1; end // short
					else begin isCount <= 1'b1; rPin_Out <= 1'b1; end
					
					5'd7, 5'd9, 5'd11 :
					if( Count_MS == 10'd300 ) begin isCount <= 1'b0; rPin_Out <= 1'b0; i <= i + 1'b1; end // long
					else begin isCount <= 1'b1; rPin_Out <= 1'b1; end
					
					5'd2, 5'd4, 5'd6,  
					5'd8, 5'd10, 5'd12,
					5'd14, 5'd16, 5'd18 :
					if( Count_MS == 10'd50 ) begin isCount <= 1'b0; i <= i + 1'b1; end// interval
					else isCount <= 1'b1;
					
					5'd19 :
					begin rPin_Out <= 1'b0; i <= 5'd0; end  // end
					
			  endcase
			  
    /***************************************************/
	 
	 assign Pin_Out = rPin_Out;
	 
	 /***************************************************/

		  
endmodule
