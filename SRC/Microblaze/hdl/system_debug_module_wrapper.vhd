-------------------------------------------------------------------------------
-- system_debug_module_wrapper.vhd
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

library mdm_v2_10_a;
use mdm_v2_10_a.all;

entity system_debug_module_wrapper is
  port (
    Interrupt : out std_logic;
    Debug_SYS_Rst : out std_logic;
    Ext_BRK : out std_logic;
    Ext_NM_BRK : out std_logic;
    S_AXI_ACLK : in std_logic;
    S_AXI_ARESETN : in std_logic;
    S_AXI_AWADDR : in std_logic_vector(31 downto 0);
    S_AXI_AWVALID : in std_logic;
    S_AXI_AWREADY : out std_logic;
    S_AXI_WDATA : in std_logic_vector(31 downto 0);
    S_AXI_WSTRB : in std_logic_vector(3 downto 0);
    S_AXI_WVALID : in std_logic;
    S_AXI_WREADY : out std_logic;
    S_AXI_BRESP : out std_logic_vector(1 downto 0);
    S_AXI_BVALID : out std_logic;
    S_AXI_BREADY : in std_logic;
    S_AXI_ARADDR : in std_logic_vector(31 downto 0);
    S_AXI_ARVALID : in std_logic;
    S_AXI_ARREADY : out std_logic;
    S_AXI_RDATA : out std_logic_vector(31 downto 0);
    S_AXI_RRESP : out std_logic_vector(1 downto 0);
    S_AXI_RVALID : out std_logic;
    S_AXI_RREADY : in std_logic;
    SPLB_Clk : in std_logic;
    SPLB_Rst : in std_logic;
    PLB_ABus : in std_logic_vector(0 to 31);
    PLB_UABus : in std_logic_vector(0 to 31);
    PLB_PAValid : in std_logic;
    PLB_SAValid : in std_logic;
    PLB_rdPrim : in std_logic;
    PLB_wrPrim : in std_logic;
    PLB_masterID : in std_logic_vector(0 to 2);
    PLB_abort : in std_logic;
    PLB_busLock : in std_logic;
    PLB_RNW : in std_logic;
    PLB_BE : in std_logic_vector(0 to 3);
    PLB_MSize : in std_logic_vector(0 to 1);
    PLB_size : in std_logic_vector(0 to 3);
    PLB_type : in std_logic_vector(0 to 2);
    PLB_lockErr : in std_logic;
    PLB_wrDBus : in std_logic_vector(0 to 31);
    PLB_wrBurst : in std_logic;
    PLB_rdBurst : in std_logic;
    PLB_wrPendReq : in std_logic;
    PLB_rdPendReq : in std_logic;
    PLB_wrPendPri : in std_logic_vector(0 to 1);
    PLB_rdPendPri : in std_logic_vector(0 to 1);
    PLB_reqPri : in std_logic_vector(0 to 1);
    PLB_TAttribute : in std_logic_vector(0 to 15);
    Sl_addrAck : out std_logic;
    Sl_SSize : out std_logic_vector(0 to 1);
    Sl_wait : out std_logic;
    Sl_rearbitrate : out std_logic;
    Sl_wrDAck : out std_logic;
    Sl_wrComp : out std_logic;
    Sl_wrBTerm : out std_logic;
    Sl_rdDBus : out std_logic_vector(0 to 31);
    Sl_rdWdAddr : out std_logic_vector(0 to 3);
    Sl_rdDAck : out std_logic;
    Sl_rdComp : out std_logic;
    Sl_rdBTerm : out std_logic;
    Sl_MBusy : out std_logic_vector(0 to 7);
    Sl_MWrErr : out std_logic_vector(0 to 7);
    Sl_MRdErr : out std_logic_vector(0 to 7);
    Sl_MIRQ : out std_logic_vector(0 to 7);
    Dbg_Clk_0 : out std_logic;
    Dbg_TDI_0 : out std_logic;
    Dbg_TDO_0 : in std_logic;
    Dbg_Reg_En_0 : out std_logic_vector(0 to 7);
    Dbg_Capture_0 : out std_logic;
    Dbg_Shift_0 : out std_logic;
    Dbg_Update_0 : out std_logic;
    Dbg_Rst_0 : out std_logic;
    Dbg_Clk_1 : out std_logic;
    Dbg_TDI_1 : out std_logic;
    Dbg_TDO_1 : in std_logic;
    Dbg_Reg_En_1 : out std_logic_vector(0 to 7);
    Dbg_Capture_1 : out std_logic;
    Dbg_Shift_1 : out std_logic;
    Dbg_Update_1 : out std_logic;
    Dbg_Rst_1 : out std_logic;
    Dbg_Clk_2 : out std_logic;
    Dbg_TDI_2 : out std_logic;
    Dbg_TDO_2 : in std_logic;
    Dbg_Reg_En_2 : out std_logic_vector(0 to 7);
    Dbg_Capture_2 : out std_logic;
    Dbg_Shift_2 : out std_logic;
    Dbg_Update_2 : out std_logic;
    Dbg_Rst_2 : out std_logic;
    Dbg_Clk_3 : out std_logic;
    Dbg_TDI_3 : out std_logic;
    Dbg_TDO_3 : in std_logic;
    Dbg_Reg_En_3 : out std_logic_vector(0 to 7);
    Dbg_Capture_3 : out std_logic;
    Dbg_Shift_3 : out std_logic;
    Dbg_Update_3 : out std_logic;
    Dbg_Rst_3 : out std_logic;
    Dbg_Clk_4 : out std_logic;
    Dbg_TDI_4 : out std_logic;
    Dbg_TDO_4 : in std_logic;
    Dbg_Reg_En_4 : out std_logic_vector(0 to 7);
    Dbg_Capture_4 : out std_logic;
    Dbg_Shift_4 : out std_logic;
    Dbg_Update_4 : out std_logic;
    Dbg_Rst_4 : out std_logic;
    Dbg_Clk_5 : out std_logic;
    Dbg_TDI_5 : out std_logic;
    Dbg_TDO_5 : in std_logic;
    Dbg_Reg_En_5 : out std_logic_vector(0 to 7);
    Dbg_Capture_5 : out std_logic;
    Dbg_Shift_5 : out std_logic;
    Dbg_Update_5 : out std_logic;
    Dbg_Rst_5 : out std_logic;
    Dbg_Clk_6 : out std_logic;
    Dbg_TDI_6 : out std_logic;
    Dbg_TDO_6 : in std_logic;
    Dbg_Reg_En_6 : out std_logic_vector(0 to 7);
    Dbg_Capture_6 : out std_logic;
    Dbg_Shift_6 : out std_logic;
    Dbg_Update_6 : out std_logic;
    Dbg_Rst_6 : out std_logic;
    Dbg_Clk_7 : out std_logic;
    Dbg_TDI_7 : out std_logic;
    Dbg_TDO_7 : in std_logic;
    Dbg_Reg_En_7 : out std_logic_vector(0 to 7);
    Dbg_Capture_7 : out std_logic;
    Dbg_Shift_7 : out std_logic;
    Dbg_Update_7 : out std_logic;
    Dbg_Rst_7 : out std_logic;
    Dbg_Clk_8 : out std_logic;
    Dbg_TDI_8 : out std_logic;
    Dbg_TDO_8 : in std_logic;
    Dbg_Reg_En_8 : out std_logic_vector(0 to 7);
    Dbg_Capture_8 : out std_logic;
    Dbg_Shift_8 : out std_logic;
    Dbg_Update_8 : out std_logic;
    Dbg_Rst_8 : out std_logic;
    Dbg_Clk_9 : out std_logic;
    Dbg_TDI_9 : out std_logic;
    Dbg_TDO_9 : in std_logic;
    Dbg_Reg_En_9 : out std_logic_vector(0 to 7);
    Dbg_Capture_9 : out std_logic;
    Dbg_Shift_9 : out std_logic;
    Dbg_Update_9 : out std_logic;
    Dbg_Rst_9 : out std_logic;
    Dbg_Clk_10 : out std_logic;
    Dbg_TDI_10 : out std_logic;
    Dbg_TDO_10 : in std_logic;
    Dbg_Reg_En_10 : out std_logic_vector(0 to 7);
    Dbg_Capture_10 : out std_logic;
    Dbg_Shift_10 : out std_logic;
    Dbg_Update_10 : out std_logic;
    Dbg_Rst_10 : out std_logic;
    Dbg_Clk_11 : out std_logic;
    Dbg_TDI_11 : out std_logic;
    Dbg_TDO_11 : in std_logic;
    Dbg_Reg_En_11 : out std_logic_vector(0 to 7);
    Dbg_Capture_11 : out std_logic;
    Dbg_Shift_11 : out std_logic;
    Dbg_Update_11 : out std_logic;
    Dbg_Rst_11 : out std_logic;
    Dbg_Clk_12 : out std_logic;
    Dbg_TDI_12 : out std_logic;
    Dbg_TDO_12 : in std_logic;
    Dbg_Reg_En_12 : out std_logic_vector(0 to 7);
    Dbg_Capture_12 : out std_logic;
    Dbg_Shift_12 : out std_logic;
    Dbg_Update_12 : out std_logic;
    Dbg_Rst_12 : out std_logic;
    Dbg_Clk_13 : out std_logic;
    Dbg_TDI_13 : out std_logic;
    Dbg_TDO_13 : in std_logic;
    Dbg_Reg_En_13 : out std_logic_vector(0 to 7);
    Dbg_Capture_13 : out std_logic;
    Dbg_Shift_13 : out std_logic;
    Dbg_Update_13 : out std_logic;
    Dbg_Rst_13 : out std_logic;
    Dbg_Clk_14 : out std_logic;
    Dbg_TDI_14 : out std_logic;
    Dbg_TDO_14 : in std_logic;
    Dbg_Reg_En_14 : out std_logic_vector(0 to 7);
    Dbg_Capture_14 : out std_logic;
    Dbg_Shift_14 : out std_logic;
    Dbg_Update_14 : out std_logic;
    Dbg_Rst_14 : out std_logic;
    Dbg_Clk_15 : out std_logic;
    Dbg_TDI_15 : out std_logic;
    Dbg_TDO_15 : in std_logic;
    Dbg_Reg_En_15 : out std_logic_vector(0 to 7);
    Dbg_Capture_15 : out std_logic;
    Dbg_Shift_15 : out std_logic;
    Dbg_Update_15 : out std_logic;
    Dbg_Rst_15 : out std_logic;
    Dbg_Clk_16 : out std_logic;
    Dbg_TDI_16 : out std_logic;
    Dbg_TDO_16 : in std_logic;
    Dbg_Reg_En_16 : out std_logic_vector(0 to 7);
    Dbg_Capture_16 : out std_logic;
    Dbg_Shift_16 : out std_logic;
    Dbg_Update_16 : out std_logic;
    Dbg_Rst_16 : out std_logic;
    Dbg_Clk_17 : out std_logic;
    Dbg_TDI_17 : out std_logic;
    Dbg_TDO_17 : in std_logic;
    Dbg_Reg_En_17 : out std_logic_vector(0 to 7);
    Dbg_Capture_17 : out std_logic;
    Dbg_Shift_17 : out std_logic;
    Dbg_Update_17 : out std_logic;
    Dbg_Rst_17 : out std_logic;
    Dbg_Clk_18 : out std_logic;
    Dbg_TDI_18 : out std_logic;
    Dbg_TDO_18 : in std_logic;
    Dbg_Reg_En_18 : out std_logic_vector(0 to 7);
    Dbg_Capture_18 : out std_logic;
    Dbg_Shift_18 : out std_logic;
    Dbg_Update_18 : out std_logic;
    Dbg_Rst_18 : out std_logic;
    Dbg_Clk_19 : out std_logic;
    Dbg_TDI_19 : out std_logic;
    Dbg_TDO_19 : in std_logic;
    Dbg_Reg_En_19 : out std_logic_vector(0 to 7);
    Dbg_Capture_19 : out std_logic;
    Dbg_Shift_19 : out std_logic;
    Dbg_Update_19 : out std_logic;
    Dbg_Rst_19 : out std_logic;
    Dbg_Clk_20 : out std_logic;
    Dbg_TDI_20 : out std_logic;
    Dbg_TDO_20 : in std_logic;
    Dbg_Reg_En_20 : out std_logic_vector(0 to 7);
    Dbg_Capture_20 : out std_logic;
    Dbg_Shift_20 : out std_logic;
    Dbg_Update_20 : out std_logic;
    Dbg_Rst_20 : out std_logic;
    Dbg_Clk_21 : out std_logic;
    Dbg_TDI_21 : out std_logic;
    Dbg_TDO_21 : in std_logic;
    Dbg_Reg_En_21 : out std_logic_vector(0 to 7);
    Dbg_Capture_21 : out std_logic;
    Dbg_Shift_21 : out std_logic;
    Dbg_Update_21 : out std_logic;
    Dbg_Rst_21 : out std_logic;
    Dbg_Clk_22 : out std_logic;
    Dbg_TDI_22 : out std_logic;
    Dbg_TDO_22 : in std_logic;
    Dbg_Reg_En_22 : out std_logic_vector(0 to 7);
    Dbg_Capture_22 : out std_logic;
    Dbg_Shift_22 : out std_logic;
    Dbg_Update_22 : out std_logic;
    Dbg_Rst_22 : out std_logic;
    Dbg_Clk_23 : out std_logic;
    Dbg_TDI_23 : out std_logic;
    Dbg_TDO_23 : in std_logic;
    Dbg_Reg_En_23 : out std_logic_vector(0 to 7);
    Dbg_Capture_23 : out std_logic;
    Dbg_Shift_23 : out std_logic;
    Dbg_Update_23 : out std_logic;
    Dbg_Rst_23 : out std_logic;
    Dbg_Clk_24 : out std_logic;
    Dbg_TDI_24 : out std_logic;
    Dbg_TDO_24 : in std_logic;
    Dbg_Reg_En_24 : out std_logic_vector(0 to 7);
    Dbg_Capture_24 : out std_logic;
    Dbg_Shift_24 : out std_logic;
    Dbg_Update_24 : out std_logic;
    Dbg_Rst_24 : out std_logic;
    Dbg_Clk_25 : out std_logic;
    Dbg_TDI_25 : out std_logic;
    Dbg_TDO_25 : in std_logic;
    Dbg_Reg_En_25 : out std_logic_vector(0 to 7);
    Dbg_Capture_25 : out std_logic;
    Dbg_Shift_25 : out std_logic;
    Dbg_Update_25 : out std_logic;
    Dbg_Rst_25 : out std_logic;
    Dbg_Clk_26 : out std_logic;
    Dbg_TDI_26 : out std_logic;
    Dbg_TDO_26 : in std_logic;
    Dbg_Reg_En_26 : out std_logic_vector(0 to 7);
    Dbg_Capture_26 : out std_logic;
    Dbg_Shift_26 : out std_logic;
    Dbg_Update_26 : out std_logic;
    Dbg_Rst_26 : out std_logic;
    Dbg_Clk_27 : out std_logic;
    Dbg_TDI_27 : out std_logic;
    Dbg_TDO_27 : in std_logic;
    Dbg_Reg_En_27 : out std_logic_vector(0 to 7);
    Dbg_Capture_27 : out std_logic;
    Dbg_Shift_27 : out std_logic;
    Dbg_Update_27 : out std_logic;
    Dbg_Rst_27 : out std_logic;
    Dbg_Clk_28 : out std_logic;
    Dbg_TDI_28 : out std_logic;
    Dbg_TDO_28 : in std_logic;
    Dbg_Reg_En_28 : out std_logic_vector(0 to 7);
    Dbg_Capture_28 : out std_logic;
    Dbg_Shift_28 : out std_logic;
    Dbg_Update_28 : out std_logic;
    Dbg_Rst_28 : out std_logic;
    Dbg_Clk_29 : out std_logic;
    Dbg_TDI_29 : out std_logic;
    Dbg_TDO_29 : in std_logic;
    Dbg_Reg_En_29 : out std_logic_vector(0 to 7);
    Dbg_Capture_29 : out std_logic;
    Dbg_Shift_29 : out std_logic;
    Dbg_Update_29 : out std_logic;
    Dbg_Rst_29 : out std_logic;
    Dbg_Clk_30 : out std_logic;
    Dbg_TDI_30 : out std_logic;
    Dbg_TDO_30 : in std_logic;
    Dbg_Reg_En_30 : out std_logic_vector(0 to 7);
    Dbg_Capture_30 : out std_logic;
    Dbg_Shift_30 : out std_logic;
    Dbg_Update_30 : out std_logic;
    Dbg_Rst_30 : out std_logic;
    Dbg_Clk_31 : out std_logic;
    Dbg_TDI_31 : out std_logic;
    Dbg_TDO_31 : in std_logic;
    Dbg_Reg_En_31 : out std_logic_vector(0 to 7);
    Dbg_Capture_31 : out std_logic;
    Dbg_Shift_31 : out std_logic;
    Dbg_Update_31 : out std_logic;
    Dbg_Rst_31 : out std_logic;
    bscan_tdi : out std_logic;
    bscan_reset : out std_logic;
    bscan_shift : out std_logic;
    bscan_update : out std_logic;
    bscan_capture : out std_logic;
    bscan_sel1 : out std_logic;
    bscan_drck1 : out std_logic;
    bscan_tdo1 : in std_logic;
    bscan_ext_tdi : in std_logic;
    bscan_ext_reset : in std_logic;
    bscan_ext_shift : in std_logic;
    bscan_ext_update : in std_logic;
    bscan_ext_capture : in std_logic;
    bscan_ext_sel : in std_logic;
    bscan_ext_drck : in std_logic;
    bscan_ext_tdo : out std_logic;
    Ext_JTAG_DRCK : out std_logic;
    Ext_JTAG_RESET : out std_logic;
    Ext_JTAG_SEL : out std_logic;
    Ext_JTAG_CAPTURE : out std_logic;
    Ext_JTAG_SHIFT : out std_logic;
    Ext_JTAG_UPDATE : out std_logic;
    Ext_JTAG_TDI : out std_logic;
    Ext_JTAG_TDO : in std_logic
  );

  attribute x_core_info : STRING;
  attribute x_core_info of system_debug_module_wrapper : entity is "mdm_v2_10_a";

