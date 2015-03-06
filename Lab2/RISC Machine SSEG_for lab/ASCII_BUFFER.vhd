---------------------------------------------------
-- School: University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Engineer: Jeffrey Magina and Jon Leidhold
-- 
-- Create Date:    SPRING 2015
-- Module Name:    DEBUG UNIT
-- Project Name:   DEBUG UNIT
-- Target Devices: Spartan-3E
-- Tool versions:  Xilinx ISE 14.7
-- Description: Debug Unit for part 4 of Lab 1
-- Takes in a 0 - F on the ASCII_DATA line
-- and outputs it to the BUFFER concatenated
-- together to form the Instruction 
---------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ASCII_BUFFER is
	port(
		ASCII_DATA : in STD_LOGIC_VECTOR(7 downto 0);
		ASCII_RD: in STD_LOGIC;
		ASCII_WE: in STD_LOGIC;
		CLK: in STD_LOGIC;
		RST: in STD_LOGIC;
		ASCII_BUFF: out STD_LOGIC_VECTOR(19 downto 0)
		);
		
end ASCII_BUFFER;

architecture dataflow of ASCII_BUFFER is
	type StateType is (init, idle, VALID_KEY, SPECIAL_KEY, BACKSPACE, FLUSH);
	signal STATE : StateType := init;
	
	type ram_type is array (0 to 5) of STD_LOGIC_VECTOR(3 downto 0);
	signal ram_addr : integer range 0 to 5;
	signal ram : ram_type;
	
	signal KEY : STD_LOGIC_VECTOR(3 downto 0);
	signal INST: STD_LOGIC_VECTOR(19 downto 0) := (OTHERS => '0');
begin
	with ASCII_DATA select
		KEY <=
			x"f" when x"66",
			x"e" when x"65",
			x"d" when x"64",
			x"c" when x"63",
			x"b" when x"62",
			x"a" when x"61",
			x"F" when x"46",
			x"E" when x"45",
			x"D" when x"44",
			x"C" when x"43",
			x"B" when x"42",
			x"A" when x"41",
			x"9" when x"39",
			x"8" when x"38",
			x"7" when x"37",
			x"6" when x"36",
			x"5" when x"35",
			x"4" when x"34",
			x"3" when x"33",
			x"2" when x"32",
			x"1" when x"31",
			x"0" when x"30",
			x"0" when OTHERS; -- Null
			
	PROCESS(CLK,RST)

	BEGIN

		if(RST = '1') then
			STATE <= init;
		elsif (CLK'event and CLK= '1' ) then
			case STATE is
				when init =>
					ASCII_BUFF <= (OTHERS => '0');
					ram(0) <= x"0";
					ram(1) <= x"0";
					ram(2) <= x"0";
					ram(3) <= x"0";
					ram(4) <= x"0";
					ram_addr <= 0;
					state <= idle;
					
				when idle =>
					ASCII_BUFF <= INST;
					if ASCII_RD = '1' and ASCII_WE = '1' then
						state <= VALID_KEY;
					-- A Valid key was pressed
					elsif ASCII_RD = '1' and ASCII_WE = '0' then
						state <= SPECIAL_KEY;
					--Special key was pressed
					else
						state <= idle;
					end if;
				
				when VALID_KEY =>
					if ram_addr < 5 then
						ram(ram_addr) <= key;
						ram_addr <= ram_addr + 1;
					else
						ram_addr <= 5;
					end if;
					state <= idle;
					
				when SPECIAL_KEY =>
					if ASCII_DATA = x"0D" then --0D = enterkey
						state <= FLUSH; 
					elsif ASCII_DATA = x"08" then -- 08 = backspace
						state <= BACKSPACE;
					else 
						state <= idle;
					end if;
						
				when BACKSPACE =>
					if ram_addr > 0 then
						ram_addr <= ram_addr - 1;
					end if;
						ram(ram_addr) <= x"0";
						state <= idle;
				
				when FLUSH =>
						INST <= ram(0) & ram(1) & ram(2) & ram(3) & ram(4);
						state <= init;
						
				when OTHERS =>
					state <= idle;
			end case;
		end if;
	end process;
end architecture dataflow;

