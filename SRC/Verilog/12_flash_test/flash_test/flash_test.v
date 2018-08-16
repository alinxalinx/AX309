module flash_test
(
    input          CLK,
	 input          RSTn,


    output flash_clk,
	 output flash_cs,
	 output flash_datain,
	 input  flash_dataout
	 

);


	 
/*******************************/
	 
reg [3:0] i;
reg [7:0] flash_cmd;
reg [23:0] flash_addr;

reg clock25M;
reg [3:0] cmd_type;

reg [7:0] time_delay;

wire Done_Sig;
wire [7:0] mydata_o;
wire myvalid_o;
wire [2:0] spi_state;


/*******************************/
//FLASH ²Á³ý,Page Program,¶ÁÈ¡³ÌÐò	
/*******************************/
always @ ( posedge clock25M or negedge RSTn )
    if( !RSTn ) begin
			i <= 4'd0;
			flash_addr <= 24'd0;
			flash_cmd <= 8'd0;
			cmd_type <= 4'b0000;
			time_delay<=0;
	 end
	 else 
	     case( i )

	      4'd0://¶ÁDevice ID
			if( Done_Sig ) begin flash_cmd <= 8'h00; i <= i + 1'b1; cmd_type <= 4'b0000; end
			else begin flash_cmd <= 8'h9f; flash_addr <= 24'd0; cmd_type <= 4'b1000; end	
		  
	      4'd1://Ð´Write Enable instruction
			if( Done_Sig ) begin flash_cmd <= 8'h00; i <= i + 1'b1; cmd_type <= 4'b0000; end
			else begin flash_cmd <= 8'h06; cmd_type <= 4'b1001; end
	
			4'd2://Sector²Á³ý
			if( Done_Sig ) begin flash_cmd <= 8'h00; i <= i + 1'b1; cmd_type<=4'b0000; end
			else begin flash_cmd <= 8'hd8; flash_addr <= 24'd0; cmd_type <= 4'b1010; end           
			
	      4'd3://waitting 100 clock
			if( time_delay<8'd100 ) begin flash_cmd <= 8'h00; time_delay<=time_delay+1'b1; cmd_type <= 4'b0000; end
			else begin i <= i + 1'b1; time_delay<=0; end	
					
			4'd4://¶Á×´Ì¬¼Ä´æÆ÷1, µÈ´ýidle
			if( Done_Sig ) begin 
			    if (mydata_o[0]==1'b0) begin flash_cmd <= 8'h00; i <= i + 1'b1; cmd_type <= 4'b0000; end
				 else begin flash_cmd <= 8'h05; cmd_type <= 4'b1011; end
			end
			else begin flash_cmd <= 8'h05; cmd_type <= 4'b1011; end

	      4'd5://Ð´Write disable instruction
			if( Done_Sig ) begin flash_cmd <= 8'h00; i <= i + 1'b1; cmd_type <= 4'b0000; end
			else begin flash_cmd <= 8'h04; cmd_type <= 4'b1100; end			

			4'd6://¶Á×´Ì¬¼Ä´æÆ÷1, µÈ´ýidle
			if( Done_Sig ) begin 
			    if (mydata_o[0]==1'b0) begin flash_cmd <= 8'h00; i <= i + 1'b1; cmd_type <= 4'b0000; end
				 else begin flash_cmd <= 8'h05; cmd_type <= 4'b1011; end
			end
			else begin flash_cmd <= 8'h05; cmd_type <= 4'b1011; end

	      4'd7://Ð´Write Enable instruction
			if( Done_Sig ) begin flash_cmd <= 8'h00; i <= i + 1'b1; cmd_type <= 4'b0000; end
			else begin flash_cmd <= 8'h06; cmd_type <= 4'b1001; end 

	      4'd8://waitting 100 clock
			if( time_delay<8'd100 ) begin flash_cmd <= 8'h00; time_delay<=time_delay+1'b1; cmd_type <= 4'b0000; end
			else begin i <= i + 1'b1; time_delay<=0; end	

	      4'd9://page program: write 0~255 to flash
			if( Done_Sig ) begin flash_cmd <= 8'h00; i <= i + 1'b1;cmd_type <= 4'b0000; end
			else begin flash_cmd <= 8'h02; flash_addr <= 24'd0; cmd_type <= 4'b1101; end
			
	      4'd10://waitting
			if( time_delay<8'd100 ) begin flash_cmd <= 8'h00; time_delay<=time_delay+1'b1; cmd_type <= 4'b0000; end
			else begin i <= i + 1'b1; time_delay<=0; end	

			4'd11://¶Á×´Ì¬¼Ä´æÆ÷1, µÈ´ýidle
			if( Done_Sig ) begin 
			    if (mydata_o[0]==1'b0) begin flash_cmd <= 8'h00; i <= i + 1'b1; cmd_type <= 4'b0000; end
				 else begin flash_cmd <= 8'h05; cmd_type <= 4'b1011; end
			end
			else begin flash_cmd <= 8'h05; cmd_type <= 4'b1011; end

	      4'd12://Ð´Write disable instruction
			if( Done_Sig ) begin flash_cmd <= 8'h00; i <= i + 1'b1; cmd_type <= 4'b0000; end
			else begin flash_cmd <= 8'h04; cmd_type <= 4'b1100; end		

			4'd13://¶Á×´Ì¬¼Ä´æÆ÷1, µÈ´ýidle
			if( Done_Sig ) begin 
			    if (mydata_o[0]==1'b0) begin flash_cmd <= 8'h00; i <= i + 1'b1; cmd_type <= 4'b0000; end
				 else begin flash_cmd <= 8'h05; cmd_type <= 4'b1011; end
			end
			else begin flash_cmd <= 8'h05; cmd_type <= 4'b1011; end
					
			4'd14://read 256byte
			if( Done_Sig ) begin flash_cmd <= 8'h00; i <= i + 1'b1; cmd_type <= 4'b0000; end
			else begin flash_cmd <= 8'h03; flash_addr <= 24'd0; cmd_type <= 4'b1110; end

			4'd15://idle
			i <= 4'd15;

	      endcase
			
 /*****************************/			  
always @ ( posedge CLK )
    if( !RSTn ) clock25M<=1'b0;
	 else clock25M <= ~clock25M;


 /*****************************/
 	 
flash_spi U1
(
	     .flash_clk(flash_clk ),
		  .flash_cs( flash_cs ),
		  .flash_datain( flash_datain ),  
		  .flash_dataout( flash_dataout ),    
		  
		  .clock25M( clock25M ),           //input clock
		  .flash_rstn( RSTn ),             //input reset 
		  .cmd_type( cmd_type ),           // flash command type		  
		  .Done_Sig( Done_Sig ),           //output done signal
		  .flash_cmd( flash_cmd ),         // input flash command 
		  .flash_addr( flash_addr ),       // input flash address 
		  .mydata_o( mydata_o ),           // output flash data 
		  .myvalid_o( myvalid_o ),          // output flash data valid 		
        .spi_state(spi_state)		  
		  

);
	 
wire [35:0]   CONTROL0;
wire [255:0]  TRIG0;
chipscope_icon icon_debug (
    .CONTROL0(CONTROL0) // INOUT BUS [35:0]
);

chipscope_ila ila_filter_debug (
    .CONTROL(CONTROL0), // INOUT BUS [35:0]
   // .CLK(dma_clk),      // IN
    .CLK(CLK),      // IN
    .TRIG0(TRIG0)      // IN BUS [255:0]
    //.TRIG_OUT(TRIG_OUT0)
);                                                     

assign  TRIG0[7:0]=mydata_o;                                               
assign  TRIG0[8]=myvalid_o;   
assign  TRIG0[12:9]=i;        
assign  TRIG0[15:13]=spi_state;   
assign  TRIG0[16]=Done_Sig;   
assign  TRIG0[17]=flash_datain;  
assign  TRIG0[18]=flash_dataout;  
assign  TRIG0[19]=flash_cs;  
assign  TRIG0[20]=flash_clk; 


endmodule
