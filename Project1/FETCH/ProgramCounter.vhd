----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:13:08 03/04/2015 
-- Design Name: 
-- Module Name:    ProgramCounter - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ProgramCounter is
	Port (CLK : in STD_LOGIC;
			NEW_PC: in STD_LOGIC_VECTOR (9 downto 0):= (OTHERS => '0');
			PC_OUT: out STD_LOGIC_VECTOR (9 downto 0):= (OTHERS => '0'));
			
end ProgramCounter;

architecture Behavioral of ProgramCounter is

begin
	Process(CLK)
		begin
			if(CLK'event and CLK='1') then
				PC_OUT <= NEW_PC;
			end if;
	end Process;
		
end Behavioral;

