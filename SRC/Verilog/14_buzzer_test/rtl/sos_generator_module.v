module sos_generator_module 
(
    CLK, RSTn, Pin_Out
);

    input CLK;
    input RSTn;
    output Pin_Out;

    /****************************/

	 wire SOS_En_Sig;
	 
    control_module U1
    (
	     .CLK( CLK ),
		  .RSTn( RSTn ),
		  .SOS_En_Sig( SOS_En_Sig )
	 );    
	 
	 wire Pin_Out_Wire;
	 
	 sos_module U2
	 (
	     .CLK( CLK ),
		  .RSTn( RSTn ),
        .SOS_En_Sig( SOS_En_Sig ),
	     .Pin_Out( Pin_Out_Wire )	  
	 );
	 
	 /******************************/

	 assign Pin_Out = !Pin_Out_Wire;
	 
	 /******************************/
	 
endmodule
