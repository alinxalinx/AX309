-------------------------------------------------------------------------------
-- system_key_4b_wrapper.vhd
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

library axi_gpio_v1_01_b;
use axi_gpio_v1_01_b.all;

entity system_key_4b_wrapper is
  port (
    S_AXI_ACLK : in std_logic;
    S_AXI_ARESETN : in std_logic;
    S_AXI_AWADDR : in std_logic_vector(8 downto 0);
    S_AXI_AWVALID : in std_logic;
    S_AXI_AWREADY : out std_logic;
    S_AXI_WDATA : in std_logic_vector(31 downto 0);
    S_AXI_WSTRB : in std_logic_vector(3 downto 0);
    S_AXI_WVALID : in std_logic;
    S_AXI_WREADY : out std_logic;
    S_AXI_BRESP : out std_logic_vector(1 downto 0);
    S_AXI_BVALID : out std_logic;
    S_AXI_BREADY : in std_logic;
    S_AXI_ARADDR : in std_logic_vector(8 downto 0);
    S_AXI_ARVALID : in std_logic;
    S_AXI_ARREADY : out std_logic;
    S_AXI_RDATA : out std_logic_vector(31 downto 0);
    S_AXI_RRESP : out std_logic_vector(1 downto 0);
    S_AXI_RVALID : out std_logic;
    S_AXI_RREADY : in std_logic;
    IP2INTC_Irpt : out std_logic;
    GPIO_IO_I : in std_logic_vector(3 downto 0);
    GPIO_IO_O : out std_logic_vector(3 downto 0);
    GPIO_IO_T : out std_logic_vector(3 downto 0);
    GPIO2_IO_I : in std_logic_vector(31 downto 0);
    GPIO2_IO_O : out std_logic_vector(31 downto 0);
    GPIO2_IO_T : out std_logic_vector(31 downto 0)
  );

  attribute x_core_info : STRING;
  attribute x_core_info of system_key_4b_wrapper : entity is "axi_gpio_v1_01_b";

end system_key_4b_wrapper;

architecture STRUCTURE of system_key_4b_wrapper is

  component axi_gpio is
    generic (
      C_FAMILY : STRING;
      C_INSTANCE : STRING;
      C_S_AXI_DATA_WIDTH : INTEGER;
      C_GPIO_WIDTH : INTEGER;
      C_GPIO2_WIDTH : INTEGER;
      C_ALL_INPUTS : INTEGER;
      C_ALL_INPUTS_2 : INTEGER;
      C_INTERRUPT_PRESENT : INTEGER;
      C_DOUT_DEFAULT : std_logic_vector(31 downto 0);
      C_TRI_DEFAULT : std_logic_vector(31 downto 0);
      C_IS_DUAL : INTEGER;
      C_DOUT_DEFAULT_2 : std_logic_vector(31 downto 0);
      C_TRI_DEFAULT_2 : std_logic_vector(31 downto 0)
    );
    port (
      S_AXI_ACLK : in std_logic;
      S_AXI_ARESETN : in std_logic;
      S_AXI_AWADDR : in std_logic_vector(8 downto 0);
      S_AXI_AWVALID : in std_logic;
      S_AXI_AWREADY : out std_logic;
      S_AXI_WDATA : in std_logic_vector((C_S_AXI_DATA_WIDTH-1) downto 0);
      S_AXI_WSTRB : in std_logic_vector(((C_S_AXI_DATA_WIDTH/8)-1) downto 0);
      S_AXI_WVALID : in std_logic;
      S_AXI_WREADY : out std_logic;
      S_AXI_BRESP : out std_logic_vector(1 downto 0);
      S_AXI_BVALID : out std_logic;
      S_AXI_BREADY : in std_logic;
      S_AXI_ARADDR : in std_logic_vector(8 downto 0);
      S_AXI_ARVALID : in std_logic;
      S_AXI_ARREADY : out std_logic;
      S_AXI_RDATA : out std_logic_vector((C_S_AXI_DATA_WIDTH-1) downto 0);
      S_AXI_RRESP : out std_logic_vector(1 downto 0);
      S_AXI_RVALID : out std_logic;
      S_AXI_RREADY : in std_logic;
      IP2INTC_Irpt : out std_logic;
      GPIO_IO_I : in std_logic_vector((C_GPIO_WIDTH-1) downto 0);
      GPIO_IO_O : out std_logic_vector((C_GPIO_WIDTH-1) downto 0);
      GPIO_IO_T : out std_logic_vector((C_GPIO_WIDTH-1) downto 0);
      GPIO2_IO_I : in std_logic_vector((C_GPIO2_WIDTH-1) downto 0);
      GPIO2_IO_O : out std_logic_vector((C_GPIO2_WIDTH-1) downto 0);
      GPIO2_IO_T : out std_logic_vector((C_GPIO2_WIDTH-1) downto 0)
    );
  end component;

begin

  key_4b : axi_gpio
    generic map (
      C_FAMILY => "spartan6",
      C_INSTANCE => "key_4b",
      C_S_AXI_DATA_WIDTH => 32,
      C_GPIO_WIDTH => 4,
      C_GPIO2_WIDTH => 32,
      C_ALL_INPUTS => 1,
      C_ALL_INPUTS_2 => 0,
      C_INTERRUPT_PRESENT => 0,
      C_DOUT_DEFAULT => X"00000000",
      C_TRI_DEFAULT => X"ffffffff",
      C_IS_DUAL => 0,
      C_DOUT_DEFAULT_2 => X"00000000",
      C_TRI_DEFAULT_2 => X"ffffffff"
    )
    port map (
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
      IP2INTC_Irpt => IP2INTC_Irpt,
      GPIO_IO_I => GPIO_IO_I,
      GPIO_IO_O => GPIO_IO_O,
      GPIO_IO_T => GPIO_IO_T,
      GPIO2_IO_I => GPIO2_IO_I,
      GPIO2_IO_O => GPIO2_IO_O,
      GPIO2_IO_T => GPIO2_IO_T
    );

end architecture STRUCTURE;

