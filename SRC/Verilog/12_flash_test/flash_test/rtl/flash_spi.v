`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name:    flash_spi 
//////////////////////////////////////////////////////////////////////////////////
module flash_spi(
                  output flash_clk,
						output reg flash_cs,
						output reg flash_datain,
						input  flash_dataout,
						
                  input clock25M,
						input flash_rstn,
						input [3:0] cmd_type,
						output reg Done_Sig,
						input [7:0]  flash_cmd,
						input  [23:0] flash_addr,
						output reg [7:0] mydata_o,
						output myvalid_o,
						output reg [2:0] spi_state
			
						);



assign myvalid_o=myvalid;

assign flash_clk=spi_clk_en?clock25M:0;


reg myvalid;
reg [7:0] mydata;

reg spi_clk_en=1'b0;
reg data_come;


parameter idle=3'b000;
parameter cmd_send=3'b001;
parameter address_send=3'b010;
parameter read_wait=3'b011;
parameter write_data=3'b101;
parameter finish_done=3'b110;



reg [7:0] cmd_reg;
reg [23:0] address_reg;
reg [7:0] cnta;
reg [8:0] write_cnt;
reg [7:0] cntb;
reg [8:0] read_cnt;
reg [8:0] read_num;

reg read_finish;

//发送读flash命令
always @(negedge clock25M)
begin
if(!flash_rstn)
	begin
		flash_cs<=1'b1;		
		spi_state<=idle;
		cmd_reg<=0;
		address_reg<=0;
	   spi_clk_en<=1'b0;                //SPI clock输出不使能
		cnta<=0;
      write_cnt<=0;
      read_num<=0;	
      address_reg<=0;
		Done_Sig<=1'b0;
	end
else
	begin
	case(spi_state)
		idle: begin			  
				spi_clk_en<=1'b0;
				flash_cs<=1'b1;
				flash_datain<=1'b1;	
			   cmd_reg<=flash_cmd;
            address_reg<=flash_addr;
		      Done_Sig<=1'b0;				
				if(cmd_type[3]==1'b1) begin                //如果flash操作命令请求
						spi_state<=cmd_send;
                  cnta<=7;		
                  write_cnt<=0;
                  read_num<=0;					
				end
		end
		cmd_send:begin
			   spi_clk_en<=1'b1;                          //flash的SPI clock输出
				flash_cs<=1'b0;                            //cs拉低
			   if(cnta>0) begin                           //如果cmd_reg还没有发送完
						flash_datain<=cmd_reg[cnta];         //发送bit7~bit1位
                  cnta<=cnta-1'b1;						
				end				
				else begin                                 //发送bit0
						flash_datain<=cmd_reg[0];
						if ((cmd_type[2:0]==3'b001) | (cmd_type[2:0]==3'b100)) begin    //如果是Write Enable/disable instruction
 						    spi_state<=finish_done;
                  end							 
                  else if (cmd_type[2:0]==3'b011) begin            //如果是read register1
						 	 spi_state<=read_wait;
							 cnta<=7;
							 read_num<=1;                            //接收一个数据
						end
                  else if (cmd_type[2:0]==3'b000) begin       //如果是read device ID
						 	 spi_state<=read_wait;
							 cnta<=7;
							 read_num<=3;                            //接收3个数据
						end							
						else begin	                          //如果是sector erase, page program, read data      
							 spi_state<=address_send;
						    cnta<=23;
					   end
				end
		end
		address_send:begin
			   if(cnta>0)  begin                                 //如果cmd_reg还没有发送完
					flash_datain<=address_reg[cnta];               //发送bit23~bit1位
               cnta<=cnta-1;						
				end				
				else begin                                        //发送bit0
					flash_datain<=address_reg[0];   
               if(cmd_type[2:0]==3'b010) begin                     //如果是	sector erase
 						 spi_state<=finish_done;	
               end
               else if (cmd_type[2:0]==3'b101) begin	               //如果是page program				
				       spi_state<=write_data;
						 cnta<=7;                       
					end
					else if (cmd_type[2:0]==3'b000) begin                //如果是读Device ID
					    spi_state<=read_wait;
						 read_num<=2;                                     //接收2个数据的Device ID
               end						 
					else begin
					    spi_state<=read_wait;
						 read_num<=256;                                  //接收256个数据							 
               end						 
				end
		end
		read_wait: begin
		     if(read_finish)  begin
			     spi_state<=finish_done;
				  data_come<=1'b0;
			  end
			  else
			     data_come<=1'b1;
		end		
		write_data: begin
		   if(write_cnt<256) begin                       // program 256 byte to flash
			   if(cnta>0) begin                           //如果data还没有发送完
						flash_datain<=write_cnt[cnta];           //发送bit7~bit1位
                  cnta<=cnta-1'b1;						
				end				
				else begin                                 
						flash_datain<=write_cnt[0];         //发送bit0
					   cnta<=7;
					   write_cnt<=write_cnt+1'b1;
				end
			end
         else begin
				 spi_state<=finish_done;
				 spi_clk_en<=1'b0;
			end
				 
		end
		finish_done:begin
 		     flash_cs<=1'b1;
			  flash_datain<=1'b1;
			  spi_clk_en<=1'b0;
			  Done_Sig<=1'b1;
			  spi_state<=idle;
		end
		default:spi_state<=idle;
		endcase;		
	end
end
	
//接收flash数据,把SPI接收的串行数据转成8位字节		
always @(posedge clock25M)
begin
	if(!flash_rstn)begin
			read_cnt<=0;
			cntb<=0;
			read_finish<=1'b0;
			myvalid<=1'b0;
			mydata<=0;
			mydata_o<=0;
	end
	else
		 if(data_come)   begin
				if(read_cnt<read_num) begin  ////接收read_num个数据			  
						if(cntb<7) begin                    //接收一个byte的bit0~bit6		  
							 myvalid<=1'b0;
							 mydata<={mydata[6:0],flash_dataout};
							 cntb<=cntb+1'b1;
						end
						else  begin
							 myvalid<=1'b1;          //一个byte数据有效
							 mydata_o<={mydata[6:0],flash_dataout};  //接收bit7
							 cntb<=0;
							 read_cnt<=read_cnt+1'b1;
						end
				end				 			 
				else begin 
					 read_cnt<=0;
					 read_finish<=1'b1;
					 myvalid<=1'b0;
				end
			end
		 else begin
			  read_cnt<=0;
			  cntb<=0;
			  read_finish<=1'b0;
			  myvalid<=1'b0;
			  mydata<=0;
		 end
end			

endmodule