end system_debug_module_wrapper;

architecture STRUCTURE of system_debug_module_wrapper is

  component mdm is
    generic (
      C_FAMILY : STRING;
      C_JTAG_CHAIN : INTEGER;
      C_INTERCONNECT : INTEGER;
      C_BASEADDR : STD_LOGIC_VECTOR;
      C_HIGHADDR : STD_LOGIC_VECTOR;
      C_SPLB_AWIDTH : INTEGER;
      C_SPLB_DWIDTH : INTEGER;
      C_SPLB_P2P : INTEGER;
      C_SPLB_MID_WIDTH : INTEGER;
      C_SPLB_NUM_MASTERS : INTEGER;
      C_SPLB_NATIVE_DWIDTH : INTEGER;
      C_SPLB_SUPPORT_BURSTS : INTEGER;
      C_MB_DBG_PORTS : INTEGER;
      C_USE_UART : INTEGER;
      C_USE_BSCAN : integer;
      C_S_AXI_ADDR_WIDTH : INTEGER;
      C_S_AXI_DATA_WIDTH : INTEGER
    );
    port (
      Interrupt : out std_logic;
      Debug_SYS_Rst : out std_logic;
      Ext_BRK : out std_logic;
      Ext_NM_BRK : out std_logic;
      S_AXI_ACLK : in std_logic;
      S_AXI_ARESETN : in std_logic;
      S_AXI_AWADDR : in std_logic_vector((C_S_AXI_ADDR_WIDTH-1) downto 0);
      S_AXI_AWVALID : in std_logic;
      S_AXI_AWREADY : out std_logic;
      S_AXI_WDATA : in std_logic_vector((C_S_AXI_DATA_WIDTH-1) downto 0);
      S_AXI_WSTRB : in std_logic_vector((C_S_AXI_DATA_WIDTH/8-1) downto 0);
      S_AXI_WVALID : in std_logic;
      S_AXI_WREADY : out std_logic;
      S_AXI_BRESP : out std_logic_vector(1 downto 0);
      S_AXI_BVALID : out std_logic;
      S_AXI_BREADY : in std_logic;
      S_AXI_ARADDR : in std_logic_vector((C_S_AXI_ADDR_WIDTH-1) downto 0);
      S_AXI_ARVALID : in std_logic;
      S_AXI_ARREADY : out std_logic;
      S_AXI_RDATA : out std_logic_vector((C_S_AXI_DATA_WIDTH-1) downto 0);
      S_AXI_RRESP : out std_logic_vector(1 downto 0);
      S_AXI_RVALID : out std_logic;
      S_AXI_RREADY : in std_logic;
      SPLB_Clk : in std_logic;
      SPLB_Rst : in std_logic;
      PLB_ABus : in std_logic_vector(0 to 31);
      PLB_UABus : in std_logic_vector(0 to 31);
      PLB_PAValid : in std_logic;
      PLB_SAValid : in std_logic;
      PLB_rdPrim : in std_logic;
      PLB_wrPrim : in std_logic;
      PLB_masterID : in std_logic_vector(0 to (C_SPLB_MID_WIDTH-1));
      PLB_abort : in std_logic;
      PLB_busLock : in std_logic;
      PLB_RNW : in std_logic;
      PLB_BE : in std_logic_vector(0 to ((C_SPLB_DWIDTH/8)-1));
      PLB_MSize : in std_logic_vector(0 to 1);
      PLB_size : in std_logic_vector(0 to 3);
      PLB_type : in std_logic_vector(0 to 2);
      PLB_lockErr : in std_logic;
      PLB_wrDBus : in std_logic_vector(0 to (C_SPLB_DWIDTH-1));
      PLB_wrBurst : in std_logic;
      PLB_rdBurst : in std_logic;
      PLB_wrPendReq : in std_logic;
      PLB_rdPendReq : in std_logic;
      PLB_wrPendPri : in std_logic_vector(0 to 1);
      PLB_rdPendPri : in std_logic_vector(0 to 1);
      PLB_reqPri : in std_logic_vector(0 to 1);
      PLB_TAttribute : in std_logic_vector(0 to 15);
      Sl_addrAck : out std_logic;
      Sl_SSize : out std_logic_vector(0 to 1);
      Sl_wait : out std_logic;
      Sl_rearbitrate : out std_logic;
      Sl_wrDAck : out std_logic;
      Sl_wrComp : out std_logic;
      Sl_wrBTerm : out std_logic;
      Sl_rdDBus : out std_logic_vector(0 to (C_SPLB_DWIDTH-1));
      Sl_rdWdAddr : out std_logic_vector(0 to 3);
      Sl_rdDAck : out std_logic;
      Sl_rdComp : out std_logic;
      Sl_rdBTerm : out std_logic;
      Sl_MBusy : out std_logic_vector(0 to (C_SPLB_NUM_MASTERS-1));
      Sl_MWrErr : out std_logic_vector(0 to (C_SPLB_NUM_MASTERS-1));
      Sl_MRdErr : out std_logic_vector(0 to (C_SPLB_NUM_MASTERS-1));
      Sl_MIRQ : out std_logic_vector(0 to (C_SPLB_NUM_MASTERS-1));
      Dbg_Clk_0 : out std_logic;
      Dbg_TDI_0 : out std_logic;
      Dbg_TDO_0 : in std_logic;
      Dbg_Reg_En_0 : out std_logic_vector(0 to 7);
      Dbg_Capture_0 : out std_logic;
      Dbg_Shift_0 : out std_logic;
      Dbg_Update_0 : out std_logic;
      Dbg_Rst_0 : out std_logic;
      Dbg_Clk_1 : out std_logic;
      Dbg_TDI_1 : out std_logic;
      Dbg_TDO_1 : in std_logic;
      Dbg_Reg_En_1 : out std_logic_vector(0 to 7);
      Dbg_Capture_1 : out std_logic;
      Dbg_Shift_1 : out std_logic;
      Dbg_Update_1 : out std_logic;
      Dbg_Rst_1 : out std_logic;
      Dbg_Clk_2 : out std_logic;
      Dbg_TDI_2 : out std_logic;
      Dbg_TDO_2 : in std_logic;
      Dbg_Reg_En_2 : out std_logic_vector(0 to 7);
      Dbg_Capture_2 : out std_logic;
      Dbg_Shift_2 : out std_logic;
      Dbg_Update_2 : out std_logic;
      Dbg_Rst_2 : out std_logic;
      Dbg_Clk_3 : out std_logic;
      Dbg_TDI_3 : out std_logic;
      Dbg_TDO_3 : in std_logic;
      Dbg_Reg_En_3 : out std_logic_vector(0 to 7);
      Dbg_Capture_3 : out std_logic;
      Dbg_Shift_3 : out std_logic;
      Dbg_Update_3 : out std_logic;
      Dbg_Rst_3 : out std_logic;
      Dbg_Clk_4 : out std_logic;
      Dbg_TDI_4 : out std_logic;
      Dbg_TDO_4 : in std_logic;
      Dbg_Reg_En_4 : out std_logic_vector(0 to 7);
      Dbg_Capture_4 : out std_logic;
      Dbg_Shift_4 : out std_logic;
      Dbg_Update_4 : out std_logic;
      Dbg_Rst_4 : out std_logic;
      Dbg_Clk_5 : out std_logic;
      Dbg_TDI_5 : out std_logic;
      Dbg_TDO_5 : in std_logic;
      Dbg_Reg_En_5 : out std_logic_vector(0 to 7);
      Dbg_Capture_5 : out std_logic;
      Dbg_Shift_5 : out std_logic;
      Dbg_Update_5 : out std_logic;
      Dbg_Rst_5 : out std_logic;
      Dbg_Clk_6 : out std_logic;
      Dbg_TDI_6 : out std_logic;
      Dbg_TDO_6 : in std_logic;
      Dbg_Reg_En_6 : out std_logic_vector(0 to 7);
      Dbg_Capture_6 : out std_logic;
      Dbg_Shift_6 : out std_logic;
      Dbg_Update_6 : out std_logic;
      Dbg_Rst_6 : out std_logic;
      Dbg_Clk_7 : out std_logic;
      Dbg_TDI_7 : out std_logic;
      Dbg_TDO_7 : in std_logic;
      Dbg_Reg_En_7 : out std_logic_vector(0 to 7);
      Dbg_Capture_7 : out std_logic;
      Dbg_Shift_7 : out std_logic;
      Dbg_Update_7 : out std_logic;
      Dbg_Rst_7 : out std_logic;
      Dbg_Clk_8 : out std_logic;
      Dbg_TDI_8 : out std_logic;
      Dbg_TDO_8 : in std_logic;
      Dbg_Reg_En_8 : out std_logic_vector(0 to 7);
      Dbg_Capture_8 : out std_logic;
      Dbg_Shift_8 : out std_logic;
      Dbg_Update_8 : out std_logic;
      Dbg_Rst_8 : out std_logic;
      Dbg_Clk_9 : out std_logic;
      Dbg_TDI_9 : out std_logic;
      Dbg_TDO_9 : in std_logic;
      Dbg_Reg_En_9 : out std_logic_vector(0 to 7);
      Dbg_Capture_9 : out std_logic;
      Dbg_Shift_9 : out std_logic;
      Dbg_Update_9 : out std_logic;
      Dbg_Rst_9 : out std_logic;
      Dbg_Clk_10 : out std_logic;
      Dbg_TDI_10 : out std_logic;
      Dbg_TDO_10 : in std_logic;
      Dbg_Reg_En_10 : out std_logic_vector(0 to 7);
      Dbg_Capture_10 : out std_logic;
      Dbg_Shift_10 : out std_logic;
      Dbg_Update_10 : out std_logic;
      Dbg_Rst_10 : out std_logic;
      Dbg_Clk_11 : out std_logic;
      Dbg_TDI_11 : out std_logic;
      Dbg_TDO_11 : in std_logic;
      Dbg_Reg_En_11 : out std_logic_vector(0 to 7);
      Dbg_Capture_11 : out std_logic;
      Dbg_Shift_11 : out std_logic;
      Dbg_Update_11 : out std_logic;
      Dbg_Rst_11 : out std_logic;
      Dbg_Clk_12 : out std_logic;
      Dbg_TDI_12 : out std_logic;
      Dbg_TDO_12 : in std_logic;
      Dbg_Reg_En_12 : out std_logic_vector(0 to 7);
      Dbg_Capture_12 : out std_logic;
      Dbg_Shift_12 : out std_logic;
      Dbg_Update_12 : out std_logic;
      Dbg_Rst_12 : out std_logic;
      Dbg_Clk_13 : out std_logic;
      Dbg_TDI_13 : out std_logic;
      Dbg_TDO_13 : in std_logic;
      Dbg_Reg_En_13 : out std_logic_vector(0 to 7);
      Dbg_Capture_13 : out std_logic;
      Dbg_Shift_13 : out std_logic;
      Dbg_Update_13 : out std_logic;
      Dbg_Rst_13 : out std_logic;
      Dbg_Clk_14 : out std_logic;
      Dbg_TDI_14 : out std_logic;
      Dbg_TDO_14 : in std_logic;
      Dbg_Reg_En_14 : out std_logic_vector(0 to 7);
      Dbg_Capture_14 : out std_logic;
      Dbg_Shift_14 : out std_logic;
      Dbg_Update_14 : out std_logic;
      Dbg_Rst_14 : out std_logic;
      Dbg_Clk_15 : out std_logic;
      Dbg_TDI_15 : out std_logic;
      Dbg_TDO_15 : in std_logic;
      Dbg_Reg_En_15 : out std_logic_vector(0 to 7);
      Dbg_Capture_15 : out std_logic;
      Dbg_Shift_15 : out std_logic;
      Dbg_Update_15 : out std_logic;
      Dbg_Rst_15 : out std_logic;
      Dbg_Clk_16 : out std_logic;
      Dbg_TDI_16 : out std_logic;
      Dbg_TDO_16 : in std_logic;
      Dbg_Reg_En_16 : out std_logic_vector(0 to 7);
      Dbg_Capture_16 : out std_logic;
      Dbg_Shift_16 : out std_logic;
      Dbg_Update_16 : out std_logic;
      Dbg_Rst_16 : out std_logic;
      Dbg_Clk_17 : out std_logic;
      Dbg_TDI_17 : out std_logic;
      Dbg_TDO_17 : in std_logic;
      Dbg_Reg_En_17 : out std_logic_vector(0 to 7);
      Dbg_Capture_17 : out std_logic;
      Dbg_Shift_17 : out std_logic;
      Dbg_Update_17 : out std_logic;
      Dbg_Rst_17 : out std_logic;
      Dbg_Clk_18 : out std_logic;
      Dbg_TDI_18 : out std_logic;
      Dbg_TDO_18 : in std_logic;
      Dbg_Reg_En_18 : out std_logic_vector(0 to 7);
      Dbg_Capture_18 : out std_logic;
      Dbg_Shift_18 : out std_logic;
      Dbg_Update_18 : out std_logic;
      Dbg_Rst_18 : out std_logic;
      Dbg_Clk_19 : out std_logic;
      Dbg_TDI_19 : out std_logic;
      Dbg_TDO_19 : in std_logic;
      Dbg_Reg_En_19 : out std_logic_vector(0 to 7);
      Dbg_Capture_19 : out std_logic;
      Dbg_Shift_19 : out std_logic;
      Dbg_Update_19 : out std_logic;
      Dbg_Rst_19 : out std_logic;
      Dbg_Clk_20 : out std_logic;
      Dbg_TDI_20 : out std_logic;
      Dbg_TDO_20 : in std_logic;
      Dbg_Reg_En_20 : out std_logic_vector(0 to 7);
      Dbg_Capture_20 : out std_logic;
      Dbg_Shift_20 : out std_logic;
      Dbg_Update_20 : out std_logic;
      Dbg_Rst_20 : out std_logic;
      Dbg_Clk_21 : out std_logic;
      Dbg_TDI_21 : out std_logic;
      Dbg_TDO_21 : in std_logic;
      Dbg_Reg_En_21 : out std_logic_vector(0 to 7);
      Dbg_Capture_21 : out std_logic;
      Dbg_Shift_21 : out std_logic;
      Dbg_Update_21 : out std_logic;
      Dbg_Rst_21 : out std_logic;
      Dbg_Clk_22 : out std_logic;
      Dbg_TDI_22 : out std_logic;
      Dbg_TDO_22 : in std_logic;
      Dbg_Reg_En_22 : out std_logic_vector(0 to 7);
      Dbg_Capture_22 : out std_logic;
      Dbg_Shift_22 : out std_logic;
      Dbg_Update_22 : out std_logic;
      Dbg_Rst_22 : out std_logic;
      Dbg_Clk_23 : out std_logic;
      Dbg_TDI_23 : out std_logic;
      Dbg_TDO_23 : in std_logic;
      Dbg_Reg_En_23 : out std_logic_vector(0 to 7);
      Dbg_Capture_23 : out std_logic;
      Dbg_Shift_23 : out std_logic;
      Dbg_Update_23 : out std_logic;
      Dbg_Rst_23 : out std_logic;
      Dbg_Clk_24 : out std_logic;
      Dbg_TDI_24 : out std_logic;
      Dbg_TDO_24 : in std_logic;
      Dbg_Reg_En_24 : out std_logic_vector(0 to 7);
      Dbg_Capture_24 : out std_logic;
      Dbg_Shift_24 : out std_logic;
      Dbg_Update_24 : out std_logic;
      Dbg_Rst_24 : out std_logic;
      Dbg_Clk_25 : out std_logic;
      Dbg_TDI_25 : out std_logic;
      Dbg_TDO_25 : in std_logic;
      Dbg_Reg_En_25 : out std_logic_vector(0 to 7);
      Dbg_Capture_25 : out std_logic;
      Dbg_Shift_25 : out std_logic;
      Dbg_Update_25 : out std_logic;
      Dbg_Rst_25 : out std_logic;
      Dbg_Clk_26 : out std_logic;
      Dbg_TDI_26 : out std_logic;
      Dbg_TDO_26 : in std_logic;
      Dbg_Reg_En_26 : out std_logic_vector(0 to 7);
      Dbg_Capture_26 : out std_logic;
      Dbg_Shift_26 : out std_logic;
      Dbg_Update_26 : out std_logic;
      Dbg_Rst_26 : out std_logic;
      Dbg_Clk_27 : out std_logic;
      Dbg_TDI_27 : out std_logic;
      Dbg_TDO_27 : in std_logic;
      Dbg_Reg_En_27 : out std_logic_vector(0 to 7);
      Dbg_Capture_27 : out std_logic;
      Dbg_Shift_27 : out std_logic;
      Dbg_Update_27 : out std_logic;
      Dbg_Rst_27 : out std_logic;
      Dbg_Clk_28 : out std_logic;
      Dbg_TDI_28 : out std_logic;
      Dbg_TDO_28 : in std_logic;
      Dbg_Reg_En_28 : out std_logic_vector(0 to 7);
      Dbg_Capture_28 : out std_logic;
      Dbg_Shift_28 : out std_logic;
      Dbg_Update_28 : out std_logic;
      Dbg_Rst_28 : out std_logic;
      Dbg_Clk_29 : out std_logic;
      Dbg_TDI_29 : out std_logic;
      Dbg_TDO_29 : in std_logic;
      Dbg_Reg_En_29 : out std_logic_vector(0 to 7);
      Dbg_Capture_29 : out std_logic;
      Dbg_Shift_29 : out std_logic;
      Dbg_Update_29 : out std_logic;
      Dbg_Rst_29 : out std_logic;
      Dbg_Clk_30 : out std_logic;
      Dbg_TDI_30 : out std_logic;
      Dbg_TDO_30 : in std_logic;
      Dbg_Reg_En_30 : out std_logic_vector(0 to 7);
      Dbg_Capture_30 : out std_logic;
      Dbg_Shift_30 : out std_logic;
      Dbg_Update_30 : out std_logic;
      Dbg_Rst_30 : out std_logic;
      Dbg_Clk_31 : out std_logic;
      Dbg_TDI_31 : out std_logic;
      Dbg_TDO_31 : in std_logic;
      Dbg_Reg_En_31 : out std_logic_vector(0 to 7);
      Dbg_Capture_31 : out std_logic;
      Dbg_Shift_31 : out std_logic;
      Dbg_Update_31 : out std_logic;
      Dbg_Rst_31 : out std_logic;
      bscan_tdi : out std_logic;
      bscan_reset : out std_logic;
      bscan_shift : out std_logic;
      bscan_update : out std_logic;
      bscan_capture : out std_logic;
      bscan_sel1 : out std_logic;
      bscan_drck1 : out std_logic;
      bscan_tdo1 : in std_logic;
      bscan_ext_tdi : in std_logic;
      bscan_ext_reset : in std_logic;
      bscan_ext_shift : in std_logic;
      bscan_ext_update : in std_logic;
      bscan_ext_capture : in std_logic;
      bscan_ext_sel : in std_logic;
      bscan_ext_drck : in std_logic;
      bscan_ext_tdo : out std_logic;
      Ext_JTAG_DRCK : out std_logic;
      Ext_JTAG_RESET : out std_logic;
      Ext_JTAG_SEL : out std_logic;
      Ext_JTAG_CAPTURE : out std_logic;
      Ext_JTAG_SHIFT : out std_logic;
      Ext_JTAG_UPDATE : out std_logic;
      Ext_JTAG_TDI : out std_logic;
      Ext_JTAG_TDO : in std_logic
    );
  end component;

