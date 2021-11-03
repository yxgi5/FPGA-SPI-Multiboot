----------------------------------------------------------------------------------
-- Company: 
-- Engineer:FengYaTou 
-- 
-- Create Date: 2020/06/11 20:56:39
-- Design Name: 
-- Module Name: ICAP_multiboot - Behavioral
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

entity ICAP_multiboot is
generic(     
  constant addr_multiboot:std_logic_vector(31 downto 0):= X"0000000F"
     );
  Port (
  clkin:in std_logic;
  rst_n:in std_logic;
  sel_multiboot:in std_logic
   );
end ICAP_multiboot;

architecture Behavioral of ICAP_multiboot is

constant data_Dummy:std_logic_vector(31 downto 0):= X"FFFFFFFF";
constant data_Sync:std_logic_vector(31 downto 0):= X"AA995566";
constant data_Noop:std_logic_vector(31 downto 0):= X"20000000";
constant data_WBSTAR:std_logic_vector(31 downto 0):= X"30020001";
constant data_CMD:std_logic_vector(31 downto 0):= X"30008001";
constant data_IPROG:std_logic_vector(31 downto 0):= X"0000000F";

component swap_byte is
  Port ( 
  din_word:in std_logic_vector(31 downto 0);
  dout_word:out std_logic_vector(31 downto 0)
  );
end component swap_byte;

signal Selectmap_Dummy:std_logic_vector(31 downto 0);
signal Selectmap_Sync:std_logic_vector(31 downto 0);
signal Selectmap_Noop:std_logic_vector(31 downto 0);
signal Selectmap_WBSTAR:std_logic_vector(31 downto 0);
signal Selectmap_CMD:std_logic_vector(31 downto 0);
signal Selectmap_IPROG:std_logic_vector(31 downto 0);
signal Selectmap_Addr:std_logic_vector(31 downto 0);

type state_type is (Idle_ICAP,Assert_RDWRB,Assert_CSIB,
Write_Dummy,Write_Sync,Write_Noop1,Write_WBSTAR,Multi_WBSTAR,Write_CMD,Write_IPROG,Write_Noop2,
Deassert_RDWRB,Deassert_CSIB,End_ICAP);

signal cstate:state_type;
signal nstate:state_type;

signal rdwr_b:std_logic;
signal csi_b:std_logic;
signal Din:std_logic_vector(31 downto 0);
signal Dout:std_logic_vector(31 downto 0);

signal rdwrb_icap:std_logic;
signal csib_icap:std_logic;
signal Din_icap:std_logic_vector(31 downto 0);
signal Dout_icap:std_logic_vector(31 downto 0);

begin

swap_Dummy:swap_byte
  Port map( 
  din_word=>data_Dummy,
  dout_word=>Selectmap_Dummy
  );

swap_Sync:swap_byte
  Port map( 
  din_word=>data_Sync,
  dout_word=>Selectmap_Sync
  );
  
swap_Noop:swap_byte
  Port map( 
  din_word=>data_Noop,
  dout_word=>Selectmap_Noop
  );

swap_WBSTAR:swap_byte
  Port map( 
  din_word=>data_WBSTAR,
  dout_word=>Selectmap_WBSTAR
  );  

swap_CMD:swap_byte
  Port map( 
  din_word=>data_CMD,
  dout_word=>Selectmap_CMD
  ); 
  
swap_IPROG:swap_byte
  Port map( 
  din_word=>data_IPROG,
  dout_word=>Selectmap_IPROG
  ); 
  
swap_addr:swap_byte
  Port map( 
  din_word=>addr_multiboot,
  dout_word=>Selectmap_Addr
  ); 
  
------ICAP_ctrl----

process(clkin,rst_n)
begin
if rst_n='0' then
   cstate<=Idle_ICAP;
elsif (rising_edge(clkin)) then
   cstate<=nstate;
end if;
end process;


