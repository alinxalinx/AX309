-------------------------------------------------------------------------------
-- system_axi_uartlite_0_wrapper.vhd
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

library axi_uartlite_v1_02_a;
use axi_uartlite_v1_02_a.all;

entity system_axi_uartlite_0_wrapper is
  port (
    S_AXI_ACLK : in std_logic;
    S_AXI_ARESETN : in std_logic;
    Interrupt : out std_logic;
    S_AXI_AWADDR : in std_logic_vector(3 downto 0);
    S_AXI_AWVALID : in std_logic;
    S_AXI_AWREADY : out std_logic;
    S_AXI_WDATA : in std_logic_vector(31 downto 0);
    S_AXI_WSTRB : in std_logic_vector(3 downto 0);
    S_AXI_WVALID : in std_logic;
    S_AXI_WREADY : out std_logic;
    S_AXI_BRESP : out std_logic_vector(1 downto 0);
    S_AXI_BVALID : out std_logic;
    S_AXI_BREADY : in std_logic;
    S_AXI_ARADDR : in std_logic_vector(3 downto 0);
    S_AXI_ARVALID : in std_logic;
    S_AXI_ARREADY : out std_logic;
    S_AXI_RDATA : out std_logic_vector(31 downto 0);
    S_AXI_RRESP : out std_logic_vector(1 downto 0);
    S_AXI_RVALID : out std_logic;
    S_AXI_RREADY : in std_logic;
    RX : in std_logic;
    TX : out std_logic
  );

  attribute x_core_info : STRING;
  attribute x_core_info of system_axi_uartlite_0_wrapper : entity is "axi_uartlite_v1_02_a";

end system_axi_uartlite_0_wrapper;

architecture STRUCTURE of system_axi_uartlite_0_wrapper is

  component axi_uartlite is
    generic (
      C_FAMILY : STRING;
      C_INSTANCE : STRING;
      C_S_AXI_ACLK_FREQ_HZ : INTEGER;
      C_S_AXI_DATA_WIDTH : INTEGER;
      C_BAUDRATE : INTEGER;
      C_DATA_BITS : INTEGER;
      C_USE_PARITY : INTEGER;
      C_ODD_PARITY : INTEGER
    );
    port (
      S_AXI_ACLK : in std_logic;
      S_AXI_ARESETN : in std_logic;
      Interrupt : out std_logic;
      S_AXI_AWADDR : in std_logic_vector(3 downto 0);
      S_AXI_AWVALID : in std_logic;
      S_AXI_AWREADY : out std_logic;
      S_AXI_WDATA : in std_logic_vector((C_S_AXI_DATA_WIDTH-1) downto 0);
      S_AXI_WSTRB : in std_logic_vector(((C_S_AXI_DATA_WIDTH/8)-1) downto 0);
      S_AXI_WVALID : in std_logic;
      S_AXI_WREADY : out std_logic;
      S_AXI_BRESP : out std_logic_vector(1 downto 0);
      S_AXI_BVALID : out std_logic;
      S_AXI_BREADY : in std_logic;
      S_AXI_ARADDR : in std_logic_vector(3 downto 0);
      S_AXI_ARVALID : in std_logic;
      S_AXI_ARREADY : out std_logic;
      S_AXI_RDATA : out std_logic_vector((C_S_AXI_DATA_WIDTH-1) downto 0);
      S_AXI_RRESP : out std_logic_vector(1 downto 0);
      S_AXI_RVALID : out std_logic;
      S_AXI_RREADY : in std_logic;
      RX : in std_logic;
      TX : out std_logic
    );
  end component;

begin

  axi_uartlite_0 : axi_uartlite
    generic map (
      C_FAMILY => "spartan6",
      C_INSTANCE => "axi_uartlite_0",
      C_S_AXI_ACLK_FREQ_HZ => 100000000,
      C_S_AXI_DATA_WIDTH => 32,
      C_BAUDRATE => 9600,
      C_DATA_BITS => 8,
      C_USE_PARITY => 0,
      C_ODD_PARITY => 0
    )
    port map (
      S_AXI_ACLK => S_AXI_ACLK,
      S_AXI_ARESETN => S_AXI_ARESETN,
      Interrupt => Interrupt,
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
      RX => RX,
      TX => TX
    );

end architecture STRUCTURE;

