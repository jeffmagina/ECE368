---------------------------------------------------
-- School: University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Engineer: Jeffrey Magina and Jon Leidhold
-- 
-- Create Date:    SPRING 2015
-- Module Name:    Flip Flop
-- Project Name:   ALUwithINPUT
-- Target Devices: Spartan-3E
-- Tool versions:  Xilinx ISE 14.7
-- Description:    8 bit Flip Flop Register
---------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity flipflop is
	Port ( CLK     : in  STD_LOGIC;
			 INST_ENB : IN STD_LOGIC;
          D_IN    : in  STD_LOGIC_VECTOR (15 downto 0);
          D_OUT   : out STD_LOGIC_VECTOR (15 downto 0));
end flipflop;

architecture Behavioral of flipflop is

begin
	Process(CLK)
		begin
			if(CLK'event and CLK='0') then
				if( INST_ENB = '1') then
					D_OUT <= D_IN;
				end if;
			end if;
	end Process;
end Behavioral;

