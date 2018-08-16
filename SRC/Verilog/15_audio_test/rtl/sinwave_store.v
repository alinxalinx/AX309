module sinwave_store(clock_50M,wav_in_data,adcclk,bclk,adcdat,record_start, wav_wren,wr_load,voice_write_done);

	 input clock_50M;       
    input adcclk;        
    input adcdat;
    input bclk;
	 output reg [15:0] wav_in_data;
	 input record_start;
    output reg wav_wren;
	 input wr_load;
	 input voice_write_done;
	 

	 
reg [7:0]data_num;
reg [15:0]wave_data_reg;
   

reg adcclk_a,adcclk_b;
reg bclk_a,bclk_b;

reg wav_wren_req;
reg wav_wren_reg1;
reg wav_wren_reg2;

reg [3:0] store_stat;
	
//检测dacclk信号的跳变
always@(posedge clock_50M )  
begin
		adcclk_a<=adcclk;
		adcclk_b<=adcclk_a;
end

//检测bclk时钟跳变  
always@(posedge clock_50M ) 
begin
		bclk_a<=bclk;
		bclk_b<=bclk_a;
end

//采集ADC的数据	
always@(negedge clock_50M )    
begin
     if(wr_load==1'b1) begin           //复位寄存器
	      data_num<=0;
			wave_data_reg<=0;
	  end
     else begin   
			if(adcclk_a&!adcclk_b) begin
				wave_data_reg<=0;            //adcclk上升跳变时
				data_num<=0;
			end
			else if(bclk_a&&!bclk_b) begin   //bclk 上降沿,采集数据 
				wave_data_reg<={wave_data_reg[14:0], adcdat};
				data_num<=data_num+1'b1;
			end
	  end		
end  
	  
//产生sdram写信号	
always@(posedge clock_50M )    
begin
    if (wr_load==1'b1) begin            //复位寄存器
		wav_wren_req<=1'b0;	
		wav_in_data<=0;
		store_stat<=4'd0;
    end		
	 else begin
	 	 case( store_stat )
	      4'd0://空闲状态,等待录音开始
			if( record_start ) begin store_stat <= store_stat + 1'b1; end    
			else begin store_stat <= 4'd0; end	

	      4'd1://录音,如果录完一段时间结束
			if( voice_write_done ) begin store_stat <= store_stat + 1'b1; end     
			else begin 
				if((data_num==32) | (data_num==64)) begin   //写入声音数据(2个16bit)到SDRAM
					wav_in_data<=wave_data_reg;            
					wav_wren_req<=1'b1;
				end
				else begin
					wav_in_data<=wav_in_data;
					wav_wren_req<=1'b0;
				end	
         end 
			
	      4'd2://空闲状态,等待录音开始
         begin wav_wren_req<=1'b0; store_stat<=4'd0;end			

	      endcase
			
	 end	
	 
end 

//脉冲信号转换为一个clock宽度	
always@(negedge clock_50M )    
begin
 	 wav_wren_reg1<=wav_wren_req;
 	 wav_wren_reg2<=wav_wren_reg1;
	 if(wav_wren_reg1 & ~wav_wren_reg2)       
	      wav_wren<=1'b1;
	 else
 	      wav_wren<=1'b0;	 
    	 
end 
     
endmodule

