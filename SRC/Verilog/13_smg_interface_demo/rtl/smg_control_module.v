module smg_control_module
(
    input CLK,
	 input RSTn,
	 input [23:0]Number_Sig,
	 output [3:0]Number_Data
);

    /******************************************/    
	 
	 parameter T1MS = 16'd49999;            //1ms计数
	 
	 /******************************************/  
	 
	  reg [15:0]C1;
	 
	 always @ ( posedge CLK or negedge RSTn )
	     if( !RSTn )
		      C1 <= 16'd0;
		  else if( C1 == T1MS )
		      C1 <= 16'd0;
		  else
		      C1 <= C1 + 1'b1;
	 
	 /******************************************/ 
	 
	 reg [3:0]i;
	 reg [3:0]rNumber;
	 
	 always @ ( posedge CLK or negedge RSTn )
	     if( !RSTn )
		      begin
		          i <= 4'd0;
			    	 rNumber <= 4'd0;
				end
		  else 
		      case( i )
				
				    0:
					 if( C1 == T1MS ) i <= i + 1'b1;
					 else rNumber <= Number_Sig[23:20];          //十万位数码管显示           
	
					 1:
					 if( C1 == T1MS ) i <= i + 1'b1;
					 else rNumber <= Number_Sig[19:16];          //万位数码管显示
					 
					 2:
					 if( C1 == T1MS ) i <= i + 1'b1;
					 else rNumber <= Number_Sig[15:12];          //千位数码管显示
					 
					 3:
					 if( C1 == T1MS ) i <= i + 1'b1;
					 else rNumber <= Number_Sig[11:8];           //百位数码管显示
					 
					 4:
					 if( C1 == T1MS ) i <= i + 1'b1;
					 else rNumber <= Number_Sig[7:4];            //十位数码管显示
					 
					 5:
					 if( C1 == T1MS ) i <= 4'd0;
					 else rNumber <= Number_Sig[3:0];            //低位数码管显示
				
				endcase
				
    /******************************************/ 
	 
	 assign Number_Data = rNumber;
	 
	 /******************************************/
	 
endmodule
