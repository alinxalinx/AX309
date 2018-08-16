-------------------------------------------------------------------------------
-- system_spi_flash_wrapper.vhd
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

library axi_spi_v1_02_a;
use axi_spi_v1_02_a.all;

entity system_spi_flash_wrapper is
  port (
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
    SCK_I : in std_logic;
    SCK_O : out std_logic;
    SCK_T : out std_logic;
    MISO_I : in std_logic;
    MISO_O : out std_logic;
    MISO_T : out std_logic;
    MOSI_I : in std_logic;
    MOSI_O : out std_logic;
    MOSI_T : out std_logic;
    SPISEL : in std_logic;
    SS_I : in std_logic_vector(0 downto 0);
    SS_O : out std_logic_vector(0 downto 0);
    SS_T : out std_logic;
    IP2INTC_Irpt : out std_logic
  );

  attribute x_core_info : STRING;
  attribute x_core_info of system_spi_flash_wrapper : entity is "axi_spi_v1_02_a";

end system_spi_flash_wrapper;

architecture STRUCTURE of system_spi_flash_wrapper is

  component axi_spi is
    generic (
      C_FAMILY : STRING;
      C_BASEADDR : std_logic_vector(31 downto 0);
      C_HIGHADDR : std_logic_vector(31 downto 0);
      C_S_AXI_ADDR_WIDTH : INTEGER;
      C_S_AXI_DATA_WIDTH : INTEGER;
      C_FIFO_EXIST : INTEGER;
      C_SCK_RATIO : INTEGER;
      C_NUM_SS_BITS : INTEGER;
      C_NUM_TRANSFER_BITS : INTEGER;
      C_INSTANCE : STRING
    );
    port (
      S_AXI_ACLK : in std_logic;
      S_AXI_ARESETN : in std_logic;
      S_AXI_AWADDR : in std_logic_vector((C_S_AXI_ADDR_WIDTH-1) downto 0);
      S_AXI_AWVALID : in std_logic;
      S_AXI_AWREADY : out std_logic;
      S_AXI_WDATA : in std_logic_vector((C_S_AXI_DATA_WIDTH-1) downto 0);
      S_AXI_WSTRB : in std_logic_vector(((C_S_AXI_DATA_WIDTH/8)-1) downto 0);
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
      SCK_I : in std_logic;
      SCK_O : out std_logic;
      SCK_T : out std_logic;
      MISO_I : in std_logic;
      MISO_O : out std_logic;
      MISO_T : out std_logic;
      MOSI_I : in std_logic;
      MOSI_O : out std_logic;
      MOSI_T : out std_logic;
      SPISEL : in std_logic;
      SS_I : in std_logic_vector((C_NUM_SS_BITS-1) downto 0);
      SS_O : out std_logic_vector((C_NUM_SS_BITS-1) downto 0);
      SS_T : out std_logic;
      IP2INTC_Irpt : out std_logic
    );
  end component;

begin

  spi_flash : axi_spi
    generic map (
      C_FAMILY => "spartan6",
      C_BASEADDR => X"40a20000",
      C_HIGHADDR => X"40a2ffff",
      C_S_AXI_ADDR_WIDTH => 32,
      C_S_AXI_DATA_WIDTH => 32,
      C_FIFO_EXIST => 1,
      C_SCK_RATIO => 32,
      C_NUM_SS_BITS => 1,
      C_NUM_TRANSFER_BITS => 8,
      C_INSTANCE => "spi_flash"
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
      SCK_I => SCK_I,
      SCK_O => SCK_O,
      SCK_T => SCK_T,
      MISO_I => MISO_I,
      MISO_O => MISO_O,
      MISO_T => MISO_T,
      MOSI_I => MOSI_I,
      MOSI_O => MOSI_O,
      MOSI_T => MOSI_T,
      SPISEL => SPISEL,
      SS_I => SS_I,
      SS_O => SS_O,
      SS_T => SS_T,
      IP2INTC_Irpt => IP2INTC_Irpt
    );

end architecture STRUCTURE;

