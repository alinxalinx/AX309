module reset_delay(clock_50m,rst_n);    //∏¥Œª—” ±65536*20ns
   input clock_50m;
   output rst_n;
   reg [15:0]cnt;
   reg rst_n;
  
   always@(posedge clock_50m)
   begin
      if(cnt<16'hffff)
      begin
        cnt<=cnt+1;
        rst_n<=0;
      end
      else
        rst_n<=1;       
   end
endmodule
