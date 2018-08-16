`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company		: 
// Engineer		: ��Ȩ franchises3
// Create Date	: 2009.05.11
// Design Name	: 
// Module Name	: sdram_para
// Project Name	: 
// Target Device: Cyclone EP1C3T144C8 
// Tool versions: Quartus II 8.1
// Description	: SDRAMģ����������
//				
// Revision		: V1.0
// Additional Comments	:  
// 
////////////////////////////////////////////////////////////////////////////////
//module sdram_para;


//------------------------------------------------------------------------------
	// SDRAM��д����״̬����
`define		W_IDLE		 4'd0		//����״̬
`define		W_ACTIVE	 4'd1		//����Ч���ж϶�д
`define		W_TRCD		 4'd2		//����Ч�ȴ�
/*************************************************************/
`define		W_READ		 4'd3		//������״̬
`define		W_CL		 4'd4		//�ȴ�Ǳ����
`define		W_RD		 4'd5		//������
`define		W_RWAIT		 4'd6		//�����ɺ���Ԥ�����ȴ�״̬
/*************************************************************/
`define		W_WRITE		 4'd7		//д����״̬
`define		W_WD		 4'd8		//д����
`define		W_TDAL		 4'd9		//�ȴ�д���ݲ���ˢ�½���
/*************************************************************/
`define		W_AR		 4'd10		//��ˢ��
`define		W_TRFC		 4'd11		//��ˢ�µȴ�


	// SDRAM��ʼ��״̬����
`define		I_NOP	 	4'd0		//�ȴ��ϵ�200us�ȶ��ڽ���
`define		I_PRE 	 	4'd1		//Ԥ����״̬
`define		I_TRP 	 	4'd2		//�ȴ�Ԥ��������	tRP
`define		I_AR1 	 	4'd3		//��1����ˢ��
`define		I_TRF1	 	4'd4		//�ȴ���1����ˢ�½���	tRFC
`define		I_AR2 	 	4'd5		//��2����ˢ��
`define		I_TRF2 	 	4'd6		//�ȴ���2����ˢ�½���	tRFC	
`define		I_MRS	 	4'd7		//ģʽ�Ĵ�������
`define		I_TMRD	 	4'd8		//�ȴ�ģʽ�Ĵ�����������	tMRD
`define		I_DONE	 	4'd9		//��ʼ������


	//��ʱ����
`define	end_trp			cnt_clk_r	== TRP_CLK
`define	end_trfc		cnt_clk_r	== TRFC_CLK
`define	end_tmrd		cnt_clk_r	== TMRD_CLK
`define	end_trcd		cnt_clk_r	== TRCD_CLK-1
`define end_tcl			cnt_clk_r   == TCL_CLK-1
`define end_rdburst		cnt_clk		== sdrd_byte-4//TREAD_CLK-4		//����ͻ�����ж�����
`define	end_tread		cnt_clk_r	== sdrd_byte+2//TREAD_CLK+2		//TREAD_CLK+2
`define end_wrburst		cnt_clk		== sdwr_byte-1//TWRITE_CLK-1	//����ͻ��д�ж�����
`define	end_twrite		cnt_clk_r	== sdwr_byte-1//TWRITE_CLK-1
`define	end_tdal		cnt_clk_r	== TDAL_CLK	
`define	end_trwait		cnt_clk_r	== TRP_CLK

	//SDRAM�����ź�����
`define		CMD_INIT 	 5'b01111	//�ϵ���ʼ�������˿�		
`define		CMD_NOP		 5'b10111	// NOP COMMAND
`define		CMD_ACTIVE	 5'b10011	// ACTIVE COMMAND
`define		CMD_READ	    5'b10101	// READ COMMADN
`define		CMD_WRITE	 5'b10100	// WRITE COMMAND
`define		CMD_B_STOP	 5'b10110	// BURST STOP
`define		CMD_PRGE	    5'b10010	// PRECHARGE
`define		CMD_A_REF	 5'b10001	// AOTO REFRESH
`define		CMD_LMR		 5'b10000	// LODE MODE REGISTER


//endmodule
