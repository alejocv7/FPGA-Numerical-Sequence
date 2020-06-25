--------------------------------------------------
-- MicroSys.vhd - Alejandro Cañizares - 11/11/2018 
-- MicroSys sort of Fibonnaci sequence
--------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
use IEEE.numeric_std_unsigned.ALL;
--use IEEE.STD_LOGIC_unsigned.ALL;

entity MicroSys is
  Port ( clk_in, clr_in  : in  STD_LOGIC;
         SWX             : in  STD_LOGIC_VECTOR (7 downto 0);
         LEDS            : out STD_LOGIC_VECTOR (7 downto 0));
end MicroSys;

architecture struct of MicroSys is

-- Components:
    component Controller is
        Port ( clk, clr      : in  STD_LOGIC;
               CF, ZF        : in  STD_LOGIC;
               Minput_vector : out STD_LOGIC_VECTOR (17 downto 0));
    end component;
    
    component Dpath is
        Port ( clk, clr      : in  STD_LOGIC;
               Minput_vector : in  STD_LOGIC_VECTOR (17 downto 0);
               Dy, SWX       : in  STD_LOGIC_VECTOR (7 downto 0);
               Ax, Dx        : out STD_LOGIC_VECTOR (7 downto 0);
               LEDS          : out STD_LOGIC_VECTOR (7 downto 0);
               CF, ZF        : out STD_LOGIC);
    end component;

    component clkd is
        Generic ( clk_f  : INTEGER := 50e6;    -- Clock Real Frecuency in Hz
                  clk_df : INTEGER := 1  );    -- Clock Desired Frecuency in Hz			  
        Port ( clk_in, reset : in  STD_LOGIC ;
               clk_out 		 : out STD_LOGIC);	
    end component;

-- Signals:
    signal clk_out, clr_out : std_logic;
    signal CF, ZF           : std_logic;
    signal Minput_vector    : std_logic_vector (17 downto 0);
    
begin

-- Changing input reset status
    clr_out <= '1' when (clr_in = '0') else '0';
        
-- Instantiation
    -- Generaring the desired clock frequenacy
    U_clock: clkd generic map (clk_f=>50e6, clk_df=>24e6)
                  port    map (clk_in=>clk_in, reset=>clr_out, clk_out=>clk_out);
                                  
    -- Controller Instantiation
    U_controller: controller 
                  port map (clk=>clk_out, clr=>clr_out, CF=>CF,
                            ZF=>ZF, Minput_vector=>Minput_vector);
                            
    -- Controller Instantiation
    U_DataPath: Dpath 
                port map (clk=>clk_out, clr=>clr_out, Minput_vector=>Minput_vector,
                          Dy=>8X"0", SWX=>SWX, LEDS=>LEDS, CF=>CF, ZF=>ZF);
end struct;
