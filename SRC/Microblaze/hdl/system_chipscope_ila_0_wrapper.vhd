-------------------------------------------------------------------------------
-- system_chipscope_ila_0_wrapper.vhd
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

library chipscope_ila_0_v1_05_a;
use chipscope_ila_0_v1_05_a.all;

entity system_chipscope_ila_0_wrapper is
  port (
    CHIPSCOPE_ILA_CONTROL : in std_logic_vector(35 downto 0);
    CLK : in std_logic;
    DATA : in std_logic_vector(31 downto 0);
    TRIG0 : in std_logic_vector(0 to 0);
    TRIG1 : in std_logic_vector(0 to 0);
    TRIG2 : in std_logic_vector(0 to 0);
    TRIG3 : in std_logic_vector(0 to 0);
    TRIG4 : in std_logic_vector(7 downto 0);
    TRIG5 : in std_logic_vector(7 downto 0);
    TRIG6 : in std_logic_vector(7 downto 0);
    TRIG7 : in std_logic_vector(7 downto 0);
    TRIG8 : in std_logic_vector(7 downto 0);
    TRIG9 : in std_logic_vector(7 downto 0);
    TRIG10 : in std_logic_vector(7 downto 0);
    TRIG11 : in std_logic_vector(7 downto 0);
    TRIG12 : in std_logic_vector(7 downto 0);
    TRIG13 : in std_logic_vector(7 downto 0);
    TRIG14 : in std_logic_vector(7 downto 0);
    TRIG15 : in std_logic_vector(7 downto 0);
    TRIG_OUT : out std_logic
  );

  attribute x_core_info : STRING;
  attribute x_core_info of system_chipscope_ila_0_wrapper : entity is "chipscope_ila_v1_05_a";

end system_chipscope_ila_0_wrapper;

