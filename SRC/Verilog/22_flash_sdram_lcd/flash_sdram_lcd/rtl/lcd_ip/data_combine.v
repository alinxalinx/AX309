/*-------------------------------------------------------------------------
Filename			:		data_combine.v
==========================================================================*/
module	data_combine
(
	input				clk,
	input				rst_n,
	
	output reg	   sys_rd,
	input	[15:0]	lcd_data_16,
	input				lcd_rden,
	output reg [95:0]	lcd_data_96

);

//----------------------------------
//negedge of lcd_rden signal
reg	lcd_rden_r0, lcd_rden_r1;

always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		begin
		lcd_rden_r0 <= 0;
		lcd_rden_r1 <= 0;
		end
	else
		begin
		lcd_rden_r0 <= lcd_rden;
		lcd_rden_r1 <= lcd_rden_r0;
		end
end
wire	lcd_rden_flag = (lcd_rden_r1 & ~lcd_rden_r0) ? 1'b1 : 1'b0;	 //negedge

//----------------------------------------
//generate 6 length read fifo to combine to 96bit 
reg	[2:0]	state_write;
reg 	[3:0]	read_counter;
always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		begin
          read_counter<=0;
			 lcd_data_96 <= 0;
		    sys_rd <= 1'b0;		
		end
	else
		begin
		case(state_write)
		3'd0:	begin	
		      if (lcd_rden_flag==1'b1) begin
				   lcd_data_96 <= 0;
             	state_write <= 3'd1;
		         sys_rd <= 1'b1;
				end	
				else 
             	state_write <= 3'd0;			   
		end
		3'd1:	begin   
		      if(read_counter==3'd6) begin                     //read data from fifo is delay one clock, read data at 1~6
				   read_counter<=3'd0;
		         sys_rd <= 1'b0;
					state_write <= 3'd2;
					lcd_data_96 <= {lcd_data_96[79:0], lcd_data_16};             
				end		
				else if(read_counter==3'd5) begin               //sys_rd is valid at 0~5
			      sys_rd <= 1'b0;
					lcd_data_96 <= {lcd_data_96[79:0], lcd_data_16};             
					state_write <= 3'd1;	
				   read_counter <= read_counter + 1'b1;
	         end				
			   else begin	
				   read_counter <= read_counter + 1'b1;
					state_write <= 3'd1;
		         sys_rd <= 1'b1;
					lcd_data_96 <= {lcd_data_96[79:0], lcd_data_16};             					
		      end
		end		
		3'd2:	begin	sys_rd <= 1'b0; state_write <= 3'd0;	end
		default:;
		endcase
		end
end


endmodule