process(cstate,sel_multiboot)
begin
   case cstate is
        when Idle_ICAP =>
             if sel_multiboot='1' then
                nstate<=Assert_RDWRB;
             else
                nstate<=idle_ICAP;
             end if;
        when Assert_RDWRB =>
             nstate<=Assert_CSIB;             
        when Assert_CSIB =>
             nstate<=Write_Dummy; 
        when Write_Dummy =>
             nstate<=Write_Sync;
        when Write_Sync =>
             nstate<=Write_Noop1;
        when Write_Noop1 =>
             nstate<=Write_WBSTAR;
        when Write_WBSTAR =>
             nstate<=Multi_WBSTAR;
        when Multi_WBSTAR =>
             nstate<=Write_CMD;
        when Write_CMD =>
             nstate<=Write_IPROG;
        when Write_IPROG =>
             nstate<=Write_Noop2;
        when Write_Noop2 =>
             nstate<=Deassert_CSIB;
        when Deassert_CSIB =>
             nstate<=Deassert_RDWRB;
        when Deassert_RDWRB =>
             nstate<=End_ICAP; 
        when End_ICAP =>
             nstate<=End_ICAP;             
        when others =>
             nstate<=Idle_ICAP;
    end case;
end process;

RDWRB_ini: process(clkin,rst_n)
begin
   if rst_n='0' then
      rdwr_b<='1';
   elsif (rising_edge(clkin)) then
      case cstate is
           when Idle_ICAP =>
                rdwr_b<='1';
           when Assert_RDWRB =>
                rdwr_b<='0';
           when Deassert_RDWRB =>
                rdwr_b<='1';                                                                     
           when others =>
                rdwr_b<=rdwr_b; 
       end case;
    end if;
end process; 

CSIB_ini: process(clkin,rst_n)
begin
   if rst_n='0' then
      csi_b<='1';
   elsif (rising_edge(clkin)) then
      case cstate is
           when Idle_ICAP =>
                csi_b<='1';
           when Assert_CSIB =>
                csi_b<='0';
           when Deassert_CSIB =>
                csi_b<='1';                                                                     
           when others =>
                csi_b<=csi_b; 
       end case;
    end if;
end process; 


Din_ini: process(clkin,rst_n)
begin
   if rst_n='0' then
      Din<=(others=>'0');
   elsif (rising_edge(clkin)) then
      case cstate is
        when Idle_ICAP =>
             Din<=(others=>'0');
        when Assert_RDWRB =>
             Din<=(others=>'0');             
        when Assert_CSIB =>
             Din<=(others=>'0'); 
        when Write_Dummy =>
             Din<=SelectMap_Dummy; 
        when Write_Sync =>
             Din<=SelectMap_Sync; 
        when Write_Noop1 =>
             Din<=SelectMap_Noop; 
        when Write_WBSTAR =>
             Din<=SelectMap_WBSTAR; 
        when Multi_WBSTAR =>
             Din<=SelectMap_Addr; 
        when Write_CMD =>
             Din<=SelectMap_CMD; 
        when Write_IPROG =>
             Din<=SelectMap_IPROG; 
        when Write_Noop2 =>
             Din<=SelectMap_Noop; 
        when Deassert_CSIB =>
             Din<=SelectMap_Noop; 
        when Deassert_RDWRB =>
             Din<=SelectMap_Noop; 
        when End_ICAP =>
             Din<=SelectMap_Noop;              
        when others =>
             Din<=SelectMap_Noop; 
    end case;
    end if;
end process; 


process(clkin,rst_n)
begin
   if rst_n='0' then
      rdwrb_icap<='1';
      csib_icap<='1';
      Din_icap<=(others=>'0');
   elsif (rising_edge(clkin)) then
      rdwrb_icap<=rdwr_b;
      csib_icap<=csi_b;
      Din_icap<=Din;
    end if;
 end process;
      

  ICAPE2_inst : ICAPE2
   generic map (
      DEVICE_ID => X"3651093",     -- Specifies the pre-programmed Device ID value to be used for simulation
                                   -- purposes.
      ICAP_WIDTH => "X32",         -- Specifies the input and output data width.
      SIM_CFG_FILE_NAME => "NONE"  -- Specifies the Raw Bitstream (RBT) file to be parsed by the simulation
                                   -- model.
   )
   port map (
      O => Dout_icap,         -- 32-bit output: Configuration data output bus
      CLK => clkin,     -- 1-bit input: Clock Input
      CSIB => csib_icap,   -- 1-bit input: Active-Low ICAP Enable
      I => Din_icap,         -- 32-bit input: Configuration data input bus
      RDWRB =>rdwrb_icap  -- 1-bit input: Read/Write Select input
   );


end Behavioral;
