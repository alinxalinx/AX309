-------------------------------------------------------------------------------
-- system_microblaze_0_ilmb_wrapper.vhd
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

library lmb_v10_v2_00_b;
use lmb_v10_v2_00_b.all;

entity system_microblaze_0_ilmb_wrapper is
  port (
    LMB_Clk : in std_logic;
    SYS_Rst : in std_logic;
    LMB_Rst : out std_logic;
    M_ABus : in std_logic_vector(0 to 31);
    M_ReadStrobe : in std_logic;
    M_WriteStrobe : in std_logic;
    M_AddrStrobe : in std_logic;
    M_DBus : in std_logic_vector(0 to 31);
    M_BE : in std_logic_vector(0 to 3);
    Sl_DBus : in std_logic_vector(0 to 31);
    Sl_Ready : in std_logic_vector(0 to 0);
    Sl_Wait : in std_logic_vector(0 to 0);
    Sl_UE : in std_logic_vector(0 to 0);
    Sl_CE : in std_logic_vector(0 to 0);
    LMB_ABus : out std_logic_vector(0 to 31);
    LMB_ReadStrobe : out std_logic;
    LMB_WriteStrobe : out std_logic;
    LMB_AddrStrobe : out std_logic;
    LMB_ReadDBus : out std_logic_vector(0 to 31);
    LMB_WriteDBus : out std_logic_vector(0 to 31);
    LMB_Ready : out std_logic;
    LMB_Wait : out std_logic;
    LMB_UE : out std_logic;
    LMB_CE : out std_logic;
    LMB_BE : out std_logic_vector(0 to 3)
  );

  attribute x_core_info : STRING;
  attribute x_core_info of system_microblaze_0_ilmb_wrapper : entity is "lmb_v10_v2_00_b";

end system_microblaze_0_ilmb_wrapper;

architecture STRUCTURE of system_microblaze_0_ilmb_wrapper is

  component lmb_v10 is
    generic (
      C_LMB_NUM_SLAVES : integer;
      C_LMB_AWIDTH : integer;
      C_LMB_DWIDTH : integer;
      C_EXT_RESET_HIGH : integer
    );
    port (
      LMB_Clk : in std_logic;
      SYS_Rst : in std_logic;
      LMB_Rst : out std_logic;
      M_ABus : in std_logic_vector(0 to C_LMB_AWIDTH-1);
      M_ReadStrobe : in std_logic;
      M_WriteStrobe : in std_logic;
      M_AddrStrobe : in std_logic;
      M_DBus : in std_logic_vector(0 to C_LMB_DWIDTH-1);
      M_BE : in std_logic_vector(0 to (C_LMB_DWIDTH+7)/8-1);
      Sl_DBus : in std_logic_vector(0 to (C_LMB_DWIDTH*C_LMB_NUM_SLAVES)-1);
      Sl_Ready : in std_logic_vector(0 to C_LMB_NUM_SLAVES-1);
      Sl_Wait : in std_logic_vector(0 to C_LMB_NUM_SLAVES-1);
      Sl_UE : in std_logic_vector(0 to C_LMB_NUM_SLAVES-1);
      Sl_CE : in std_logic_vector(0 to C_LMB_NUM_SLAVES-1);
      LMB_ABus : out std_logic_vector(0 to C_LMB_AWIDTH-1);
      LMB_ReadStrobe : out std_logic;
      LMB_WriteStrobe : out std_logic;
      LMB_AddrStrobe : out std_logic;
      LMB_ReadDBus : out std_logic_vector(0 to C_LMB_DWIDTH-1);
      LMB_WriteDBus : out std_logic_vector(0 to C_LMB_DWIDTH-1);
      LMB_Ready : out std_logic;
      LMB_Wait : out std_logic;
      LMB_UE : out std_logic;
      LMB_CE : out std_logic;
      LMB_BE : out std_logic_vector(0 to (C_LMB_DWIDTH+7)/8-1)
    );
  end component;

begin

  microblaze_0_ilmb : lmb_v10
    generic map (
      C_LMB_NUM_SLAVES => 1,
      C_LMB_AWIDTH => 32,
      C_LMB_DWIDTH => 32,
      C_EXT_RESET_HIGH => 1
    )
    port map (
      LMB_Clk => LMB_Clk,
      SYS_Rst => SYS_Rst,
      LMB_Rst => LMB_Rst,
      M_ABus => M_ABus,
      M_ReadStrobe => M_ReadStrobe,
      M_WriteStrobe => M_WriteStrobe,
      M_AddrStrobe => M_AddrStrobe,
      M_DBus => M_DBus,
      M_BE => M_BE,
      Sl_DBus => Sl_DBus,
      Sl_Ready => Sl_Ready,
      Sl_Wait => Sl_Wait,
      Sl_UE => Sl_UE,
      Sl_CE => Sl_CE,
      LMB_ABus => LMB_ABus,
      LMB_ReadStrobe => LMB_ReadStrobe,
      LMB_WriteStrobe => LMB_WriteStrobe,
      LMB_AddrStrobe => LMB_AddrStrobe,
      LMB_ReadDBus => LMB_ReadDBus,
      LMB_WriteDBus => LMB_WriteDBus,
      LMB_Ready => LMB_Ready,
      LMB_Wait => LMB_Wait,
      LMB_UE => LMB_UE,
      LMB_CE => LMB_CE,
      LMB_BE => LMB_BE
    );

end architecture STRUCTURE;

