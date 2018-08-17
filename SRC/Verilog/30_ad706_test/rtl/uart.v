`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
module uart(
           input clk50,                     //50Mhz clock
			  input reset_n,
			  
			  input [19:0] ch1_dec,
			  input [19:0] ch2_dec,
			  input [19:0] ch3_dec,
			  input [19:0] ch4_dec,
			  input [19:0] ch5_dec,
			  input [19:0] ch6_dec,
			  input [19:0] ch7_dec,
			  input [19:0] ch8_dec,			  
				
           input [7:0] ch1_sig,
           input [7:0] ch2_sig,
           input [7:0] ch3_sig,
           input [7:0] ch4_sig,
           input [7:0] ch5_sig,
           input [7:0] ch6_sig,
           input [7:0] ch7_sig,
           input [7:0] ch8_sig,
			  

           output tx			  
    );


/********************************************/
//´æ´¢´ý·¢ËÍµÄ´®¿ÚÐÅÏ¢
/********************************************/
reg [7:0] uart_ad [113:0];                        //´æ´¢·¢ËÍµÄASIC×Ö·û

always @(clk)
begin     //¶¨Òå·¢ËÍµÄ×Ö·û
   if(uart_stat==3'b000) begin
		 uart_ad[0]<=65;                           //´æ´¢×Ö·û A 
		 uart_ad[1]<=68;                           //´æ´¢×Ö·û D
		 uart_ad[2]<=49;                           //´æ´¢×Ö·û 1
		 uart_ad[3]<=58;                           //´æ´¢×Ö·û : 
		 uart_ad[4]<=ch1_sig;                      //´æ´¢×Ö·û Õý¸º   	 
		 uart_ad[5]<=ch1_dec[19:16] + 48;          //´æ´¢×Ö·û ¸öÎ»                          
		 uart_ad[6]<=46;                           //´æ´¢×Ö·û . 
		 uart_ad[7]<=ch1_dec[15:12] + 48;          //´æ´¢×Ö·û Ð¡ÊýµãºóÒ»Î»
		 uart_ad[8]<=ch1_dec[11:8] + 48;           //´æ´¢×Ö·û Ð¡Êýµãºó¶þÎ»
		 uart_ad[9]<=ch1_dec[7:4] + 48;            //´æ´¢×Ö·û Ð¡ÊýµãºóÈýÎ»
		 uart_ad[10]<=ch1_dec[3:0] + 48;            //´æ´¢×Ö·û Ð¡ÊýµãºóËÄÎ»
		 uart_ad[11]<=86;                          //´æ´¢×Ö·û V
		 uart_ad[12]<=32;                          //´æ´¢×Ö·û ¿Õ¸ñ
		 uart_ad[13]<=32;                          //´æ´¢×Ö·û ¿Õ¸ñ
		 
		 uart_ad[14]<=65;                           //´æ´¢×Ö·û A 
		 uart_ad[15]<=68;                           //´æ´¢×Ö·û D
		 uart_ad[16]<=50;                           //´æ´¢×Ö·û 2
		 uart_ad[17]<=58;                           //´æ´¢×Ö·û : 
		 uart_ad[18]<=ch2_sig;                      //´æ´¢×Ö·û Õý¸º   	 
		 uart_ad[19]<=ch2_dec[19:16] + 48;          //´æ´¢×Ö·û ¸öÎ»                          
		 uart_ad[20]<=46;                           //´æ´¢×Ö·û . 
		 uart_ad[21]<=ch2_dec[15:12] + 48;          //´æ´¢×Ö·û Ð¡ÊýµãºóÒ»Î»
		 uart_ad[22]<=ch2_dec[11:8] + 48;           //´æ´¢×Ö·û Ð¡Êýµãºó¶þÎ»
		 uart_ad[23]<=ch2_dec[7:4] + 48;            //´æ´¢×Ö·û Ð¡ÊýµãºóÈýÎ»
		 uart_ad[24]<=ch2_dec[3:0] + 48;            //´æ´¢×Ö·û Ð¡ÊýµãºóËÄÎ»
		 uart_ad[25]<=86;                           //´æ´¢×Ö·û V
		 uart_ad[26]<=32;                           //´æ´¢×Ö·û ¿Õ¸ñ
		 uart_ad[27]<=32;                           //´æ´¢×Ö·û ¿Õ¸ñ
		 
		 uart_ad[28]<=65;                           //´æ´¢×Ö·û A 
		 uart_ad[29]<=68;                           //´æ´¢×Ö·û D
		 uart_ad[30]<=51;                           //´æ´¢×Ö·û 3
		 uart_ad[31]<=58;                           //´æ´¢×Ö·û : 
		 uart_ad[32]<=ch3_sig;                      //´æ´¢×Ö·û Õý¸º   	 
		 uart_ad[33]<=ch3_dec[19:16] + 48;          //´æ´¢×Ö·û ¸öÎ»                          
		 uart_ad[34]<=46;                           //´æ´¢×Ö·û . 
		 uart_ad[35]<=ch3_dec[15:12] + 48;          //´æ´¢×Ö·û Ð¡ÊýµãºóÒ»Î»
		 uart_ad[36]<=ch3_dec[11:8] + 48;           //´æ´¢×Ö·û Ð¡Êýµãºó¶þÎ»
		 uart_ad[37]<=ch3_dec[7:4] + 48;            //´æ´¢×Ö·û Ð¡ÊýµãºóÈýÎ»
		 uart_ad[38]<=ch3_dec[3:0] + 48;            //´æ´¢×Ö·û Ð¡ÊýµãºóËÄÎ»
		 uart_ad[39]<=86;                           //´æ´¢×Ö·û V
		 uart_ad[40]<=32;                           //´æ´¢×Ö·û ¿Õ¸ñ
		 uart_ad[41]<=32;                           //´æ´¢×Ö·û ¿Õ¸ñ	 
		 
		 uart_ad[42]<=65;                           //´æ´¢×Ö·û A 
		 uart_ad[43]<=68;                           //´æ´¢×Ö·û D
		 uart_ad[44]<=52;                           //´æ´¢×Ö·û 4
		 uart_ad[45]<=58;                           //´æ´¢×Ö·û : 
		 uart_ad[46]<=ch4_sig;                      //´æ´¢×Ö·û Õý¸º   	 
		 uart_ad[47]<=ch4_dec[19:16] + 48;          //´æ´¢×Ö·û ¸öÎ»                          
		 uart_ad[48]<=46;                           //´æ´¢×Ö·û . 
		 uart_ad[49]<=ch4_dec[15:12] + 48;          //´æ´¢×Ö·û Ð¡ÊýµãºóÒ»Î»
		 uart_ad[50]<=ch4_dec[11:8] + 48;           //´æ´¢×Ö·û Ð¡Êýµãºó¶þÎ»
		 uart_ad[51]<=ch4_dec[7:4] + 48;            //´æ´¢×Ö·û Ð¡ÊýµãºóÈýÎ»
		 uart_ad[52]<=ch4_dec[3:0] + 48;            //´æ´¢×Ö·û Ð¡ÊýµãºóËÄÎ»
		 uart_ad[53]<=86;                           //´æ´¢×Ö·û V
		 uart_ad[54]<=32;                           //´æ´¢×Ö·û ¿Õ¸ñ
		 uart_ad[55]<=32;                           //´æ´¢×Ö·û ¿Õ¸ñ
		 
		 uart_ad[56]<=65;                           //´æ´¢×Ö·û A 
		 uart_ad[57]<=68;                           //´æ´¢×Ö·û D
		 uart_ad[58]<=53;                           //´æ´¢×Ö·û 5
		 uart_ad[59]<=58;                           //´æ´¢×Ö·û : 
		 uart_ad[60]<=ch5_sig;                      //´æ´¢×Ö·û Õý¸º   	 
		 uart_ad[61]<=ch5_dec[19:16] + 48;          //´æ´¢×Ö·û ¸öÎ»                          
		 uart_ad[62]<=46;                           //´æ´¢×Ö·û . 
		 uart_ad[63]<=ch5_dec[15:12] + 48;          //´æ´¢×Ö·û Ð¡ÊýµãºóÒ»Î»
		 uart_ad[64]<=ch5_dec[11:8] + 48;           //´æ´¢×Ö·û Ð¡Êýµãºó¶þÎ»
		 uart_ad[65]<=ch5_dec[7:4] + 48;            //´æ´¢×Ö·û Ð¡ÊýµãºóÈýÎ»
		 uart_ad[66]<=ch5_dec[3:0] + 48;            //´æ´¢×Ö·û Ð¡ÊýµãºóËÄÎ»
		 uart_ad[67]<=86;                           //´æ´¢×Ö·û V
		 uart_ad[68]<=32;                           //´æ´¢×Ö·û ¿Õ¸ñ
		 uart_ad[69]<=32;                           //´æ´¢×Ö·û ¿Õ¸ñ
		 
		 uart_ad[70]<=65;                           //´æ´¢×Ö·û A 
		 uart_ad[71]<=68;                           //´æ´¢×Ö·û D
		 uart_ad[72]<=54;                           //´æ´¢×Ö·û 6
		 uart_ad[73]<=58;                           //´æ´¢×Ö·û : 
		 uart_ad[74]<=ch6_sig;                      //´æ´¢×Ö·û Õý¸º   	 
		 uart_ad[75]<=ch6_dec[19:16] + 48;          //´æ´¢×Ö·û ¸öÎ»                          
		 uart_ad[76]<=46;                           //´æ´¢×Ö·û . 
		 uart_ad[77]<=ch6_dec[15:12] + 48;          //´æ´¢×Ö·û Ð¡ÊýµãºóÒ»Î»
		 uart_ad[78]<=ch6_dec[11:8] + 48;           //´æ´¢×Ö·û Ð¡Êýµãºó¶þÎ»
		 uart_ad[79]<=ch6_dec[7:4] + 48;            //´æ´¢×Ö·û Ð¡ÊýµãºóÈýÎ»
		 uart_ad[80]<=ch6_dec[3:0] + 48;            //´æ´¢×Ö·û Ð¡ÊýµãºóËÄÎ»
		 uart_ad[81]<=86;                           //´æ´¢×Ö·û V
		 uart_ad[82]<=32;                           //´æ´¢×Ö·û ¿Õ¸ñ
		 uart_ad[83]<=32;                           //´æ´¢×Ö·û ¿Õ¸ñ

		 uart_ad[84]<=65;                           //´æ´¢×Ö·û A 
		 uart_ad[85]<=68;                           //´æ´¢×Ö·û D
		 uart_ad[86]<=55;                           //´æ´¢×Ö·û 7
		 uart_ad[87]<=58;                           //´æ´¢×Ö·û : 
		 uart_ad[88]<=ch7_sig;                      //´æ´¢×Ö·û Õý¸º   	 
		 uart_ad[89]<=ch7_dec[19:16] + 48;          //´æ´¢×Ö·û ¸öÎ»                          
		 uart_ad[90]<=46;                           //´æ´¢×Ö·û . 
		 uart_ad[91]<=ch7_dec[15:12] + 48;          //´æ´¢×Ö·û Ð¡ÊýµãºóÒ»Î»
		 uart_ad[92]<=ch7_dec[11:8] + 48;           //´æ´¢×Ö·û Ð¡Êýµãºó¶þÎ»
		 uart_ad[93]<=ch7_dec[7:4] + 48;            //´æ´¢×Ö·û Ð¡ÊýµãºóÈýÎ»
		 uart_ad[94]<=ch7_dec[3:0] + 48;            //´æ´¢×Ö·û Ð¡ÊýµãºóËÄÎ»
		 uart_ad[95]<=86;                           //´æ´¢×Ö·û V
		 uart_ad[96]<=32;                           //´æ´¢×Ö·û ¿Õ¸ñ
		 uart_ad[97]<=32;                           //´æ´¢×Ö·û ¿Õ¸ñ	

		 uart_ad[98]<=65;                           //´æ´¢×Ö·û A 
		 uart_ad[99]<=68;                           //´æ´¢×Ö·û D
		 uart_ad[100]<=56;                          //´æ´¢×Ö·û 8
		 uart_ad[101]<=58;                          //´æ´¢×Ö·û : 
		 uart_ad[102]<=ch8_sig;                     //´æ´¢×Ö·û Õý¸º   	 
		 uart_ad[103]<=ch8_dec[19:16] + 48;         //´æ´¢×Ö·û ¸öÎ»                          
		 uart_ad[104]<=46;                          //´æ´¢×Ö·û . 
		 uart_ad[105]<=ch8_dec[15:12] + 48;         //´æ´¢×Ö·û Ð¡ÊýµãºóÒ»Î»
		 uart_ad[106]<=ch8_dec[11:8] + 48;          //´æ´¢×Ö·û Ð¡Êýµãºó¶þÎ»
		 uart_ad[107]<=ch8_dec[7:4] + 48;           //´æ´¢×Ö·û Ð¡ÊýµãºóÈýÎ»
		 uart_ad[108]<=ch8_dec[3:0] + 48;           //´æ´¢×Ö·û Ð¡ÊýµãºóËÄÎ»
		 uart_ad[109]<=86;                          //´æ´¢×Ö·û V
		 uart_ad[110]<=32;                          //´æ´¢×Ö·û ¿Õ¸ñ
		 uart_ad[111]<=32;                          //´æ´¢×Ö·û ¿Õ¸ñ		

		 uart_ad[112]<=10;                          //»»ÐÐ·û
		 uart_ad[113]<=13;                          //»Ø³µ·û 
	end	 
end 

/********************************************/
//´®¿Ú·¢ËÍÊ±¼ä×Ö·û´®
/********************************************/
reg [15:0] uart_cnt;
reg [2:0] uart_stat;

reg  [7:0]  txdata;             //´®¿Ú·¢ËÍ×Ö·û
reg         wrsig;               //´®¿Ú·¢ËÍÓÐÐ§ÐÅºÅ

reg [8:0] k;

reg [15:0] Time_wait;                  

always @(posedge clk )
begin
  if(!reset_n) begin   
		uart_cnt<=0;
		uart_stat<=3'b000;	
		k<=0;
  end
  else begin
  	 case(uart_stat)
	 3'b000: begin               
       if (Time_wait == 16'hffff) begin          //Èç¹ûÃëÊý¾ÝÓÐ±ä»¯
		    uart_stat<=3'b001; 
			 Time_wait<=0;
		 end
		 else begin
			 uart_stat<=3'b000; 
			 Time_wait<=Time_wait + 1'b1;
		 end
	 end	
	 3'b001: begin                        
         if (k == 113 ) begin          	//·¢ËÍµÚ112¸ö×Ö·û 	 
				 if(uart_cnt ==0) begin
					txdata <= uart_ad[113]; 
					uart_cnt <= uart_cnt + 1'b1;
					wrsig <= 1'b1;                			
				 end	
				 else if(uart_cnt ==254) begin
					uart_cnt <= 0;
					wrsig <= 1'b0; 				
					uart_stat <= 3'b010; 
					k <= 0;
				 end
				 else	begin			
					 uart_cnt <= uart_cnt + 1'b1;
					 wrsig <= 1'b0;  
				 end
		 end
	    else begin                      //·¢ËÍÇ°111¸ö×Ö·û 
				 if(uart_cnt ==0) begin      
					txdata <= uart_ad[k]; 
					uart_cnt <= uart_cnt + 1'b1;
					wrsig <= 1'b1;                			
				 end	
				 else if(uart_cnt ==254) begin
					uart_cnt <= 0;
					wrsig <= 1'b0; 
					k <= k + 1'b1;				
				 end
				 else	begin			
					 uart_cnt <= uart_cnt + 1'b1;
					 wrsig <= 1'b0;  
				 end
		 end	 
	 end
	 3'b010: begin       //·¢ËÍfinish	 
		 	uart_stat <= 3'b000; 
	 end
	 default:uart_stat <= 3'b000;
    endcase 
  end
end

/**********²úÉú´®¿ÚÊ±ÖÓ***********/
clkdiv u0 (
		.clk50                   (clk50),                           
		.clkout                  (clk)             //´®¿Ú·¢ËÍÊ±ÖÓ                 
 );

/*************´®¿Ú·¢ËÍ³ÌÐò************/
uarttx u1 (
		.clk                     (clk),                           
		.datain                  (txdata),
      .wrsig                   (wrsig), 
      .idle                    (idle), 	
	   .tx                      (tx)		
 );



endmodule
