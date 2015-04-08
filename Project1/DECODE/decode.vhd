----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:37:49 03/24/2015 
-- Design Name: 
-- Module Name:    decode - Behavioral 
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

entity decode is
	Port( CLK 		: IN STD_LOGIC;
			INST_IN  : IN STD_LOGIC_VECTOR(15 downto 0);
			OPCODE 	: OUT STD_LOGIC_VECTOR(3 downto 0);
			REG_A 	: OUT STD_LOGIC_VECTOR(3 downto 0);
			IMMEDIATE: OUT STD_LOGIC_VECTOR(7 downto 0)
			);
end decode;

architecture Behavioral of decode is

begin
	Process(CLK)
	BEGIN
		IF(CLK'EVENT and CLK = '0') then
			OPCODE    <= INST_IN(15 downto 12);
			REG_A     <= INST_IN(11 downto 8);
			IMMEDIATE <= INST_IN(7 downto 0);
		end IF;
	end Process;
end Behavioral;

