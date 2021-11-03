----------------------------------------------------------------------------------
-- Company: 
-- Engineer:FengYaTou 
-- 
-- Create Date: 2020/06/11 20:56:39
-- Design Name: 
-- Module Name: LED_Display - Behavioral
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


------------------------------------------------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
--
------------------------------------------------------------------------------------
entity LED_Display is
generic(     
   led_constant:std_logic_vector(7 downto 0):= "10000000"
     );
port(  
    clk : in std_logic;
    rst_n:in std_logic;
    led_out : out std_logic_vector(7 downto 0)
    );
end LED_Display;

------------------------------------------------------------------------------------
-- Start of test architecture

architecture Behavioral of LED_Display is
------------------------------------------------------------------------------------
-- Signals used to interface to rotary encoder

signal led_pattern : std_logic_vector(7 downto 0):= "10000000"; --initial value puts one LED on near the middle.
signal cnt : integer :=0;

begin                       
                       
 led_display: process(clk,rst_n)
	begin
	   if rst_n='0' then
	      led_pattern<=led_constant;
	      cnt<=0;
	      led_out<=led_constant;
	   elsif rising_edge(clk) then
		  if (cnt>= 40000000) then
			 cnt <= 0;
			 led_pattern <=  led_pattern(0) &led_pattern(7 downto 1) ; --rotate LEDs right to left
		  else
			 cnt <= cnt +1;
			 led_pattern<=led_pattern;
		  end if;
		  led_out <= led_pattern; 
		end if;		
	 end process led_display;
	 
	 
end Behavioral;  