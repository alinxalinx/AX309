-------------------------------------------------------------------------------
-- system_microblaze_0_i_bram_ctrl_wrapper.vhd
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

library lmb_bram_if_cntlr_v3_10_c;
use lmb_bram_if_cntlr_v3_10_c.all;

entity system_microblaze_0_i_bram_ctrl_wrapper is
  port (
    LMB_Clk : in std_logic;
    LMB_Rst : in std_logic;
    LMB_ABus : in std_logic_vector(0 to 31);
    LMB_WriteDBus : in std_logic_vector(0 to 31);
    LMB_AddrStrobe : in std_logic;
    LMB_ReadStrobe : in std_logic;
    LMB_WriteStrobe : in std_logic;
    LMB_BE : in std_logic_vector(0 to 3);
    Sl_DBus : out std_logic_vector(0 to 31);
    Sl_Ready : out std_logic;
    Sl_Wait : out std_logic;
    Sl_UE : out std_logic;
    Sl_CE : out std_logic;
    LMB1_ABus : in std_logic_vector(0 to 31);
    LMB1_WriteDBus : in std_logic_vector(0 to 31);
    LMB1_AddrStrobe : in std_logic;
    LMB1_ReadStrobe : in std_logic;
    LMB1_WriteStrobe : in std_logic;
    LMB1_BE : in std_logic_vector(0 to 3);
    Sl1_DBus : out std_logic_vector(0 to 31);
    Sl1_Ready : out std_logic;
    Sl1_Wait : out std_logic;
    Sl1_UE : out std_logic;
    Sl1_CE : out std_logic;
    LMB2_ABus : in std_logic_vector(0 to 31);
    LMB2_WriteDBus : in std_logic_vector(0 to 31);
    LMB2_AddrStrobe : in std_logic;
    LMB2_ReadStrobe : in std_logic;
    LMB2_WriteStrobe : in std_logic;
    LMB2_BE : in std_logic_vector(0 to 3);
    Sl2_DBus : out std_logic_vector(0 to 31);
    Sl2_Ready : out std_logic;
    Sl2_Wait : out std_logic;
    Sl2_UE : out std_logic;
    Sl2_CE : out std_logic;
    LMB3_ABus : in std_logic_vector(0 to 31);
    LMB3_WriteDBus : in std_logic_vector(0 to 31);
    LMB3_AddrStrobe : in std_logic;
    LMB3_ReadStrobe : in std_logic;
    LMB3_WriteStrobe : in std_logic;
    LMB3_BE : in std_logic_vector(0 to 3);
    Sl3_DBus : out std_logic_vector(0 to 31);
    Sl3_Ready : out std_logic;
    Sl3_Wait : out std_logic;
    Sl3_UE : out std_logic;
    Sl3_CE : out std_logic;
    BRAM_Rst_A : out std_logic;
    BRAM_Clk_A : out std_logic;
    BRAM_EN_A : out std_logic;
    BRAM_WEN_A : out std_logic_vector(0 to 3);
    BRAM_Addr_A : out std_logic_vector(0 to 31);
    BRAM_Din_A : in std_logic_vector(0 to 31);
    BRAM_Dout_A : out std_logic_vector(0 to 31);
    Interrupt : out std_logic;
    UE : out std_logic;
    CE : out std_logic;
    SPLB_CTRL_PLB_ABus : in std_logic_vector(0 to 31);
    SPLB_CTRL_PLB_PAValid : in std_logic;
    SPLB_CTRL_PLB_masterID : in std_logic_vector(0 to 0);
    SPLB_CTRL_PLB_RNW : in std_logic;
    SPLB_CTRL_PLB_BE : in std_logic_vector(0 to 3);
    SPLB_CTRL_PLB_size : in std_logic_vector(0 to 3);
    SPLB_CTRL_PLB_type : in std_logic_vector(0 to 2);
    SPLB_CTRL_PLB_wrDBus : in std_logic_vector(0 to 31);
    SPLB_CTRL_Sl_addrAck : out std_logic;
    SPLB_CTRL_Sl_SSize : out std_logic_vector(0 to 1);
    SPLB_CTRL_Sl_wait : out std_logic;
    SPLB_CTRL_Sl_rearbitrate : out std_logic;
    SPLB_CTRL_Sl_wrDAck : out std_logic;
    SPLB_CTRL_Sl_wrComp : out std_logic;
    SPLB_CTRL_Sl_rdDBus : out std_logic_vector(0 to 31);
    SPLB_CTRL_Sl_rdDAck : out std_logic;
    SPLB_CTRL_Sl_rdComp : out std_logic;
    SPLB_CTRL_Sl_MBusy : out std_logic_vector(0 to 0);
    SPLB_CTRL_Sl_MWrErr : out std_logic_vector(0 to 0);
    SPLB_CTRL_Sl_MRdErr : out std_logic_vector(0 to 0);
    SPLB_CTRL_PLB_UABus : in std_logic_vector(0 to 31);
    SPLB_CTRL_PLB_SAValid : in std_logic;
    SPLB_CTRL_PLB_rdPrim : in std_logic;
    SPLB_CTRL_PLB_wrPrim : in std_logic;
    SPLB_CTRL_PLB_abort : in std_logic;
    SPLB_CTRL_PLB_busLock : in std_logic;
    SPLB_CTRL_PLB_MSize : in std_logic_vector(0 to 1);
    SPLB_CTRL_PLB_lockErr : in std_logic;
    SPLB_CTRL_PLB_wrBurst : in std_logic;
    SPLB_CTRL_PLB_rdBurst : in std_logic;
    SPLB_CTRL_PLB_wrPendReq : in std_logic;
    SPLB_CTRL_PLB_rdPendReq : in std_logic;
    SPLB_CTRL_PLB_wrPendPri : in std_logic_vector(0 to 1);
    SPLB_CTRL_PLB_rdPendPri : in std_logic_vector(0 to 1);
    SPLB_CTRL_PLB_reqPri : in std_logic_vector(0 to 1);
    SPLB_CTRL_PLB_TAttribute : in std_logic_vector(0 to 15);
    SPLB_CTRL_Sl_wrBTerm : out std_logic;
    SPLB_CTRL_Sl_rdWdAddr : out std_logic_vector(0 to 3);
    SPLB_CTRL_Sl_rdBTerm : out std_logic;
    SPLB_CTRL_Sl_MIRQ : out std_logic_vector(0 to 0);
    S_AXI_CTRL_ACLK : in std_logic;
    S_AXI_CTRL_ARESETN : in std_logic;
    S_AXI_CTRL_AWADDR : in std_logic_vector(31 downto 0);
    S_AXI_CTRL_AWVALID : in std_logic;
    S_AXI_CTRL_AWREADY : out std_logic;
    S_AXI_CTRL_WDATA : in std_logic_vector(31 downto 0);
    S_AXI_CTRL_WSTRB : in std_logic_vector(3 downto 0);
    S_AXI_CTRL_WVALID : in std_logic;
    S_AXI_CTRL_WREADY : out std_logic;
    S_AXI_CTRL_BRESP : out std_logic_vector(1 downto 0);
    S_AXI_CTRL_BVALID : out std_logic;
    S_AXI_CTRL_BREADY : in std_logic;
    S_AXI_CTRL_ARADDR : in std_logic_vector(31 downto 0);
    S_AXI_CTRL_ARVALID : in std_logic;
    S_AXI_CTRL_ARREADY : out std_logic;
    S_AXI_CTRL_RDATA : out std_logic_vector(31 downto 0);
    S_AXI_CTRL_RRESP : out std_logic_vector(1 downto 0);
    S_AXI_CTRL_RVALID : out std_logic;
    S_AXI_CTRL_RREADY : in std_logic
  );

  attribute x_core_info : STRING;
  attribute x_core_info of system_microblaze_0_i_bram_ctrl_wrapper : entity is "lmb_bram_if_cntlr_v3_10_c";

