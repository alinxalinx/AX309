-------------------------------------------------------------------------------
-- microblaze_0_bram_block_elaborate.vhd
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

entity microblaze_0_bram_block_elaborate is
  generic (
    C_MEMSIZE : integer;
    C_PORT_DWIDTH : integer;
    C_PORT_AWIDTH : integer;
    C_NUM_WE : integer;
    C_FAMILY : string
    );
  port (
    BRAM_Rst_A : in std_logic;
    BRAM_Clk_A : in std_logic;
    BRAM_EN_A : in std_logic;
    BRAM_WEN_A : in std_logic_vector(0 to C_NUM_WE-1);
    BRAM_Addr_A : in std_logic_vector(0 to C_PORT_AWIDTH-1);
    BRAM_Din_A : out std_logic_vector(0 to C_PORT_DWIDTH-1);
    BRAM_Dout_A : in std_logic_vector(0 to C_PORT_DWIDTH-1);
    BRAM_Rst_B : in std_logic;
    BRAM_Clk_B : in std_logic;
    BRAM_EN_B : in std_logic;
    BRAM_WEN_B : in std_logic_vector(0 to C_NUM_WE-1);
    BRAM_Addr_B : in std_logic_vector(0 to C_PORT_AWIDTH-1);
    BRAM_Din_B : out std_logic_vector(0 to C_PORT_DWIDTH-1);
    BRAM_Dout_B : in std_logic_vector(0 to C_PORT_DWIDTH-1)
  );

  attribute keep_hierarchy : STRING;
  attribute keep_hierarchy of microblaze_0_bram_block_elaborate : entity is "yes";

end microblaze_0_bram_block_elaborate;

