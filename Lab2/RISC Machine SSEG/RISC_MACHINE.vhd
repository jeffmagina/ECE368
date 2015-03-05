---------------------------------------------------
-- School: University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Engineer: Jeffrey Magina and Jon Leidhold
-- 
-- Create Date:    SPRING 2015
-- Module Name:    RISC_MACHINE
-- Project Name:   RISC_MACHINE
-- Target Devices: Spartan-3E
-- Tool versions:  Xilinx ISE 14.7
-- Description: RISC Machine possibly for future
-- design of UMD RISC Machine. Takes in a 0 - F 
-- on the ASCII_DATA line outputs, it to the BUFFER 
-- concatenated together to form the Instruction 
-- which is sent to the ALU to perform a function and
-- outputs it to the seven segment display
---------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.all;

entity RISC_MACHINE is
Port( CLK : in STD_LOGIC;
		RST : in STD_LOGIC;
	   PS2_CLK  : inout STD_LOGIC;
      PS2_DATA : inout STD_LOGIC;
		SEG 	: out STD_LOGIC_VECTOR (6 downto 0);
		DP  	: out STD_LOGIC;
		AN  	: out STD_LOGIC_VECTOR (3 downto 0);
		LED : out STD_LOGIC_VECTOR (3 downto 0));
end RISC_MACHINE;

architecture Structural of RISC_MACHINE is

	signal RD,WE :STD_LOGIC;
	signal KEY_DATA : STD_LOGIC_VECTOR (7 downto 0);
	signal TO_SEG : STD_LOGIC_VECTOR(7 downto 0);
	signal TO_ALU : STD_LOGIC_VECTOR(15 downto 0);
	signal RegA : STD_LOGIC_VECTOR(7 downto 0);
	signal cen : STD_LOGIC := '0';
   signal enl : STD_LOGIC := '1';
	signal dpc : STD_LOGIC_VECTOR (3 downto 0) := "1111";
	
begin

Keyboard: entity work.KEYBOARD_CONTROLLER
    Port MAP ( CLK  => CLK,    
					RST  => RST,
					PS2_CLK => PS2_CLK,
					PS2_DATA => PS2_DATA,
					ASCII_OUT => KEY_DATA,
					ASCII_RD => RD,
					ASCII_WE => WE);
			  
Debug_Unit: entity work.ASCII_BUFFER 
	 port MAP(
		ASCII_DATA => KEY_DATA,
		ASCII_RD => RD,
		ASCII_WE => WE,
		CLK => CLK,
		RST => RST,
		ASCII_BUFF => TO_ALU);
		
SSeg: entity work.SSegDriver
    port map( CLK     => CLK,
              RST     => '0',
              EN      => enl,
              SEG_0   => "0000",
              SEG_1   => "0000",
              SEG_2   => TO_SEG(7 downto 4),
              SEG_3   => TO_SEG(3 downto 0),
              DP_CTRL => dpc,
              COL_EN  => cen,
              SEG_OUT => SEG,
              DP_OUT  => DP,
              AN_OUT  => AN);
				  
RegA <= ("0000" & TO_ALU(11 downto 8));

ALU: entity work.ALU
		Port map ( CLK 	  => CLK,
					  RA 		  => RegA,
					  RB 		  => TO_ALU(7 downto 0),
					  OPCODE   => TO_ALU(15 downto 12),
					  CCR      => LED(3 downto 0),
					  ALU_OUT  => TO_SEG(7 downto 0));

end Structural;