end system_microblaze_0_i_bram_ctrl_wrapper;

architecture STRUCTURE of system_microblaze_0_i_bram_ctrl_wrapper is

  component lmb_bram_if_cntlr is
    generic (
      C_BASEADDR : std_logic_vector(0 to 31);
      C_HIGHADDR : std_logic_vector(0 to 31);
      C_FAMILY : string;
      C_MASK : std_logic_vector(0 to 31);
      C_MASK1 : std_logic_vector(0 to 31);
      C_MASK2 : std_logic_vector(0 to 31);
      C_MASK3 : std_logic_vector(0 to 31);
      C_LMB_AWIDTH : integer;
      C_LMB_DWIDTH : integer;
      C_ECC : integer;
      C_INTERCONNECT : integer;
      C_FAULT_INJECT : integer;
      C_CE_FAILING_REGISTERS : integer;
      C_UE_FAILING_REGISTERS : integer;
      C_ECC_STATUS_REGISTERS : integer;
      C_ECC_ONOFF_REGISTER : integer;
      C_ECC_ONOFF_RESET_VALUE : integer;
      C_CE_COUNTER_WIDTH : integer;
      C_WRITE_ACCESS : integer;
      C_NUM_LMB : integer;
      C_SPLB_CTRL_BASEADDR : std_logic_vector;
      C_SPLB_CTRL_HIGHADDR : std_logic_vector;
      C_SPLB_CTRL_AWIDTH : INTEGER;
      C_SPLB_CTRL_DWIDTH : INTEGER;
      C_SPLB_CTRL_P2P : INTEGER;
      C_SPLB_CTRL_MID_WIDTH : INTEGER;
      C_SPLB_CTRL_NUM_MASTERS : INTEGER;
      C_SPLB_CTRL_SUPPORT_BURSTS : INTEGER;
      C_SPLB_CTRL_NATIVE_DWIDTH : INTEGER;
      C_S_AXI_CTRL_BASEADDR : std_logic_vector(31 downto 0);
      C_S_AXI_CTRL_HIGHADDR : std_logic_vector(31 downto 0);
      C_S_AXI_CTRL_ADDR_WIDTH : INTEGER;
      C_S_AXI_CTRL_DATA_WIDTH : INTEGER
    );
    port (
      LMB_Clk : in std_logic;
      LMB_Rst : in std_logic;
      LMB_ABus : in std_logic_vector(0 to C_LMB_AWIDTH-1);
      LMB_WriteDBus : in std_logic_vector(0 to C_LMB_DWIDTH-1);
      LMB_AddrStrobe : in std_logic;
      LMB_ReadStrobe : in std_logic;
      LMB_WriteStrobe : in std_logic;
      LMB_BE : in std_logic_vector(0 to C_LMB_DWIDTH/8-1);
      Sl_DBus : out std_logic_vector(0 to C_LMB_DWIDTH-1);
      Sl_Ready : out std_logic;
      Sl_Wait : out std_logic;
      Sl_UE : out std_logic;
      Sl_CE : out std_logic;
      LMB1_ABus : in std_logic_vector(0 to C_LMB_AWIDTH-1);
      LMB1_WriteDBus : in std_logic_vector(0 to C_LMB_DWIDTH-1);
      LMB1_AddrStrobe : in std_logic;
      LMB1_ReadStrobe : in std_logic;
      LMB1_WriteStrobe : in std_logic;
      LMB1_BE : in std_logic_vector(0 to C_LMB_DWIDTH/8-1);
      Sl1_DBus : out std_logic_vector(0 to C_LMB_DWIDTH-1);
      Sl1_Ready : out std_logic;
      Sl1_Wait : out std_logic;
      Sl1_UE : out std_logic;
      Sl1_CE : out std_logic;
      LMB2_ABus : in std_logic_vector(0 to C_LMB_AWIDTH-1);
      LMB2_WriteDBus : in std_logic_vector(0 to C_LMB_DWIDTH-1);
      LMB2_AddrStrobe : in std_logic;
      LMB2_ReadStrobe : in std_logic;
      LMB2_WriteStrobe : in std_logic;
      LMB2_BE : in std_logic_vector(0 to C_LMB_DWIDTH/8-1);
      Sl2_DBus : out std_logic_vector(0 to C_LMB_DWIDTH-1);
      Sl2_Ready : out std_logic;
      Sl2_Wait : out std_logic;
      Sl2_UE : out std_logic;
      Sl2_CE : out std_logic;
      LMB3_ABus : in std_logic_vector(0 to C_LMB_AWIDTH-1);
      LMB3_WriteDBus : in std_logic_vector(0 to C_LMB_DWIDTH-1);
      LMB3_AddrStrobe : in std_logic;
      LMB3_ReadStrobe : in std_logic;
      LMB3_WriteStrobe : in std_logic;
      LMB3_BE : in std_logic_vector(0 to C_LMB_DWIDTH/8-1);
      Sl3_DBus : out std_logic_vector(0 to C_LMB_DWIDTH-1);
      Sl3_Ready : out std_logic;
      Sl3_Wait : out std_logic;
      Sl3_UE : out std_logic;
      Sl3_CE : out std_logic;
      BRAM_Rst_A : out std_logic;
      BRAM_Clk_A : out std_logic;
      BRAM_EN_A : out std_logic;
      BRAM_WEN_A : out std_logic_vector(0 to ((C_LMB_DWIDTH+8*C_ECC)/8)-1);
      BRAM_Addr_A : out std_logic_vector(0 to C_LMB_AWIDTH-1);
      BRAM_Din_A : in std_logic_vector(0 to C_LMB_DWIDTH-1+8*C_ECC);
      BRAM_Dout_A : out std_logic_vector(0 to C_LMB_DWIDTH-1+8*C_ECC);
      Interrupt : out std_logic;
      UE : out std_logic;
      CE : out std_logic;
      SPLB_CTRL_PLB_ABus : in std_logic_vector(0 to 31);
      SPLB_CTRL_PLB_PAValid : in std_logic;
      SPLB_CTRL_PLB_masterID : in std_logic_vector(0 to (C_SPLB_CTRL_MID_WIDTH-1));
      SPLB_CTRL_PLB_RNW : in std_logic;
      SPLB_CTRL_PLB_BE : in std_logic_vector(0 to ((C_SPLB_CTRL_DWIDTH/8)-1));
      SPLB_CTRL_PLB_size : in std_logic_vector(0 to 3);
      SPLB_CTRL_PLB_type : in std_logic_vector(0 to 2);
      SPLB_CTRL_PLB_wrDBus : in std_logic_vector(0 to (C_SPLB_CTRL_DWIDTH-1));
      SPLB_CTRL_Sl_addrAck : out std_logic;
      SPLB_CTRL_Sl_SSize : out std_logic_vector(0 to 1);
      SPLB_CTRL_Sl_wait : out std_logic;
      SPLB_CTRL_Sl_rearbitrate : out std_logic;
      SPLB_CTRL_Sl_wrDAck : out std_logic;
      SPLB_CTRL_Sl_wrComp : out std_logic;
      SPLB_CTRL_Sl_rdDBus : out std_logic_vector(0 to (C_SPLB_CTRL_DWIDTH-1));
      SPLB_CTRL_Sl_rdDAck : out std_logic;
      SPLB_CTRL_Sl_rdComp : out std_logic;
      SPLB_CTRL_Sl_MBusy : out std_logic_vector(0 to (C_SPLB_CTRL_NUM_MASTERS-1));
      SPLB_CTRL_Sl_MWrErr : out std_logic_vector(0 to (C_SPLB_CTRL_NUM_MASTERS-1));
      SPLB_CTRL_Sl_MRdErr : out std_logic_vector(0 to (C_SPLB_CTRL_NUM_MASTERS-1));
      SPLB_CTRL_PLB_UABus : in std_logic_vector(0 to 31);
      SPLB_CTRL_PLB_SAValid : in std_logic;
      SPLB_CTRL_PLB_rdPrim : in std_logic;
      SPLB_CTRL_PLB_wrPrim : in std_logic;
      SPLB_CTRL_PLB_abort : in std_logic;
      SPLB_CTRL_PLB_busLock : in std_logic;
      SPLB_CTRL_PLB_MSize : in std_logic_vector(0 to 1);
      SPLB_CTRL_PLB_lockErr : in std_logic;
      SPLB_CTRL_PLB_wrBurst : in std_logic;
      SPLB_CTRL_PLB_rdBurst : in std_logic;
      SPLB_CTRL_PLB_wrPendReq : in std_logic;
      SPLB_CTRL_PLB_rdPendReq : in std_logic;
      SPLB_CTRL_PLB_wrPendPri : in std_logic_vector(0 to 1);
      SPLB_CTRL_PLB_rdPendPri : in std_logic_vector(0 to 1);
      SPLB_CTRL_PLB_reqPri : in std_logic_vector(0 to 1);
      SPLB_CTRL_PLB_TAttribute : in std_logic_vector(0 to 15);
      SPLB_CTRL_Sl_wrBTerm : out std_logic;
      SPLB_CTRL_Sl_rdWdAddr : out std_logic_vector(0 to 3);
      SPLB_CTRL_Sl_rdBTerm : out std_logic;
      SPLB_CTRL_Sl_MIRQ : out std_logic_vector(0 to (C_SPLB_CTRL_NUM_MASTERS-1));
      S_AXI_CTRL_ACLK : in std_logic;
      S_AXI_CTRL_ARESETN : in std_logic;
      S_AXI_CTRL_AWADDR : in std_logic_vector((C_S_AXI_CTRL_ADDR_WIDTH-1) downto 0);
      S_AXI_CTRL_AWVALID : in std_logic;
      S_AXI_CTRL_AWREADY : out std_logic;
      S_AXI_CTRL_WDATA : in std_logic_vector((C_S_AXI_CTRL_DATA_WIDTH-1) downto 0);
      S_AXI_CTRL_WSTRB : in std_logic_vector(((C_S_AXI_CTRL_DATA_WIDTH/8)-1) downto 0);
      S_AXI_CTRL_WVALID : in std_logic;
      S_AXI_CTRL_WREADY : out std_logic;
      S_AXI_CTRL_BRESP : out std_logic_vector(1 downto 0);
      S_AXI_CTRL_BVALID : out std_logic;
      S_AXI_CTRL_BREADY : in std_logic;
      S_AXI_CTRL_ARADDR : in std_logic_vector((C_S_AXI_CTRL_ADDR_WIDTH-1) downto 0);
      S_AXI_CTRL_ARVALID : in std_logic;
      S_AXI_CTRL_ARREADY : out std_logic;
      S_AXI_CTRL_RDATA : out std_logic_vector((C_S_AXI_CTRL_DATA_WIDTH-1) downto 0);
      S_AXI_CTRL_RRESP : out std_logic_vector(1 downto 0);
      S_AXI_CTRL_RVALID : out std_logic;
      S_AXI_CTRL_RREADY : in std_logic
    );
  end component;

