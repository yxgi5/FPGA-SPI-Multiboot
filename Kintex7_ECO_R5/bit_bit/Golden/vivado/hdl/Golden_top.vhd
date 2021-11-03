----------------------------------------------------------------------------------
-- Company: 
-- Engineer:FengYaTou 
-- 
-- Create Date: 2020/06/11 20:56:39
-- Design Name: 
-- Module Name: Golden - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Golden is
Port ( 
--     reset             : in     std_logic;
     reset_n         : in     std_logic;
--     clk_in1_p         : in     std_logic;
--     clk_in1_n         : in     std_logic;--- Differential 200 Mhz clock input
     clk_in1         : in     std_logic;--- 50 Mhz clock input
     led:out std_logic_vector(7 downto 0);
     SW11:in std_logic_vector(3 downto 0)
		);
end Golden;

architecture Behavioral of Golden is

------ Golden -------
constant led_constant:std_logic_vector(7 downto 0):= "10000000";
constant addr_multiboot:std_logic_vector(31 downto 0):= X"00800000";

-------- Update -------
--constant led_constant:std_logic_vector(7 downto 0):= "10001000";
--constant addr_multiboot:std_logic_vector(31 downto 0):= X"00000000";


------ Differential Clock input 200 MHz -------

component clk_wiz_0 is
  Port ( 
    clk_out1 : out STD_LOGIC;
    reset : in STD_LOGIC;
    locked : out STD_LOGIC;
--    clk_in1_p : in STD_LOGIC;
--    clk_in1_n : in STD_LOGIC
    clk_in1: in STD_LOGIC
  );
end component;
 
---- LED pattern output ----
component LED_Display is
generic(     
    led_constant:std_logic_vector(7 downto 0):= "10000000"
     );
port(  
    clk : in std_logic;
    rst_n:in std_logic;
    led_out: out std_logic_vector(7 downto 0)
     );
end component LED_Display;

component ICAP_multiboot is
generic(     
  constant addr_multiboot:std_logic_vector(31 downto 0):= X"0000000F"
     );
  Port (
  clkin:in std_logic;
  rst_n:in std_logic;
  sel_multiboot:in std_logic
   );
end component ICAP_multiboot;

signal clk_icap:std_logic;
signal locked:std_logic;
signal reset:std_logic;
signal sel_multiboot:std_logic;
begin

reset <= not reset_n;

------ Golden -------
sel_multiboot<=SW11(0);

-------- Update -------
--sel_multiboot<=not SW11(0);

------- Instantiation of all modules  -------

clk_instance: clk_wiz_0
   port map ( 
  -- Clock out ports  
   clk_out1 =>clk_icap,
  -- Status and control signals                
   reset => reset,
   locked => locked,
   -- Clock in ports
--   clk_in1_p => clk_in1_p,
--   clk_in1_n => clk_in1_n
    clk_in1 => clk_in1
 );

Led_ini: LED_Display
generic map(     
   led_constant=>led_constant
     )
port map(  
    clk=>clk_icap,
    rst_n=>locked,
    led_out=>led
     );

Icap_ini:ICAP_multiboot
generic map(     
  addr_multiboot=>addr_multiboot
     )
Port map(
  clkin=>clk_icap,
  rst_n=>locked,
  sel_multiboot=>sel_multiboot
   );

end Behavioral;