architecture STRUCTURE of microblaze_0_bram_block_elaborate is

  component RAMB16BWER is
    generic (
      INIT_FILE : string;
      DATA_WIDTH_A : integer;
      DATA_WIDTH_B : integer
    );
    port (
      ADDRA : in std_logic_vector(13 downto 0);
      CLKA : in std_logic;
      DIA : in std_logic_vector(31 downto 0);
      DIPA : in std_logic_vector(3 downto 0);
      DOA : out std_logic_vector(31 downto 0);
      DOPA : out std_logic_vector(3 downto 0);
      ENA : in std_logic;
      REGCEA : in std_logic;
      RSTA : in std_logic;
      WEA : in std_logic_vector(3 downto 0);
      ADDRB : in std_logic_vector(13 downto 0);
      CLKB : in std_logic;
      DIB : in std_logic_vector(31 downto 0);
      DIPB : in std_logic_vector(3 downto 0);
      DOB : out std_logic_vector(31 downto 0);
      DOPB : out std_logic_vector(3 downto 0);
      ENB : in std_logic;
      REGCEB : in std_logic;
      RSTB : in std_logic;
      WEB : in std_logic_vector(3 downto 0)
    );
  end component;

  attribute BMM_INFO : STRING;

  attribute BMM_INFO of ramb16bwer_0: label is " ";
  attribute BMM_INFO of ramb16bwer_1: label is " ";
  attribute BMM_INFO of ramb16bwer_2: label is " ";
  attribute BMM_INFO of ramb16bwer_3: label is " ";
  attribute BMM_INFO of ramb16bwer_4: label is " ";
  attribute BMM_INFO of ramb16bwer_5: label is " ";
  attribute BMM_INFO of ramb16bwer_6: label is " ";
  attribute BMM_INFO of ramb16bwer_7: label is " ";
  -- Internal signals

  signal net_gnd0 : std_logic;
  signal net_gnd4 : std_logic_vector(3 downto 0);
  signal pgassign1 : std_logic_vector(0 to 1);
  signal pgassign2 : std_logic_vector(0 to 27);
  signal pgassign3 : std_logic_vector(13 downto 0);
  signal pgassign4 : std_logic_vector(31 downto 0);
  signal pgassign5 : std_logic_vector(31 downto 0);
  signal pgassign6 : std_logic_vector(3 downto 0);
  signal pgassign7 : std_logic_vector(13 downto 0);
  signal pgassign8 : std_logic_vector(31 downto 0);
  signal pgassign9 : std_logic_vector(31 downto 0);
  signal pgassign10 : std_logic_vector(3 downto 0);
  signal pgassign11 : std_logic_vector(13 downto 0);
  signal pgassign12 : std_logic_vector(31 downto 0);
  signal pgassign13 : std_logic_vector(31 downto 0);
  signal pgassign14 : std_logic_vector(3 downto 0);
  signal pgassign15 : std_logic_vector(13 downto 0);
  signal pgassign16 : std_logic_vector(31 downto 0);
  signal pgassign17 : std_logic_vector(31 downto 0);
  signal pgassign18 : std_logic_vector(3 downto 0);
  signal pgassign19 : std_logic_vector(13 downto 0);
  signal pgassign20 : std_logic_vector(31 downto 0);
  signal pgassign21 : std_logic_vector(31 downto 0);
  signal pgassign22 : std_logic_vector(3 downto 0);
  signal pgassign23 : std_logic_vector(13 downto 0);
  signal pgassign24 : std_logic_vector(31 downto 0);
  signal pgassign25 : std_logic_vector(31 downto 0);
  signal pgassign26 : std_logic_vector(3 downto 0);
  signal pgassign27 : std_logic_vector(13 downto 0);
  signal pgassign28 : std_logic_vector(31 downto 0);
  signal pgassign29 : std_logic_vector(31 downto 0);
  signal pgassign30 : std_logic_vector(3 downto 0);
  signal pgassign31 : std_logic_vector(13 downto 0);
  signal pgassign32 : std_logic_vector(31 downto 0);
  signal pgassign33 : std_logic_vector(31 downto 0);
  signal pgassign34 : std_logic_vector(3 downto 0);
  signal pgassign35 : std_logic_vector(13 downto 0);
  signal pgassign36 : std_logic_vector(31 downto 0);
  signal pgassign37 : std_logic_vector(31 downto 0);
  signal pgassign38 : std_logic_vector(3 downto 0);
  signal pgassign39 : std_logic_vector(13 downto 0);
  signal pgassign40 : std_logic_vector(31 downto 0);
  signal pgassign41 : std_logic_vector(31 downto 0);
  signal pgassign42 : std_logic_vector(3 downto 0);
  signal pgassign43 : std_logic_vector(13 downto 0);
  signal pgassign44 : std_logic_vector(31 downto 0);
  signal pgassign45 : std_logic_vector(31 downto 0);
  signal pgassign46 : std_logic_vector(3 downto 0);
  signal pgassign47 : std_logic_vector(13 downto 0);
  signal pgassign48 : std_logic_vector(31 downto 0);
  signal pgassign49 : std_logic_vector(31 downto 0);
  signal pgassign50 : std_logic_vector(3 downto 0);
  signal pgassign51 : std_logic_vector(13 downto 0);
  signal pgassign52 : std_logic_vector(31 downto 0);
  signal pgassign53 : std_logic_vector(31 downto 0);
  signal pgassign54 : std_logic_vector(3 downto 0);
  signal pgassign55 : std_logic_vector(13 downto 0);
  signal pgassign56 : std_logic_vector(31 downto 0);
  signal pgassign57 : std_logic_vector(31 downto 0);
  signal pgassign58 : std_logic_vector(3 downto 0);
  signal pgassign59 : std_logic_vector(13 downto 0);
  signal pgassign60 : std_logic_vector(31 downto 0);
  signal pgassign61 : std_logic_vector(31 downto 0);
  signal pgassign62 : std_logic_vector(3 downto 0);
  signal pgassign63 : std_logic_vector(13 downto 0);
  signal pgassign64 : std_logic_vector(31 downto 0);
  signal pgassign65 : std_logic_vector(31 downto 0);
  signal pgassign66 : std_logic_vector(3 downto 0);

