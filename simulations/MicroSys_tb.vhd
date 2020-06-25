---------------------------------------------------------
-- MicroSys_tb.vhd - Alejandro Cañizares - 11/11/2018 
-- MicroSys Testbench
---------------------------------------------------------
library IEEE;
use IEEE.Std_logic_1164.all;
--use IEEE.Numeric_Std.all;

entity MicroSys_tb is
end;

architecture bench of MicroSys_tb is

  component MicroSys is
      Port ( clk_in, clr_in  : in  STD_LOGIC;
             SWX             : in  STD_LOGIC_VECTOR (7 downto 0);
             LEDS            : out STD_LOGIC_VECTOR (7 downto 0));
  end component;

  signal clk_in  : STD_LOGIC := '1';
  signal clr_in  : STD_LOGIC;
  signal SWX     : STD_LOGIC_VECTOR (7 downto 0);
  signal LEDS    : STD_LOGIC_VECTOR (7 downto 0);

begin

  uut: MicroSys port map ( clk_in => clk_in,
                           clr_in => clr_in,
                           SWX    => SWX,
                           LEDS   => LEDS );    
                                                      
  clk_in <= not clk_in  after 20 ns;
  clr_in <= '0', '1' after 40 ns;
   
  SWX_stimulus: process
  begin
    SWX <= 8X"00";   --   wait for 800ns;
    --SWX <= "00000010"; wait for 0.1us;
    wait;
  end process;
  
end bench;