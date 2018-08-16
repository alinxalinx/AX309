-------------------------------------------------------------------------------
-- system_stub.vhd
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

entity system_stub is
  port (
    RESET : in std_logic;
    CLK_P : in std_logic;
    led_4b_GPIO_IO_pin : inout std_logic_vector(3 downto 0);
    key_4b_GPIO_IO_pin : inout std_logic_vector(3 downto 0);
    axi_uartlite_0_RX_pin : in std_logic;
    axi_uartlite_0_TX_pin : out std_logic;
    axi_iic_0_Sda_pin : inout std_logic;
    axi_iic_0_Scl_pin : inout std_logic;
    axi_rtc_GPIO_IO_pin : inout std_logic_vector(2 downto 0);
    spi_flash_SCK_pin : inout std_logic;
    spi_flash_MISO_pin : inout std_logic;
    spi_flash_MOSI_pin : inout std_logic;
    spi_flash_SS_pin : inout std_logic;
    smg_ip_0_Scan_Sig_pin : out std_logic_vector(5 downto 0);
    smg_ip_0_SMG_Data_pin : out std_logic_vector(7 downto 0);
    buzzer_1b_GPIO_IO_pin : inout std_logic;
    vga_ip_0_vga_vs_pin : out std_logic;
    vga_ip_0_vga_r_pin : out std_logic_vector(4 downto 0);
    vga_ip_0_vga_hs_pin : out std_logic;
    vga_ip_0_vga_g_pin : out std_logic_vector(5 downto 0);
    vga_ip_0_vga_b_pin : out std_logic_vector(4 downto 0)
  );
end system_stub;

architecture STRUCTURE of system_stub is

  component system is
    port (
      RESET : in std_logic;
      CLK_P : in std_logic;
      led_4b_GPIO_IO_pin : inout std_logic_vector(3 downto 0);
      key_4b_GPIO_IO_pin : inout std_logic_vector(3 downto 0);
      axi_uartlite_0_RX_pin : in std_logic;
      axi_uartlite_0_TX_pin : out std_logic;
      axi_iic_0_Sda_pin : inout std_logic;
      axi_iic_0_Scl_pin : inout std_logic;
      axi_rtc_GPIO_IO_pin : inout std_logic_vector(2 downto 0);
      spi_flash_SCK_pin : inout std_logic;
      spi_flash_MISO_pin : inout std_logic;
      spi_flash_MOSI_pin : inout std_logic;
      spi_flash_SS_pin : inout std_logic;
      smg_ip_0_Scan_Sig_pin : out std_logic_vector(5 downto 0);
      smg_ip_0_SMG_Data_pin : out std_logic_vector(7 downto 0);
      buzzer_1b_GPIO_IO_pin : inout std_logic;
      vga_ip_0_vga_vs_pin : out std_logic;
      vga_ip_0_vga_r_pin : out std_logic_vector(4 downto 0);
      vga_ip_0_vga_hs_pin : out std_logic;
      vga_ip_0_vga_g_pin : out std_logic_vector(5 downto 0);
      vga_ip_0_vga_b_pin : out std_logic_vector(4 downto 0)
    );
  end component;

  attribute BOX_TYPE : STRING;
  attribute BOX_TYPE of system : component is "user_black_box";

begin

  system_i : system
    port map (
      RESET => RESET,
      CLK_P => CLK_P,
      led_4b_GPIO_IO_pin => led_4b_GPIO_IO_pin,
      key_4b_GPIO_IO_pin => key_4b_GPIO_IO_pin,
      axi_uartlite_0_RX_pin => axi_uartlite_0_RX_pin,
      axi_uartlite_0_TX_pin => axi_uartlite_0_TX_pin,
      axi_iic_0_Sda_pin => axi_iic_0_Sda_pin,
      axi_iic_0_Scl_pin => axi_iic_0_Scl_pin,
      axi_rtc_GPIO_IO_pin => axi_rtc_GPIO_IO_pin,
      spi_flash_SCK_pin => spi_flash_SCK_pin,
      spi_flash_MISO_pin => spi_flash_MISO_pin,
      spi_flash_MOSI_pin => spi_flash_MOSI_pin,
      spi_flash_SS_pin => spi_flash_SS_pin,
      smg_ip_0_Scan_Sig_pin => smg_ip_0_Scan_Sig_pin,
      smg_ip_0_SMG_Data_pin => smg_ip_0_SMG_Data_pin,
      buzzer_1b_GPIO_IO_pin => buzzer_1b_GPIO_IO_pin,
      vga_ip_0_vga_vs_pin => vga_ip_0_vga_vs_pin,
      vga_ip_0_vga_r_pin => vga_ip_0_vga_r_pin,
      vga_ip_0_vga_hs_pin => vga_ip_0_vga_hs_pin,
      vga_ip_0_vga_g_pin => vga_ip_0_vga_g_pin,
      vga_ip_0_vga_b_pin => vga_ip_0_vga_b_pin
    );

end architecture STRUCTURE;

