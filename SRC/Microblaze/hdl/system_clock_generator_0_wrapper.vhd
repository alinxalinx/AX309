-------------------------------------------------------------------------------
-- system_clock_generator_0_wrapper.vhd
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

library clock_generator_0_v4_03_a;
use clock_generator_0_v4_03_a.all;

library clock_generator_v4_03_a;
use clock_generator_v4_03_a.all;

entity system_clock_generator_0_wrapper is
  port (
    CLKIN : in std_logic;
    CLKOUT0 : out std_logic;
    CLKOUT1 : out std_logic;
    CLKOUT2 : out std_logic;
    CLKOUT3 : out std_logic;
    CLKOUT4 : out std_logic;
    CLKOUT5 : out std_logic;
    CLKOUT6 : out std_logic;
    CLKOUT7 : out std_logic;
    CLKOUT8 : out std_logic;
    CLKOUT9 : out std_logic;
    CLKOUT10 : out std_logic;
    CLKOUT11 : out std_logic;
    CLKOUT12 : out std_logic;
    CLKOUT13 : out std_logic;
    CLKOUT14 : out std_logic;
    CLKOUT15 : out std_logic;
    CLKFBIN : in std_logic;
    CLKFBOUT : out std_logic;
    PSCLK : in std_logic;
    PSEN : in std_logic;
    PSINCDEC : in std_logic;
    PSDONE : out std_logic;
    RST : in std_logic;
    LOCKED : out std_logic
  );

  attribute x_core_info : STRING;
  attribute x_core_info of system_clock_generator_0_wrapper : entity is "clock_generator_v4_03_a";

end system_clock_generator_0_wrapper;

architecture STRUCTURE of system_clock_generator_0_wrapper is

  component clock_generator is
    generic (
      C_FAMILY : STRING;
      C_DEVICE : STRING;
      C_PACKAGE : STRING;
      C_SPEEDGRADE : STRING
    );
    port (
      CLKIN : in std_logic;
      CLKOUT0 : out std_logic;
      CLKOUT1 : out std_logic;
      CLKOUT2 : out std_logic;
      CLKOUT3 : out std_logic;
      CLKOUT4 : out std_logic;
      CLKOUT5 : out std_logic;
      CLKOUT6 : out std_logic;
      CLKOUT7 : out std_logic;
      CLKOUT8 : out std_logic;
      CLKOUT9 : out std_logic;
      CLKOUT10 : out std_logic;
      CLKOUT11 : out std_logic;
      CLKOUT12 : out std_logic;
      CLKOUT13 : out std_logic;
      CLKOUT14 : out std_logic;
      CLKOUT15 : out std_logic;
      CLKFBIN : in std_logic;
      CLKFBOUT : out std_logic;
      PSCLK : in std_logic;
      PSEN : in std_logic;
      PSINCDEC : in std_logic;
      PSDONE : out std_logic;
      RST : in std_logic;
      LOCKED : out std_logic
    );
  end component;

begin

  clock_generator_0 : clock_generator
    generic map (
      C_FAMILY => "spartan6",
      C_DEVICE => "6slx9",
      C_PACKAGE => "ftg256",
      C_SPEEDGRADE => "-2"
    )
    port map (
      CLKIN => CLKIN,
      CLKOUT0 => CLKOUT0,
      CLKOUT1 => CLKOUT1,
      CLKOUT2 => CLKOUT2,
      CLKOUT3 => CLKOUT3,
      CLKOUT4 => CLKOUT4,
      CLKOUT5 => CLKOUT5,
      CLKOUT6 => CLKOUT6,
      CLKOUT7 => CLKOUT7,
      CLKOUT8 => CLKOUT8,
      CLKOUT9 => CLKOUT9,
      CLKOUT10 => CLKOUT10,
      CLKOUT11 => CLKOUT11,
      CLKOUT12 => CLKOUT12,
      CLKOUT13 => CLKOUT13,
      CLKOUT14 => CLKOUT14,
      CLKOUT15 => CLKOUT15,
      CLKFBIN => CLKFBIN,
      CLKFBOUT => CLKFBOUT,
      PSCLK => PSCLK,
      PSEN => PSEN,
      PSINCDEC => PSINCDEC,
      PSDONE => PSDONE,
      RST => RST,
      LOCKED => LOCKED
    );

end architecture STRUCTURE;

