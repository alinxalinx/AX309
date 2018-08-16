`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module mywav(
		input 	      clk50M,
			
		input  [15:0]	wav_out_data,
		output     	   wav_rden,
		output [15:0] 	wav_in_data,
		output 	      wav_wren,
		
		
 	   input          record_start,               //开始录音信号
		input          voice_write_done,           //录音完成信号

	   input          rd_load, 		
	   input          wr_load, 	
	
		input 	      DACLRC,
		input 	      BCLK,
		output 	      DACDAT,
		input          ADCLRC,                   
		input          ADCDAT,					      

		
		output   	   I2C_SCLK,
		inout 	      I2C_SDAT
);


wire	rst_n;


//复位延时65536*20ns
reset_delay	reset_delay_inst(
	.clock_50m(clk50M),
	.rst_n(rst_n));

//配置WM8731的寄存器
reg_config	reg_config_inst(
	.clock_50m(clk50M),
	.reset_n(rst_n),
	.i2c_sdat(I2C_SDAT),
	.i2c_sclk(I2C_SCLK)
	);

//发送音频数据,right justified
sinwave_gen sinwave_gen_inst(
	.clock_50M(clk50M),
	.wav_out_data(wav_out_data),
	.dacclk(DACLRC),
	.bclk(BCLK),
	.voice_write_done(voice_write_done),
	.dacdat(DACDAT),

	.rd_load(rd_load),	
	.wav_rden(wav_rden)
	);
	
//接收音频数据,right justified
sinwave_store sinwave_store_inst(
	.clock_50M(clk50M),
	.wav_in_data(wav_in_data),
	.adcclk(ADCLRC),
	.bclk(BCLK),
	.adcdat(ADCDAT),
	.record_start(record_start),
	.wr_load(wr_load),
	.wav_wren(wav_wren),
	.voice_write_done(voice_write_done)
	
	);



endmodule