begin

  -- Internal assignments

  pgassign1(0 to 1) <= B"00";
  pgassign2(0 to 27) <= B"0000000000000000000000000000";
  pgassign3(13 downto 2) <= BRAM_Addr_A(18 to 29);
  pgassign3(1 downto 0) <= B"00";
  pgassign4(31 downto 4) <= B"0000000000000000000000000000";
  pgassign4(3 downto 0) <= BRAM_Dout_A(0 to 3);
  BRAM_Din_A(0 to 3) <= pgassign5(3 downto 0);
  pgassign6(3 downto 3) <= BRAM_WEN_A(0 to 0);
  pgassign6(2 downto 2) <= BRAM_WEN_A(0 to 0);
  pgassign6(1 downto 1) <= BRAM_WEN_A(0 to 0);
  pgassign6(0 downto 0) <= BRAM_WEN_A(0 to 0);
  pgassign7(13 downto 2) <= BRAM_Addr_B(18 to 29);
  pgassign7(1 downto 0) <= B"00";
  pgassign8(31 downto 4) <= B"0000000000000000000000000000";
  pgassign8(3 downto 0) <= BRAM_Dout_B(0 to 3);
  BRAM_Din_B(0 to 3) <= pgassign9(3 downto 0);
  pgassign10(3 downto 3) <= BRAM_WEN_B(0 to 0);
  pgassign10(2 downto 2) <= BRAM_WEN_B(0 to 0);
  pgassign10(1 downto 1) <= BRAM_WEN_B(0 to 0);
  pgassign10(0 downto 0) <= BRAM_WEN_B(0 to 0);
  pgassign11(13 downto 2) <= BRAM_Addr_A(18 to 29);
  pgassign11(1 downto 0) <= B"00";
  pgassign12(31 downto 4) <= B"0000000000000000000000000000";
  pgassign12(3 downto 0) <= BRAM_Dout_A(4 to 7);
  BRAM_Din_A(4 to 7) <= pgassign13(3 downto 0);
  pgassign14(3 downto 3) <= BRAM_WEN_A(0 to 0);
  pgassign14(2 downto 2) <= BRAM_WEN_A(0 to 0);
  pgassign14(1 downto 1) <= BRAM_WEN_A(0 to 0);
  pgassign14(0 downto 0) <= BRAM_WEN_A(0 to 0);
  pgassign15(13 downto 2) <= BRAM_Addr_B(18 to 29);
  pgassign15(1 downto 0) <= B"00";
  pgassign16(31 downto 4) <= B"0000000000000000000000000000";
  pgassign16(3 downto 0) <= BRAM_Dout_B(4 to 7);
  BRAM_Din_B(4 to 7) <= pgassign17(3 downto 0);
  pgassign18(3 downto 3) <= BRAM_WEN_B(0 to 0);
  pgassign18(2 downto 2) <= BRAM_WEN_B(0 to 0);
  pgassign18(1 downto 1) <= BRAM_WEN_B(0 to 0);
  pgassign18(0 downto 0) <= BRAM_WEN_B(0 to 0);
  pgassign19(13 downto 2) <= BRAM_Addr_A(18 to 29);
  pgassign19(1 downto 0) <= B"00";
  pgassign20(31 downto 4) <= B"0000000000000000000000000000";
  pgassign20(3 downto 0) <= BRAM_Dout_A(8 to 11);
  BRAM_Din_A(8 to 11) <= pgassign21(3 downto 0);
  pgassign22(3 downto 3) <= BRAM_WEN_A(1 to 1);
  pgassign22(2 downto 2) <= BRAM_WEN_A(1 to 1);
  pgassign22(1 downto 1) <= BRAM_WEN_A(1 to 1);
  pgassign22(0 downto 0) <= BRAM_WEN_A(1 to 1);
  pgassign23(13 downto 2) <= BRAM_Addr_B(18 to 29);
  pgassign23(1 downto 0) <= B"00";
  pgassign24(31 downto 4) <= B"0000000000000000000000000000";
  pgassign24(3 downto 0) <= BRAM_Dout_B(8 to 11);
  BRAM_Din_B(8 to 11) <= pgassign25(3 downto 0);
  pgassign26(3 downto 3) <= BRAM_WEN_B(1 to 1);
  pgassign26(2 downto 2) <= BRAM_WEN_B(1 to 1);
  pgassign26(1 downto 1) <= BRAM_WEN_B(1 to 1);
  pgassign26(0 downto 0) <= BRAM_WEN_B(1 to 1);
  pgassign27(13 downto 2) <= BRAM_Addr_A(18 to 29);
  pgassign27(1 downto 0) <= B"00";
  pgassign28(31 downto 4) <= B"0000000000000000000000000000";
  pgassign28(3 downto 0) <= BRAM_Dout_A(12 to 15);
  BRAM_Din_A(12 to 15) <= pgassign29(3 downto 0);
  pgassign30(3 downto 3) <= BRAM_WEN_A(1 to 1);
  pgassign30(2 downto 2) <= BRAM_WEN_A(1 to 1);
  pgassign30(1 downto 1) <= BRAM_WEN_A(1 to 1);
  pgassign30(0 downto 0) <= BRAM_WEN_A(1 to 1);
  pgassign31(13 downto 2) <= BRAM_Addr_B(18 to 29);
  pgassign31(1 downto 0) <= B"00";
  pgassign32(31 downto 4) <= B"0000000000000000000000000000";
  pgassign32(3 downto 0) <= BRAM_Dout_B(12 to 15);
  BRAM_Din_B(12 to 15) <= pgassign33(3 downto 0);
  pgassign34(3 downto 3) <= BRAM_WEN_B(1 to 1);
  pgassign34(2 downto 2) <= BRAM_WEN_B(1 to 1);
  pgassign34(1 downto 1) <= BRAM_WEN_B(1 to 1);
  pgassign34(0 downto 0) <= BRAM_WEN_B(1 to 1);
  pgassign35(13 downto 2) <= BRAM_Addr_A(18 to 29);
  pgassign35(1 downto 0) <= B"00";
  pgassign36(31 downto 4) <= B"0000000000000000000000000000";
  pgassign36(3 downto 0) <= BRAM_Dout_A(16 to 19);
  BRAM_Din_A(16 to 19) <= pgassign37(3 downto 0);
  pgassign38(3 downto 3) <= BRAM_WEN_A(2 to 2);
  pgassign38(2 downto 2) <= BRAM_WEN_A(2 to 2);
  pgassign38(1 downto 1) <= BRAM_WEN_A(2 to 2);
  pgassign38(0 downto 0) <= BRAM_WEN_A(2 to 2);
  pgassign39(13 downto 2) <= BRAM_Addr_B(18 to 29);
  pgassign39(1 downto 0) <= B"00";
  pgassign40(31 downto 4) <= B"0000000000000000000000000000";
  pgassign40(3 downto 0) <= BRAM_Dout_B(16 to 19);
  BRAM_Din_B(16 to 19) <= pgassign41(3 downto 0);
  pgassign42(3 downto 3) <= BRAM_WEN_B(2 to 2);
  pgassign42(2 downto 2) <= BRAM_WEN_B(2 to 2);
  pgassign42(1 downto 1) <= BRAM_WEN_B(2 to 2);
  pgassign42(0 downto 0) <= BRAM_WEN_B(2 to 2);
  pgassign43(13 downto 2) <= BRAM_Addr_A(18 to 29);
  pgassign43(1 downto 0) <= B"00";
  pgassign44(31 downto 4) <= B"0000000000000000000000000000";
  pgassign44(3 downto 0) <= BRAM_Dout_A(20 to 23);
  BRAM_Din_A(20 to 23) <= pgassign45(3 downto 0);
  pgassign46(3 downto 3) <= BRAM_WEN_A(2 to 2);
  pgassign46(2 downto 2) <= BRAM_WEN_A(2 to 2);
  pgassign46(1 downto 1) <= BRAM_WEN_A(2 to 2);
  pgassign46(0 downto 0) <= BRAM_WEN_A(2 to 2);
  pgassign47(13 downto 2) <= BRAM_Addr_B(18 to 29);
  pgassign47(1 downto 0) <= B"00";
  pgassign48(31 downto 4) <= B"0000000000000000000000000000";
  pgassign48(3 downto 0) <= BRAM_Dout_B(20 to 23);
  BRAM_Din_B(20 to 23) <= pgassign49(3 downto 0);
  pgassign50(3 downto 3) <= BRAM_WEN_B(2 to 2);
  pgassign50(2 downto 2) <= BRAM_WEN_B(2 to 2);
  pgassign50(1 downto 1) <= BRAM_WEN_B(2 to 2);
  pgassign50(0 downto 0) <= BRAM_WEN_B(2 to 2);
  pgassign51(13 downto 2) <= BRAM_Addr_A(18 to 29);
  pgassign51(1 downto 0) <= B"00";
  pgassign52(31 downto 4) <= B"0000000000000000000000000000";
  pgassign52(3 downto 0) <= BRAM_Dout_A(24 to 27);
  BRAM_Din_A(24 to 27) <= pgassign53(3 downto 0);
  pgassign54(3 downto 3) <= BRAM_WEN_A(3 to 3);
  pgassign54(2 downto 2) <= BRAM_WEN_A(3 to 3);
  pgassign54(1 downto 1) <= BRAM_WEN_A(3 to 3);
  pgassign54(0 downto 0) <= BRAM_WEN_A(3 to 3);
  pgassign55(13 downto 2) <= BRAM_Addr_B(18 to 29);
  pgassign55(1 downto 0) <= B"00";
  pgassign56(31 downto 4) <= B"0000000000000000000000000000";
  pgassign56(3 downto 0) <= BRAM_Dout_B(24 to 27);
  BRAM_Din_B(24 to 27) <= pgassign57(3 downto 0);
  pgassign58(3 downto 3) <= BRAM_WEN_B(3 to 3);
  pgassign58(2 downto 2) <= BRAM_WEN_B(3 to 3);
  pgassign58(1 downto 1) <= BRAM_WEN_B(3 to 3);
  pgassign58(0 downto 0) <= BRAM_WEN_B(3 to 3);
  pgassign59(13 downto 2) <= BRAM_Addr_A(18 to 29);
  pgassign59(1 downto 0) <= B"00";
  pgassign60(31 downto 4) <= B"0000000000000000000000000000";
  pgassign60(3 downto 0) <= BRAM_Dout_A(28 to 31);
  BRAM_Din_A(28 to 31) <= pgassign61(3 downto 0);
  pgassign62(3 downto 3) <= BRAM_WEN_A(3 to 3);
  pgassign62(2 downto 2) <= BRAM_WEN_A(3 to 3);
  pgassign62(1 downto 1) <= BRAM_WEN_A(3 to 3);
  pgassign62(0 downto 0) <= BRAM_WEN_A(3 to 3);
  pgassign63(13 downto 2) <= BRAM_Addr_B(18 to 29);
  pgassign63(1 downto 0) <= B"00";
  pgassign64(31 downto 4) <= B"0000000000000000000000000000";
  pgassign64(3 downto 0) <= BRAM_Dout_B(28 to 31);
  BRAM_Din_B(28 to 31) <= pgassign65(3 downto 0);
  pgassign66(3 downto 3) <= BRAM_WEN_B(3 to 3);
  pgassign66(2 downto 2) <= BRAM_WEN_B(3 to 3);
  pgassign66(1 downto 1) <= BRAM_WEN_B(3 to 3);
  pgassign66(0 downto 0) <= BRAM_WEN_B(3 to 3);
  net_gnd0 <= '0';
  net_gnd4(3 downto 0) <= B"0000";

  ramb16bwer_0 : RAMB16BWER
    generic map (
      INIT_FILE => "microblaze_0_bram_block_combined_0.mem",
      DATA_WIDTH_A => 4,
      DATA_WIDTH_B => 4
    )
    port map (
      ADDRA => pgassign3,
      CLKA => BRAM_Clk_A,
      DIA => pgassign4,
      DIPA => net_gnd4,
      DOA => pgassign5,
      DOPA => open,
      ENA => BRAM_EN_A,
      REGCEA => net_gnd0,
      RSTA => BRAM_Rst_A,
      WEA => pgassign6,
      ADDRB => pgassign7,
      CLKB => BRAM_Clk_B,
      DIB => pgassign8,
      DIPB => net_gnd4,
      DOB => pgassign9,
      DOPB => open,
      ENB => BRAM_EN_B,
      REGCEB => net_gnd0,
      RSTB => BRAM_Rst_B,
      WEB => pgassign10
    );

  ramb16bwer_1 : RAMB16BWER
    generic map (
      INIT_FILE => "microblaze_0_bram_block_combined_1.mem",
      DATA_WIDTH_A => 4,
      DATA_WIDTH_B => 4
    )
    port map (
      ADDRA => pgassign11,
      CLKA => BRAM_Clk_A,
      DIA => pgassign12,
      DIPA => net_gnd4,
      DOA => pgassign13,
      DOPA => open,
      ENA => BRAM_EN_A,
      REGCEA => net_gnd0,
      RSTA => BRAM_Rst_A,
      WEA => pgassign14,
      ADDRB => pgassign15,
      CLKB => BRAM_Clk_B,
      DIB => pgassign16,
      DIPB => net_gnd4,
      DOB => pgassign17,
      DOPB => open,
      ENB => BRAM_EN_B,
      REGCEB => net_gnd0,
      RSTB => BRAM_Rst_B,
      WEB => pgassign18
    );

  ramb16bwer_2 : RAMB16BWER
    generic map (
      INIT_FILE => "microblaze_0_bram_block_combined_2.mem",
      DATA_WIDTH_A => 4,
      DATA_WIDTH_B => 4
    )
    port map (
      ADDRA => pgassign19,
      CLKA => BRAM_Clk_A,
      DIA => pgassign20,
      DIPA => net_gnd4,
      DOA => pgassign21,
      DOPA => open,
      ENA => BRAM_EN_A,
      REGCEA => net_gnd0,
      RSTA => BRAM_Rst_A,
      WEA => pgassign22,
      ADDRB => pgassign23,
      CLKB => BRAM_Clk_B,
      DIB => pgassign24,
      DIPB => net_gnd4,
      DOB => pgassign25,
      DOPB => open,
      ENB => BRAM_EN_B,
      REGCEB => net_gnd0,
      RSTB => BRAM_Rst_B,
      WEB => pgassign26
    );

  ramb16bwer_3 : RAMB16BWER
    generic map (
      INIT_FILE => "microblaze_0_bram_block_combined_3.mem",
      DATA_WIDTH_A => 4,
      DATA_WIDTH_B => 4
    )
    port map (
      ADDRA => pgassign27,
      CLKA => BRAM_Clk_A,
      DIA => pgassign28,
      DIPA => net_gnd4,
      DOA => pgassign29,
      DOPA => open,
      ENA => BRAM_EN_A,
      REGCEA => net_gnd0,
      RSTA => BRAM_Rst_A,
      WEA => pgassign30,
      ADDRB => pgassign31,
      CLKB => BRAM_Clk_B,
      DIB => pgassign32,
      DIPB => net_gnd4,
      DOB => pgassign33,
      DOPB => open,
      ENB => BRAM_EN_B,
      REGCEB => net_gnd0,
      RSTB => BRAM_Rst_B,
      WEB => pgassign34
    );

  ramb16bwer_4 : RAMB16BWER
    generic map (
      INIT_FILE => "microblaze_0_bram_block_combined_4.mem",
      DATA_WIDTH_A => 4,
      DATA_WIDTH_B => 4
    )
    port map (
      ADDRA => pgassign35,
      CLKA => BRAM_Clk_A,
      DIA => pgassign36,
      DIPA => net_gnd4,
      DOA => pgassign37,
      DOPA => open,
      ENA => BRAM_EN_A,
      REGCEA => net_gnd0,
      RSTA => BRAM_Rst_A,
      WEA => pgassign38,
      ADDRB => pgassign39,
      CLKB => BRAM_Clk_B,
      DIB => pgassign40,
      DIPB => net_gnd4,
      DOB => pgassign41,
      DOPB => open,
      ENB => BRAM_EN_B,
      REGCEB => net_gnd0,
      RSTB => BRAM_Rst_B,
      WEB => pgassign42
    );

  ramb16bwer_5 : RAMB16BWER
    generic map (
      INIT_FILE => "microblaze_0_bram_block_combined_5.mem",
      DATA_WIDTH_A => 4,
      DATA_WIDTH_B => 4
    )
    port map (
      ADDRA => pgassign43,
      CLKA => BRAM_Clk_A,
      DIA => pgassign44,
      DIPA => net_gnd4,
      DOA => pgassign45,
      DOPA => open,
      ENA => BRAM_EN_A,
      REGCEA => net_gnd0,
      RSTA => BRAM_Rst_A,
      WEA => pgassign46,
      ADDRB => pgassign47,
      CLKB => BRAM_Clk_B,
      DIB => pgassign48,
      DIPB => net_gnd4,
      DOB => pgassign49,
      DOPB => open,
      ENB => BRAM_EN_B,
      REGCEB => net_gnd0,
      RSTB => BRAM_Rst_B,
      WEB => pgassign50
    );

  ramb16bwer_6 : RAMB16BWER
    generic map (
      INIT_FILE => "microblaze_0_bram_block_combined_6.mem",
      DATA_WIDTH_A => 4,
      DATA_WIDTH_B => 4
    )
    port map (
      ADDRA => pgassign51,
      CLKA => BRAM_Clk_A,
      DIA => pgassign52,
      DIPA => net_gnd4,
      DOA => pgassign53,
      DOPA => open,
      ENA => BRAM_EN_A,
      REGCEA => net_gnd0,
      RSTA => BRAM_Rst_A,
      WEA => pgassign54,
      ADDRB => pgassign55,
      CLKB => BRAM_Clk_B,
      DIB => pgassign56,
      DIPB => net_gnd4,
      DOB => pgassign57,
      DOPB => open,
      ENB => BRAM_EN_B,
      REGCEB => net_gnd0,
      RSTB => BRAM_Rst_B,
      WEB => pgassign58
    );

  ramb16bwer_7 : RAMB16BWER
    generic map (
      INIT_FILE => "microblaze_0_bram_block_combined_7.mem",
      DATA_WIDTH_A => 4,
      DATA_WIDTH_B => 4
    )
    port map (
      ADDRA => pgassign59,
      CLKA => BRAM_Clk_A,
      DIA => pgassign60,
      DIPA => net_gnd4,
      DOA => pgassign61,
      DOPA => open,
      ENA => BRAM_EN_A,
      REGCEA => net_gnd0,
      RSTA => BRAM_Rst_A,
      WEA => pgassign62,
      ADDRB => pgassign63,
      CLKB => BRAM_Clk_B,
      DIB => pgassign64,
      DIPB => net_gnd4,
      DOB => pgassign65,
      DOPB => open,
      ENB => BRAM_EN_B,
      REGCEB => net_gnd0,
      RSTB => BRAM_Rst_B,
      WEB => pgassign66
    );

end architecture STRUCTURE;

