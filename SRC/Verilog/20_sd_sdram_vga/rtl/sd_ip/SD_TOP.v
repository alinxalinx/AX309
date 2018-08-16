`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name:    SD_TOP 
//////////////////////////////////////////////////////////////////////////////////
module SD_TOP(
					input              clk,
					input              sd_rst_n,
					
					input              sdram_init_done,

					input              SD_clk,					
					output  reg        SD_cs,
					output  reg        SD_datain,
					input              SD_dataout,
					
	
					output             sd_valid,
					output   [15:0]    sd_data,					
 					output             init_o,
               output             pic_read_done		  
					
    );



wire [3:0] state;

wire [15:0]mydata_o;
wire myvalid_o;

wire [3:0] mystate_o;

wire [7:0]rx_o;
wire init_o;
wire read_o;

wire SD_cs_i;
wire SD_cs_r;
wire SD_datain_i;
wire SD_datain_r;

assign sd_data = mydata_o;


//---------------------------------
//sd card initial				
SD_initial SD_initial_inst(
         .rst_n(sd_rst_n),
			.SD_clk(SD_clk),
			.SD_cs(SD_cs_i),
			.SD_datain(SD_datain_i),
			.SD_dataout(SD_dataout),
			.rx(),
			.init_o(init_o),
			.state(state)
);

//---------------------------------
//sd card data read	 
SD_read	SD_read_inst(  
			.sdram_init_done(sdram_init_done), 
			.SD_clk(SD_clk),
			.SD_cs(SD_cs_r),
			.SD_datain(SD_datain_r),
			.SD_dataout(SD_dataout),
				
			.mydata_o(mydata_o),
			.myvalid_o(myvalid_o),
		
			.mystate_o(mystate_o),
			
			.data_come_o(),
			
			.init(init_o),
					
			.rx(rx_o),
			
			.picture_store(pic_read_done)					
						
    );

//---------------------------------
//SD¿¨ÐÅºÅÑ¡Ôñ	 
always @(*)
begin
	if(!init_o)
		begin
			SD_cs<=SD_cs_i;
			SD_datain<=SD_datain_i;
		end
	else
		begin
			SD_cs<=SD_cs_r;
			SD_datain<=SD_datain_r;
		end
end
 



//---------------------------------
//myvalid_o->sd_valid
reg	myvalid_o_r0, myvalid_o_r1;

always@(negedge clk or negedge sd_rst_n)
begin
	if(!sd_rst_n)
		begin
		myvalid_o_r0 <= 0;
		myvalid_o_r1 <= 0;
		end
	else
		begin
		myvalid_o_r0 <= myvalid_o;
		myvalid_o_r1 <= myvalid_o_r0;
		end
end
assign sd_valid = (~myvalid_o_r1 & myvalid_o_r0) ? 1'b1 : 1'b0;	 //posedge


 
	 
endmodule


