-------------------------------------------------------------------------------
-- system_proc_sys_reset_0_wrapper.vhd
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

library proc_sys_reset_v3_00_a;
use proc_sys_reset_v3_00_a.all;

entity system_proc_sys_reset_0_wrapper is
  port (
    Slowest_sync_clk : in std_logic;
    Ext_Reset_In : in std_logic;
    Aux_Reset_In : in std_logic;
    MB_Debug_Sys_Rst : in std_logic;
    Core_Reset_Req_0 : in std_logic;
    Chip_Reset_Req_0 : in std_logic;
    System_Reset_Req_0 : in std_logic;
    Core_Reset_Req_1 : in std_logic;
    Chip_Reset_Req_1 : in std_logic;
    System_Reset_Req_1 : in std_logic;
    Dcm_locked : in std_logic;
    RstcPPCresetcore_0 : out std_logic;
    RstcPPCresetchip_0 : out std_logic;
    RstcPPCresetsys_0 : out std_logic;
    RstcPPCresetcore_1 : out std_logic;
    RstcPPCresetchip_1 : out std_logic;
    RstcPPCresetsys_1 : out std_logic;
    MB_Reset : out std_logic;
    Bus_Struct_Reset : out std_logic_vector(0 to 0);
    Peripheral_Reset : out std_logic_vector(0 to 0);
    Interconnect_aresetn : out std_logic_vector(0 to 0);
    Peripheral_aresetn : out std_logic_vector(0 to 0)
  );

  attribute x_core_info : STRING;
  attribute x_core_info of system_proc_sys_reset_0_wrapper : entity is "proc_sys_reset_v3_00_a";

end system_proc_sys_reset_0_wrapper;

architecture STRUCTURE of system_proc_sys_reset_0_wrapper is

  component proc_sys_reset is
    generic (
      C_EXT_RST_WIDTH : integer;
      C_AUX_RST_WIDTH : integer;
      C_EXT_RESET_HIGH : std_logic;
      C_AUX_RESET_HIGH : std_logic;
      C_NUM_BUS_RST : integer;
      C_NUM_PERP_RST : integer;
      C_NUM_INTERCONNECT_ARESETN : integer;
      C_NUM_PERP_ARESETN : integer
    );
    port (
      Slowest_sync_clk : in std_logic;
      Ext_Reset_In : in std_logic;
      Aux_Reset_In : in std_logic;
      MB_Debug_Sys_Rst : in std_logic;
      Core_Reset_Req_0 : in std_logic;
      Chip_Reset_Req_0 : in std_logic;
      System_Reset_Req_0 : in std_logic;
      Core_Reset_Req_1 : in std_logic;
      Chip_Reset_Req_1 : in std_logic;
      System_Reset_Req_1 : in std_logic;
      Dcm_locked : in std_logic;
      RstcPPCresetcore_0 : out std_logic;
      RstcPPCresetchip_0 : out std_logic;
      RstcPPCresetsys_0 : out std_logic;
      RstcPPCresetcore_1 : out std_logic;
      RstcPPCresetchip_1 : out std_logic;
      RstcPPCresetsys_1 : out std_logic;
      MB_Reset : out std_logic;
      Bus_Struct_Reset : out std_logic_vector(0 to C_NUM_BUS_RST-1);
      Peripheral_Reset : out std_logic_vector(0 to C_NUM_PERP_RST-1);
      Interconnect_aresetn : out std_logic_vector(0 to C_NUM_INTERCONNECT_ARESETN-1);
      Peripheral_aresetn : out std_logic_vector(0 to C_NUM_PERP_ARESETN-1)
    );
  end component;

begin

  proc_sys_reset_0 : proc_sys_reset
    generic map (
      C_EXT_RST_WIDTH => 4,
      C_AUX_RST_WIDTH => 4,
      C_EXT_RESET_HIGH => '0',
      C_AUX_RESET_HIGH => '1',
      C_NUM_BUS_RST => 1,
      C_NUM_PERP_RST => 1,
      C_NUM_INTERCONNECT_ARESETN => 1,
      C_NUM_PERP_ARESETN => 1
    )
    port map (
      Slowest_sync_clk => Slowest_sync_clk,
      Ext_Reset_In => Ext_Reset_In,
      Aux_Reset_In => Aux_Reset_In,
      MB_Debug_Sys_Rst => MB_Debug_Sys_Rst,
      Core_Reset_Req_0 => Core_Reset_Req_0,
      Chip_Reset_Req_0 => Chip_Reset_Req_0,
      System_Reset_Req_0 => System_Reset_Req_0,
      Core_Reset_Req_1 => Core_Reset_Req_1,
      Chip_Reset_Req_1 => Chip_Reset_Req_1,
      System_Reset_Req_1 => System_Reset_Req_1,
      Dcm_locked => Dcm_locked,
      RstcPPCresetcore_0 => RstcPPCresetcore_0,
      RstcPPCresetchip_0 => RstcPPCresetchip_0,
      RstcPPCresetsys_0 => RstcPPCresetsys_0,
      RstcPPCresetcore_1 => RstcPPCresetcore_1,
      RstcPPCresetchip_1 => RstcPPCresetchip_1,
      RstcPPCresetsys_1 => RstcPPCresetsys_1,
      MB_Reset => MB_Reset,
      Bus_Struct_Reset => Bus_Struct_Reset,
      Peripheral_Reset => Peripheral_Reset,
      Interconnect_aresetn => Interconnect_aresetn,
      Peripheral_aresetn => Peripheral_aresetn
    );

end architecture STRUCTURE;

