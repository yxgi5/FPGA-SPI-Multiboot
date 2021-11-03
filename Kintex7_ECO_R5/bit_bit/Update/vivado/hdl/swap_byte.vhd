----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2020/06/11 22:01:24
-- Design Name: 
-- Module Name: swap_byte - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity swap_byte is
  Port ( 
  din_word:in std_logic_vector(31 downto 0);
  dout_word:out std_logic_vector(31 downto 0)
  );
end swap_byte;

architecture Behavioral of swap_byte is

signal din_byte_0:std_logic_vector(7 downto 0);
signal dout_byte_0:std_logic_vector(7 downto 0);

signal din_byte_1:std_logic_vector(7 downto 0);
signal dout_byte_1:std_logic_vector(7 downto 0);

signal din_byte_2:std_logic_vector(7 downto 0);
signal dout_byte_2:std_logic_vector(7 downto 0);

signal din_byte_3:std_logic_vector(7 downto 0);
signal dout_byte_3:std_logic_vector(7 downto 0);

begin

dout_byte_0(7)<=din_byte_0(0);
dout_byte_0(6)<=din_byte_0(1);
dout_byte_0(5)<=din_byte_0(2);
dout_byte_0(4)<=din_byte_0(3);
dout_byte_0(3)<=din_byte_0(4);
dout_byte_0(2)<=din_byte_0(5);
dout_byte_0(1)<=din_byte_0(6);
dout_byte_0(0)<=din_byte_0(7);


dout_byte_1(7)<=din_byte_1(0);
dout_byte_1(6)<=din_byte_1(1);
dout_byte_1(5)<=din_byte_1(2);
dout_byte_1(4)<=din_byte_1(3);
dout_byte_1(3)<=din_byte_1(4);
dout_byte_1(2)<=din_byte_1(5);
dout_byte_1(1)<=din_byte_1(6);
dout_byte_1(0)<=din_byte_1(7);


dout_byte_2(7)<=din_byte_2(0);
dout_byte_2(6)<=din_byte_2(1);
dout_byte_2(5)<=din_byte_2(2);
dout_byte_2(4)<=din_byte_2(3);
dout_byte_2(3)<=din_byte_2(4);
dout_byte_2(2)<=din_byte_2(5);
dout_byte_2(1)<=din_byte_2(6);
dout_byte_2(0)<=din_byte_2(7);


dout_byte_3(7)<=din_byte_3(0);
dout_byte_3(6)<=din_byte_3(1);
dout_byte_3(5)<=din_byte_3(2);
dout_byte_3(4)<=din_byte_3(3);
dout_byte_3(3)<=din_byte_3(4);
dout_byte_3(2)<=din_byte_3(5);
dout_byte_3(1)<=din_byte_3(6);
dout_byte_3(0)<=din_byte_3(7);

din_byte_0<=din_word(7 downto 0);
din_byte_1<=din_word(15 downto 8);
din_byte_2<=din_word(23 downto 16);
din_byte_3<=din_word(31 downto 24);

dout_word(7 downto 0)<=dout_byte_0;
dout_word(15 downto 8)<=dout_byte_1;
dout_word(23 downto 16)<=dout_byte_2;
dout_word(31 downto 24)<=dout_byte_3;


end Behavioral;