architecture STRUCTURE of system_chipscope_ila_0_wrapper is

  component chipscope_ila is
    generic (
      C_FAMILY : string;
      C_DEVICE : string;
      C_PACKAGE : string;
      C_SPEEDGRADE : string;
      C_NUM_DATA_SAMPLES : integer;
      C_DATA_SAME_AS_TRIGGER : integer;
      C_DATA_IN_WIDTH : integer;
      C_ENABLE_TRIGGER_OUT : integer;
      C_DISABLE_RPM : integer;
      C_RISING_CLOCK_EDGE : integer;
      C_MAX_SEQUENCER_LEVELS : integer;
      C_ENABLE_STORAGE_QUALIFICATION : integer;
      C_TRIG0_UNITS : integer;
      C_TRIG0_TRIGGER_IN_WIDTH : integer;
      C_TRIG0_UNIT_COUNTER_WIDTH : integer;
      C_TRIG0_UNIT_MATCH_TYPE : string;
      C_TRIG1_UNITS : integer;
      C_TRIG1_TRIGGER_IN_WIDTH : integer;
      C_TRIG1_UNIT_COUNTER_WIDTH : integer;
      C_TRIG1_UNIT_MATCH_TYPE : string;
      C_TRIG2_UNITS : integer;
      C_TRIG2_TRIGGER_IN_WIDTH : integer;
      C_TRIG2_UNIT_COUNTER_WIDTH : integer;
      C_TRIG2_UNIT_MATCH_TYPE : string;
      C_TRIG3_UNITS : integer;
      C_TRIG3_TRIGGER_IN_WIDTH : integer;
      C_TRIG3_UNIT_COUNTER_WIDTH : integer;
      C_TRIG3_UNIT_MATCH_TYPE : string;
      C_TRIG4_UNITS : integer;
      C_TRIG4_TRIGGER_IN_WIDTH : integer;
      C_TRIG4_UNIT_COUNTER_WIDTH : integer;
      C_TRIG4_UNIT_MATCH_TYPE : string;
      C_TRIG5_UNITS : integer;
      C_TRIG5_TRIGGER_IN_WIDTH : integer;
      C_TRIG5_UNIT_COUNTER_WIDTH : integer;
      C_TRIG5_UNIT_MATCH_TYPE : string;
      C_TRIG6_UNITS : integer;
      C_TRIG6_TRIGGER_IN_WIDTH : integer;
      C_TRIG6_UNIT_COUNTER_WIDTH : integer;
      C_TRIG6_UNIT_MATCH_TYPE : string;
      C_TRIG7_UNITS : integer;
      C_TRIG7_TRIGGER_IN_WIDTH : integer;
      C_TRIG7_UNIT_COUNTER_WIDTH : integer;
      C_TRIG7_UNIT_MATCH_TYPE : string;
      C_TRIG8_UNITS : integer;
      C_TRIG8_TRIGGER_IN_WIDTH : integer;
      C_TRIG8_UNIT_COUNTER_WIDTH : integer;
      C_TRIG8_UNIT_MATCH_TYPE : string;
      C_TRIG9_UNITS : integer;
      C_TRIG9_TRIGGER_IN_WIDTH : integer;
      C_TRIG9_UNIT_COUNTER_WIDTH : integer;
      C_TRIG9_UNIT_MATCH_TYPE : string;
      C_TRIG10_UNITS : integer;
      C_TRIG10_TRIGGER_IN_WIDTH : integer;
      C_TRIG10_UNIT_COUNTER_WIDTH : integer;
      C_TRIG10_UNIT_MATCH_TYPE : string;
      C_TRIG11_UNITS : integer;
      C_TRIG11_TRIGGER_IN_WIDTH : integer;
      C_TRIG11_UNIT_COUNTER_WIDTH : integer;
      C_TRIG11_UNIT_MATCH_TYPE : string;
      C_TRIG12_UNITS : integer;
      C_TRIG12_TRIGGER_IN_WIDTH : integer;
      C_TRIG12_UNIT_COUNTER_WIDTH : integer;
      C_TRIG12_UNIT_MATCH_TYPE : string;
      C_TRIG13_UNITS : integer;
      C_TRIG13_TRIGGER_IN_WIDTH : integer;
      C_TRIG13_UNIT_COUNTER_WIDTH : integer;
      C_TRIG13_UNIT_MATCH_TYPE : string;
      C_TRIG14_UNITS : integer;
      C_TRIG14_TRIGGER_IN_WIDTH : integer;
      C_TRIG14_UNIT_COUNTER_WIDTH : integer;
      C_TRIG14_UNIT_MATCH_TYPE : string;
      C_TRIG15_UNITS : integer;
      C_TRIG15_TRIGGER_IN_WIDTH : integer;
      C_TRIG15_UNIT_COUNTER_WIDTH : integer;
      C_TRIG15_UNIT_MATCH_TYPE : string
    );
    port (
      CHIPSCOPE_ILA_CONTROL : in std_logic_vector(35 downto 0);
      CLK : in std_logic;
      DATA : in std_logic_vector((C_DATA_IN_WIDTH-1) downto 0);
      TRIG0 : in std_logic_vector((C_TRIG0_TRIGGER_IN_WIDTH-1) to 0);
      TRIG1 : in std_logic_vector((C_TRIG1_TRIGGER_IN_WIDTH-1) to 0);
      TRIG2 : in std_logic_vector((C_TRIG2_TRIGGER_IN_WIDTH-1) to 0);
      TRIG3 : in std_logic_vector((C_TRIG3_TRIGGER_IN_WIDTH-1) to 0);
      TRIG4 : in std_logic_vector((C_TRIG4_TRIGGER_IN_WIDTH-1) downto 0);
      TRIG5 : in std_logic_vector((C_TRIG5_TRIGGER_IN_WIDTH-1) downto 0);
      TRIG6 : in std_logic_vector((C_TRIG6_TRIGGER_IN_WIDTH-1) downto 0);
      TRIG7 : in std_logic_vector((C_TRIG7_TRIGGER_IN_WIDTH-1) downto 0);
      TRIG8 : in std_logic_vector((C_TRIG8_TRIGGER_IN_WIDTH-1) downto 0);
      TRIG9 : in std_logic_vector((C_TRIG9_TRIGGER_IN_WIDTH-1) downto 0);
      TRIG10 : in std_logic_vector((C_TRIG10_TRIGGER_IN_WIDTH-1) downto 0);
      TRIG11 : in std_logic_vector((C_TRIG11_TRIGGER_IN_WIDTH-1) downto 0);
      TRIG12 : in std_logic_vector((C_TRIG12_TRIGGER_IN_WIDTH-1) downto 0);
      TRIG13 : in std_logic_vector((C_TRIG13_TRIGGER_IN_WIDTH-1) downto 0);
      TRIG14 : in std_logic_vector((C_TRIG14_TRIGGER_IN_WIDTH-1) downto 0);
      TRIG15 : in std_logic_vector((C_TRIG15_TRIGGER_IN_WIDTH-1) downto 0);
      TRIG_OUT : out std_logic
    );
  end component;