begin

  debug_module : mdm
    generic map (
      C_FAMILY => "spartan6",
      C_JTAG_CHAIN => 2,
      C_INTERCONNECT => 2,
      C_BASEADDR => X"41400000",
      C_HIGHADDR => X"4140ffff",
      C_SPLB_AWIDTH => 32,
      C_SPLB_DWIDTH => 32,
      C_SPLB_P2P => 0,
      C_SPLB_MID_WIDTH => 3,
      C_SPLB_NUM_MASTERS => 8,
      C_SPLB_NATIVE_DWIDTH => 32,
      C_SPLB_SUPPORT_BURSTS => 0,
      C_MB_DBG_PORTS => 1,
      C_USE_UART => 1,
      C_USE_BSCAN => 0,
      C_S_AXI_ADDR_WIDTH => 32,
      C_S_AXI_DATA_WIDTH => 32
    )
    port map (
      Interrupt => Interrupt,
      Debug_SYS_Rst => Debug_SYS_Rst,
      Ext_BRK => Ext_BRK,
      Ext_NM_BRK => Ext_NM_BRK,
      S_AXI_ACLK => S_AXI_ACLK,
      S_AXI_ARESETN => S_AXI_ARESETN,
      S_AXI_AWADDR => S_AXI_AWADDR,
      S_AXI_AWVALID => S_AXI_AWVALID,
      S_AXI_AWREADY => S_AXI_AWREADY,
      S_AXI_WDATA => S_AXI_WDATA,
      S_AXI_WSTRB => S_AXI_WSTRB,
      S_AXI_WVALID => S_AXI_WVALID,
      S_AXI_WREADY => S_AXI_WREADY,
      S_AXI_BRESP => S_AXI_BRESP,
      S_AXI_BVALID => S_AXI_BVALID,
      S_AXI_BREADY => S_AXI_BREADY,
      S_AXI_ARADDR => S_AXI_ARADDR,
      S_AXI_ARVALID => S_AXI_ARVALID,
      S_AXI_ARREADY => S_AXI_ARREADY,
      S_AXI_RDATA => S_AXI_RDATA,
      S_AXI_RRESP => S_AXI_RRESP,
      S_AXI_RVALID => S_AXI_RVALID,
      S_AXI_RREADY => S_AXI_RREADY,
      SPLB_Clk => SPLB_Clk,
      SPLB_Rst => SPLB_Rst,
      PLB_ABus => PLB_ABus,
      PLB_UABus => PLB_UABus,
      PLB_PAValid => PLB_PAValid,
      PLB_SAValid => PLB_SAValid,
      PLB_rdPrim => PLB_rdPrim,
      PLB_wrPrim => PLB_wrPrim,
      PLB_masterID => PLB_masterID,
      PLB_abort => PLB_abort,
      PLB_busLock => PLB_busLock,
      PLB_RNW => PLB_RNW,
      PLB_BE => PLB_BE,
      PLB_MSize => PLB_MSize,
      PLB_size => PLB_size,
      PLB_type => PLB_type,
      PLB_lockErr => PLB_lockErr,
      PLB_wrDBus => PLB_wrDBus,
      PLB_wrBurst => PLB_wrBurst,
      PLB_rdBurst => PLB_rdBurst,
      PLB_wrPendReq => PLB_wrPendReq,
      PLB_rdPendReq => PLB_rdPendReq,
      PLB_wrPendPri => PLB_wrPendPri,
      PLB_rdPendPri => PLB_rdPendPri,
      PLB_reqPri => PLB_reqPri,
      PLB_TAttribute => PLB_TAttribute,
      Sl_addrAck => Sl_addrAck,
      Sl_SSize => Sl_SSize,
      Sl_wait => Sl_wait,
      Sl_rearbitrate => Sl_rearbitrate,
      Sl_wrDAck => Sl_wrDAck,
      Sl_wrComp => Sl_wrComp,
      Sl_wrBTerm => Sl_wrBTerm,
      Sl_rdDBus => Sl_rdDBus,
      Sl_rdWdAddr => Sl_rdWdAddr,
      Sl_rdDAck => Sl_rdDAck,
      Sl_rdComp => Sl_rdComp,
      Sl_rdBTerm => Sl_rdBTerm,
      Sl_MBusy => Sl_MBusy,
      Sl_MWrErr => Sl_MWrErr,
      Sl_MRdErr => Sl_MRdErr,
      Sl_MIRQ => Sl_MIRQ,
      Dbg_Clk_0 => Dbg_Clk_0,
      Dbg_TDI_0 => Dbg_TDI_0,
      Dbg_TDO_0 => Dbg_TDO_0,
      Dbg_Reg_En_0 => Dbg_Reg_En_0,
      Dbg_Capture_0 => Dbg_Capture_0,
      Dbg_Shift_0 => Dbg_Shift_0,
      Dbg_Update_0 => Dbg_Update_0,
      Dbg_Rst_0 => Dbg_Rst_0,
      Dbg_Clk_1 => Dbg_Clk_1,
      Dbg_TDI_1 => Dbg_TDI_1,
      Dbg_TDO_1 => Dbg_TDO_1,
      Dbg_Reg_En_1 => Dbg_Reg_En_1,
      Dbg_Capture_1 => Dbg_Capture_1,
      Dbg_Shift_1 => Dbg_Shift_1,
      Dbg_Update_1 => Dbg_Update_1,
      Dbg_Rst_1 => Dbg_Rst_1,
      Dbg_Clk_2 => Dbg_Clk_2,
      Dbg_TDI_2 => Dbg_TDI_2,
      Dbg_TDO_2 => Dbg_TDO_2,
      Dbg_Reg_En_2 => Dbg_Reg_En_2,
      Dbg_Capture_2 => Dbg_Capture_2,
      Dbg_Shift_2 => Dbg_Shift_2,
      Dbg_Update_2 => Dbg_Update_2,
      Dbg_Rst_2 => Dbg_Rst_2,
      Dbg_Clk_3 => Dbg_Clk_3,
      Dbg_TDI_3 => Dbg_TDI_3,
      Dbg_TDO_3 => Dbg_TDO_3,
      Dbg_Reg_En_3 => Dbg_Reg_En_3,
      Dbg_Capture_3 => Dbg_Capture_3,
      Dbg_Shift_3 => Dbg_Shift_3,
      Dbg_Update_3 => Dbg_Update_3,
      Dbg_Rst_3 => Dbg_Rst_3,
      Dbg_Clk_4 => Dbg_Clk_4,
      Dbg_TDI_4 => Dbg_TDI_4,
      Dbg_TDO_4 => Dbg_TDO_4,
      Dbg_Reg_En_4 => Dbg_Reg_En_4,
      Dbg_Capture_4 => Dbg_Capture_4,
      Dbg_Shift_4 => Dbg_Shift_4,
      Dbg_Update_4 => Dbg_Update_4,
      Dbg_Rst_4 => Dbg_Rst_4,
      Dbg_Clk_5 => Dbg_Clk_5,
      Dbg_TDI_5 => Dbg_TDI_5,
      Dbg_TDO_5 => Dbg_TDO_5,
      Dbg_Reg_En_5 => Dbg_Reg_En_5,
      Dbg_Capture_5 => Dbg_Capture_5,
      Dbg_Shift_5 => Dbg_Shift_5,
      Dbg_Update_5 => Dbg_Update_5,
      Dbg_Rst_5 => Dbg_Rst_5,
      Dbg_Clk_6 => Dbg_Clk_6,
      Dbg_TDI_6 => Dbg_TDI_6,
      Dbg_TDO_6 => Dbg_TDO_6,
      Dbg_Reg_En_6 => Dbg_Reg_En_6,
      Dbg_Capture_6 => Dbg_Capture_6,
      Dbg_Shift_6 => Dbg_Shift_6,
      Dbg_Update_6 => Dbg_Update_6,
      Dbg_Rst_6 => Dbg_Rst_6,
      Dbg_Clk_7 => Dbg_Clk_7,
      Dbg_TDI_7 => Dbg_TDI_7,
      Dbg_TDO_7 => Dbg_TDO_7,
      Dbg_Reg_En_7 => Dbg_Reg_En_7,
      Dbg_Capture_7 => Dbg_Capture_7,
      Dbg_Shift_7 => Dbg_Shift_7,
      Dbg_Update_7 => Dbg_Update_7,
      Dbg_Rst_7 => Dbg_Rst_7,
      Dbg_Clk_8 => Dbg_Clk_8,
      Dbg_TDI_8 => Dbg_TDI_8,
      Dbg_TDO_8 => Dbg_TDO_8,
      Dbg_Reg_En_8 => Dbg_Reg_En_8,
      Dbg_Capture_8 => Dbg_Capture_8,
      Dbg_Shift_8 => Dbg_Shift_8,
      Dbg_Update_8 => Dbg_Update_8,
      Dbg_Rst_8 => Dbg_Rst_8,
      Dbg_Clk_9 => Dbg_Clk_9,
      Dbg_TDI_9 => Dbg_TDI_9,
      Dbg_TDO_9 => Dbg_TDO_9,
      Dbg_Reg_En_9 => Dbg_Reg_En_9,
      Dbg_Capture_9 => Dbg_Capture_9,
      Dbg_Shift_9 => Dbg_Shift_9,
      Dbg_Update_9 => Dbg_Update_9,
      Dbg_Rst_9 => Dbg_Rst_9,
      Dbg_Clk_10 => Dbg_Clk_10,
      Dbg_TDI_10 => Dbg_TDI_10,
      Dbg_TDO_10 => Dbg_TDO_10,
      Dbg_Reg_En_10 => Dbg_Reg_En_10,
      Dbg_Capture_10 => Dbg_Capture_10,
      Dbg_Shift_10 => Dbg_Shift_10,
      Dbg_Update_10 => Dbg_Update_10,
      Dbg_Rst_10 => Dbg_Rst_10,
      Dbg_Clk_11 => Dbg_Clk_11,
      Dbg_TDI_11 => Dbg_TDI_11,
      Dbg_TDO_11 => Dbg_TDO_11,
      Dbg_Reg_En_11 => Dbg_Reg_En_11,
      Dbg_Capture_11 => Dbg_Capture_11,
      Dbg_Shift_11 => Dbg_Shift_11,
      Dbg_Update_11 => Dbg_Update_11,
      Dbg_Rst_11 => Dbg_Rst_11,
      Dbg_Clk_12 => Dbg_Clk_12,
      Dbg_TDI_12 => Dbg_TDI_12,
      Dbg_TDO_12 => Dbg_TDO_12,
      Dbg_Reg_En_12 => Dbg_Reg_En_12,
      Dbg_Capture_12 => Dbg_Capture_12,
      Dbg_Shift_12 => Dbg_Shift_12,
      Dbg_Update_12 => Dbg_Update_12,
      Dbg_Rst_12 => Dbg_Rst_12,
      Dbg_Clk_13 => Dbg_Clk_13,
      Dbg_TDI_13 => Dbg_TDI_13,
      Dbg_TDO_13 => Dbg_TDO_13,
      Dbg_Reg_En_13 => Dbg_Reg_En_13,
      Dbg_Capture_13 => Dbg_Capture_13,
      Dbg_Shift_13 => Dbg_Shift_13,
      Dbg_Update_13 => Dbg_Update_13,
      Dbg_Rst_13 => Dbg_Rst_13,
      Dbg_Clk_14 => Dbg_Clk_14,
      Dbg_TDI_14 => Dbg_TDI_14,
      Dbg_TDO_14 => Dbg_TDO_14,
      Dbg_Reg_En_14 => Dbg_Reg_En_14,
      Dbg_Capture_14 => Dbg_Capture_14,
      Dbg_Shift_14 => Dbg_Shift_14,
      Dbg_Update_14 => Dbg_Update_14,
      Dbg_Rst_14 => Dbg_Rst_14,
      Dbg_Clk_15 => Dbg_Clk_15,
      Dbg_TDI_15 => Dbg_TDI_15,
      Dbg_TDO_15 => Dbg_TDO_15,
      Dbg_Reg_En_15 => Dbg_Reg_En_15,
      Dbg_Capture_15 => Dbg_Capture_15,
      Dbg_Shift_15 => Dbg_Shift_15,
      Dbg_Update_15 => Dbg_Update_15,
      Dbg_Rst_15 => Dbg_Rst_15,
      Dbg_Clk_16 => Dbg_Clk_16,
      Dbg_TDI_16 => Dbg_TDI_16,
      Dbg_TDO_16 => Dbg_TDO_16,
      Dbg_Reg_En_16 => Dbg_Reg_En_16,
      Dbg_Capture_16 => Dbg_Capture_16,
      Dbg_Shift_16 => Dbg_Shift_16,
      Dbg_Update_16 => Dbg_Update_16,
      Dbg_Rst_16 => Dbg_Rst_16,
      Dbg_Clk_17 => Dbg_Clk_17,
      Dbg_TDI_17 => Dbg_TDI_17,
      Dbg_TDO_17 => Dbg_TDO_17,
      Dbg_Reg_En_17 => Dbg_Reg_En_17,
      Dbg_Capture_17 => Dbg_Capture_17,
      Dbg_Shift_17 => Dbg_Shift_17,
      Dbg_Update_17 => Dbg_Update_17,
      Dbg_Rst_17 => Dbg_Rst_17,
      Dbg_Clk_18 => Dbg_Clk_18,
      Dbg_TDI_18 => Dbg_TDI_18,
      Dbg_TDO_18 => Dbg_TDO_18,
      Dbg_Reg_En_18 => Dbg_Reg_En_18,
      Dbg_Capture_18 => Dbg_Capture_18,
      Dbg_Shift_18 => Dbg_Shift_18,
      Dbg_Update_18 => Dbg_Update_18,
      Dbg_Rst_18 => Dbg_Rst_18,
      Dbg_Clk_19 => Dbg_Clk_19,
      Dbg_TDI_19 => Dbg_TDI_19,
      Dbg_TDO_19 => Dbg_TDO_19,
      Dbg_Reg_En_19 => Dbg_Reg_En_19,
      Dbg_Capture_19 => Dbg_Capture_19,
      Dbg_Shift_19 => Dbg_Shift_19,
      Dbg_Update_19 => Dbg_Update_19,
      Dbg_Rst_19 => Dbg_Rst_19,
      Dbg_Clk_20 => Dbg_Clk_20,
      Dbg_TDI_20 => Dbg_TDI_20,
      Dbg_TDO_20 => Dbg_TDO_20,
      Dbg_Reg_En_20 => Dbg_Reg_En_20,
      Dbg_Capture_20 => Dbg_Capture_20,
      Dbg_Shift_20 => Dbg_Shift_20,
      Dbg_Update_20 => Dbg_Update_20,
      Dbg_Rst_20 => Dbg_Rst_20,
      Dbg_Clk_21 => Dbg_Clk_21,
      Dbg_TDI_21 => Dbg_TDI_21,
      Dbg_TDO_21 => Dbg_TDO_21,
      Dbg_Reg_En_21 => Dbg_Reg_En_21,
      Dbg_Capture_21 => Dbg_Capture_21,
      Dbg_Shift_21 => Dbg_Shift_21,
      Dbg_Update_21 => Dbg_Update_21,
      Dbg_Rst_21 => Dbg_Rst_21,
      Dbg_Clk_22 => Dbg_Clk_22,
      Dbg_TDI_22 => Dbg_TDI_22,
      Dbg_TDO_22 => Dbg_TDO_22,
      Dbg_Reg_En_22 => Dbg_Reg_En_22,
      Dbg_Capture_22 => Dbg_Capture_22,
      Dbg_Shift_22 => Dbg_Shift_22,
      Dbg_Update_22 => Dbg_Update_22,
      Dbg_Rst_22 => Dbg_Rst_22,
      Dbg_Clk_23 => Dbg_Clk_23,
      Dbg_TDI_23 => Dbg_TDI_23,
      Dbg_TDO_23 => Dbg_TDO_23,
      Dbg_Reg_En_23 => Dbg_Reg_En_23,
      Dbg_Capture_23 => Dbg_Capture_23,
      Dbg_Shift_23 => Dbg_Shift_23,
      Dbg_Update_23 => Dbg_Update_23,
      Dbg_Rst_23 => Dbg_Rst_23,
      Dbg_Clk_24 => Dbg_Clk_24,
      Dbg_TDI_24 => Dbg_TDI_24,
      Dbg_TDO_24 => Dbg_TDO_24,
      Dbg_Reg_En_24 => Dbg_Reg_En_24,
      Dbg_Capture_24 => Dbg_Capture_24,
      Dbg_Shift_24 => Dbg_Shift_24,
      Dbg_Update_24 => Dbg_Update_24,
      Dbg_Rst_24 => Dbg_Rst_24,
      Dbg_Clk_25 => Dbg_Clk_25,
      Dbg_TDI_25 => Dbg_TDI_25,
      Dbg_TDO_25 => Dbg_TDO_25,
      Dbg_Reg_En_25 => Dbg_Reg_En_25,
      Dbg_Capture_25 => Dbg_Capture_25,
      Dbg_Shift_25 => Dbg_Shift_25,
      Dbg_Update_25 => Dbg_Update_25,
      Dbg_Rst_25 => Dbg_Rst_25,
      Dbg_Clk_26 => Dbg_Clk_26,
      Dbg_TDI_26 => Dbg_TDI_26,
      Dbg_TDO_26 => Dbg_TDO_26,
      Dbg_Reg_En_26 => Dbg_Reg_En_26,
      Dbg_Capture_26 => Dbg_Capture_26,
      Dbg_Shift_26 => Dbg_Shift_26,
      Dbg_Update_26 => Dbg_Update_26,
      Dbg_Rst_26 => Dbg_Rst_26,
      Dbg_Clk_27 => Dbg_Clk_27,
      Dbg_TDI_27 => Dbg_TDI_27,
      Dbg_TDO_27 => Dbg_TDO_27,
      Dbg_Reg_En_27 => Dbg_Reg_En_27,
      Dbg_Capture_27 => Dbg_Capture_27,
      Dbg_Shift_27 => Dbg_Shift_27,
      Dbg_Update_27 => Dbg_Update_27,
      Dbg_Rst_27 => Dbg_Rst_27,
      Dbg_Clk_28 => Dbg_Clk_28,
      Dbg_TDI_28 => Dbg_TDI_28,
      Dbg_TDO_28 => Dbg_TDO_28,
      Dbg_Reg_En_28 => Dbg_Reg_En_28,
      Dbg_Capture_28 => Dbg_Capture_28,
      Dbg_Shift_28 => Dbg_Shift_28,
      Dbg_Update_28 => Dbg_Update_28,
      Dbg_Rst_28 => Dbg_Rst_28,
      Dbg_Clk_29 => Dbg_Clk_29,
      Dbg_TDI_29 => Dbg_TDI_29,
      Dbg_TDO_29 => Dbg_TDO_29,
      Dbg_Reg_En_29 => Dbg_Reg_En_29,
      Dbg_Capture_29 => Dbg_Capture_29,
      Dbg_Shift_29 => Dbg_Shift_29,
      Dbg_Update_29 => Dbg_Update_29,
      Dbg_Rst_29 => Dbg_Rst_29,
      Dbg_Clk_30 => Dbg_Clk_30,
      Dbg_TDI_30 => Dbg_TDI_30,
      Dbg_TDO_30 => Dbg_TDO_30,
      Dbg_Reg_En_30 => Dbg_Reg_En_30,
      Dbg_Capture_30 => Dbg_Capture_30,
      Dbg_Shift_30 => Dbg_Shift_30,
      Dbg_Update_30 => Dbg_Update_30,
      Dbg_Rst_30 => Dbg_Rst_30,
      Dbg_Clk_31 => Dbg_Clk_31,
      Dbg_TDI_31 => Dbg_TDI_31,
      Dbg_TDO_31 => Dbg_TDO_31,
      Dbg_Reg_En_31 => Dbg_Reg_En_31,
      Dbg_Capture_31 => Dbg_Capture_31,
      Dbg_Shift_31 => Dbg_Shift_31,
      Dbg_Update_31 => Dbg_Update_31,
      Dbg_Rst_31 => Dbg_Rst_31,
      bscan_tdi => bscan_tdi,
      bscan_reset => bscan_reset,
      bscan_shift => bscan_shift,
      bscan_update => bscan_update,
      bscan_capture => bscan_capture,
      bscan_sel1 => bscan_sel1,
      bscan_drck1 => bscan_drck1,
      bscan_tdo1 => bscan_tdo1,
      bscan_ext_tdi => bscan_ext_tdi,
      bscan_ext_reset => bscan_ext_reset,
      bscan_ext_shift => bscan_ext_shift,
      bscan_ext_update => bscan_ext_update,
      bscan_ext_capture => bscan_ext_capture,
      bscan_ext_sel => bscan_ext_sel,
      bscan_ext_drck => bscan_ext_drck,
      bscan_ext_tdo => bscan_ext_tdo,
      Ext_JTAG_DRCK => Ext_JTAG_DRCK,
      Ext_JTAG_RESET => Ext_JTAG_RESET,
      Ext_JTAG_SEL => Ext_JTAG_SEL,
      Ext_JTAG_CAPTURE => Ext_JTAG_CAPTURE,
      Ext_JTAG_SHIFT => Ext_JTAG_SHIFT,
      Ext_JTAG_UPDATE => Ext_JTAG_UPDATE,
      Ext_JTAG_TDI => Ext_JTAG_TDI,
      Ext_JTAG_TDO => Ext_JTAG_TDO
    );

end architecture STRUCTURE;

