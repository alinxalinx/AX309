/*-------------------------------------------------------------------------
Filename			:		lcd_top.v
==========================================================================*/
module lcd_top
(  	
	//global clock
	input			clk_lcd,			//system clock
	input			lcd_rst,     	//sync reset
	input       key1,          //key1
	
	//lcd interface
	output			lcd_dclk,   	//lcd pixel clock
	output			lcd_de,		   //lcd blank
	output			lcd_hsync,	  	//lcd horizontal sync
	output			lcd_vsync,	   //lcd vertical sync
	output	[7:0]	lcd_r,		   //lcd display data
	output	[7:0]	lcd_g,		   //lcd display data	
	output	[7:0]	lcd_b,		   //lcd display data
	
	//user interface
	output			   lcd_rden,	//lcd data request
	output            sdr_addr_set,
	output			   lcd_framesync,	//lcd frame sync
	input  	[95:0]	lcd_data	      //lcd data 96bit
);	  


//-------------------------------------
lcd_driver u_lcd_driver
(
	//global clock
	.clk_lcd			(clk_lcd),		
	.lcd_rst			(lcd_rst), 
	.key1		      (key1),	
	
	 //lcd interface
	.lcd_dclk		(lcd_dclk),
	.lcd_de		   (lcd_de),
	.lcd_hsync		(lcd_hsync),		    	
	.lcd_vsync		(lcd_vsync),
	.lcd_r			(lcd_r),	
	.lcd_g			(lcd_g),	
	.lcd_b			(lcd_b),		
	
	//user interface
	.lcd_rden   	(lcd_rden),
	.lcd_framesync	(lcd_framesync),
	.lcd_data	   (lcd_data),	
	.sdr_addr_set	(sdr_addr_set)	
	
	
);

endmodule


