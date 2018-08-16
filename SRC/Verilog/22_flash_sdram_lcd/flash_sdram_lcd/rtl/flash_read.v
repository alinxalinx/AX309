`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name:    flash_read 
//////////////////////////////////////////////////////////////////////////////////
module flash_read(
                  input clk_ref,
                  input clock,
						input flash_rstn,   
                  input sdram_init_done,       //sdram初始化完成信号		

					   output flash_clk,
						output reg flash_cs,
						output reg flash_datain,
						input  flash_dataout,						


						output reg [15:0]mydata_o,       //FLASH 16bit数据图像
						output myvalid_o,            //数据图像有效信号
						
                  input frame_write_done						
						);


reg [2:0] mystate;


assign flash_clk=spi_clk_en?clock:0;


reg myvalid;
reg [15:0] mydata;

reg spi_clk_en=1'b0;


parameter idle=3'b000;
parameter cmd_send=3'b001;
parameter address_send=3'b010;
parameter read_wait=3'b011;
parameter read_done=3'b100;


parameter FLASH_ADDR=24'h60000;         //图像在flash存储的地址
parameter FLASH_READ=8'b00000011;       //flash读的命令字节序列


reg [7:0] cmd_reg=FLASH_READ;
reg [23:0] address_reg=FLASH_ADDR;
reg [7:0] cnta;
reg [7:0] cntb;
reg data_come;
reg read_finish;


//发送读flash命令
always @(negedge clock)
begin
if(~flash_rstn) begin
		flash_cs<=1'b1;		
		mystate<=idle;
		cmd_reg<=FLASH_READ;
	   spi_clk_en<=1'b0;                //SPI clock输出不使能
		cnta<=0;
      address_reg<=FLASH_ADDR;
		data_come<=1'b0;
	end
else begin
	case(mystate)
		idle: begin//空闲状态			  
				spi_clk_en<=1'b0;
				flash_cs<=1'b1;
				flash_datain<=1'b1;	
			   cmd_reg<=FLASH_READ;
            address_reg<=FLASH_ADDR;
				if(sdram_init_done)                //如果sdram初始化完成
					begin
						mystate<=cmd_send;
                  cnta<=7;							
					end
		end
		cmd_send: begin//发送读命令状态 (8bit)	
			   spi_clk_en<=1'b1;                           //flash的SPI clock输出
				flash_cs<=1'b0;                             //cs拉低
			   if(cnta>0) begin                            //如果cmd_reg还没有发送完					
						flash_datain<=cmd_reg[cnta];          //发送bit7~bit1位
                  cnta<=cnta-1;						
					end				
				 else                                       //发送bit0
				   begin 
						flash_datain<=cmd_reg[0];              
					   mystate<=address_send;
						cnta<=23;		 
				   end
		end
		address_send: begin//发送FLASH地址	 (24bit)	
			   if(cnta>0) begin                                      //如果cmd_reg还没有发送完
				      flash_datain<=address_reg[cnta];               //发送bit23~bit1位
                  cnta<=cnta-1;						
				end				
				else begin                                             //发送bit0	   
						flash_datain<=address_reg[0];              
					   mystate<=read_wait;
						cnta<=0;             						
				   end
		end
		read_wait: begin//读取FLASH的数据状态
		     if(frame_write_done) begin
			     mystate<=read_done;
				  data_come<=1'b0;
			  end
			  else begin
			     data_come<=1'b1;
				  mystate<=mystate;
			  end	  
		end
		read_done:
			begin
 		     flash_cs<=1'b1;
			  flash_datain<=1'b1;
			  spi_clk_en<=1'b0;
			end
		default:mystate<=0;
		endcase;		
	end
end	

//接收flash数据	
always @(posedge clock)
begin
if(~flash_rstn) begin
		cntb<=0;
		myvalid<=1'b0;
		mydata<=0;
end
else
    if(data_come) begin               
		 if(cntb<15) begin         //接收前15位				  
		    myvalid<=1'b0;
		    mydata<={mydata[14:0],flash_dataout};
		    cntb<=cntb+1'b1;
		 end
		 else begin
		    myvalid<=1'b1;          //16位数据有效
			 mydata_o<={mydata[14:0],flash_dataout}; 
			 cntb<=0;
		 end		 			 
	 end
	 else begin
		  cntb<=0;
		  myvalid<=1'b0;
		  mydata<=0;
    end
end			

//---------------------------------
//myvalid->myvalid_o
reg	myvalid_o_r0, myvalid_o_r1;

always@(posedge clk_ref)
begin
	if(~flash_rstn)
		begin
		myvalid_o_r0 <= 0;
		myvalid_o_r1 <= 0;
		end
	else
		begin
		myvalid_o_r0 <= myvalid;
		myvalid_o_r1 <= myvalid_o_r0;
		end
end
assign myvalid_o = (myvalid_o_r1 & ~myvalid_o_r0) ? 1'b1 : 1'b0;	 //negedge


endmodule

