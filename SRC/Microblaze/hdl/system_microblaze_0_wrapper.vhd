-------------------------------------------------------------------------------
-- system_microblaze_0_wrapper.vhd
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

library microblaze_v8_50_c;
use microblaze_v8_50_c.all;

entity system_microblaze_0_wrapper is
  port (
    CLK : in std_logic;
    RESET : in std_logic;
    MB_RESET : in std_logic;
    INTERRUPT : in std_logic;
    INTERRUPT_ADDRESS : in std_logic_vector(0 to 31);
    INTERRUPT_ACK : out std_logic_vector(0 to 1);
    EXT_BRK : in std_logic;
    EXT_NM_BRK : in std_logic;
    DBG_STOP : in std_logic;
    MB_Halted : out std_logic;
    MB_Error : out std_logic;
    WAKEUP : in std_logic_vector(0 to 1);
    SLEEP : out std_logic;
    DBG_WAKEUP : out std_logic;
    LOCKSTEP_MASTER_OUT : out std_logic_vector(0 to 4095);
    LOCKSTEP_SLAVE_IN : in std_logic_vector(0 to 4095);
    LOCKSTEP_OUT : out std_logic_vector(0 to 4095);
    INSTR : in std_logic_vector(0 to 31);
    IREADY : in std_logic;
    IWAIT : in std_logic;
    ICE : in std_logic;
    IUE : in std_logic;
    INSTR_ADDR : out std_logic_vector(0 to 31);
    IFETCH : out std_logic;
    I_AS : out std_logic;
    IPLB_M_ABort : out std_logic;
    IPLB_M_ABus : out std_logic_vector(0 to 31);
    IPLB_M_UABus : out std_logic_vector(0 to 31);
    IPLB_M_BE : out std_logic_vector(0 to 3);
    IPLB_M_busLock : out std_logic;
    IPLB_M_lockErr : out std_logic;
    IPLB_M_MSize : out std_logic_vector(0 to 1);
    IPLB_M_priority : out std_logic_vector(0 to 1);
    IPLB_M_rdBurst : out std_logic;
    IPLB_M_request : out std_logic;
    IPLB_M_RNW : out std_logic;
    IPLB_M_size : out std_logic_vector(0 to 3);
    IPLB_M_TAttribute : out std_logic_vector(0 to 15);
    IPLB_M_type : out std_logic_vector(0 to 2);
    IPLB_M_wrBurst : out std_logic;
    IPLB_M_wrDBus : out std_logic_vector(0 to 31);
    IPLB_MBusy : in std_logic;
    IPLB_MRdErr : in std_logic;
    IPLB_MWrErr : in std_logic;
    IPLB_MIRQ : in std_logic;
    IPLB_MWrBTerm : in std_logic;
    IPLB_MWrDAck : in std_logic;
    IPLB_MAddrAck : in std_logic;
    IPLB_MRdBTerm : in std_logic;
    IPLB_MRdDAck : in std_logic;
    IPLB_MRdDBus : in std_logic_vector(0 to 31);
    IPLB_MRdWdAddr : in std_logic_vector(0 to 3);
    IPLB_MRearbitrate : in std_logic;
    IPLB_MSSize : in std_logic_vector(0 to 1);
    IPLB_MTimeout : in std_logic;
    DATA_READ : in std_logic_vector(0 to 31);
    DREADY : in std_logic;
    DWAIT : in std_logic;
    DCE : in std_logic;
    DUE : in std_logic;
    DATA_WRITE : out std_logic_vector(0 to 31);
    DATA_ADDR : out std_logic_vector(0 to 31);
    D_AS : out std_logic;
    READ_STROBE : out std_logic;
    WRITE_STROBE : out std_logic;
    BYTE_ENABLE : out std_logic_vector(0 to 3);
    DPLB_M_ABort : out std_logic;
    DPLB_M_ABus : out std_logic_vector(0 to 31);
    DPLB_M_UABus : out std_logic_vector(0 to 31);
    DPLB_M_BE : out std_logic_vector(0 to 3);
    DPLB_M_busLock : out std_logic;
    DPLB_M_lockErr : out std_logic;
    DPLB_M_MSize : out std_logic_vector(0 to 1);
    DPLB_M_priority : out std_logic_vector(0 to 1);
    DPLB_M_rdBurst : out std_logic;
    DPLB_M_request : out std_logic;
    DPLB_M_RNW : out std_logic;
    DPLB_M_size : out std_logic_vector(0 to 3);
    DPLB_M_TAttribute : out std_logic_vector(0 to 15);
    DPLB_M_type : out std_logic_vector(0 to 2);
    DPLB_M_wrBurst : out std_logic;
    DPLB_M_wrDBus : out std_logic_vector(0 to 31);
    DPLB_MBusy : in std_logic;
    DPLB_MRdErr : in std_logic;
    DPLB_MWrErr : in std_logic;
    DPLB_MIRQ : in std_logic;
    DPLB_MWrBTerm : in std_logic;
    DPLB_MWrDAck : in std_logic;
    DPLB_MAddrAck : in std_logic;
    DPLB_MRdBTerm : in std_logic;
    DPLB_MRdDAck : in std_logic;
    DPLB_MRdDBus : in std_logic_vector(0 to 31);
    DPLB_MRdWdAddr : in std_logic_vector(0 to 3);
    DPLB_MRearbitrate : in std_logic;
    DPLB_MSSize : in std_logic_vector(0 to 1);
    DPLB_MTimeout : in std_logic;
    M_AXI_IP_AWID : out std_logic_vector(0 downto 0);
    M_AXI_IP_AWADDR : out std_logic_vector(31 downto 0);
    M_AXI_IP_AWLEN : out std_logic_vector(7 downto 0);
    M_AXI_IP_AWSIZE : out std_logic_vector(2 downto 0);
    M_AXI_IP_AWBURST : out std_logic_vector(1 downto 0);
    M_AXI_IP_AWLOCK : out std_logic;
    M_AXI_IP_AWCACHE : out std_logic_vector(3 downto 0);
    M_AXI_IP_AWPROT : out std_logic_vector(2 downto 0);
    M_AXI_IP_AWQOS : out std_logic_vector(3 downto 0);
    M_AXI_IP_AWVALID : out std_logic;
    M_AXI_IP_AWREADY : in std_logic;
    M_AXI_IP_WDATA : out std_logic_vector(31 downto 0);
    M_AXI_IP_WSTRB : out std_logic_vector(3 downto 0);
    M_AXI_IP_WLAST : out std_logic;
    M_AXI_IP_WVALID : out std_logic;
    M_AXI_IP_WREADY : in std_logic;
    M_AXI_IP_BID : in std_logic_vector(0 downto 0);
    M_AXI_IP_BRESP : in std_logic_vector(1 downto 0);
    M_AXI_IP_BVALID : in std_logic;
    M_AXI_IP_BREADY : out std_logic;
    M_AXI_IP_ARID : out std_logic_vector(0 downto 0);
    M_AXI_IP_ARADDR : out std_logic_vector(31 downto 0);
    M_AXI_IP_ARLEN : out std_logic_vector(7 downto 0);
    M_AXI_IP_ARSIZE : out std_logic_vector(2 downto 0);
    M_AXI_IP_ARBURST : out std_logic_vector(1 downto 0);
    M_AXI_IP_ARLOCK : out std_logic;
    M_AXI_IP_ARCACHE : out std_logic_vector(3 downto 0);
    M_AXI_IP_ARPROT : out std_logic_vector(2 downto 0);
    M_AXI_IP_ARQOS : out std_logic_vector(3 downto 0);
    M_AXI_IP_ARVALID : out std_logic;
    M_AXI_IP_ARREADY : in std_logic;
    M_AXI_IP_RID : in std_logic_vector(0 downto 0);
    M_AXI_IP_RDATA : in std_logic_vector(31 downto 0);
    M_AXI_IP_RRESP : in std_logic_vector(1 downto 0);
    M_AXI_IP_RLAST : in std_logic;
    M_AXI_IP_RVALID : in std_logic;
    M_AXI_IP_RREADY : out std_logic;
    M_AXI_DP_AWID : out std_logic_vector(0 downto 0);
    M_AXI_DP_AWADDR : out std_logic_vector(31 downto 0);
    M_AXI_DP_AWLEN : out std_logic_vector(7 downto 0);
    M_AXI_DP_AWSIZE : out std_logic_vector(2 downto 0);
    M_AXI_DP_AWBURST : out std_logic_vector(1 downto 0);
    M_AXI_DP_AWLOCK : out std_logic;
    M_AXI_DP_AWCACHE : out std_logic_vector(3 downto 0);
    M_AXI_DP_AWPROT : out std_logic_vector(2 downto 0);
    M_AXI_DP_AWQOS : out std_logic_vector(3 downto 0);
    M_AXI_DP_AWVALID : out std_logic;
    M_AXI_DP_AWREADY : in std_logic;
    M_AXI_DP_WDATA : out std_logic_vector(31 downto 0);
    M_AXI_DP_WSTRB : out std_logic_vector(3 downto 0);
    M_AXI_DP_WLAST : out std_logic;
    M_AXI_DP_WVALID : out std_logic;
    M_AXI_DP_WREADY : in std_logic;
    M_AXI_DP_BID : in std_logic_vector(0 downto 0);
    M_AXI_DP_BRESP : in std_logic_vector(1 downto 0);
    M_AXI_DP_BVALID : in std_logic;
    M_AXI_DP_BREADY : out std_logic;
    M_AXI_DP_ARID : out std_logic_vector(0 downto 0);
    M_AXI_DP_ARADDR : out std_logic_vector(31 downto 0);
    M_AXI_DP_ARLEN : out std_logic_vector(7 downto 0);
    M_AXI_DP_ARSIZE : out std_logic_vector(2 downto 0);
    M_AXI_DP_ARBURST : out std_logic_vector(1 downto 0);
    M_AXI_DP_ARLOCK : out std_logic;
    M_AXI_DP_ARCACHE : out std_logic_vector(3 downto 0);
    M_AXI_DP_ARPROT : out std_logic_vector(2 downto 0);
    M_AXI_DP_ARQOS : out std_logic_vector(3 downto 0);
    M_AXI_DP_ARVALID : out std_logic;
    M_AXI_DP_ARREADY : in std_logic;
    M_AXI_DP_RID : in std_logic_vector(0 downto 0);
    M_AXI_DP_RDATA : in std_logic_vector(31 downto 0);
    M_AXI_DP_RRESP : in std_logic_vector(1 downto 0);
    M_AXI_DP_RLAST : in std_logic;
    M_AXI_DP_RVALID : in std_logic;
    M_AXI_DP_RREADY : out std_logic;
    M_AXI_IC_AWID : out std_logic_vector(0 downto 0);
    M_AXI_IC_AWADDR : out std_logic_vector(31 downto 0);
    M_AXI_IC_AWLEN : out std_logic_vector(7 downto 0);
    M_AXI_IC_AWSIZE : out std_logic_vector(2 downto 0);
    M_AXI_IC_AWBURST : out std_logic_vector(1 downto 0);
    M_AXI_IC_AWLOCK : out std_logic;
    M_AXI_IC_AWCACHE : out std_logic_vector(3 downto 0);
    M_AXI_IC_AWPROT : out std_logic_vector(2 downto 0);
    M_AXI_IC_AWQOS : out std_logic_vector(3 downto 0);
    M_AXI_IC_AWVALID : out std_logic;
    M_AXI_IC_AWREADY : in std_logic;
    M_AXI_IC_AWUSER : out std_logic_vector(4 downto 0);
    M_AXI_IC_AWDOMAIN : out std_logic_vector(1 downto 0);
    M_AXI_IC_AWSNOOP : out std_logic_vector(2 downto 0);
    M_AXI_IC_AWBAR : out std_logic_vector(1 downto 0);
    M_AXI_IC_WDATA : out std_logic_vector(31 downto 0);
    M_AXI_IC_WSTRB : out std_logic_vector(3 downto 0);
    M_AXI_IC_WLAST : out std_logic;
    M_AXI_IC_WVALID : out std_logic;
    M_AXI_IC_WREADY : in std_logic;
    M_AXI_IC_WUSER : out std_logic_vector(0 downto 0);
    M_AXI_IC_BID : in std_logic_vector(0 downto 0);
    M_AXI_IC_BRESP : in std_logic_vector(1 downto 0);
    M_AXI_IC_BVALID : in std_logic;
    M_AXI_IC_BREADY : out std_logic;
    M_AXI_IC_BUSER : in std_logic_vector(0 downto 0);
    M_AXI_IC_WACK : out std_logic;
    M_AXI_IC_ARID : out std_logic_vector(0 downto 0);
    M_AXI_IC_ARADDR : out std_logic_vector(31 downto 0);
    M_AXI_IC_ARLEN : out std_logic_vector(7 downto 0);
    M_AXI_IC_ARSIZE : out std_logic_vector(2 downto 0);
    M_AXI_IC_ARBURST : out std_logic_vector(1 downto 0);
    M_AXI_IC_ARLOCK : out std_logic;
    M_AXI_IC_ARCACHE : out std_logic_vector(3 downto 0);
    M_AXI_IC_ARPROT : out std_logic_vector(2 downto 0);
    M_AXI_IC_ARQOS : out std_logic_vector(3 downto 0);
    M_AXI_IC_ARVALID : out std_logic;
    M_AXI_IC_ARREADY : in std_logic;
    M_AXI_IC_ARUSER : out std_logic_vector(4 downto 0);
    M_AXI_IC_ARDOMAIN : out std_logic_vector(1 downto 0);
    M_AXI_IC_ARSNOOP : out std_logic_vector(3 downto 0);
    M_AXI_IC_ARBAR : out std_logic_vector(1 downto 0);
    M_AXI_IC_RID : in std_logic_vector(0 downto 0);
    M_AXI_IC_RDATA : in std_logic_vector(31 downto 0);
    M_AXI_IC_RRESP : in std_logic_vector(1 downto 0);
    M_AXI_IC_RLAST : in std_logic;
    M_AXI_IC_RVALID : in std_logic;
    M_AXI_IC_RREADY : out std_logic;
    M_AXI_IC_RUSER : in std_logic_vector(0 downto 0);
    M_AXI_IC_RACK : out std_logic;
    M_AXI_IC_ACVALID : in std_logic;
    M_AXI_IC_ACADDR : in std_logic_vector(31 downto 0);
    M_AXI_IC_ACSNOOP : in std_logic_vector(3 downto 0);
    M_AXI_IC_ACPROT : in std_logic_vector(2 downto 0);
    M_AXI_IC_ACREADY : out std_logic;
    M_AXI_IC_CRREADY : in std_logic;
    M_AXI_IC_CRVALID : out std_logic;
    M_AXI_IC_CRRESP : out std_logic_vector(4 downto 0);
    M_AXI_IC_CDVALID : out std_logic;
    M_AXI_IC_CDREADY : in std_logic;
    M_AXI_IC_CDDATA : out std_logic_vector(31 downto 0);
    M_AXI_IC_CDLAST : out std_logic;
    M_AXI_DC_AWID : out std_logic_vector(0 downto 0);
    M_AXI_DC_AWADDR : out std_logic_vector(31 downto 0);
    M_AXI_DC_AWLEN : out std_logic_vector(7 downto 0);
    M_AXI_DC_AWSIZE : out std_logic_vector(2 downto 0);
    M_AXI_DC_AWBURST : out std_logic_vector(1 downto 0);
    M_AXI_DC_AWLOCK : out std_logic;
    M_AXI_DC_AWCACHE : out std_logic_vector(3 downto 0);
    M_AXI_DC_AWPROT : out std_logic_vector(2 downto 0);
    M_AXI_DC_AWQOS : out std_logic_vector(3 downto 0);
    M_AXI_DC_AWVALID : out std_logic;
    M_AXI_DC_AWREADY : in std_logic;
    M_AXI_DC_AWUSER : out std_logic_vector(4 downto 0);
    M_AXI_DC_AWDOMAIN : out std_logic_vector(1 downto 0);
    M_AXI_DC_AWSNOOP : out std_logic_vector(2 downto 0);
    M_AXI_DC_AWBAR : out std_logic_vector(1 downto 0);
    M_AXI_DC_WDATA : out std_logic_vector(31 downto 0);
    M_AXI_DC_WSTRB : out std_logic_vector(3 downto 0);
    M_AXI_DC_WLAST : out std_logic;
    M_AXI_DC_WVALID : out std_logic;
    M_AXI_DC_WREADY : in std_logic;
    M_AXI_DC_WUSER : out std_logic_vector(0 downto 0);
    M_AXI_DC_BID : in std_logic_vector(0 downto 0);
    M_AXI_DC_BRESP : in std_logic_vector(1 downto 0);
    M_AXI_DC_BVALID : in std_logic;
    M_AXI_DC_BREADY : out std_logic;
    M_AXI_DC_BUSER : in std_logic_vector(0 downto 0);
    M_AXI_DC_WACK : out std_logic;
    M_AXI_DC_ARID : out std_logic_vector(0 downto 0);
    M_AXI_DC_ARADDR : out std_logic_vector(31 downto 0);
    M_AXI_DC_ARLEN : out std_logic_vector(7 downto 0);
    M_AXI_DC_ARSIZE : out std_logic_vector(2 downto 0);
    M_AXI_DC_ARBURST : out std_logic_vector(1 downto 0);
    M_AXI_DC_ARLOCK : out std_logic;
    M_AXI_DC_ARCACHE : out std_logic_vector(3 downto 0);
    M_AXI_DC_ARPROT : out std_logic_vector(2 downto 0);
    M_AXI_DC_ARQOS : out std_logic_vector(3 downto 0);
    M_AXI_DC_ARVALID : out std_logic;
    M_AXI_DC_ARREADY : in std_logic;
    M_AXI_DC_ARUSER : out std_logic_vector(4 downto 0);
    M_AXI_DC_ARDOMAIN : out std_logic_vector(1 downto 0);
    M_AXI_DC_ARSNOOP : out std_logic_vector(3 downto 0);
    M_AXI_DC_ARBAR : out std_logic_vector(1 downto 0);
    M_AXI_DC_RID : in std_logic_vector(0 downto 0);
    M_AXI_DC_RDATA : in std_logic_vector(31 downto 0);
    M_AXI_DC_RRESP : in std_logic_vector(1 downto 0);
    M_AXI_DC_RLAST : in std_logic;
    M_AXI_DC_RVALID : in std_logic;
    M_AXI_DC_RREADY : out std_logic;
    M_AXI_DC_RUSER : in std_logic_vector(0 downto 0);
    M_AXI_DC_RACK : out std_logic;
    M_AXI_DC_ACVALID : in std_logic;
    M_AXI_DC_ACADDR : in std_logic_vector(31 downto 0);
    M_AXI_DC_ACSNOOP : in std_logic_vector(3 downto 0);
    M_AXI_DC_ACPROT : in std_logic_vector(2 downto 0);
    M_AXI_DC_ACREADY : out std_logic;
    M_AXI_DC_CRREADY : in std_logic;
    M_AXI_DC_CRVALID : out std_logic;
    M_AXI_DC_CRRESP : out std_logic_vector(4 downto 0);
    M_AXI_DC_CDVALID : out std_logic;
    M_AXI_DC_CDREADY : in std_logic;
    M_AXI_DC_CDDATA : out std_logic_vector(31 downto 0);
    M_AXI_DC_CDLAST : out std_logic;
    DBG_CLK : in std_logic;
    DBG_TDI : in std_logic;
    DBG_TDO : out std_logic;
    DBG_REG_EN : in std_logic_vector(0 to 7);
    DBG_SHIFT : in std_logic;
    DBG_CAPTURE : in std_logic;
    DBG_UPDATE : in std_logic;
    DEBUG_RST : in std_logic;
    Trace_Instruction : out std_logic_vector(0 to 31);
    Trace_Valid_Instr : out std_logic;
    Trace_PC : out std_logic_vector(0 to 31);
    Trace_Reg_Write : out std_logic;
    Trace_Reg_Addr : out std_logic_vector(0 to 4);
    Trace_MSR_Reg : out std_logic_vector(0 to 14);
    Trace_PID_Reg : out std_logic_vector(0 to 7);
    Trace_New_Reg_Value : out std_logic_vector(0 to 31);
    Trace_Exception_Taken : out std_logic;
    Trace_Exception_Kind : out std_logic_vector(0 to 4);
    Trace_Jump_Taken : out std_logic;
    Trace_Delay_Slot : out std_logic;
    Trace_Data_Address : out std_logic_vector(0 to 31);
    Trace_Data_Access : out std_logic;
    Trace_Data_Read : out std_logic;
    Trace_Data_Write : out std_logic;
    Trace_Data_Write_Value : out std_logic_vector(0 to 31);
    Trace_Data_Byte_Enable : out std_logic_vector(0 to 3);
    Trace_DCache_Req : out std_logic;
    Trace_DCache_Hit : out std_logic;
    Trace_DCache_Rdy : out std_logic;
    Trace_DCache_Read : out std_logic;
    Trace_ICache_Req : out std_logic;
    Trace_ICache_Hit : out std_logic;
    Trace_ICache_Rdy : out std_logic;
    Trace_OF_PipeRun : out std_logic;
    Trace_EX_PipeRun : out std_logic;
    Trace_MEM_PipeRun : out std_logic;
    Trace_MB_Halted : out std_logic;
    Trace_Jump_Hit : out std_logic;
    FSL0_S_CLK : out std_logic;
    FSL0_S_READ : out std_logic;
    FSL0_S_DATA : in std_logic_vector(0 to 31);
    FSL0_S_CONTROL : in std_logic;
    FSL0_S_EXISTS : in std_logic;
    FSL0_M_CLK : out std_logic;
    FSL0_M_WRITE : out std_logic;
    FSL0_M_DATA : out std_logic_vector(0 to 31);
    FSL0_M_CONTROL : out std_logic;
    FSL0_M_FULL : in std_logic;
    FSL1_S_CLK : out std_logic;
    FSL1_S_READ : out std_logic;
    FSL1_S_DATA : in std_logic_vector(0 to 31);
    FSL1_S_CONTROL : in std_logic;
    FSL1_S_EXISTS : in std_logic;
    FSL1_M_CLK : out std_logic;
    FSL1_M_WRITE : out std_logic;
    FSL1_M_DATA : out std_logic_vector(0 to 31);
    FSL1_M_CONTROL : out std_logic;
    FSL1_M_FULL : in std_logic;
    FSL2_S_CLK : out std_logic;
    FSL2_S_READ : out std_logic;
    FSL2_S_DATA : in std_logic_vector(0 to 31);
    FSL2_S_CONTROL : in std_logic;
    FSL2_S_EXISTS : in std_logic;
    FSL2_M_CLK : out std_logic;
    FSL2_M_WRITE : out std_logic;
    FSL2_M_DATA : out std_logic_vector(0 to 31);
    FSL2_M_CONTROL : out std_logic;
    FSL2_M_FULL : in std_logic;
    FSL3_S_CLK : out std_logic;
    FSL3_S_READ : out std_logic;
    FSL3_S_DATA : in std_logic_vector(0 to 31);
    FSL3_S_CONTROL : in std_logic;
    FSL3_S_EXISTS : in std_logic;
    FSL3_M_CLK : out std_logic;
    FSL3_M_WRITE : out std_logic;
    FSL3_M_DATA : out std_logic_vector(0 to 31);
    FSL3_M_CONTROL : out std_logic;
    FSL3_M_FULL : in std_logic;
    FSL4_S_CLK : out std_logic;
    FSL4_S_READ : out std_logic;
    FSL4_S_DATA : in std_logic_vector(0 to 31);
    FSL4_S_CONTROL : in std_logic;
    FSL4_S_EXISTS : in std_logic;
    FSL4_M_CLK : out std_logic;
    FSL4_M_WRITE : out std_logic;
    FSL4_M_DATA : out std_logic_vector(0 to 31);
    FSL4_M_CONTROL : out std_logic;
    FSL4_M_FULL : in std_logic;
    FSL5_S_CLK : out std_logic;
    FSL5_S_READ : out std_logic;
    FSL5_S_DATA : in std_logic_vector(0 to 31);
    FSL5_S_CONTROL : in std_logic;
    FSL5_S_EXISTS : in std_logic;
    FSL5_M_CLK : out std_logic;
    FSL5_M_WRITE : out std_logic;
    FSL5_M_DATA : out std_logic_vector(0 to 31);
    FSL5_M_CONTROL : out std_logic;
    FSL5_M_FULL : in std_logic;
    FSL6_S_CLK : out std_logic;
    FSL6_S_READ : out std_logic;
    FSL6_S_DATA : in std_logic_vector(0 to 31);
    FSL6_S_CONTROL : in std_logic;
    FSL6_S_EXISTS : in std_logic;
    FSL6_M_CLK : out std_logic;
    FSL6_M_WRITE : out std_logic;
    FSL6_M_DATA : out std_logic_vector(0 to 31);
    FSL6_M_CONTROL : out std_logic;
    FSL6_M_FULL : in std_logic;
    FSL7_S_CLK : out std_logic;
    FSL7_S_READ : out std_logic;
    FSL7_S_DATA : in std_logic_vector(0 to 31);
    FSL7_S_CONTROL : in std_logic;
    FSL7_S_EXISTS : in std_logic;
    FSL7_M_CLK : out std_logic;
    FSL7_M_WRITE : out std_logic;
    FSL7_M_DATA : out std_logic_vector(0 to 31);
    FSL7_M_CONTROL : out std_logic;
    FSL7_M_FULL : in std_logic;
    FSL8_S_CLK : out std_logic;
    FSL8_S_READ : out std_logic;
    FSL8_S_DATA : in std_logic_vector(0 to 31);
    FSL8_S_CONTROL : in std_logic;
    FSL8_S_EXISTS : in std_logic;
    FSL8_M_CLK : out std_logic;
    FSL8_M_WRITE : out std_logic;
    FSL8_M_DATA : out std_logic_vector(0 to 31);
    FSL8_M_CONTROL : out std_logic;
    FSL8_M_FULL : in std_logic;
    FSL9_S_CLK : out std_logic;
    FSL9_S_READ : out std_logic;
    FSL9_S_DATA : in std_logic_vector(0 to 31);
    FSL9_S_CONTROL : in std_logic;
    FSL9_S_EXISTS : in std_logic;
    FSL9_M_CLK : out std_logic;
    FSL9_M_WRITE : out std_logic;
    FSL9_M_DATA : out std_logic_vector(0 to 31);
    FSL9_M_CONTROL : out std_logic;
    FSL9_M_FULL : in std_logic;
    FSL10_S_CLK : out std_logic;
    FSL10_S_READ : out std_logic;
    FSL10_S_DATA : in std_logic_vector(0 to 31);
    FSL10_S_CONTROL : in std_logic;
    FSL10_S_EXISTS : in std_logic;
    FSL10_M_CLK : out std_logic;
    FSL10_M_WRITE : out std_logic;
    FSL10_M_DATA : out std_logic_vector(0 to 31);
    FSL10_M_CONTROL : out std_logic;
    FSL10_M_FULL : in std_logic;
    FSL11_S_CLK : out std_logic;
    FSL11_S_READ : out std_logic;
    FSL11_S_DATA : in std_logic_vector(0 to 31);
    FSL11_S_CONTROL : in std_logic;
    FSL11_S_EXISTS : in std_logic;
    FSL11_M_CLK : out std_logic;
    FSL11_M_WRITE : out std_logic;
    FSL11_M_DATA : out std_logic_vector(0 to 31);
    FSL11_M_CONTROL : out std_logic;
    FSL11_M_FULL : in std_logic;
    FSL12_S_CLK : out std_logic;
    FSL12_S_READ : out std_logic;
    FSL12_S_DATA : in std_logic_vector(0 to 31);
    FSL12_S_CONTROL : in std_logic;
    FSL12_S_EXISTS : in std_logic;
    FSL12_M_CLK : out std_logic;
    FSL12_M_WRITE : out std_logic;
    FSL12_M_DATA : out std_logic_vector(0 to 31);
    FSL12_M_CONTROL : out std_logic;
    FSL12_M_FULL : in std_logic;
    FSL13_S_CLK : out std_logic;
    FSL13_S_READ : out std_logic;
    FSL13_S_DATA : in std_logic_vector(0 to 31);
    FSL13_S_CONTROL : in std_logic;
    FSL13_S_EXISTS : in std_logic;
    FSL13_M_CLK : out std_logic;
    FSL13_M_WRITE : out std_logic;
    FSL13_M_DATA : out std_logic_vector(0 to 31);
    FSL13_M_CONTROL : out std_logic;
    FSL13_M_FULL : in std_logic;
    FSL14_S_CLK : out std_logic;
    FSL14_S_READ : out std_logic;
    FSL14_S_DATA : in std_logic_vector(0 to 31);
    FSL14_S_CONTROL : in std_logic;
    FSL14_S_EXISTS : in std_logic;
    FSL14_M_CLK : out std_logic;
    FSL14_M_WRITE : out std_logic;
    FSL14_M_DATA : out std_logic_vector(0 to 31);
    FSL14_M_CONTROL : out std_logic;
    FSL14_M_FULL : in std_logic;
    FSL15_S_CLK : out std_logic;
    FSL15_S_READ : out std_logic;
    FSL15_S_DATA : in std_logic_vector(0 to 31);
    FSL15_S_CONTROL : in std_logic;
    FSL15_S_EXISTS : in std_logic;
    FSL15_M_CLK : out std_logic;
    FSL15_M_WRITE : out std_logic;
    FSL15_M_DATA : out std_logic_vector(0 to 31);
    FSL15_M_CONTROL : out std_logic;
    FSL15_M_FULL : in std_logic;
    M0_AXIS_TLAST : out std_logic;
    M0_AXIS_TDATA : out std_logic_vector(31 downto 0);
    M0_AXIS_TVALID : out std_logic;
    M0_AXIS_TREADY : in std_logic;
    S0_AXIS_TLAST : in std_logic;
    S0_AXIS_TDATA : in std_logic_vector(31 downto 0);
    S0_AXIS_TVALID : in std_logic;
    S0_AXIS_TREADY : out std_logic;
    M1_AXIS_TLAST : out std_logic;
    M1_AXIS_TDATA : out std_logic_vector(31 downto 0);
    M1_AXIS_TVALID : out std_logic;
    M1_AXIS_TREADY : in std_logic;
    S1_AXIS_TLAST : in std_logic;
    S1_AXIS_TDATA : in std_logic_vector(31 downto 0);
    S1_AXIS_TVALID : in std_logic;
    S1_AXIS_TREADY : out std_logic;
    M2_AXIS_TLAST : out std_logic;
    M2_AXIS_TDATA : out std_logic_vector(31 downto 0);
    M2_AXIS_TVALID : out std_logic;
    M2_AXIS_TREADY : in std_logic;
    S2_AXIS_TLAST : in std_logic;
    S2_AXIS_TDATA : in std_logic_vector(31 downto 0);
    S2_AXIS_TVALID : in std_logic;
    S2_AXIS_TREADY : out std_logic;
    M3_AXIS_TLAST : out std_logic;
    M3_AXIS_TDATA : out std_logic_vector(31 downto 0);
    M3_AXIS_TVALID : out std_logic;
    M3_AXIS_TREADY : in std_logic;
    S3_AXIS_TLAST : in std_logic;
    S3_AXIS_TDATA : in std_logic_vector(31 downto 0);
    S3_AXIS_TVALID : in std_logic;
    S3_AXIS_TREADY : out std_logic;
    M4_AXIS_TLAST : out std_logic;
    M4_AXIS_TDATA : out std_logic_vector(31 downto 0);
    M4_AXIS_TVALID : out std_logic;
    M4_AXIS_TREADY : in std_logic;
    S4_AXIS_TLAST : in std_logic;
    S4_AXIS_TDATA : in std_logic_vector(31 downto 0);
    S4_AXIS_TVALID : in std_logic;
    S4_AXIS_TREADY : out std_logic;
    M5_AXIS_TLAST : out std_logic;
    M5_AXIS_TDATA : out std_logic_vector(31 downto 0);
    M5_AXIS_TVALID : out std_logic;
    M5_AXIS_TREADY : in std_logic;
    S5_AXIS_TLAST : in std_logic;
    S5_AXIS_TDATA : in std_logic_vector(31 downto 0);
    S5_AXIS_TVALID : in std_logic;
    S5_AXIS_TREADY : out std_logic;
    M6_AXIS_TLAST : out std_logic;
    M6_AXIS_TDATA : out std_logic_vector(31 downto 0);
    M6_AXIS_TVALID : out std_logic;
    M6_AXIS_TREADY : in std_logic;
    S6_AXIS_TLAST : in std_logic;
    S6_AXIS_TDATA : in std_logic_vector(31 downto 0);
    S6_AXIS_TVALID : in std_logic;
    S6_AXIS_TREADY : out std_logic;
    M7_AXIS_TLAST : out std_logic;
    M7_AXIS_TDATA : out std_logic_vector(31 downto 0);
    M7_AXIS_TVALID : out std_logic;
    M7_AXIS_TREADY : in std_logic;
    S7_AXIS_TLAST : in std_logic;
    S7_AXIS_TDATA : in std_logic_vector(31 downto 0);
    S7_AXIS_TVALID : in std_logic;
    S7_AXIS_TREADY : out std_logic;
    M8_AXIS_TLAST : out std_logic;
    M8_AXIS_TDATA : out std_logic_vector(31 downto 0);
    M8_AXIS_TVALID : out std_logic;
    M8_AXIS_TREADY : in std_logic;
    S8_AXIS_TLAST : in std_logic;
    S8_AXIS_TDATA : in std_logic_vector(31 downto 0);
    S8_AXIS_TVALID : in std_logic;
    S8_AXIS_TREADY : out std_logic;
    M9_AXIS_TLAST : out std_logic;
    M9_AXIS_TDATA : out std_logic_vector(31 downto 0);
    M9_AXIS_TVALID : out std_logic;
    M9_AXIS_TREADY : in std_logic;
    S9_AXIS_TLAST : in std_logic;
    S9_AXIS_TDATA : in std_logic_vector(31 downto 0);
    S9_AXIS_TVALID : in std_logic;
    S9_AXIS_TREADY : out std_logic;
    M10_AXIS_TLAST : out std_logic;
    M10_AXIS_TDATA : out std_logic_vector(31 downto 0);
    M10_AXIS_TVALID : out std_logic;
    M10_AXIS_TREADY : in std_logic;
    S10_AXIS_TLAST : in std_logic;
    S10_AXIS_TDATA : in std_logic_vector(31 downto 0);
    S10_AXIS_TVALID : in std_logic;
    S10_AXIS_TREADY : out std_logic;
    M11_AXIS_TLAST : out std_logic;
    M11_AXIS_TDATA : out std_logic_vector(31 downto 0);
    M11_AXIS_TVALID : out std_logic;
    M11_AXIS_TREADY : in std_logic;
    S11_AXIS_TLAST : in std_logic;
    S11_AXIS_TDATA : in std_logic_vector(31 downto 0);
    S11_AXIS_TVALID : in std_logic;
    S11_AXIS_TREADY : out std_logic;
    M12_AXIS_TLAST : out std_logic;
    M12_AXIS_TDATA : out std_logic_vector(31 downto 0);
    M12_AXIS_TVALID : out std_logic;
    M12_AXIS_TREADY : in std_logic;
    S12_AXIS_TLAST : in std_logic;
    S12_AXIS_TDATA : in std_logic_vector(31 downto 0);
    S12_AXIS_TVALID : in std_logic;
    S12_AXIS_TREADY : out std_logic;
    M13_AXIS_TLAST : out std_logic;
    M13_AXIS_TDATA : out std_logic_vector(31 downto 0);
    M13_AXIS_TVALID : out std_logic;
    M13_AXIS_TREADY : in std_logic;
    S13_AXIS_TLAST : in std_logic;
    S13_AXIS_TDATA : in std_logic_vector(31 downto 0);
    S13_AXIS_TVALID : in std_logic;
    S13_AXIS_TREADY : out std_logic;
    M14_AXIS_TLAST : out std_logic;
    M14_AXIS_TDATA : out std_logic_vector(31 downto 0);
    M14_AXIS_TVALID : out std_logic;
    M14_AXIS_TREADY : in std_logic;
    S14_AXIS_TLAST : in std_logic;
    S14_AXIS_TDATA : in std_logic_vector(31 downto 0);
    S14_AXIS_TVALID : in std_logic;
    S14_AXIS_TREADY : out std_logic;
    M15_AXIS_TLAST : out std_logic;
    M15_AXIS_TDATA : out std_logic_vector(31 downto 0);
    M15_AXIS_TVALID : out std_logic;
    M15_AXIS_TREADY : in std_logic;
    S15_AXIS_TLAST : in std_logic;
    S15_AXIS_TDATA : in std_logic_vector(31 downto 0);
    S15_AXIS_TVALID : in std_logic;
    S15_AXIS_TREADY : out std_logic;
    ICACHE_FSL_IN_CLK : out std_logic;
    ICACHE_FSL_IN_READ : out std_logic;
    ICACHE_FSL_IN_DATA : in std_logic_vector(0 to 31);
    ICACHE_FSL_IN_CONTROL : in std_logic;
    ICACHE_FSL_IN_EXISTS : in std_logic;
    ICACHE_FSL_OUT_CLK : out std_logic;
    ICACHE_FSL_OUT_WRITE : out std_logic;
    ICACHE_FSL_OUT_DATA : out std_logic_vector(0 to 31);
    ICACHE_FSL_OUT_CONTROL : out std_logic;
    ICACHE_FSL_OUT_FULL : in std_logic;
    DCACHE_FSL_IN_CLK : out std_logic;
    DCACHE_FSL_IN_READ : out std_logic;
    DCACHE_FSL_IN_DATA : in std_logic_vector(0 to 31);
    DCACHE_FSL_IN_CONTROL : in std_logic;
    DCACHE_FSL_IN_EXISTS : in std_logic;
    DCACHE_FSL_OUT_CLK : out std_logic;
    DCACHE_FSL_OUT_WRITE : out std_logic;
    DCACHE_FSL_OUT_DATA : out std_logic_vector(0 to 31);
    DCACHE_FSL_OUT_CONTROL : out std_logic;
    DCACHE_FSL_OUT_FULL : in std_logic
  );

  attribute x_core_info : STRING;
  attribute x_core_info of system_microblaze_0_wrapper : entity is "microblaze_v8_50_c";

