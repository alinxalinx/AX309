module smg_scan_module
(
    input CLK, 
	 input RSTn, 
	 output [5:0]Scan_Sig
);
	 
	 /*****************************/
	 
	 parameter T1MS = 16'd49999;
	 
	 /*****************************/
	 
	 reg [15:0]C1;
	 
	 always @ ( posedge CLK or negedge RSTn )
	     if( !RSTn )
		      C1 <= 16'd0;
		  else if( C1 == T1MS )
		      C1 <= 16'd0;
		  else
		      C1 <= C1 + 1'b1;
	
	 /*******************************/
	 
	 reg [3:0]i;
	 reg [5:0]rScan;
	 
	 always @ ( posedge CLK or negedge RSTn )
	     if( !RSTn )
		      begin
		          i <= 4'd0;
		          rScan <= 6'b100_000;
			   end
		  else 
		      case( i )
				    
					 0:
		          if( C1 == T1MS ) i <= i + 1'b1;
					 else rScan <= 6'b011_111;                      //第一个数码选通
					 
					 1:
					 if( C1 == T1MS ) i <= i + 1'b1;
					 else rScan <= 6'b101_111;                      //第二个数码选通
					 
					 2:
					 if( C1 == T1MS ) i <= i + 1'b1;
					 else rScan <= 6'b110_111;                      //第三个数码选通
					 
					 3:
					 if( C1 == T1MS ) i <= i + 1'b1;
					 else rScan <= 6'b111_011;                      //第四个数码选通
					 
					 4:
					 if( C1 == T1MS ) i <= i + 1'b1;
					 else rScan <= 6'b111_101;                      //第五个数码选通
					 
					 5:
					 if( C1 == T1MS ) i <= 4'd0;
					 else rScan <= 6'b111_110;                      //第六个数码选通
					 
					 
				endcase
				
	 /******************************/
	 
	 assign Scan_Sig = rScan;
	 
	 /******************************/
		      

endmodule