begin

  chipscope_ila_0 : chipscope_ila
    generic map (
      C_FAMILY => "spartan6",
      C_DEVICE => "6slx9",
      C_PACKAGE => "ftg256",
      C_SPEEDGRADE => "-2",
      C_NUM_DATA_SAMPLES => 4096,
      C_DATA_SAME_AS_TRIGGER => 1,
      C_DATA_IN_WIDTH => 32,
      C_ENABLE_TRIGGER_OUT => 1,
      C_DISABLE_RPM => 0,
      C_RISING_CLOCK_EDGE => 1,
      C_MAX_SEQUENCER_LEVELS => 1,
      C_ENABLE_STORAGE_QUALIFICATION => 1,
      C_TRIG0_UNITS => 1,
      C_TRIG0_TRIGGER_IN_WIDTH => 1,
      C_TRIG0_UNIT_COUNTER_WIDTH => 0,
      C_TRIG0_UNIT_MATCH_TYPE => "basic",
      C_TRIG1_UNITS => 1,
      C_TRIG1_TRIGGER_IN_WIDTH => 1,
      C_TRIG1_UNIT_COUNTER_WIDTH => 0,
      C_TRIG1_UNIT_MATCH_TYPE => "basic",
      C_TRIG2_UNITS => 1,
      C_TRIG2_TRIGGER_IN_WIDTH => 1,
      C_TRIG2_UNIT_COUNTER_WIDTH => 0,
      C_TRIG2_UNIT_MATCH_TYPE => "basic",
      C_TRIG3_UNITS => 1,
      C_TRIG3_TRIGGER_IN_WIDTH => 1,
      C_TRIG3_UNIT_COUNTER_WIDTH => 0,
      C_TRIG3_UNIT_MATCH_TYPE => "basic",
      C_TRIG4_UNITS => 0,
      C_TRIG4_TRIGGER_IN_WIDTH => 8,
      C_TRIG4_UNIT_COUNTER_WIDTH => 0,
      C_TRIG4_UNIT_MATCH_TYPE => "basic",
      C_TRIG5_UNITS => 0,
      C_TRIG5_TRIGGER_IN_WIDTH => 8,
      C_TRIG5_UNIT_COUNTER_WIDTH => 0,
      C_TRIG5_UNIT_MATCH_TYPE => "basic",
      C_TRIG6_UNITS => 0,
      C_TRIG6_TRIGGER_IN_WIDTH => 8,
      C_TRIG6_UNIT_COUNTER_WIDTH => 0,
      C_TRIG6_UNIT_MATCH_TYPE => "basic",
      C_TRIG7_UNITS => 0,
      C_TRIG7_TRIGGER_IN_WIDTH => 8,
      C_TRIG7_UNIT_COUNTER_WIDTH => 0,
      C_TRIG7_UNIT_MATCH_TYPE => "basic",
      C_TRIG8_UNITS => 0,
      C_TRIG8_TRIGGER_IN_WIDTH => 8,
      C_TRIG8_UNIT_COUNTER_WIDTH => 0,
      C_TRIG8_UNIT_MATCH_TYPE => "basic",
      C_TRIG9_UNITS => 0,
      C_TRIG9_TRIGGER_IN_WIDTH => 8,
      C_TRIG9_UNIT_COUNTER_WIDTH => 0,
      C_TRIG9_UNIT_MATCH_TYPE => "basic",
      C_TRIG10_UNITS => 0,
      C_TRIG10_TRIGGER_IN_WIDTH => 8,
      C_TRIG10_UNIT_COUNTER_WIDTH => 0,
      C_TRIG10_UNIT_MATCH_TYPE => "basic",
      C_TRIG11_UNITS => 0,
      C_TRIG11_TRIGGER_IN_WIDTH => 8,
      C_TRIG11_UNIT_COUNTER_WIDTH => 0,
      C_TRIG11_UNIT_MATCH_TYPE => "basic",
      C_TRIG12_UNITS => 0,
      C_TRIG12_TRIGGER_IN_WIDTH => 8,
      C_TRIG12_UNIT_COUNTER_WIDTH => 0,
      C_TRIG12_UNIT_MATCH_TYPE => "basic",
      C_TRIG13_UNITS => 0,
      C_TRIG13_TRIGGER_IN_WIDTH => 8,
      C_TRIG13_UNIT_COUNTER_WIDTH => 0,
      C_TRIG13_UNIT_MATCH_TYPE => "basic",
      C_TRIG14_UNITS => 0,
      C_TRIG14_TRIGGER_IN_WIDTH => 8,
      C_TRIG14_UNIT_COUNTER_WIDTH => 0,
      C_TRIG14_UNIT_MATCH_TYPE => "basic",
      C_TRIG15_UNITS => 0,
      C_TRIG15_TRIGGER_IN_WIDTH => 8,
      C_TRIG15_UNIT_COUNTER_WIDTH => 0,
      C_TRIG15_UNIT_MATCH_TYPE => "basic"
    )
    port map (
      CHIPSCOPE_ILA_CONTROL => CHIPSCOPE_ILA_CONTROL,
      CLK => CLK,
      DATA => DATA,
      TRIG0 => TRIG0,
      TRIG1 => TRIG1,
      TRIG2 => TRIG2,
      TRIG3 => TRIG3,
      TRIG4 => TRIG4,
      TRIG5 => TRIG5,
      TRIG6 => TRIG6,
      TRIG7 => TRIG7,
      TRIG8 => TRIG8,
      TRIG9 => TRIG9,
      TRIG10 => TRIG10,
      TRIG11 => TRIG11,
      TRIG12 => TRIG12,
      TRIG13 => TRIG13,
      TRIG14 => TRIG14,
      TRIG15 => TRIG15,
      TRIG_OUT => TRIG_OUT
    );

end architecture STRUCTURE;