end system_microblaze_0_wrapper;

architecture STRUCTURE of system_microblaze_0_wrapper is

  component microblaze is
    generic (
      C_SCO : integer;
      C_FREQ : integer;
      C_DATA_SIZE : integer;
      C_DYNAMIC_BUS_SIZING : integer;
      C_FAMILY : string;
      C_INSTANCE : string;
      C_AVOID_PRIMITIVES : integer;
      C_FAULT_TOLERANT : integer;
      C_ECC_USE_CE_EXCEPTION : integer;
      C_LOCKSTEP_SLAVE : integer;
      C_ENDIANNESS : integer;
      C_AREA_OPTIMIZED : integer;
      C_OPTIMIZATION : integer;
      C_INTERCONNECT : integer;
      C_STREAM_INTERCONNECT : integer;
      C_BASE_VECTORS : std_logic_vector;
      C_DPLB_DWIDTH : integer;
      C_DPLB_NATIVE_DWIDTH : integer;
      C_DPLB_BURST_EN : integer;
      C_DPLB_P2P : integer;
      C_IPLB_DWIDTH : integer;
      C_IPLB_NATIVE_DWIDTH : integer;
      C_IPLB_BURST_EN : integer;
      C_IPLB_P2P : integer;
      C_M_AXI_DP_THREAD_ID_WIDTH : integer;
      C_M_AXI_DP_DATA_WIDTH : integer;
      C_M_AXI_DP_ADDR_WIDTH : integer;
      C_M_AXI_DP_EXCLUSIVE_ACCESS : integer;
      C_M_AXI_IP_THREAD_ID_WIDTH : integer;
      C_M_AXI_IP_DATA_WIDTH : integer;
      C_M_AXI_IP_ADDR_WIDTH : integer;
      C_D_AXI : integer;
      C_D_PLB : integer;
      C_D_LMB : integer;
      C_I_AXI : integer;
      C_I_PLB : integer;
      C_I_LMB : integer;
      C_USE_MSR_INSTR : integer;
      C_USE_PCMP_INSTR : integer;
      C_USE_BARREL : integer;
      C_USE_DIV : integer;
      C_USE_HW_MUL : integer;
      C_USE_FPU : integer;
      C_USE_REORDER_INSTR : integer;
      C_UNALIGNED_EXCEPTIONS : integer;
      C_ILL_OPCODE_EXCEPTION : integer;
      C_M_AXI_I_BUS_EXCEPTION : integer;
      C_M_AXI_D_BUS_EXCEPTION : integer;
      C_IPLB_BUS_EXCEPTION : integer;
      C_DPLB_BUS_EXCEPTION : integer;
      C_DIV_ZERO_EXCEPTION : integer;
      C_FPU_EXCEPTION : integer;
      C_FSL_EXCEPTION : integer;
      C_USE_STACK_PROTECTION : integer;
      C_PVR : integer;
      C_PVR_USER1 : std_logic_vector(0 to 7);
      C_PVR_USER2 : std_logic_vector(0 to 31);
      C_DEBUG_ENABLED : integer;
      C_NUMBER_OF_PC_BRK : integer;
      C_NUMBER_OF_RD_ADDR_BRK : integer;
      C_NUMBER_OF_WR_ADDR_BRK : integer;
      C_INTERRUPT_IS_EDGE : integer;
      C_EDGE_IS_POSITIVE : integer;
      C_RESET_MSR : std_logic_vector;
      C_OPCODE_0x0_ILLEGAL : integer;
      C_FSL_LINKS : integer;
      C_FSL_DATA_SIZE : integer;
      C_USE_EXTENDED_FSL_INSTR : integer;
      C_M0_AXIS_DATA_WIDTH : integer;
      C_S0_AXIS_DATA_WIDTH : integer;
      C_M1_AXIS_DATA_WIDTH : integer;
      C_S1_AXIS_DATA_WIDTH : integer;
      C_M2_AXIS_DATA_WIDTH : integer;
      C_S2_AXIS_DATA_WIDTH : integer;
      C_M3_AXIS_DATA_WIDTH : integer;
      C_S3_AXIS_DATA_WIDTH : integer;
      C_M4_AXIS_DATA_WIDTH : integer;
      C_S4_AXIS_DATA_WIDTH : integer;
      C_M5_AXIS_DATA_WIDTH : integer;
      C_S5_AXIS_DATA_WIDTH : integer;
      C_M6_AXIS_DATA_WIDTH : integer;
      C_S6_AXIS_DATA_WIDTH : integer;
      C_M7_AXIS_DATA_WIDTH : integer;
      C_S7_AXIS_DATA_WIDTH : integer;
      C_M8_AXIS_DATA_WIDTH : integer;
      C_S8_AXIS_DATA_WIDTH : integer;
      C_M9_AXIS_DATA_WIDTH : integer;
      C_S9_AXIS_DATA_WIDTH : integer;
      C_M10_AXIS_DATA_WIDTH : integer;
      C_S10_AXIS_DATA_WIDTH : integer;
      C_M11_AXIS_DATA_WIDTH : integer;
      C_S11_AXIS_DATA_WIDTH : integer;
      C_M12_AXIS_DATA_WIDTH : integer;
      C_S12_AXIS_DATA_WIDTH : integer;
      C_M13_AXIS_DATA_WIDTH : integer;
      C_S13_AXIS_DATA_WIDTH : integer;
      C_M14_AXIS_DATA_WIDTH : integer;
      C_S14_AXIS_DATA_WIDTH : integer;
      C_M15_AXIS_DATA_WIDTH : integer;
      C_S15_AXIS_DATA_WIDTH : integer;
      C_ICACHE_BASEADDR : std_logic_vector;
      C_ICACHE_HIGHADDR : std_logic_vector;
      C_USE_ICACHE : integer;
      C_ALLOW_ICACHE_WR : integer;
      C_ADDR_TAG_BITS : integer;
      C_CACHE_BYTE_SIZE : integer;
      C_ICACHE_USE_FSL : integer;
      C_ICACHE_LINE_LEN : integer;
      C_ICACHE_ALWAYS_USED : integer;
      C_ICACHE_INTERFACE : integer;
      C_ICACHE_VICTIMS : integer;
      C_ICACHE_STREAMS : integer;
      C_ICACHE_FORCE_TAG_LUTRAM : integer;
      C_ICACHE_DATA_WIDTH : integer;
      C_M_AXI_IC_THREAD_ID_WIDTH : integer;
      C_M_AXI_IC_DATA_WIDTH : integer;
      C_M_AXI_IC_ADDR_WIDTH : integer;
      C_M_AXI_IC_USER_VALUE : integer;
      C_M_AXI_IC_AWUSER_WIDTH : integer;
      C_M_AXI_IC_ARUSER_WIDTH : integer;
      C_M_AXI_IC_WUSER_WIDTH : integer;
      C_M_AXI_IC_RUSER_WIDTH : integer;
      C_M_AXI_IC_BUSER_WIDTH : integer;
      C_DCACHE_BASEADDR : std_logic_vector;
      C_DCACHE_HIGHADDR : std_logic_vector;
      C_USE_DCACHE : integer;
      C_ALLOW_DCACHE_WR : integer;
      C_DCACHE_ADDR_TAG : integer;
      C_DCACHE_BYTE_SIZE : integer;
      C_DCACHE_USE_FSL : integer;
      C_DCACHE_LINE_LEN : integer;
      C_DCACHE_ALWAYS_USED : integer;
      C_DCACHE_INTERFACE : integer;
      C_DCACHE_USE_WRITEBACK : integer;
      C_DCACHE_VICTIMS : integer;
      C_DCACHE_FORCE_TAG_LUTRAM : integer;
      C_DCACHE_DATA_WIDTH : integer;
      C_M_AXI_DC_THREAD_ID_WIDTH : integer;
      C_M_AXI_DC_DATA_WIDTH : integer;
      C_M_AXI_DC_ADDR_WIDTH : integer;
      C_M_AXI_DC_EXCLUSIVE_ACCESS : integer;
      C_M_AXI_DC_USER_VALUE : integer;
      C_M_AXI_DC_AWUSER_WIDTH : integer;
      C_M_AXI_DC_ARUSER_WIDTH : integer;
      C_M_AXI_DC_WUSER_WIDTH : integer;
      C_M_AXI_DC_RUSER_WIDTH : integer;
      C_M_AXI_DC_BUSER_WIDTH : integer;
      C_USE_MMU : integer;
      C_MMU_DTLB_SIZE : integer;
      C_MMU_ITLB_SIZE : integer;
      C_MMU_TLB_ACCESS : integer;
      C_MMU_ZONES : integer;
      C_MMU_PRIVILEGED_INSTR : integer;
      C_USE_INTERRUPT : integer;
      C_USE_EXT_BRK : integer;
      C_USE_EXT_NM_BRK : integer;
      C_USE_BRANCH_TARGET_CACHE : integer;
      C_BRANCH_TARGET_CACHE_SIZE : integer;
      C_PC_WIDTH : integer
    );
    port (
      CLK : in std_logic;
      RESET : in std_logic;
      MB_RESET : in std_logic;
      INTERRUPT : in std_logic;
      INTERRUPT_ADDRESS : in std_logic_vector(0 to 31);
      INTERRUPT_ACK : out std_logic_vector(0 to 1);
      EXT_BRK : in std_logic;
      EXT_NM_BRK : in std_logic;
      DBG_STOP : in std_logic;
      MB_Halted : out std_logic;
      MB_Error : out std_logic;
      WAKEUP : in std_logic_vector(0 to 1);
      SLEEP : out std_logic;
      DBG_WAKEUP : out std_logic;
      LOCKSTEP_MASTER_OUT : out std_logic_vector(0 to 4095);
      LOCKSTEP_SLAVE_IN : in std_logic_vector(0 to 4095);
      LOCKSTEP_OUT : out std_logic_vector(0 to 4095);
      INSTR : in std_logic_vector(0 to 31);
      IREADY : in std_logic;
      IWAIT : in std_logic;
      ICE : in std_logic;
      IUE : in std_logic;
      INSTR_ADDR : out std_logic_vector(0 to 31);
      IFETCH : out std_logic;
      I_AS : out std_logic;
      IPLB_M_ABort : out std_logic;
      IPLB_M_ABus : out std_logic_vector(0 to 31);
      IPLB_M_UABus : out std_logic_vector(0 to 31);
      IPLB_M_BE : out std_logic_vector(0 to (C_IPLB_DWIDTH-1)/8);
      IPLB_M_busLock : out std_logic;
      IPLB_M_lockErr : out std_logic;
      IPLB_M_MSize : out std_logic_vector(0 to 1);
      IPLB_M_priority : out std_logic_vector(0 to 1);
      IPLB_M_rdBurst : out std_logic;
      IPLB_M_request : out std_logic;
      IPLB_M_RNW : out std_logic;
      IPLB_M_size : out std_logic_vector(0 to 3);
      IPLB_M_TAttribute : out std_logic_vector(0 to 15);
      IPLB_M_type : out std_logic_vector(0 to 2);
      IPLB_M_wrBurst : out std_logic;
      IPLB_M_wrDBus : out std_logic_vector(0 to C_IPLB_DWIDTH-1);
      IPLB_MBusy : in std_logic;
      IPLB_MRdErr : in std_logic;
      IPLB_MWrErr : in std_logic;
      IPLB_MIRQ : in std_logic;
      IPLB_MWrBTerm : in std_logic;
      IPLB_MWrDAck : in std_logic;
      IPLB_MAddrAck : in std_logic;
      IPLB_MRdBTerm : in std_logic;
      IPLB_MRdDAck : in std_logic;
      IPLB_MRdDBus : in std_logic_vector(0 to C_IPLB_DWIDTH-1);
      IPLB_MRdWdAddr : in std_logic_vector(0 to 3);
      IPLB_MRearbitrate : in std_logic;
      IPLB_MSSize : in std_logic_vector(0 to 1);
      IPLB_MTimeout : in std_logic;
      DATA_READ : in std_logic_vector(0 to 31);
      DREADY : in std_logic;
      DWAIT : in std_logic;
      DCE : in std_logic;
      DUE : in std_logic;
      DATA_WRITE : out std_logic_vector(0 to 31);
      DATA_ADDR : out std_logic_vector(0 to 31);
      D_AS : out std_logic;
      READ_STROBE : out std_logic;
      WRITE_STROBE : out std_logic;
      BYTE_ENABLE : out std_logic_vector(0 to 3);
      DPLB_M_ABort : out std_logic;
      DPLB_M_ABus : out std_logic_vector(0 to 31);
      DPLB_M_UABus : out std_logic_vector(0 to 31);
      DPLB_M_BE : out std_logic_vector(0 to (C_DPLB_DWIDTH-1)/8);
      DPLB_M_busLock : out std_logic;
      DPLB_M_lockErr : out std_logic;
      DPLB_M_MSize : out std_logic_vector(0 to 1);
      DPLB_M_priority : out std_logic_vector(0 to 1);
      DPLB_M_rdBurst : out std_logic;
      DPLB_M_request : out std_logic;
      DPLB_M_RNW : out std_logic;
      DPLB_M_size : out std_logic_vector(0 to 3);
      DPLB_M_TAttribute : out std_logic_vector(0 to 15);
      DPLB_M_type : out std_logic_vector(0 to 2);
      DPLB_M_wrBurst : out std_logic;
      DPLB_M_wrDBus : out std_logic_vector(0 to C_DPLB_DWIDTH-1);
      DPLB_MBusy : in std_logic;
      DPLB_MRdErr : in std_logic;
      DPLB_MWrErr : in std_logic;
      DPLB_MIRQ : in std_logic;
      DPLB_MWrBTerm : in std_logic;
      DPLB_MWrDAck : in std_logic;
      DPLB_MAddrAck : in std_logic;
      DPLB_MRdBTerm : in std_logic;
      DPLB_MRdDAck : in std_logic;
      DPLB_MRdDBus : in std_logic_vector(0 to C_DPLB_DWIDTH-1);
      DPLB_MRdWdAddr : in std_logic_vector(0 to 3);
      DPLB_MRearbitrate : in std_logic;
      DPLB_MSSize : in std_logic_vector(0 to 1);
      DPLB_MTimeout : in std_logic;
      M_AXI_IP_AWID : out std_logic_vector((C_M_AXI_IP_THREAD_ID_WIDTH-1) downto 0);
      M_AXI_IP_AWADDR : out std_logic_vector((C_M_AXI_IP_ADDR_WIDTH-1) downto 0);
      M_AXI_IP_AWLEN : out std_logic_vector(7 downto 0);
      M_AXI_IP_AWSIZE : out std_logic_vector(2 downto 0);
      M_AXI_IP_AWBURST : out std_logic_vector(1 downto 0);
      M_AXI_IP_AWLOCK : out std_logic;
      M_AXI_IP_AWCACHE : out std_logic_vector(3 downto 0);
      M_AXI_IP_AWPROT : out std_logic_vector(2 downto 0);
      M_AXI_IP_AWQOS : out std_logic_vector(3 downto 0);
      M_AXI_IP_AWVALID : out std_logic;
      M_AXI_IP_AWREADY : in std_logic;
      M_AXI_IP_WDATA : out std_logic_vector((C_M_AXI_IP_DATA_WIDTH-1) downto 0);
      M_AXI_IP_WSTRB : out std_logic_vector(((C_M_AXI_IP_DATA_WIDTH/8)-1) downto 0);
      M_AXI_IP_WLAST : out std_logic;
      M_AXI_IP_WVALID : out std_logic;
      M_AXI_IP_WREADY : in std_logic;
      M_AXI_IP_BID : in std_logic_vector((C_M_AXI_IP_THREAD_ID_WIDTH-1) downto 0);
      M_AXI_IP_BRESP : in std_logic_vector(1 downto 0);
      M_AXI_IP_BVALID : in std_logic;
      M_AXI_IP_BREADY : out std_logic;
      M_AXI_IP_ARID : out std_logic_vector((C_M_AXI_IP_THREAD_ID_WIDTH-1) downto 0);
      M_AXI_IP_ARADDR : out std_logic_vector((C_M_AXI_IP_ADDR_WIDTH-1) downto 0);
      M_AXI_IP_ARLEN : out std_logic_vector(7 downto 0);
      M_AXI_IP_ARSIZE : out std_logic_vector(2 downto 0);
      M_AXI_IP_ARBURST : out std_logic_vector(1 downto 0);
      M_AXI_IP_ARLOCK : out std_logic;
      M_AXI_IP_ARCACHE : out std_logic_vector(3 downto 0);
      M_AXI_IP_ARPROT : out std_logic_vector(2 downto 0);
      M_AXI_IP_ARQOS : out std_logic_vector(3 downto 0);
      M_AXI_IP_ARVALID : out std_logic;
      M_AXI_IP_ARREADY : in std_logic;
      M_AXI_IP_RID : in std_logic_vector((C_M_AXI_IP_THREAD_ID_WIDTH-1) downto 0);
      M_AXI_IP_RDATA : in std_logic_vector((C_M_AXI_IP_DATA_WIDTH-1) downto 0);
      M_AXI_IP_RRESP : in std_logic_vector(1 downto 0);
      M_AXI_IP_RLAST : in std_logic;
      M_AXI_IP_RVALID : in std_logic;
      M_AXI_IP_RREADY : out std_logic;
      M_AXI_DP_AWID : out std_logic_vector((C_M_AXI_DP_THREAD_ID_WIDTH-1) downto 0);
      M_AXI_DP_AWADDR : out std_logic_vector((C_M_AXI_DP_ADDR_WIDTH-1) downto 0);
      M_AXI_DP_AWLEN : out std_logic_vector(7 downto 0);
      M_AXI_DP_AWSIZE : out std_logic_vector(2 downto 0);
      M_AXI_DP_AWBURST : out std_logic_vector(1 downto 0);
      M_AXI_DP_AWLOCK : out std_logic;
      M_AXI_DP_AWCACHE : out std_logic_vector(3 downto 0);
      M_AXI_DP_AWPROT : out std_logic_vector(2 downto 0);
      M_AXI_DP_AWQOS : out std_logic_vector(3 downto 0);
      M_AXI_DP_AWVALID : out std_logic;
      M_AXI_DP_AWREADY : in std_logic;
      M_AXI_DP_WDATA : out std_logic_vector((C_M_AXI_DP_DATA_WIDTH-1) downto 0);
      M_AXI_DP_WSTRB : out std_logic_vector(((C_M_AXI_DP_DATA_WIDTH/8)-1) downto 0);
      M_AXI_DP_WLAST : out std_logic;
      M_AXI_DP_WVALID : out std_logic;
      M_AXI_DP_WREADY : in std_logic;
      M_AXI_DP_BID : in std_logic_vector((C_M_AXI_DP_THREAD_ID_WIDTH-1) downto 0);
      M_AXI_DP_BRESP : in std_logic_vector(1 downto 0);
      M_AXI_DP_BVALID : in std_logic;
      M_AXI_DP_BREADY : out std_logic;
      M_AXI_DP_ARID : out std_logic_vector((C_M_AXI_DP_THREAD_ID_WIDTH-1) downto 0);
      M_AXI_DP_ARADDR : out std_logic_vector((C_M_AXI_DP_ADDR_WIDTH-1) downto 0);
      M_AXI_DP_ARLEN : out std_logic_vector(7 downto 0);
      M_AXI_DP_ARSIZE : out std_logic_vector(2 downto 0);
      M_AXI_DP_ARBURST : out std_logic_vector(1 downto 0);
      M_AXI_DP_ARLOCK : out std_logic;
      M_AXI_DP_ARCACHE : out std_logic_vector(3 downto 0);
      M_AXI_DP_ARPROT : out std_logic_vector(2 downto 0);
      M_AXI_DP_ARQOS : out std_logic_vector(3 downto 0);
      M_AXI_DP_ARVALID : out std_logic;
      M_AXI_DP_ARREADY : in std_logic;
      M_AXI_DP_RID : in std_logic_vector((C_M_AXI_DP_THREAD_ID_WIDTH-1) downto 0);
      M_AXI_DP_RDATA : in std_logic_vector((C_M_AXI_DP_DATA_WIDTH-1) downto 0);
      M_AXI_DP_RRESP : in std_logic_vector(1 downto 0);
      M_AXI_DP_RLAST : in std_logic;
      M_AXI_DP_RVALID : in std_logic;
      M_AXI_DP_RREADY : out std_logic;
      M_AXI_IC_AWID : out std_logic_vector((C_M_AXI_IC_THREAD_ID_WIDTH-1) downto 0);
      M_AXI_IC_AWADDR : out std_logic_vector((C_M_AXI_IC_ADDR_WIDTH-1) downto 0);
      M_AXI_IC_AWLEN : out std_logic_vector(7 downto 0);
      M_AXI_IC_AWSIZE : out std_logic_vector(2 downto 0);
      M_AXI_IC_AWBURST : out std_logic_vector(1 downto 0);
      M_AXI_IC_AWLOCK : out std_logic;
      M_AXI_IC_AWCACHE : out std_logic_vector(3 downto 0);
      M_AXI_IC_AWPROT : out std_logic_vector(2 downto 0);
      M_AXI_IC_AWQOS : out std_logic_vector(3 downto 0);
      M_AXI_IC_AWVALID : out std_logic;
      M_AXI_IC_AWREADY : in std_logic;
      M_AXI_IC_AWUSER : out std_logic_vector((C_M_AXI_IC_AWUSER_WIDTH-1) downto 0);
      M_AXI_IC_AWDOMAIN : out std_logic_vector(1 downto 0);
      M_AXI_IC_AWSNOOP : out std_logic_vector(2 downto 0);
      M_AXI_IC_AWBAR : out std_logic_vector(1 downto 0);
      M_AXI_IC_WDATA : out std_logic_vector((C_M_AXI_IC_DATA_WIDTH-1) downto 0);
      M_AXI_IC_WSTRB : out std_logic_vector(((C_M_AXI_IC_DATA_WIDTH/8)-1) downto 0);
      M_AXI_IC_WLAST : out std_logic;
      M_AXI_IC_WVALID : out std_logic;
      M_AXI_IC_WREADY : in std_logic;
      M_AXI_IC_WUSER : out std_logic_vector((C_M_AXI_IC_WUSER_WIDTH-1) downto 0);
      M_AXI_IC_BID : in std_logic_vector((C_M_AXI_IC_THREAD_ID_WIDTH-1) downto 0);
      M_AXI_IC_BRESP : in std_logic_vector(1 downto 0);
      M_AXI_IC_BVALID : in std_logic;
      M_AXI_IC_BREADY : out std_logic;
      M_AXI_IC_BUSER : in std_logic_vector((C_M_AXI_IC_BUSER_WIDTH-1) downto 0);
      M_AXI_IC_WACK : out std_logic;
      M_AXI_IC_ARID : out std_logic_vector((C_M_AXI_IC_THREAD_ID_WIDTH-1) downto 0);
      M_AXI_IC_ARADDR : out std_logic_vector((C_M_AXI_IC_ADDR_WIDTH-1) downto 0);
      M_AXI_IC_ARLEN : out std_logic_vector(7 downto 0);
      M_AXI_IC_ARSIZE : out std_logic_vector(2 downto 0);
      M_AXI_IC_ARBURST : out std_logic_vector(1 downto 0);
      M_AXI_IC_ARLOCK : out std_logic;
      M_AXI_IC_ARCACHE : out std_logic_vector(3 downto 0);
      M_AXI_IC_ARPROT : out std_logic_vector(2 downto 0);
      M_AXI_IC_ARQOS : out std_logic_vector(3 downto 0);
      M_AXI_IC_ARVALID : out std_logic;
      M_AXI_IC_ARREADY : in std_logic;
      M_AXI_IC_ARUSER : out std_logic_vector((C_M_AXI_IC_ARUSER_WIDTH-1) downto 0);
      M_AXI_IC_ARDOMAIN : out std_logic_vector(1 downto 0);
      M_AXI_IC_ARSNOOP : out std_logic_vector(3 downto 0);
      M_AXI_IC_ARBAR : out std_logic_vector(1 downto 0);
      M_AXI_IC_RID : in std_logic_vector((C_M_AXI_IC_THREAD_ID_WIDTH-1) downto 0);
      M_AXI_IC_RDATA : in std_logic_vector((C_M_AXI_IC_DATA_WIDTH-1) downto 0);
      M_AXI_IC_RRESP : in std_logic_vector(1+2*((C_INTERCONNECT-1)/2) downto 0);
      M_AXI_IC_RLAST : in std_logic;
      M_AXI_IC_RVALID : in std_logic;
      M_AXI_IC_RREADY : out std_logic;
      M_AXI_IC_RUSER : in std_logic_vector((C_M_AXI_IC_RUSER_WIDTH-1) downto 0);
      M_AXI_IC_RACK : out std_logic;
      M_AXI_IC_ACVALID : in std_logic;
      M_AXI_IC_ACADDR : in std_logic_vector((C_M_AXI_IC_ADDR_WIDTH-1) downto 0);
      M_AXI_IC_ACSNOOP : in std_logic_vector(3 downto 0);
      M_AXI_IC_ACPROT : in std_logic_vector(2 downto 0);
      M_AXI_IC_ACREADY : out std_logic;
      M_AXI_IC_CRREADY : in std_logic;
      M_AXI_IC_CRVALID : out std_logic;
      M_AXI_IC_CRRESP : out std_logic_vector(4 downto 0);
      M_AXI_IC_CDVALID : out std_logic;
      M_AXI_IC_CDREADY : in std_logic;
      M_AXI_IC_CDDATA : out std_logic_vector((C_M_AXI_IC_DATA_WIDTH-1) downto 0);
      M_AXI_IC_CDLAST : out std_logic;
      M_AXI_DC_AWID : out std_logic_vector((C_M_AXI_DC_THREAD_ID_WIDTH-1) downto 0);
      M_AXI_DC_AWADDR : out std_logic_vector((C_M_AXI_DC_ADDR_WIDTH-1) downto 0);
      M_AXI_DC_AWLEN : out std_logic_vector(7 downto 0);
      M_AXI_DC_AWSIZE : out std_logic_vector(2 downto 0);
      M_AXI_DC_AWBURST : out std_logic_vector(1 downto 0);
      M_AXI_DC_AWLOCK : out std_logic;
      M_AXI_DC_AWCACHE : out std_logic_vector(3 downto 0);
      M_AXI_DC_AWPROT : out std_logic_vector(2 downto 0);
      M_AXI_DC_AWQOS : out std_logic_vector(3 downto 0);
      M_AXI_DC_AWVALID : out std_logic;
      M_AXI_DC_AWREADY : in std_logic;
      M_AXI_DC_AWUSER : out std_logic_vector((C_M_AXI_DC_AWUSER_WIDTH-1) downto 0);
      M_AXI_DC_AWDOMAIN : out std_logic_vector(1 downto 0);
      M_AXI_DC_AWSNOOP : out std_logic_vector(2 downto 0);
      M_AXI_DC_AWBAR : out std_logic_vector(1 downto 0);
      M_AXI_DC_WDATA : out std_logic_vector((C_M_AXI_DC_DATA_WIDTH-1) downto 0);
      M_AXI_DC_WSTRB : out std_logic_vector(((C_M_AXI_DC_DATA_WIDTH/8)-1) downto 0);
      M_AXI_DC_WLAST : out std_logic;
      M_AXI_DC_WVALID : out std_logic;
      M_AXI_DC_WREADY : in std_logic;
      M_AXI_DC_WUSER : out std_logic_vector((C_M_AXI_DC_WUSER_WIDTH-1) downto 0);
      M_AXI_DC_BID : in std_logic_vector((C_M_AXI_DC_THREAD_ID_WIDTH-1) downto 0);
      M_AXI_DC_BRESP : in std_logic_vector(1 downto 0);
      M_AXI_DC_BVALID : in std_logic;
      M_AXI_DC_BREADY : out std_logic;
      M_AXI_DC_BUSER : in std_logic_vector((C_M_AXI_DC_BUSER_WIDTH-1) downto 0);
      M_AXI_DC_WACK : out std_logic;
      M_AXI_DC_ARID : out std_logic_vector((C_M_AXI_DC_THREAD_ID_WIDTH-1) downto 0);
      M_AXI_DC_ARADDR : out std_logic_vector((C_M_AXI_DC_ADDR_WIDTH-1) downto 0);
      M_AXI_DC_ARLEN : out std_logic_vector(7 downto 0);
      M_AXI_DC_ARSIZE : out std_logic_vector(2 downto 0);
      M_AXI_DC_ARBURST : out std_logic_vector(1 downto 0);
      M_AXI_DC_ARLOCK : out std_logic;
      M_AXI_DC_ARCACHE : out std_logic_vector(3 downto 0);
      M_AXI_DC_ARPROT : out std_logic_vector(2 downto 0);
      M_AXI_DC_ARQOS : out std_logic_vector(3 downto 0);
      M_AXI_DC_ARVALID : out std_logic;
      M_AXI_DC_ARREADY : in std_logic;
      M_AXI_DC_ARUSER : out std_logic_vector((C_M_AXI_DC_ARUSER_WIDTH-1) downto 0);
      M_AXI_DC_ARDOMAIN : out std_logic_vector(1 downto 0);
      M_AXI_DC_ARSNOOP : out std_logic_vector(3 downto 0);
      M_AXI_DC_ARBAR : out std_logic_vector(1 downto 0);
      M_AXI_DC_RID : in std_logic_vector((C_M_AXI_DC_THREAD_ID_WIDTH-1) downto 0);
      M_AXI_DC_RDATA : in std_logic_vector((C_M_AXI_DC_DATA_WIDTH-1) downto 0);
      M_AXI_DC_RRESP : in std_logic_vector(1+2*((C_INTERCONNECT-1)/2) downto 0);
      M_AXI_DC_RLAST : in std_logic;
      M_AXI_DC_RVALID : in std_logic;
      M_AXI_DC_RREADY : out std_logic;
      M_AXI_DC_RUSER : in std_logic_vector((C_M_AXI_DC_RUSER_WIDTH-1) downto 0);
      M_AXI_DC_RACK : out std_logic;
      M_AXI_DC_ACVALID : in std_logic;
      M_AXI_DC_ACADDR : in std_logic_vector((C_M_AXI_DC_ADDR_WIDTH-1) downto 0);
      M_AXI_DC_ACSNOOP : in std_logic_vector(3 downto 0);
      M_AXI_DC_ACPROT : in std_logic_vector(2 downto 0);
      M_AXI_DC_ACREADY : out std_logic;
      M_AXI_DC_CRREADY : in std_logic;
      M_AXI_DC_CRVALID : out std_logic;
      M_AXI_DC_CRRESP : out std_logic_vector(4 downto 0);
      M_AXI_DC_CDVALID : out std_logic;
      M_AXI_DC_CDREADY : in std_logic;
      M_AXI_DC_CDDATA : out std_logic_vector((C_M_AXI_DC_DATA_WIDTH-1) downto 0);
      M_AXI_DC_CDLAST : out std_logic;
      DBG_CLK : in std_logic;
      DBG_TDI : in std_logic;
      DBG_TDO : out std_logic;
      DBG_REG_EN : in std_logic_vector(0 to 7);
      DBG_SHIFT : in std_logic;
      DBG_CAPTURE : in std_logic;
      DBG_UPDATE : in std_logic;
      DEBUG_RST : in std_logic;
      Trace_Instruction : out std_logic_vector(0 to 31);
      Trace_Valid_Instr : out std_logic;
      Trace_PC : out std_logic_vector(0 to 31);
      Trace_Reg_Write : out std_logic;
      Trace_Reg_Addr : out std_logic_vector(0 to 4);
      Trace_MSR_Reg : out std_logic_vector(0 to 14);
      Trace_PID_Reg : out std_logic_vector(0 to 7);
      Trace_New_Reg_Value : out std_logic_vector(0 to 31);
      Trace_Exception_Taken : out std_logic;
      Trace_Exception_Kind : out std_logic_vector(0 to 4);
      Trace_Jump_Taken : out std_logic;
      Trace_Delay_Slot : out std_logic;
      Trace_Data_Address : out std_logic_vector(0 to 31);
      Trace_Data_Access : out std_logic;
      Trace_Data_Read : out std_logic;
      Trace_Data_Write : out std_logic;
      Trace_Data_Write_Value : out std_logic_vector(0 to 31);
      Trace_Data_Byte_Enable : out std_logic_vector(0 to 3);
      Trace_DCache_Req : out std_logic;
      Trace_DCache_Hit : out std_logic;
      Trace_DCache_Rdy : out std_logic;
      Trace_DCache_Read : out std_logic;
      Trace_ICache_Req : out std_logic;
      Trace_ICache_Hit : out std_logic;
      Trace_ICache_Rdy : out std_logic;
      Trace_OF_PipeRun : out std_logic;
      Trace_EX_PipeRun : out std_logic;
      Trace_MEM_PipeRun : out std_logic;
      Trace_MB_Halted : out std_logic;
      Trace_Jump_Hit : out std_logic;
      FSL0_S_CLK : out std_logic;
      FSL0_S_READ : out std_logic;
      FSL0_S_DATA : in std_logic_vector(0 to C_FSL_DATA_SIZE-1);
      FSL0_S_CONTROL : in std_logic;
      FSL0_S_EXISTS : in std_logic;
      FSL0_M_CLK : out std_logic;
      FSL0_M_WRITE : out std_logic;
      FSL0_M_DATA : out std_logic_vector(0 to C_FSL_DATA_SIZE-1);
      FSL0_M_CONTROL : out std_logic;
      FSL0_M_FULL : in std_logic;
      FSL1_S_CLK : out std_logic;
      FSL1_S_READ : out std_logic;
      FSL1_S_DATA : in std_logic_vector(0 to C_FSL_DATA_SIZE-1);
      FSL1_S_CONTROL : in std_logic;
      FSL1_S_EXISTS : in std_logic;
      FSL1_M_CLK : out std_logic;
      FSL1_M_WRITE : out std_logic;
      FSL1_M_DATA : out std_logic_vector(0 to C_FSL_DATA_SIZE-1);
      FSL1_M_CONTROL : out std_logic;
      FSL1_M_FULL : in std_logic;
      FSL2_S_CLK : out std_logic;
      FSL2_S_READ : out std_logic;
      FSL2_S_DATA : in std_logic_vector(0 to C_FSL_DATA_SIZE-1);
      FSL2_S_CONTROL : in std_logic;
      FSL2_S_EXISTS : in std_logic;
      FSL2_M_CLK : out std_logic;
      FSL2_M_WRITE : out std_logic;
      FSL2_M_DATA : out std_logic_vector(0 to C_FSL_DATA_SIZE-1);
      FSL2_M_CONTROL : out std_logic;
      FSL2_M_FULL : in std_logic;
      FSL3_S_CLK : out std_logic;
      FSL3_S_READ : out std_logic;
      FSL3_S_DATA : in std_logic_vector(0 to C_FSL_DATA_SIZE-1);
      FSL3_S_CONTROL : in std_logic;
      FSL3_S_EXISTS : in std_logic;
      FSL3_M_CLK : out std_logic;
      FSL3_M_WRITE : out std_logic;
      FSL3_M_DATA : out std_logic_vector(0 to C_FSL_DATA_SIZE-1);
      FSL3_M_CONTROL : out std_logic;
      FSL3_M_FULL : in std_logic;
      FSL4_S_CLK : out std_logic;
      FSL4_S_READ : out std_logic;
      FSL4_S_DATA : in std_logic_vector(0 to C_FSL_DATA_SIZE-1);
      FSL4_S_CONTROL : in std_logic;
      FSL4_S_EXISTS : in std_logic;
      FSL4_M_CLK : out std_logic;
      FSL4_M_WRITE : out std_logic;
      FSL4_M_DATA : out std_logic_vector(0 to C_FSL_DATA_SIZE-1);
      FSL4_M_CONTROL : out std_logic;
      FSL4_M_FULL : in std_logic;
      FSL5_S_CLK : out std_logic;
      FSL5_S_READ : out std_logic;
      FSL5_S_DATA : in std_logic_vector(0 to C_FSL_DATA_SIZE-1);
      FSL5_S_CONTROL : in std_logic;
      FSL5_S_EXISTS : in std_logic;
      FSL5_M_CLK : out std_logic;
      FSL5_M_WRITE : out std_logic;
      FSL5_M_DATA : out std_logic_vector(0 to C_FSL_DATA_SIZE-1);
      FSL5_M_CONTROL : out std_logic;
      FSL5_M_FULL : in std_logic;
      FSL6_S_CLK : out std_logic;
      FSL6_S_READ : out std_logic;
      FSL6_S_DATA : in std_logic_vector(0 to C_FSL_DATA_SIZE-1);
      FSL6_S_CONTROL : in std_logic;
      FSL6_S_EXISTS : in std_logic;
      FSL6_M_CLK : out std_logic;
      FSL6_M_WRITE : out std_logic;
      FSL6_M_DATA : out std_logic_vector(0 to C_FSL_DATA_SIZE-1);
      FSL6_M_CONTROL : out std_logic;
      FSL6_M_FULL : in std_logic;
      FSL7_S_CLK : out std_logic;
      FSL7_S_READ : out std_logic;
      FSL7_S_DATA : in std_logic_vector(0 to C_FSL_DATA_SIZE-1);
      FSL7_S_CONTROL : in std_logic;
      FSL7_S_EXISTS : in std_logic;
      FSL7_M_CLK : out std_logic;
      FSL7_M_WRITE : out std_logic;
      FSL7_M_DATA : out std_logic_vector(0 to C_FSL_DATA_SIZE-1);
      FSL7_M_CONTROL : out std_logic;
      FSL7_M_FULL : in std_logic;
      FSL8_S_CLK : out std_logic;
      FSL8_S_READ : out std_logic;
      FSL8_S_DATA : in std_logic_vector(0 to C_FSL_DATA_SIZE-1);
      FSL8_S_CONTROL : in std_logic;
      FSL8_S_EXISTS : in std_logic;
      FSL8_M_CLK : out std_logic;
      FSL8_M_WRITE : out std_logic;
      FSL8_M_DATA : out std_logic_vector(0 to C_FSL_DATA_SIZE-1);
      FSL8_M_CONTROL : out std_logic;
      FSL8_M_FULL : in std_logic;
      FSL9_S_CLK : out std_logic;
      FSL9_S_READ : out std_logic;
      FSL9_S_DATA : in std_logic_vector(0 to C_FSL_DATA_SIZE-1);
      FSL9_S_CONTROL : in std_logic;
      FSL9_S_EXISTS : in std_logic;
      FSL9_M_CLK : out std_logic;
      FSL9_M_WRITE : out std_logic;
      FSL9_M_DATA : out std_logic_vector(0 to C_FSL_DATA_SIZE-1);
      FSL9_M_CONTROL : out std_logic;
      FSL9_M_FULL : in std_logic;
      FSL10_S_CLK : out std_logic;
      FSL10_S_READ : out std_logic;
      FSL10_S_DATA : in std_logic_vector(0 to C_FSL_DATA_SIZE-1);
      FSL10_S_CONTROL : in std_logic;
      FSL10_S_EXISTS : in std_logic;
      FSL10_M_CLK : out std_logic;
      FSL10_M_WRITE : out std_logic;
      FSL10_M_DATA : out std_logic_vector(0 to C_FSL_DATA_SIZE-1);
      FSL10_M_CONTROL : out std_logic;
      FSL10_M_FULL : in std_logic;
      FSL11_S_CLK : out std_logic;
      FSL11_S_READ : out std_logic;
      FSL11_S_DATA : in std_logic_vector(0 to C_FSL_DATA_SIZE-1);
      FSL11_S_CONTROL : in std_logic;
      FSL11_S_EXISTS : in std_logic;
      FSL11_M_CLK : out std_logic;
      FSL11_M_WRITE : out std_logic;
      FSL11_M_DATA : out std_logic_vector(0 to C_FSL_DATA_SIZE-1);
      FSL11_M_CONTROL : out std_logic;
      FSL11_M_FULL : in std_logic;
      FSL12_S_CLK : out std_logic;
      FSL12_S_READ : out std_logic;
      FSL12_S_DATA : in std_logic_vector(0 to C_FSL_DATA_SIZE-1);
      FSL12_S_CONTROL : in std_logic;
      FSL12_S_EXISTS : in std_logic;
      FSL12_M_CLK : out std_logic;
      FSL12_M_WRITE : out std_logic;
      FSL12_M_DATA : out std_logic_vector(0 to C_FSL_DATA_SIZE-1);
      FSL12_M_CONTROL : out std_logic;
      FSL12_M_FULL : in std_logic;
      FSL13_S_CLK : out std_logic;
      FSL13_S_READ : out std_logic;
      FSL13_S_DATA : in std_logic_vector(0 to C_FSL_DATA_SIZE-1);
      FSL13_S_CONTROL : in std_logic;
      FSL13_S_EXISTS : in std_logic;
      FSL13_M_CLK : out std_logic;
      FSL13_M_WRITE : out std_logic;
      FSL13_M_DATA : out std_logic_vector(0 to C_FSL_DATA_SIZE-1);
      FSL13_M_CONTROL : out std_logic;
      FSL13_M_FULL : in std_logic;
      FSL14_S_CLK : out std_logic;
      FSL14_S_READ : out std_logic;
      FSL14_S_DATA : in std_logic_vector(0 to C_FSL_DATA_SIZE-1);
      FSL14_S_CONTROL : in std_logic;
      FSL14_S_EXISTS : in std_logic;
      FSL14_M_CLK : out std_logic;
      FSL14_M_WRITE : out std_logic;
      FSL14_M_DATA : out std_logic_vector(0 to C_FSL_DATA_SIZE-1);
      FSL14_M_CONTROL : out std_logic;
      FSL14_M_FULL : in std_logic;
      FSL15_S_CLK : out std_logic;
      FSL15_S_READ : out std_logic;
      FSL15_S_DATA : in std_logic_vector(0 to C_FSL_DATA_SIZE-1);
      FSL15_S_CONTROL : in std_logic;
      FSL15_S_EXISTS : in std_logic;
      FSL15_M_CLK : out std_logic;
      FSL15_M_WRITE : out std_logic;
      FSL15_M_DATA : out std_logic_vector(0 to C_FSL_DATA_SIZE-1);
      FSL15_M_CONTROL : out std_logic;
      FSL15_M_FULL : in std_logic;
      M0_AXIS_TLAST : out std_logic;
      M0_AXIS_TDATA : out std_logic_vector(C_M0_AXIS_DATA_WIDTH-1 downto 0);
      M0_AXIS_TVALID : out std_logic;
      M0_AXIS_TREADY : in std_logic;
      S0_AXIS_TLAST : in std_logic;
      S0_AXIS_TDATA : in std_logic_vector(C_S0_AXIS_DATA_WIDTH-1 downto 0);
      S0_AXIS_TVALID : in std_logic;
      S0_AXIS_TREADY : out std_logic;
      M1_AXIS_TLAST : out std_logic;
      M1_AXIS_TDATA : out std_logic_vector(C_M1_AXIS_DATA_WIDTH-1 downto 0);
      M1_AXIS_TVALID : out std_logic;
      M1_AXIS_TREADY : in std_logic;
      S1_AXIS_TLAST : in std_logic;
      S1_AXIS_TDATA : in std_logic_vector(C_S1_AXIS_DATA_WIDTH-1 downto 0);
      S1_AXIS_TVALID : in std_logic;
      S1_AXIS_TREADY : out std_logic;
      M2_AXIS_TLAST : out std_logic;
      M2_AXIS_TDATA : out std_logic_vector(C_M2_AXIS_DATA_WIDTH-1 downto 0);
      M2_AXIS_TVALID : out std_logic;
      M2_AXIS_TREADY : in std_logic;
      S2_AXIS_TLAST : in std_logic;
      S2_AXIS_TDATA : in std_logic_vector(C_S2_AXIS_DATA_WIDTH-1 downto 0);
      S2_AXIS_TVALID : in std_logic;
      S2_AXIS_TREADY : out std_logic;
      M3_AXIS_TLAST : out std_logic;
      M3_AXIS_TDATA : out std_logic_vector(C_M3_AXIS_DATA_WIDTH-1 downto 0);
      M3_AXIS_TVALID : out std_logic;
      M3_AXIS_TREADY : in std_logic;
      S3_AXIS_TLAST : in std_logic;
      S3_AXIS_TDATA : in std_logic_vector(C_S3_AXIS_DATA_WIDTH-1 downto 0);
      S3_AXIS_TVALID : in std_logic;
      S3_AXIS_TREADY : out std_logic;
      M4_AXIS_TLAST : out std_logic;
      M4_AXIS_TDATA : out std_logic_vector(C_M4_AXIS_DATA_WIDTH-1 downto 0);
      M4_AXIS_TVALID : out std_logic;
      M4_AXIS_TREADY : in std_logic;
      S4_AXIS_TLAST : in std_logic;
      S4_AXIS_TDATA : in std_logic_vector(C_S4_AXIS_DATA_WIDTH-1 downto 0);
      S4_AXIS_TVALID : in std_logic;
      S4_AXIS_TREADY : out std_logic;
      M5_AXIS_TLAST : out std_logic;
      M5_AXIS_TDATA : out std_logic_vector(C_M5_AXIS_DATA_WIDTH-1 downto 0);
      M5_AXIS_TVALID : out std_logic;
      M5_AXIS_TREADY : in std_logic;
      S5_AXIS_TLAST : in std_logic;
      S5_AXIS_TDATA : in std_logic_vector(C_S5_AXIS_DATA_WIDTH-1 downto 0);
      S5_AXIS_TVALID : in std_logic;
      S5_AXIS_TREADY : out std_logic;
      M6_AXIS_TLAST : out std_logic;
      M6_AXIS_TDATA : out std_logic_vector(C_M6_AXIS_DATA_WIDTH-1 downto 0);
      M6_AXIS_TVALID : out std_logic;
      M6_AXIS_TREADY : in std_logic;
      S6_AXIS_TLAST : in std_logic;
      S6_AXIS_TDATA : in std_logic_vector(C_S6_AXIS_DATA_WIDTH-1 downto 0);
      S6_AXIS_TVALID : in std_logic;
      S6_AXIS_TREADY : out std_logic;
      M7_AXIS_TLAST : out std_logic;
      M7_AXIS_TDATA : out std_logic_vector(C_M7_AXIS_DATA_WIDTH-1 downto 0);
      M7_AXIS_TVALID : out std_logic;
      M7_AXIS_TREADY : in std_logic;
      S7_AXIS_TLAST : in std_logic;
      S7_AXIS_TDATA : in std_logic_vector(C_S7_AXIS_DATA_WIDTH-1 downto 0);
      S7_AXIS_TVALID : in std_logic;
      S7_AXIS_TREADY : out std_logic;
      M8_AXIS_TLAST : out std_logic;
      M8_AXIS_TDATA : out std_logic_vector(C_M8_AXIS_DATA_WIDTH-1 downto 0);
      M8_AXIS_TVALID : out std_logic;
      M8_AXIS_TREADY : in std_logic;
      S8_AXIS_TLAST : in std_logic;
      S8_AXIS_TDATA : in std_logic_vector(C_S8_AXIS_DATA_WIDTH-1 downto 0);
      S8_AXIS_TVALID : in std_logic;
      S8_AXIS_TREADY : out std_logic;
      M9_AXIS_TLAST : out std_logic;
      M9_AXIS_TDATA : out std_logic_vector(C_M9_AXIS_DATA_WIDTH-1 downto 0);
      M9_AXIS_TVALID : out std_logic;
      M9_AXIS_TREADY : in std_logic;
      S9_AXIS_TLAST : in std_logic;
      S9_AXIS_TDATA : in std_logic_vector(C_S9_AXIS_DATA_WIDTH-1 downto 0);
      S9_AXIS_TVALID : in std_logic;
      S9_AXIS_TREADY : out std_logic;
      M10_AXIS_TLAST : out std_logic;
      M10_AXIS_TDATA : out std_logic_vector(C_M10_AXIS_DATA_WIDTH-1 downto 0);
      M10_AXIS_TVALID : out std_logic;
      M10_AXIS_TREADY : in std_logic;
      S10_AXIS_TLAST : in std_logic;
      S10_AXIS_TDATA : in std_logic_vector(C_S10_AXIS_DATA_WIDTH-1 downto 0);
      S10_AXIS_TVALID : in std_logic;
      S10_AXIS_TREADY : out std_logic;
      M11_AXIS_TLAST : out std_logic;
      M11_AXIS_TDATA : out std_logic_vector(C_M11_AXIS_DATA_WIDTH-1 downto 0);
      M11_AXIS_TVALID : out std_logic;
      M11_AXIS_TREADY : in std_logic;
      S11_AXIS_TLAST : in std_logic;
      S11_AXIS_TDATA : in std_logic_vector(C_S11_AXIS_DATA_WIDTH-1 downto 0);
      S11_AXIS_TVALID : in std_logic;
      S11_AXIS_TREADY : out std_logic;
      M12_AXIS_TLAST : out std_logic;
      M12_AXIS_TDATA : out std_logic_vector(C_M12_AXIS_DATA_WIDTH-1 downto 0);
      M12_AXIS_TVALID : out std_logic;
      M12_AXIS_TREADY : in std_logic;
      S12_AXIS_TLAST : in std_logic;
      S12_AXIS_TDATA : in std_logic_vector(C_S12_AXIS_DATA_WIDTH-1 downto 0);
      S12_AXIS_TVALID : in std_logic;
      S12_AXIS_TREADY : out std_logic;
      M13_AXIS_TLAST : out std_logic;
      M13_AXIS_TDATA : out std_logic_vector(C_M13_AXIS_DATA_WIDTH-1 downto 0);
      M13_AXIS_TVALID : out std_logic;
      M13_AXIS_TREADY : in std_logic;
      S13_AXIS_TLAST : in std_logic;
      S13_AXIS_TDATA : in std_logic_vector(C_S13_AXIS_DATA_WIDTH-1 downto 0);
      S13_AXIS_TVALID : in std_logic;
      S13_AXIS_TREADY : out std_logic;
      M14_AXIS_TLAST : out std_logic;
      M14_AXIS_TDATA : out std_logic_vector(C_M14_AXIS_DATA_WIDTH-1 downto 0);
      M14_AXIS_TVALID : out std_logic;
      M14_AXIS_TREADY : in std_logic;
      S14_AXIS_TLAST : in std_logic;
      S14_AXIS_TDATA : in std_logic_vector(C_S14_AXIS_DATA_WIDTH-1 downto 0);
      S14_AXIS_TVALID : in std_logic;
      S14_AXIS_TREADY : out std_logic;
      M15_AXIS_TLAST : out std_logic;
      M15_AXIS_TDATA : out std_logic_vector(C_M15_AXIS_DATA_WIDTH-1 downto 0);
      M15_AXIS_TVALID : out std_logic;
      M15_AXIS_TREADY : in std_logic;
      S15_AXIS_TLAST : in std_logic;
      S15_AXIS_TDATA : in std_logic_vector(C_S15_AXIS_DATA_WIDTH-1 downto 0);
      S15_AXIS_TVALID : in std_logic;
      S15_AXIS_TREADY : out std_logic;
      ICACHE_FSL_IN_CLK : out std_logic;
      ICACHE_FSL_IN_READ : out std_logic;
      ICACHE_FSL_IN_DATA : in std_logic_vector(0 to 31);
      ICACHE_FSL_IN_CONTROL : in std_logic;
      ICACHE_FSL_IN_EXISTS : in std_logic;
      ICACHE_FSL_OUT_CLK : out std_logic;
      ICACHE_FSL_OUT_WRITE : out std_logic;
      ICACHE_FSL_OUT_DATA : out std_logic_vector(0 to 31);
      ICACHE_FSL_OUT_CONTROL : out std_logic;
      ICACHE_FSL_OUT_FULL : in std_logic;
      DCACHE_FSL_IN_CLK : out std_logic;
      DCACHE_FSL_IN_READ : out std_logic;
      DCACHE_FSL_IN_DATA : in std_logic_vector(0 to 31);
      DCACHE_FSL_IN_CONTROL : in std_logic;
      DCACHE_FSL_IN_EXISTS : in std_logic;
      DCACHE_FSL_OUT_CLK : out std_logic;
      DCACHE_FSL_OUT_WRITE : out std_logic;
      DCACHE_FSL_OUT_DATA : out std_logic_vector(0 to 31);
      DCACHE_FSL_OUT_CONTROL : out std_logic;
      DCACHE_FSL_OUT_FULL : in std_logic
    );
  end component;