begin

  microblaze_0_i_bram_ctrl : lmb_bram_if_cntlr
    generic map (
      C_BASEADDR => X"00000000",
      C_HIGHADDR => X"00003fff",
      C_FAMILY => "spartan6",
      C_MASK => X"40000000",
      C_MASK1 => X"00800000",
      C_MASK2 => X"00800000",
      C_MASK3 => X"00800000",
      C_LMB_AWIDTH => 32,
      C_LMB_DWIDTH => 32,
      C_ECC => 0,
      C_INTERCONNECT => 0,
      C_FAULT_INJECT => 0,
      C_CE_FAILING_REGISTERS => 0,
      C_UE_FAILING_REGISTERS => 0,
      C_ECC_STATUS_REGISTERS => 0,
      C_ECC_ONOFF_REGISTER => 0,
      C_ECC_ONOFF_RESET_VALUE => 1,
      C_CE_COUNTER_WIDTH => 0,
      C_WRITE_ACCESS => 2,
      C_NUM_LMB => 1,
      C_SPLB_CTRL_BASEADDR => X"FFFFFFFF",
      C_SPLB_CTRL_HIGHADDR => X"00000000",
      C_SPLB_CTRL_AWIDTH => 32,
      C_SPLB_CTRL_DWIDTH => 32,
      C_SPLB_CTRL_P2P => 0,
      C_SPLB_CTRL_MID_WIDTH => 1,
      C_SPLB_CTRL_NUM_MASTERS => 1,
      C_SPLB_CTRL_SUPPORT_BURSTS => 0,
      C_SPLB_CTRL_NATIVE_DWIDTH => 32,
      C_S_AXI_CTRL_BASEADDR => X"FFFFFFFF",
      C_S_AXI_CTRL_HIGHADDR => X"00000000",
      C_S_AXI_CTRL_ADDR_WIDTH => 32,
      C_S_AXI_CTRL_DATA_WIDTH => 32
    )
    port map (
      LMB_Clk => LMB_Clk,
      LMB_Rst => LMB_Rst,
      LMB_ABus => LMB_ABus,
      LMB_WriteDBus => LMB_WriteDBus,
      LMB_AddrStrobe => LMB_AddrStrobe,
      LMB_ReadStrobe => LMB_ReadStrobe,
      LMB_WriteStrobe => LMB_WriteStrobe,
      LMB_BE => LMB_BE,
      Sl_DBus => Sl_DBus,
      Sl_Ready => Sl_Ready,
      Sl_Wait => Sl_Wait,
      Sl_UE => Sl_UE,
      Sl_CE => Sl_CE,
      LMB1_ABus => LMB1_ABus,
      LMB1_WriteDBus => LMB1_WriteDBus,
      LMB1_AddrStrobe => LMB1_AddrStrobe,
      LMB1_ReadStrobe => LMB1_ReadStrobe,
      LMB1_WriteStrobe => LMB1_WriteStrobe,
      LMB1_BE => LMB1_BE,
      Sl1_DBus => Sl1_DBus,
      Sl1_Ready => Sl1_Ready,
      Sl1_Wait => Sl1_Wait,
      Sl1_UE => Sl1_UE,
      Sl1_CE => Sl1_CE,
      LMB2_ABus => LMB2_ABus,
      LMB2_WriteDBus => LMB2_WriteDBus,
      LMB2_AddrStrobe => LMB2_AddrStrobe,
      LMB2_ReadStrobe => LMB2_ReadStrobe,
      LMB2_WriteStrobe => LMB2_WriteStrobe,
      LMB2_BE => LMB2_BE,
      Sl2_DBus => Sl2_DBus,
      Sl2_Ready => Sl2_Ready,
      Sl2_Wait => Sl2_Wait,
      Sl2_UE => Sl2_UE,
      Sl2_CE => Sl2_CE,
      LMB3_ABus => LMB3_ABus,
      LMB3_WriteDBus => LMB3_WriteDBus,
      LMB3_AddrStrobe => LMB3_AddrStrobe,
      LMB3_ReadStrobe => LMB3_ReadStrobe,
      LMB3_WriteStrobe => LMB3_WriteStrobe,
      LMB3_BE => LMB3_BE,
      Sl3_DBus => Sl3_DBus,
      Sl3_Ready => Sl3_Ready,
      Sl3_Wait => Sl3_Wait,
      Sl3_UE => Sl3_UE,
      Sl3_CE => Sl3_CE,
      BRAM_Rst_A => BRAM_Rst_A,
      BRAM_Clk_A => BRAM_Clk_A,
      BRAM_EN_A => BRAM_EN_A,
      BRAM_WEN_A => BRAM_WEN_A,
      BRAM_Addr_A => BRAM_Addr_A,
      BRAM_Din_A => BRAM_Din_A,
      BRAM_Dout_A => BRAM_Dout_A,
      Interrupt => Interrupt,
      UE => UE,
      CE => CE,
      SPLB_CTRL_PLB_ABus => SPLB_CTRL_PLB_ABus,
      SPLB_CTRL_PLB_PAValid => SPLB_CTRL_PLB_PAValid,
      SPLB_CTRL_PLB_masterID => SPLB_CTRL_PLB_masterID,
      SPLB_CTRL_PLB_RNW => SPLB_CTRL_PLB_RNW,
      SPLB_CTRL_PLB_BE => SPLB_CTRL_PLB_BE,
      SPLB_CTRL_PLB_size => SPLB_CTRL_PLB_size,
      SPLB_CTRL_PLB_type => SPLB_CTRL_PLB_type,
      SPLB_CTRL_PLB_wrDBus => SPLB_CTRL_PLB_wrDBus,
      SPLB_CTRL_Sl_addrAck => SPLB_CTRL_Sl_addrAck,
      SPLB_CTRL_Sl_SSize => SPLB_CTRL_Sl_SSize,
      SPLB_CTRL_Sl_wait => SPLB_CTRL_Sl_wait,
      SPLB_CTRL_Sl_rearbitrate => SPLB_CTRL_Sl_rearbitrate,
      SPLB_CTRL_Sl_wrDAck => SPLB_CTRL_Sl_wrDAck,
      SPLB_CTRL_Sl_wrComp => SPLB_CTRL_Sl_wrComp,
      SPLB_CTRL_Sl_rdDBus => SPLB_CTRL_Sl_rdDBus,
      SPLB_CTRL_Sl_rdDAck => SPLB_CTRL_Sl_rdDAck,
      SPLB_CTRL_Sl_rdComp => SPLB_CTRL_Sl_rdComp,
      SPLB_CTRL_Sl_MBusy => SPLB_CTRL_Sl_MBusy,
      SPLB_CTRL_Sl_MWrErr => SPLB_CTRL_Sl_MWrErr,
      SPLB_CTRL_Sl_MRdErr => SPLB_CTRL_Sl_MRdErr,
      SPLB_CTRL_PLB_UABus => SPLB_CTRL_PLB_UABus,
      SPLB_CTRL_PLB_SAValid => SPLB_CTRL_PLB_SAValid,
      SPLB_CTRL_PLB_rdPrim => SPLB_CTRL_PLB_rdPrim,
      SPLB_CTRL_PLB_wrPrim => SPLB_CTRL_PLB_wrPrim,
      SPLB_CTRL_PLB_abort => SPLB_CTRL_PLB_abort,
      SPLB_CTRL_PLB_busLock => SPLB_CTRL_PLB_busLock,
      SPLB_CTRL_PLB_MSize => SPLB_CTRL_PLB_MSize,
      SPLB_CTRL_PLB_lockErr => SPLB_CTRL_PLB_lockErr,
      SPLB_CTRL_PLB_wrBurst => SPLB_CTRL_PLB_wrBurst,
      SPLB_CTRL_PLB_rdBurst => SPLB_CTRL_PLB_rdBurst,
      SPLB_CTRL_PLB_wrPendReq => SPLB_CTRL_PLB_wrPendReq,
      SPLB_CTRL_PLB_rdPendReq => SPLB_CTRL_PLB_rdPendReq,
      SPLB_CTRL_PLB_wrPendPri => SPLB_CTRL_PLB_wrPendPri,
      SPLB_CTRL_PLB_rdPendPri => SPLB_CTRL_PLB_rdPendPri,
      SPLB_CTRL_PLB_reqPri => SPLB_CTRL_PLB_reqPri,
      SPLB_CTRL_PLB_TAttribute => SPLB_CTRL_PLB_TAttribute,
      SPLB_CTRL_Sl_wrBTerm => SPLB_CTRL_Sl_wrBTerm,
      SPLB_CTRL_Sl_rdWdAddr => SPLB_CTRL_Sl_rdWdAddr,
      SPLB_CTRL_Sl_rdBTerm => SPLB_CTRL_Sl_rdBTerm,
      SPLB_CTRL_Sl_MIRQ => SPLB_CTRL_Sl_MIRQ,
      S_AXI_CTRL_ACLK => S_AXI_CTRL_ACLK,
      S_AXI_CTRL_ARESETN => S_AXI_CTRL_ARESETN,
      S_AXI_CTRL_AWADDR => S_AXI_CTRL_AWADDR,
      S_AXI_CTRL_AWVALID => S_AXI_CTRL_AWVALID,
      S_AXI_CTRL_AWREADY => S_AXI_CTRL_AWREADY,
      S_AXI_CTRL_WDATA => S_AXI_CTRL_WDATA,
      S_AXI_CTRL_WSTRB => S_AXI_CTRL_WSTRB,
      S_AXI_CTRL_WVALID => S_AXI_CTRL_WVALID,
      S_AXI_CTRL_WREADY => S_AXI_CTRL_WREADY,
      S_AXI_CTRL_BRESP => S_AXI_CTRL_BRESP,
      S_AXI_CTRL_BVALID => S_AXI_CTRL_BVALID,
      S_AXI_CTRL_BREADY => S_AXI_CTRL_BREADY,
      S_AXI_CTRL_ARADDR => S_AXI_CTRL_ARADDR,
      S_AXI_CTRL_ARVALID => S_AXI_CTRL_ARVALID,
      S_AXI_CTRL_ARREADY => S_AXI_CTRL_ARREADY,
      S_AXI_CTRL_RDATA => S_AXI_CTRL_RDATA,
      S_AXI_CTRL_RRESP => S_AXI_CTRL_RRESP,
      S_AXI_CTRL_RVALID => S_AXI_CTRL_RVALID,
      S_AXI_CTRL_RREADY => S_AXI_CTRL_RREADY
    );

end architecture STRUCTURE;