begin

  microblaze_0 : microblaze
    generic map (
      C_SCO => 0,
      C_FREQ => 100000000,
      C_DATA_SIZE => 32,
      C_DYNAMIC_BUS_SIZING => 1,
      C_FAMILY => "spartan6",
      C_INSTANCE => "microblaze_0",
      C_AVOID_PRIMITIVES => 0,
      C_FAULT_TOLERANT => 0,
      C_ECC_USE_CE_EXCEPTION => 0,
      C_LOCKSTEP_SLAVE => 0,
      C_ENDIANNESS => 1,
      C_AREA_OPTIMIZED => 0,
      C_OPTIMIZATION => 0,
      C_INTERCONNECT => 2,
      C_STREAM_INTERCONNECT => 0,
      C_BASE_VECTORS => X"00000000",
      C_DPLB_DWIDTH => 32,
      C_DPLB_NATIVE_DWIDTH => 32,
      C_DPLB_BURST_EN => 0,
      C_DPLB_P2P => 0,
      C_IPLB_DWIDTH => 32,
      C_IPLB_NATIVE_DWIDTH => 32,
      C_IPLB_BURST_EN => 0,
      C_IPLB_P2P => 0,
      C_M_AXI_DP_THREAD_ID_WIDTH => 1,
      C_M_AXI_DP_DATA_WIDTH => 32,
      C_M_AXI_DP_ADDR_WIDTH => 32,
      C_M_AXI_DP_EXCLUSIVE_ACCESS => 0,
      C_M_AXI_IP_THREAD_ID_WIDTH => 1,
      C_M_AXI_IP_DATA_WIDTH => 32,
      C_M_AXI_IP_ADDR_WIDTH => 32,
      C_D_AXI => 1,
      C_D_PLB => 0,
      C_D_LMB => 1,
      C_I_AXI => 0,
      C_I_PLB => 0,
      C_I_LMB => 1,
      C_USE_MSR_INSTR => 1,
      C_USE_PCMP_INSTR => 1,
      C_USE_BARREL => 1,
      C_USE_DIV => 0,
      C_USE_HW_MUL => 1,
      C_USE_FPU => 0,
      C_USE_REORDER_INSTR => 1,
      C_UNALIGNED_EXCEPTIONS => 0,
      C_ILL_OPCODE_EXCEPTION => 0,
      C_M_AXI_I_BUS_EXCEPTION => 0,
      C_M_AXI_D_BUS_EXCEPTION => 0,
      C_IPLB_BUS_EXCEPTION => 0,
      C_DPLB_BUS_EXCEPTION => 0,
      C_DIV_ZERO_EXCEPTION => 0,
      C_FPU_EXCEPTION => 0,
      C_FSL_EXCEPTION => 0,
      C_USE_STACK_PROTECTION => 0,
      C_PVR => 0,
      C_PVR_USER1 => X"00",
      C_PVR_USER2 => X"00000000",
      C_DEBUG_ENABLED => 1,
      C_NUMBER_OF_PC_BRK => 1,
      C_NUMBER_OF_RD_ADDR_BRK => 0,
      C_NUMBER_OF_WR_ADDR_BRK => 0,
      C_INTERRUPT_IS_EDGE => 0,
      C_EDGE_IS_POSITIVE => 1,
      C_RESET_MSR => X"00000000",
      C_OPCODE_0x0_ILLEGAL => 0,
      C_FSL_LINKS => 0,
      C_FSL_DATA_SIZE => 32,
      C_USE_EXTENDED_FSL_INSTR => 0,
      C_M0_AXIS_DATA_WIDTH => 32,
      C_S0_AXIS_DATA_WIDTH => 32,
      C_M1_AXIS_DATA_WIDTH => 32,
      C_S1_AXIS_DATA_WIDTH => 32,
      C_M2_AXIS_DATA_WIDTH => 32,
      C_S2_AXIS_DATA_WIDTH => 32,
      C_M3_AXIS_DATA_WIDTH => 32,
      C_S3_AXIS_DATA_WIDTH => 32,
      C_M4_AXIS_DATA_WIDTH => 32,
      C_S4_AXIS_DATA_WIDTH => 32,
      C_M5_AXIS_DATA_WIDTH => 32,
      C_S5_AXIS_DATA_WIDTH => 32,
      C_M6_AXIS_DATA_WIDTH => 32,
      C_S6_AXIS_DATA_WIDTH => 32,
      C_M7_AXIS_DATA_WIDTH => 32,
      C_S7_AXIS_DATA_WIDTH => 32,
      C_M8_AXIS_DATA_WIDTH => 32,
      C_S8_AXIS_DATA_WIDTH => 32,
      C_M9_AXIS_DATA_WIDTH => 32,
      C_S9_AXIS_DATA_WIDTH => 32,
      C_M10_AXIS_DATA_WIDTH => 32,
      C_S10_AXIS_DATA_WIDTH => 32,
      C_M11_AXIS_DATA_WIDTH => 32,
      C_S11_AXIS_DATA_WIDTH => 32,
      C_M12_AXIS_DATA_WIDTH => 32,
      C_S12_AXIS_DATA_WIDTH => 32,
      C_M13_AXIS_DATA_WIDTH => 32,
      C_S13_AXIS_DATA_WIDTH => 32,
      C_M14_AXIS_DATA_WIDTH => 32,
      C_S14_AXIS_DATA_WIDTH => 32,
      C_M15_AXIS_DATA_WIDTH => 32,
      C_S15_AXIS_DATA_WIDTH => 32,
      C_ICACHE_BASEADDR => X"00000000",
      C_ICACHE_HIGHADDR => X"3FFFFFFF",
      C_USE_ICACHE => 0,
      C_ALLOW_ICACHE_WR => 1,
      C_ADDR_TAG_BITS => 0,
      C_CACHE_BYTE_SIZE => 8192,
      C_ICACHE_USE_FSL => 0,
      C_ICACHE_LINE_LEN => 4,
      C_ICACHE_ALWAYS_USED => 0,
      C_ICACHE_INTERFACE => 0,
      C_ICACHE_VICTIMS => 0,
      C_ICACHE_STREAMS => 0,
      C_ICACHE_FORCE_TAG_LUTRAM => 0,
      C_ICACHE_DATA_WIDTH => 0,
      C_M_AXI_IC_THREAD_ID_WIDTH => 1,
      C_M_AXI_IC_DATA_WIDTH => 32,
      C_M_AXI_IC_ADDR_WIDTH => 32,
      C_M_AXI_IC_USER_VALUE => 2#11111#,
      C_M_AXI_IC_AWUSER_WIDTH => 5,
      C_M_AXI_IC_ARUSER_WIDTH => 5,
      C_M_AXI_IC_WUSER_WIDTH => 1,
      C_M_AXI_IC_RUSER_WIDTH => 1,
      C_M_AXI_IC_BUSER_WIDTH => 1,
      C_DCACHE_BASEADDR => X"00000000",
      C_DCACHE_HIGHADDR => X"3FFFFFFF",
      C_USE_DCACHE => 0,
      C_ALLOW_DCACHE_WR => 1,
      C_DCACHE_ADDR_TAG => 0,
      C_DCACHE_BYTE_SIZE => 8192,
      C_DCACHE_USE_FSL => 0,
      C_DCACHE_LINE_LEN => 4,
      C_DCACHE_ALWAYS_USED => 0,
      C_DCACHE_INTERFACE => 0,
      C_DCACHE_USE_WRITEBACK => 0,
      C_DCACHE_VICTIMS => 0,
      C_DCACHE_FORCE_TAG_LUTRAM => 0,
      C_DCACHE_DATA_WIDTH => 0,
      C_M_AXI_DC_THREAD_ID_WIDTH => 1,
      C_M_AXI_DC_DATA_WIDTH => 32,
      C_M_AXI_DC_ADDR_WIDTH => 32,
      C_M_AXI_DC_EXCLUSIVE_ACCESS => 0,
      C_M_AXI_DC_USER_VALUE => 2#11111#,
      C_M_AXI_DC_AWUSER_WIDTH => 5,
      C_M_AXI_DC_ARUSER_WIDTH => 5,
      C_M_AXI_DC_WUSER_WIDTH => 1,
      C_M_AXI_DC_RUSER_WIDTH => 1,
      C_M_AXI_DC_BUSER_WIDTH => 1,
      C_USE_MMU => 0,
      C_MMU_DTLB_SIZE => 4,
      C_MMU_ITLB_SIZE => 2,
      C_MMU_TLB_ACCESS => 3,
      C_MMU_ZONES => 16,
      C_MMU_PRIVILEGED_INSTR => 0,
      C_USE_INTERRUPT => 1,
      C_USE_EXT_BRK => 1,
      C_USE_EXT_NM_BRK => 1,
      C_USE_BRANCH_TARGET_CACHE => 0,
      C_BRANCH_TARGET_CACHE_SIZE => 0,
      C_PC_WIDTH => 32
    )
    port map (
      CLK => CLK,
      RESET => RESET,
      MB_RESET => MB_RESET,
      INTERRUPT => INTERRUPT,
      INTERRUPT_ADDRESS => INTERRUPT_ADDRESS,
      INTERRUPT_ACK => INTERRUPT_ACK,
      EXT_BRK => EXT_BRK,
      EXT_NM_BRK => EXT_NM_BRK,
      DBG_STOP => DBG_STOP,
      MB_Halted => MB_Halted,
      MB_Error => MB_Error,
      WAKEUP => WAKEUP,
      SLEEP => SLEEP,
      DBG_WAKEUP => DBG_WAKEUP,
      LOCKSTEP_MASTER_OUT => LOCKSTEP_MASTER_OUT,
      LOCKSTEP_SLAVE_IN => LOCKSTEP_SLAVE_IN,
      LOCKSTEP_OUT => LOCKSTEP_OUT,
      INSTR => INSTR,
      IREADY => IREADY,
      IWAIT => IWAIT,
      ICE => ICE,
      IUE => IUE,
      INSTR_ADDR => INSTR_ADDR,
      IFETCH => IFETCH,
      I_AS => I_AS,
      IPLB_M_ABort => IPLB_M_ABort,
      IPLB_M_ABus => IPLB_M_ABus,
      IPLB_M_UABus => IPLB_M_UABus,
      IPLB_M_BE => IPLB_M_BE,
      IPLB_M_busLock => IPLB_M_busLock,
      IPLB_M_lockErr => IPLB_M_lockErr,
      IPLB_M_MSize => IPLB_M_MSize,
      IPLB_M_priority => IPLB_M_priority,
      IPLB_M_rdBurst => IPLB_M_rdBurst,
      IPLB_M_request => IPLB_M_request,
      IPLB_M_RNW => IPLB_M_RNW,
      IPLB_M_size => IPLB_M_size,
      IPLB_M_TAttribute => IPLB_M_TAttribute,
      IPLB_M_type => IPLB_M_type,
      IPLB_M_wrBurst => IPLB_M_wrBurst,
      IPLB_M_wrDBus => IPLB_M_wrDBus,
      IPLB_MBusy => IPLB_MBusy,
      IPLB_MRdErr => IPLB_MRdErr,
      IPLB_MWrErr => IPLB_MWrErr,
      IPLB_MIRQ => IPLB_MIRQ,
      IPLB_MWrBTerm => IPLB_MWrBTerm,
      IPLB_MWrDAck => IPLB_MWrDAck,
      IPLB_MAddrAck => IPLB_MAddrAck,
      IPLB_MRdBTerm => IPLB_MRdBTerm,
      IPLB_MRdDAck => IPLB_MRdDAck,
      IPLB_MRdDBus => IPLB_MRdDBus,
      IPLB_MRdWdAddr => IPLB_MRdWdAddr,
      IPLB_MRearbitrate => IPLB_MRearbitrate,
      IPLB_MSSize => IPLB_MSSize,
      IPLB_MTimeout => IPLB_MTimeout,
      DATA_READ => DATA_READ,
      DREADY => DREADY,
      DWAIT => DWAIT,
      DCE => DCE,
      DUE => DUE,
      DATA_WRITE => DATA_WRITE,
      DATA_ADDR => DATA_ADDR,
      D_AS => D_AS,
      READ_STROBE => READ_STROBE,
      WRITE_STROBE => WRITE_STROBE,
      BYTE_ENABLE => BYTE_ENABLE,
      DPLB_M_ABort => DPLB_M_ABort,
      DPLB_M_ABus => DPLB_M_ABus,
      DPLB_M_UABus => DPLB_M_UABus,
      DPLB_M_BE => DPLB_M_BE,
      DPLB_M_busLock => DPLB_M_busLock,
      DPLB_M_lockErr => DPLB_M_lockErr,
      DPLB_M_MSize => DPLB_M_MSize,
      DPLB_M_priority => DPLB_M_priority,
      DPLB_M_rdBurst => DPLB_M_rdBurst,
      DPLB_M_request => DPLB_M_request,
      DPLB_M_RNW => DPLB_M_RNW,
      DPLB_M_size => DPLB_M_size,
      DPLB_M_TAttribute => DPLB_M_TAttribute,
      DPLB_M_type => DPLB_M_type,
      DPLB_M_wrBurst => DPLB_M_wrBurst,
      DPLB_M_wrDBus => DPLB_M_wrDBus,
      DPLB_MBusy => DPLB_MBusy,
      DPLB_MRdErr => DPLB_MRdErr,
      DPLB_MWrErr => DPLB_MWrErr,
      DPLB_MIRQ => DPLB_MIRQ,
      DPLB_MWrBTerm => DPLB_MWrBTerm,
      DPLB_MWrDAck => DPLB_MWrDAck,
      DPLB_MAddrAck => DPLB_MAddrAck,
      DPLB_MRdBTerm => DPLB_MRdBTerm,
      DPLB_MRdDAck => DPLB_MRdDAck,
      DPLB_MRdDBus => DPLB_MRdDBus,
      DPLB_MRdWdAddr => DPLB_MRdWdAddr,
      DPLB_MRearbitrate => DPLB_MRearbitrate,
      DPLB_MSSize => DPLB_MSSize,
      DPLB_MTimeout => DPLB_MTimeout,
      M_AXI_IP_AWID => M_AXI_IP_AWID,
      M_AXI_IP_AWADDR => M_AXI_IP_AWADDR,
      M_AXI_IP_AWLEN => M_AXI_IP_AWLEN,
      M_AXI_IP_AWSIZE => M_AXI_IP_AWSIZE,
      M_AXI_IP_AWBURST => M_AXI_IP_AWBURST,
      M_AXI_IP_AWLOCK => M_AXI_IP_AWLOCK,
      M_AXI_IP_AWCACHE => M_AXI_IP_AWCACHE,
      M_AXI_IP_AWPROT => M_AXI_IP_AWPROT,
      M_AXI_IP_AWQOS => M_AXI_IP_AWQOS,
      M_AXI_IP_AWVALID => M_AXI_IP_AWVALID,
      M_AXI_IP_AWREADY => M_AXI_IP_AWREADY,
      M_AXI_IP_WDATA => M_AXI_IP_WDATA,
      M_AXI_IP_WSTRB => M_AXI_IP_WSTRB,
      M_AXI_IP_WLAST => M_AXI_IP_WLAST,
      M_AXI_IP_WVALID => M_AXI_IP_WVALID,
      M_AXI_IP_WREADY => M_AXI_IP_WREADY,
      M_AXI_IP_BID => M_AXI_IP_BID,
      M_AXI_IP_BRESP => M_AXI_IP_BRESP,
      M_AXI_IP_BVALID => M_AXI_IP_BVALID,
      M_AXI_IP_BREADY => M_AXI_IP_BREADY,
      M_AXI_IP_ARID => M_AXI_IP_ARID,
      M_AXI_IP_ARADDR => M_AXI_IP_ARADDR,
      M_AXI_IP_ARLEN => M_AXI_IP_ARLEN,
      M_AXI_IP_ARSIZE => M_AXI_IP_ARSIZE,
      M_AXI_IP_ARBURST => M_AXI_IP_ARBURST,
      M_AXI_IP_ARLOCK => M_AXI_IP_ARLOCK,
      M_AXI_IP_ARCACHE => M_AXI_IP_ARCACHE,
      M_AXI_IP_ARPROT => M_AXI_IP_ARPROT,
      M_AXI_IP_ARQOS => M_AXI_IP_ARQOS,
      M_AXI_IP_ARVALID => M_AXI_IP_ARVALID,
      M_AXI_IP_ARREADY => M_AXI_IP_ARREADY,
      M_AXI_IP_RID => M_AXI_IP_RID,
      M_AXI_IP_RDATA => M_AXI_IP_RDATA,
      M_AXI_IP_RRESP => M_AXI_IP_RRESP,
      M_AXI_IP_RLAST => M_AXI_IP_RLAST,
      M_AXI_IP_RVALID => M_AXI_IP_RVALID,
      M_AXI_IP_RREADY => M_AXI_IP_RREADY,
      M_AXI_DP_AWID => M_AXI_DP_AWID,
      M_AXI_DP_AWADDR => M_AXI_DP_AWADDR,
      M_AXI_DP_AWLEN => M_AXI_DP_AWLEN,
      M_AXI_DP_AWSIZE => M_AXI_DP_AWSIZE,
      M_AXI_DP_AWBURST => M_AXI_DP_AWBURST,
      M_AXI_DP_AWLOCK => M_AXI_DP_AWLOCK,
      M_AXI_DP_AWCACHE => M_AXI_DP_AWCACHE,
      M_AXI_DP_AWPROT => M_AXI_DP_AWPROT,
      M_AXI_DP_AWQOS => M_AXI_DP_AWQOS,
      M_AXI_DP_AWVALID => M_AXI_DP_AWVALID,
      M_AXI_DP_AWREADY => M_AXI_DP_AWREADY,
      M_AXI_DP_WDATA => M_AXI_DP_WDATA,
      M_AXI_DP_WSTRB => M_AXI_DP_WSTRB,
      M_AXI_DP_WLAST => M_AXI_DP_WLAST,
      M_AXI_DP_WVALID => M_AXI_DP_WVALID,
      M_AXI_DP_WREADY => M_AXI_DP_WREADY,
      M_AXI_DP_BID => M_AXI_DP_BID,
      M_AXI_DP_BRESP => M_AXI_DP_BRESP,
      M_AXI_DP_BVALID => M_AXI_DP_BVALID,
      M_AXI_DP_BREADY => M_AXI_DP_BREADY,
      M_AXI_DP_ARID => M_AXI_DP_ARID,
      M_AXI_DP_ARADDR => M_AXI_DP_ARADDR,
      M_AXI_DP_ARLEN => M_AXI_DP_ARLEN,
      M_AXI_DP_ARSIZE => M_AXI_DP_ARSIZE,
      M_AXI_DP_ARBURST => M_AXI_DP_ARBURST,
      M_AXI_DP_ARLOCK => M_AXI_DP_ARLOCK,
      M_AXI_DP_ARCACHE => M_AXI_DP_ARCACHE,
      M_AXI_DP_ARPROT => M_AXI_DP_ARPROT,
      M_AXI_DP_ARQOS => M_AXI_DP_ARQOS,
      M_AXI_DP_ARVALID => M_AXI_DP_ARVALID,
      M_AXI_DP_ARREADY => M_AXI_DP_ARREADY,
      M_AXI_DP_RID => M_AXI_DP_RID,
      M_AXI_DP_RDATA => M_AXI_DP_RDATA,
      M_AXI_DP_RRESP => M_AXI_DP_RRESP,
      M_AXI_DP_RLAST => M_AXI_DP_RLAST,
      M_AXI_DP_RVALID => M_AXI_DP_RVALID,
      M_AXI_DP_RREADY => M_AXI_DP_RREADY,
      M_AXI_IC_AWID => M_AXI_IC_AWID,
      M_AXI_IC_AWADDR => M_AXI_IC_AWADDR,
      M_AXI_IC_AWLEN => M_AXI_IC_AWLEN,
      M_AXI_IC_AWSIZE => M_AXI_IC_AWSIZE,
      M_AXI_IC_AWBURST => M_AXI_IC_AWBURST,
      M_AXI_IC_AWLOCK => M_AXI_IC_AWLOCK,
      M_AXI_IC_AWCACHE => M_AXI_IC_AWCACHE,
      M_AXI_IC_AWPROT => M_AXI_IC_AWPROT,
      M_AXI_IC_AWQOS => M_AXI_IC_AWQOS,
      M_AXI_IC_AWVALID => M_AXI_IC_AWVALID,
      M_AXI_IC_AWREADY => M_AXI_IC_AWREADY,
      M_AXI_IC_AWUSER => M_AXI_IC_AWUSER,
      M_AXI_IC_AWDOMAIN => M_AXI_IC_AWDOMAIN,
      M_AXI_IC_AWSNOOP => M_AXI_IC_AWSNOOP,
      M_AXI_IC_AWBAR => M_AXI_IC_AWBAR,
      M_AXI_IC_WDATA => M_AXI_IC_WDATA,
      M_AXI_IC_WSTRB => M_AXI_IC_WSTRB,
      M_AXI_IC_WLAST => M_AXI_IC_WLAST,
      M_AXI_IC_WVALID => M_AXI_IC_WVALID,
      M_AXI_IC_WREADY => M_AXI_IC_WREADY,
      M_AXI_IC_WUSER => M_AXI_IC_WUSER,
      M_AXI_IC_BID => M_AXI_IC_BID,
      M_AXI_IC_BRESP => M_AXI_IC_BRESP,
      M_AXI_IC_BVALID => M_AXI_IC_BVALID,
      M_AXI_IC_BREADY => M_AXI_IC_BREADY,
      M_AXI_IC_BUSER => M_AXI_IC_BUSER,
      M_AXI_IC_WACK => M_AXI_IC_WACK,
      M_AXI_IC_ARID => M_AXI_IC_ARID,
      M_AXI_IC_ARADDR => M_AXI_IC_ARADDR,
      M_AXI_IC_ARLEN => M_AXI_IC_ARLEN,
      M_AXI_IC_ARSIZE => M_AXI_IC_ARSIZE,
      M_AXI_IC_ARBURST => M_AXI_IC_ARBURST,
      M_AXI_IC_ARLOCK => M_AXI_IC_ARLOCK,
      M_AXI_IC_ARCACHE => M_AXI_IC_ARCACHE,
      M_AXI_IC_ARPROT => M_AXI_IC_ARPROT,
      M_AXI_IC_ARQOS => M_AXI_IC_ARQOS,
      M_AXI_IC_ARVALID => M_AXI_IC_ARVALID,
      M_AXI_IC_ARREADY => M_AXI_IC_ARREADY,
      M_AXI_IC_ARUSER => M_AXI_IC_ARUSER,
      M_AXI_IC_ARDOMAIN => M_AXI_IC_ARDOMAIN,
      M_AXI_IC_ARSNOOP => M_AXI_IC_ARSNOOP,
      M_AXI_IC_ARBAR => M_AXI_IC_ARBAR,
      M_AXI_IC_RID => M_AXI_IC_RID,
      M_AXI_IC_RDATA => M_AXI_IC_RDATA,
      M_AXI_IC_RRESP => M_AXI_IC_RRESP,
      M_AXI_IC_RLAST => M_AXI_IC_RLAST,
      M_AXI_IC_RVALID => M_AXI_IC_RVALID,
      M_AXI_IC_RREADY => M_AXI_IC_RREADY,
      M_AXI_IC_RUSER => M_AXI_IC_RUSER,
      M_AXI_IC_RACK => M_AXI_IC_RACK,
      M_AXI_IC_ACVALID => M_AXI_IC_ACVALID,
      M_AXI_IC_ACADDR => M_AXI_IC_ACADDR,
      M_AXI_IC_ACSNOOP => M_AXI_IC_ACSNOOP,
      M_AXI_IC_ACPROT => M_AXI_IC_ACPROT,
      M_AXI_IC_ACREADY => M_AXI_IC_ACREADY,
      M_AXI_IC_CRREADY => M_AXI_IC_CRREADY,
      M_AXI_IC_CRVALID => M_AXI_IC_CRVALID,
      M_AXI_IC_CRRESP => M_AXI_IC_CRRESP,
      M_AXI_IC_CDVALID => M_AXI_IC_CDVALID,
      M_AXI_IC_CDREADY => M_AXI_IC_CDREADY,
      M_AXI_IC_CDDATA => M_AXI_IC_CDDATA,
      M_AXI_IC_CDLAST => M_AXI_IC_CDLAST,
      M_AXI_DC_AWID => M_AXI_DC_AWID,
      M_AXI_DC_AWADDR => M_AXI_DC_AWADDR,
      M_AXI_DC_AWLEN => M_AXI_DC_AWLEN,
      M_AXI_DC_AWSIZE => M_AXI_DC_AWSIZE,
      M_AXI_DC_AWBURST => M_AXI_DC_AWBURST,
      M_AXI_DC_AWLOCK => M_AXI_DC_AWLOCK,
      M_AXI_DC_AWCACHE => M_AXI_DC_AWCACHE,
      M_AXI_DC_AWPROT => M_AXI_DC_AWPROT,
      M_AXI_DC_AWQOS => M_AXI_DC_AWQOS,
      M_AXI_DC_AWVALID => M_AXI_DC_AWVALID,
      M_AXI_DC_AWREADY => M_AXI_DC_AWREADY,
      M_AXI_DC_AWUSER => M_AXI_DC_AWUSER,
      M_AXI_DC_AWDOMAIN => M_AXI_DC_AWDOMAIN,
      M_AXI_DC_AWSNOOP => M_AXI_DC_AWSNOOP,
      M_AXI_DC_AWBAR => M_AXI_DC_AWBAR,
      M_AXI_DC_WDATA => M_AXI_DC_WDATA,
      M_AXI_DC_WSTRB => M_AXI_DC_WSTRB,
      M_AXI_DC_WLAST => M_AXI_DC_WLAST,
      M_AXI_DC_WVALID => M_AXI_DC_WVALID,
      M_AXI_DC_WREADY => M_AXI_DC_WREADY,
      M_AXI_DC_WUSER => M_AXI_DC_WUSER,
      M_AXI_DC_BID => M_AXI_DC_BID,
      M_AXI_DC_BRESP => M_AXI_DC_BRESP,
      M_AXI_DC_BVALID => M_AXI_DC_BVALID,
      M_AXI_DC_BREADY => M_AXI_DC_BREADY,
      M_AXI_DC_BUSER => M_AXI_DC_BUSER,
      M_AXI_DC_WACK => M_AXI_DC_WACK,
      M_AXI_DC_ARID => M_AXI_DC_ARID,
      M_AXI_DC_ARADDR => M_AXI_DC_ARADDR,
      M_AXI_DC_ARLEN => M_AXI_DC_ARLEN,
      M_AXI_DC_ARSIZE => M_AXI_DC_ARSIZE,
      M_AXI_DC_ARBURST => M_AXI_DC_ARBURST,
      M_AXI_DC_ARLOCK => M_AXI_DC_ARLOCK,
      M_AXI_DC_ARCACHE => M_AXI_DC_ARCACHE,
      M_AXI_DC_ARPROT => M_AXI_DC_ARPROT,
      M_AXI_DC_ARQOS => M_AXI_DC_ARQOS,
      M_AXI_DC_ARVALID => M_AXI_DC_ARVALID,
      M_AXI_DC_ARREADY => M_AXI_DC_ARREADY,
      M_AXI_DC_ARUSER => M_AXI_DC_ARUSER,
      M_AXI_DC_ARDOMAIN => M_AXI_DC_ARDOMAIN,
      M_AXI_DC_ARSNOOP => M_AXI_DC_ARSNOOP,
      M_AXI_DC_ARBAR => M_AXI_DC_ARBAR,
      M_AXI_DC_RID => M_AXI_DC_RID,
      M_AXI_DC_RDATA => M_AXI_DC_RDATA,
      M_AXI_DC_RRESP => M_AXI_DC_RRESP,
      M_AXI_DC_RLAST => M_AXI_DC_RLAST,
      M_AXI_DC_RVALID => M_AXI_DC_RVALID,
      M_AXI_DC_RREADY => M_AXI_DC_RREADY,
      M_AXI_DC_RUSER => M_AXI_DC_RUSER,
      M_AXI_DC_RACK => M_AXI_DC_RACK,
      M_AXI_DC_ACVALID => M_AXI_DC_ACVALID,
      M_AXI_DC_ACADDR => M_AXI_DC_ACADDR,
      M_AXI_DC_ACSNOOP => M_AXI_DC_ACSNOOP,
      M_AXI_DC_ACPROT => M_AXI_DC_ACPROT,
      M_AXI_DC_ACREADY => M_AXI_DC_ACREADY,
      M_AXI_DC_CRREADY => M_AXI_DC_CRREADY,
      M_AXI_DC_CRVALID => M_AXI_DC_CRVALID,
      M_AXI_DC_CRRESP => M_AXI_DC_CRRESP,
      M_AXI_DC_CDVALID => M_AXI_DC_CDVALID,
      M_AXI_DC_CDREADY => M_AXI_DC_CDREADY,
      M_AXI_DC_CDDATA => M_AXI_DC_CDDATA,
      M_AXI_DC_CDLAST => M_AXI_DC_CDLAST,
      DBG_CLK => DBG_CLK,
      DBG_TDI => DBG_TDI,
      DBG_TDO => DBG_TDO,
      DBG_REG_EN => DBG_REG_EN,
      DBG_SHIFT => DBG_SHIFT,
      DBG_CAPTURE => DBG_CAPTURE,
      DBG_UPDATE => DBG_UPDATE,
      DEBUG_RST => DEBUG_RST,
      Trace_Instruction => Trace_Instruction,
      Trace_Valid_Instr => Trace_Valid_Instr,
      Trace_PC => Trace_PC,
      Trace_Reg_Write => Trace_Reg_Write,
      Trace_Reg_Addr => Trace_Reg_Addr,
      Trace_MSR_Reg => Trace_MSR_Reg,
      Trace_PID_Reg => Trace_PID_Reg,
      Trace_New_Reg_Value => Trace_New_Reg_Value,
      Trace_Exception_Taken => Trace_Exception_Taken,
      Trace_Exception_Kind => Trace_Exception_Kind,
      Trace_Jump_Taken => Trace_Jump_Taken,
      Trace_Delay_Slot => Trace_Delay_Slot,
      Trace_Data_Address => Trace_Data_Address,
      Trace_Data_Access => Trace_Data_Access,
      Trace_Data_Read => Trace_Data_Read,
      Trace_Data_Write => Trace_Data_Write,
      Trace_Data_Write_Value => Trace_Data_Write_Value,
      Trace_Data_Byte_Enable => Trace_Data_Byte_Enable,
      Trace_DCache_Req => Trace_DCache_Req,
      Trace_DCache_Hit => Trace_DCache_Hit,
      Trace_DCache_Rdy => Trace_DCache_Rdy,
      Trace_DCache_Read => Trace_DCache_Read,
      Trace_ICache_Req => Trace_ICache_Req,
      Trace_ICache_Hit => Trace_ICache_Hit,
      Trace_ICache_Rdy => Trace_ICache_Rdy,
      Trace_OF_PipeRun => Trace_OF_PipeRun,
      Trace_EX_PipeRun => Trace_EX_PipeRun,
      Trace_MEM_PipeRun => Trace_MEM_PipeRun,
      Trace_MB_Halted => Trace_MB_Halted,
      Trace_Jump_Hit => Trace_Jump_Hit,
      FSL0_S_CLK => FSL0_S_CLK,
      FSL0_S_READ => FSL0_S_READ,
      FSL0_S_DATA => FSL0_S_DATA,
      FSL0_S_CONTROL => FSL0_S_CONTROL,
      FSL0_S_EXISTS => FSL0_S_EXISTS,
      FSL0_M_CLK => FSL0_M_CLK,
      FSL0_M_WRITE => FSL0_M_WRITE,
      FSL0_M_DATA => FSL0_M_DATA,
      FSL0_M_CONTROL => FSL0_M_CONTROL,
      FSL0_M_FULL => FSL0_M_FULL,
      FSL1_S_CLK => FSL1_S_CLK,
      FSL1_S_READ => FSL1_S_READ,
      FSL1_S_DATA => FSL1_S_DATA,
      FSL1_S_CONTROL => FSL1_S_CONTROL,
      FSL1_S_EXISTS => FSL1_S_EXISTS,
      FSL1_M_CLK => FSL1_M_CLK,
      FSL1_M_WRITE => FSL1_M_WRITE,
      FSL1_M_DATA => FSL1_M_DATA,
      FSL1_M_CONTROL => FSL1_M_CONTROL,
      FSL1_M_FULL => FSL1_M_FULL,
      FSL2_S_CLK => FSL2_S_CLK,
      FSL2_S_READ => FSL2_S_READ,
      FSL2_S_DATA => FSL2_S_DATA,
      FSL2_S_CONTROL => FSL2_S_CONTROL,
      FSL2_S_EXISTS => FSL2_S_EXISTS,
      FSL2_M_CLK => FSL2_M_CLK,
      FSL2_M_WRITE => FSL2_M_WRITE,
      FSL2_M_DATA => FSL2_M_DATA,
      FSL2_M_CONTROL => FSL2_M_CONTROL,
      FSL2_M_FULL => FSL2_M_FULL,
      FSL3_S_CLK => FSL3_S_CLK,
      FSL3_S_READ => FSL3_S_READ,
      FSL3_S_DATA => FSL3_S_DATA,
      FSL3_S_CONTROL => FSL3_S_CONTROL,
      FSL3_S_EXISTS => FSL3_S_EXISTS,
      FSL3_M_CLK => FSL3_M_CLK,
      FSL3_M_WRITE => FSL3_M_WRITE,
      FSL3_M_DATA => FSL3_M_DATA,
      FSL3_M_CONTROL => FSL3_M_CONTROL,
      FSL3_M_FULL => FSL3_M_FULL,
      FSL4_S_CLK => FSL4_S_CLK,
      FSL4_S_READ => FSL4_S_READ,
      FSL4_S_DATA => FSL4_S_DATA,
      FSL4_S_CONTROL => FSL4_S_CONTROL,
      FSL4_S_EXISTS => FSL4_S_EXISTS,
      FSL4_M_CLK => FSL4_M_CLK,
      FSL4_M_WRITE => FSL4_M_WRITE,
      FSL4_M_DATA => FSL4_M_DATA,
      FSL4_M_CONTROL => FSL4_M_CONTROL,
      FSL4_M_FULL => FSL4_M_FULL,
      FSL5_S_CLK => FSL5_S_CLK,
      FSL5_S_READ => FSL5_S_READ,
      FSL5_S_DATA => FSL5_S_DATA,
      FSL5_S_CONTROL => FSL5_S_CONTROL,
      FSL5_S_EXISTS => FSL5_S_EXISTS,
      FSL5_M_CLK => FSL5_M_CLK,
      FSL5_M_WRITE => FSL5_M_WRITE,
      FSL5_M_DATA => FSL5_M_DATA,
      FSL5_M_CONTROL => FSL5_M_CONTROL,
      FSL5_M_FULL => FSL5_M_FULL,
      FSL6_S_CLK => FSL6_S_CLK,
      FSL6_S_READ => FSL6_S_READ,
      FSL6_S_DATA => FSL6_S_DATA,
      FSL6_S_CONTROL => FSL6_S_CONTROL,
      FSL6_S_EXISTS => FSL6_S_EXISTS,
      FSL6_M_CLK => FSL6_M_CLK,
      FSL6_M_WRITE => FSL6_M_WRITE,
      FSL6_M_DATA => FSL6_M_DATA,
      FSL6_M_CONTROL => FSL6_M_CONTROL,
      FSL6_M_FULL => FSL6_M_FULL,
      FSL7_S_CLK => FSL7_S_CLK,
      FSL7_S_READ => FSL7_S_READ,
      FSL7_S_DATA => FSL7_S_DATA,
      FSL7_S_CONTROL => FSL7_S_CONTROL,
      FSL7_S_EXISTS => FSL7_S_EXISTS,
      FSL7_M_CLK => FSL7_M_CLK,
      FSL7_M_WRITE => FSL7_M_WRITE,
      FSL7_M_DATA => FSL7_M_DATA,
      FSL7_M_CONTROL => FSL7_M_CONTROL,
      FSL7_M_FULL => FSL7_M_FULL,
      FSL8_S_CLK => FSL8_S_CLK,
      FSL8_S_READ => FSL8_S_READ,
      FSL8_S_DATA => FSL8_S_DATA,
      FSL8_S_CONTROL => FSL8_S_CONTROL,
      FSL8_S_EXISTS => FSL8_S_EXISTS,
      FSL8_M_CLK => FSL8_M_CLK,
      FSL8_M_WRITE => FSL8_M_WRITE,
      FSL8_M_DATA => FSL8_M_DATA,
      FSL8_M_CONTROL => FSL8_M_CONTROL,
      FSL8_M_FULL => FSL8_M_FULL,
      FSL9_S_CLK => FSL9_S_CLK,
      FSL9_S_READ => FSL9_S_READ,
      FSL9_S_DATA => FSL9_S_DATA,
      FSL9_S_CONTROL => FSL9_S_CONTROL,
      FSL9_S_EXISTS => FSL9_S_EXISTS,
      FSL9_M_CLK => FSL9_M_CLK,
      FSL9_M_WRITE => FSL9_M_WRITE,
      FSL9_M_DATA => FSL9_M_DATA,
      FSL9_M_CONTROL => FSL9_M_CONTROL,
      FSL9_M_FULL => FSL9_M_FULL,
      FSL10_S_CLK => FSL10_S_CLK,
      FSL10_S_READ => FSL10_S_READ,
      FSL10_S_DATA => FSL10_S_DATA,
      FSL10_S_CONTROL => FSL10_S_CONTROL,
      FSL10_S_EXISTS => FSL10_S_EXISTS,
      FSL10_M_CLK => FSL10_M_CLK,
      FSL10_M_WRITE => FSL10_M_WRITE,
      FSL10_M_DATA => FSL10_M_DATA,
      FSL10_M_CONTROL => FSL10_M_CONTROL,
      FSL10_M_FULL => FSL10_M_FULL,
      FSL11_S_CLK => FSL11_S_CLK,
      FSL11_S_READ => FSL11_S_READ,
      FSL11_S_DATA => FSL11_S_DATA,
      FSL11_S_CONTROL => FSL11_S_CONTROL,
      FSL11_S_EXISTS => FSL11_S_EXISTS,
      FSL11_M_CLK => FSL11_M_CLK,
      FSL11_M_WRITE => FSL11_M_WRITE,
      FSL11_M_DATA => FSL11_M_DATA,
      FSL11_M_CONTROL => FSL11_M_CONTROL,
      FSL11_M_FULL => FSL11_M_FULL,
      FSL12_S_CLK => FSL12_S_CLK,
      FSL12_S_READ => FSL12_S_READ,
      FSL12_S_DATA => FSL12_S_DATA,
      FSL12_S_CONTROL => FSL12_S_CONTROL,
      FSL12_S_EXISTS => FSL12_S_EXISTS,
      FSL12_M_CLK => FSL12_M_CLK,
      FSL12_M_WRITE => FSL12_M_WRITE,
      FSL12_M_DATA => FSL12_M_DATA,
      FSL12_M_CONTROL => FSL12_M_CONTROL,
      FSL12_M_FULL => FSL12_M_FULL,
      FSL13_S_CLK => FSL13_S_CLK,
      FSL13_S_READ => FSL13_S_READ,
      FSL13_S_DATA => FSL13_S_DATA,
      FSL13_S_CONTROL => FSL13_S_CONTROL,
      FSL13_S_EXISTS => FSL13_S_EXISTS,
      FSL13_M_CLK => FSL13_M_CLK,
      FSL13_M_WRITE => FSL13_M_WRITE,
      FSL13_M_DATA => FSL13_M_DATA,
      FSL13_M_CONTROL => FSL13_M_CONTROL,
      FSL13_M_FULL => FSL13_M_FULL,
      FSL14_S_CLK => FSL14_S_CLK,
      FSL14_S_READ => FSL14_S_READ,
      FSL14_S_DATA => FSL14_S_DATA,
      FSL14_S_CONTROL => FSL14_S_CONTROL,
      FSL14_S_EXISTS => FSL14_S_EXISTS,
      FSL14_M_CLK => FSL14_M_CLK,
      FSL14_M_WRITE => FSL14_M_WRITE,
      FSL14_M_DATA => FSL14_M_DATA,
      FSL14_M_CONTROL => FSL14_M_CONTROL,
      FSL14_M_FULL => FSL14_M_FULL,
      FSL15_S_CLK => FSL15_S_CLK,
      FSL15_S_READ => FSL15_S_READ,
      FSL15_S_DATA => FSL15_S_DATA,
      FSL15_S_CONTROL => FSL15_S_CONTROL,
      FSL15_S_EXISTS => FSL15_S_EXISTS,
      FSL15_M_CLK => FSL15_M_CLK,
      FSL15_M_WRITE => FSL15_M_WRITE,
      FSL15_M_DATA => FSL15_M_DATA,
      FSL15_M_CONTROL => FSL15_M_CONTROL,
      FSL15_M_FULL => FSL15_M_FULL,
      M0_AXIS_TLAST => M0_AXIS_TLAST,
      M0_AXIS_TDATA => M0_AXIS_TDATA,
      M0_AXIS_TVALID => M0_AXIS_TVALID,
      M0_AXIS_TREADY => M0_AXIS_TREADY,
      S0_AXIS_TLAST => S0_AXIS_TLAST,
      S0_AXIS_TDATA => S0_AXIS_TDATA,
      S0_AXIS_TVALID => S0_AXIS_TVALID,
      S0_AXIS_TREADY => S0_AXIS_TREADY,
      M1_AXIS_TLAST => M1_AXIS_TLAST,
      M1_AXIS_TDATA => M1_AXIS_TDATA,
      M1_AXIS_TVALID => M1_AXIS_TVALID,
      M1_AXIS_TREADY => M1_AXIS_TREADY,
      S1_AXIS_TLAST => S1_AXIS_TLAST,
      S1_AXIS_TDATA => S1_AXIS_TDATA,
      S1_AXIS_TVALID => S1_AXIS_TVALID,
      S1_AXIS_TREADY => S1_AXIS_TREADY,
      M2_AXIS_TLAST => M2_AXIS_TLAST,
      M2_AXIS_TDATA => M2_AXIS_TDATA,
      M2_AXIS_TVALID => M2_AXIS_TVALID,
      M2_AXIS_TREADY => M2_AXIS_TREADY,
      S2_AXIS_TLAST => S2_AXIS_TLAST,
      S2_AXIS_TDATA => S2_AXIS_TDATA,
      S2_AXIS_TVALID => S2_AXIS_TVALID,
      S2_AXIS_TREADY => S2_AXIS_TREADY,
      M3_AXIS_TLAST => M3_AXIS_TLAST,
      M3_AXIS_TDATA => M3_AXIS_TDATA,
      M3_AXIS_TVALID => M3_AXIS_TVALID,
      M3_AXIS_TREADY => M3_AXIS_TREADY,
      S3_AXIS_TLAST => S3_AXIS_TLAST,
      S3_AXIS_TDATA => S3_AXIS_TDATA,
      S3_AXIS_TVALID => S3_AXIS_TVALID,
      S3_AXIS_TREADY => S3_AXIS_TREADY,
      M4_AXIS_TLAST => M4_AXIS_TLAST,
      M4_AXIS_TDATA => M4_AXIS_TDATA,
      M4_AXIS_TVALID => M4_AXIS_TVALID,
      M4_AXIS_TREADY => M4_AXIS_TREADY,
      S4_AXIS_TLAST => S4_AXIS_TLAST,
      S4_AXIS_TDATA => S4_AXIS_TDATA,
      S4_AXIS_TVALID => S4_AXIS_TVALID,
      S4_AXIS_TREADY => S4_AXIS_TREADY,
      M5_AXIS_TLAST => M5_AXIS_TLAST,
      M5_AXIS_TDATA => M5_AXIS_TDATA,
      M5_AXIS_TVALID => M5_AXIS_TVALID,
      M5_AXIS_TREADY => M5_AXIS_TREADY,
      S5_AXIS_TLAST => S5_AXIS_TLAST,
      S5_AXIS_TDATA => S5_AXIS_TDATA,
      S5_AXIS_TVALID => S5_AXIS_TVALID,
      S5_AXIS_TREADY => S5_AXIS_TREADY,
      M6_AXIS_TLAST => M6_AXIS_TLAST,
      M6_AXIS_TDATA => M6_AXIS_TDATA,
      M6_AXIS_TVALID => M6_AXIS_TVALID,
      M6_AXIS_TREADY => M6_AXIS_TREADY,
      S6_AXIS_TLAST => S6_AXIS_TLAST,
      S6_AXIS_TDATA => S6_AXIS_TDATA,
      S6_AXIS_TVALID => S6_AXIS_TVALID,
      S6_AXIS_TREADY => S6_AXIS_TREADY,
      M7_AXIS_TLAST => M7_AXIS_TLAST,
      M7_AXIS_TDATA => M7_AXIS_TDATA,
      M7_AXIS_TVALID => M7_AXIS_TVALID,
      M7_AXIS_TREADY => M7_AXIS_TREADY,
      S7_AXIS_TLAST => S7_AXIS_TLAST,
      S7_AXIS_TDATA => S7_AXIS_TDATA,
      S7_AXIS_TVALID => S7_AXIS_TVALID,
      S7_AXIS_TREADY => S7_AXIS_TREADY,
      M8_AXIS_TLAST => M8_AXIS_TLAST,
      M8_AXIS_TDATA => M8_AXIS_TDATA,
      M8_AXIS_TVALID => M8_AXIS_TVALID,
      M8_AXIS_TREADY => M8_AXIS_TREADY,
      S8_AXIS_TLAST => S8_AXIS_TLAST,
      S8_AXIS_TDATA => S8_AXIS_TDATA,
      S8_AXIS_TVALID => S8_AXIS_TVALID,
      S8_AXIS_TREADY => S8_AXIS_TREADY,
      M9_AXIS_TLAST => M9_AXIS_TLAST,
      M9_AXIS_TDATA => M9_AXIS_TDATA,
      M9_AXIS_TVALID => M9_AXIS_TVALID,
      M9_AXIS_TREADY => M9_AXIS_TREADY,
      S9_AXIS_TLAST => S9_AXIS_TLAST,
      S9_AXIS_TDATA => S9_AXIS_TDATA,
      S9_AXIS_TVALID => S9_AXIS_TVALID,
      S9_AXIS_TREADY => S9_AXIS_TREADY,
      M10_AXIS_TLAST => M10_AXIS_TLAST,
      M10_AXIS_TDATA => M10_AXIS_TDATA,
      M10_AXIS_TVALID => M10_AXIS_TVALID,
      M10_AXIS_TREADY => M10_AXIS_TREADY,
      S10_AXIS_TLAST => S10_AXIS_TLAST,
      S10_AXIS_TDATA => S10_AXIS_TDATA,
      S10_AXIS_TVALID => S10_AXIS_TVALID,
      S10_AXIS_TREADY => S10_AXIS_TREADY,
      M11_AXIS_TLAST => M11_AXIS_TLAST,
      M11_AXIS_TDATA => M11_AXIS_TDATA,
      M11_AXIS_TVALID => M11_AXIS_TVALID,
      M11_AXIS_TREADY => M11_AXIS_TREADY,
      S11_AXIS_TLAST => S11_AXIS_TLAST,
      S11_AXIS_TDATA => S11_AXIS_TDATA,
      S11_AXIS_TVALID => S11_AXIS_TVALID,
      S11_AXIS_TREADY => S11_AXIS_TREADY,
      M12_AXIS_TLAST => M12_AXIS_TLAST,
      M12_AXIS_TDATA => M12_AXIS_TDATA,
      M12_AXIS_TVALID => M12_AXIS_TVALID,
      M12_AXIS_TREADY => M12_AXIS_TREADY,
      S12_AXIS_TLAST => S12_AXIS_TLAST,
      S12_AXIS_TDATA => S12_AXIS_TDATA,
      S12_AXIS_TVALID => S12_AXIS_TVALID,
      S12_AXIS_TREADY => S12_AXIS_TREADY,
      M13_AXIS_TLAST => M13_AXIS_TLAST,
      M13_AXIS_TDATA => M13_AXIS_TDATA,
      M13_AXIS_TVALID => M13_AXIS_TVALID,
      M13_AXIS_TREADY => M13_AXIS_TREADY,
      S13_AXIS_TLAST => S13_AXIS_TLAST,
      S13_AXIS_TDATA => S13_AXIS_TDATA,
      S13_AXIS_TVALID => S13_AXIS_TVALID,
      S13_AXIS_TREADY => S13_AXIS_TREADY,
      M14_AXIS_TLAST => M14_AXIS_TLAST,
      M14_AXIS_TDATA => M14_AXIS_TDATA,
      M14_AXIS_TVALID => M14_AXIS_TVALID,
      M14_AXIS_TREADY => M14_AXIS_TREADY,
      S14_AXIS_TLAST => S14_AXIS_TLAST,
      S14_AXIS_TDATA => S14_AXIS_TDATA,
      S14_AXIS_TVALID => S14_AXIS_TVALID,
      S14_AXIS_TREADY => S14_AXIS_TREADY,
      M15_AXIS_TLAST => M15_AXIS_TLAST,
      M15_AXIS_TDATA => M15_AXIS_TDATA,
      M15_AXIS_TVALID => M15_AXIS_TVALID,
      M15_AXIS_TREADY => M15_AXIS_TREADY,
      S15_AXIS_TLAST => S15_AXIS_TLAST,
      S15_AXIS_TDATA => S15_AXIS_TDATA,
      S15_AXIS_TVALID => S15_AXIS_TVALID,
      S15_AXIS_TREADY => S15_AXIS_TREADY,
      ICACHE_FSL_IN_CLK => ICACHE_FSL_IN_CLK,
      ICACHE_FSL_IN_READ => ICACHE_FSL_IN_READ,
      ICACHE_FSL_IN_DATA => ICACHE_FSL_IN_DATA,
      ICACHE_FSL_IN_CONTROL => ICACHE_FSL_IN_CONTROL,
      ICACHE_FSL_IN_EXISTS => ICACHE_FSL_IN_EXISTS,
      ICACHE_FSL_OUT_CLK => ICACHE_FSL_OUT_CLK,
      ICACHE_FSL_OUT_WRITE => ICACHE_FSL_OUT_WRITE,
      ICACHE_FSL_OUT_DATA => ICACHE_FSL_OUT_DATA,
      ICACHE_FSL_OUT_CONTROL => ICACHE_FSL_OUT_CONTROL,
      ICACHE_FSL_OUT_FULL => ICACHE_FSL_OUT_FULL,
      DCACHE_FSL_IN_CLK => DCACHE_FSL_IN_CLK,
      DCACHE_FSL_IN_READ => DCACHE_FSL_IN_READ,
      DCACHE_FSL_IN_DATA => DCACHE_FSL_IN_DATA,
      DCACHE_FSL_IN_CONTROL => DCACHE_FSL_IN_CONTROL,
      DCACHE_FSL_IN_EXISTS => DCACHE_FSL_IN_EXISTS,
      DCACHE_FSL_OUT_CLK => DCACHE_FSL_OUT_CLK,
      DCACHE_FSL_OUT_WRITE => DCACHE_FSL_OUT_WRITE,
      DCACHE_FSL_OUT_DATA => DCACHE_FSL_OUT_DATA,
      DCACHE_FSL_OUT_CONTROL => DCACHE_FSL_OUT_CONTROL,
      DCACHE_FSL_OUT_FULL => DCACHE_FSL_OUT_FULL
    );

end architecture STRUCTURE;

