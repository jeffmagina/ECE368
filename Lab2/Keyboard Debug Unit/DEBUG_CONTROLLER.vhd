---------------------------------------------------
-- School: University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Engineer: Jeffrey Magina and Jon Leidhold
-- 
-- Create Date:    SPRING 2015
-- Module Name:    DEBUG CONTROLLER
-- Project Name:   DEBUG CONTROLLER
-- Target Devices: Spartan-3E
-- Tool versions:  Xilinx ISE 14.7
-- Description: Debug Unit for part 4 of Lab 1
-- Takes in a 0 - F on the ASCII_DATA line
-- and outputs it to the BUFFER concatenated
-- together to form the Instruction 
---------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity DEBUG_CONTROLLER is
Port( CLK : in STD_LOGIC;
		RST : in STD_LOGIC;
	   PS2_CLK  : inout STD_LOGIC;
      PS2_DATA : inout STD_LOGIC;
		SEG 	: out STD_LOGIC_VECTOR (6 downto 0);
		DP  	: out STD_LOGIC;
		AN  	: out STD_LOGIC_VECTOR (3 downto 0));
end DEBUG_CONTROLLER;

architecture Structural of DEBUG_CONTROLLER is

	signal RD : STD_LOGIC := '0';
	signal WE : STD_LOGIC := '0';
	signal KEY_DATA : STD_LOGIC_VECTOR (7 downto 0);
	signal TO_SEG : STD_LOGIC_VECTOR(15 downto 0);
	
	signal cen : STD_LOGIC := '0';
   signal enl : STD_LOGIC := '1';
	signal dpc : STD_LOGIC_VECTOR (3 downto 0) := "1111";
	
begin


U1: entity work.KEYBOARD_CONTROLLER
    Port MAP ( CLK  => CLK,    
           RST  => RST,
           PS2_CLK => PS2_CLK,
           PS2_DATA => PS2_DATA,
           ASCII_OUT => KEY_DATA,
           ASCII_RD => RD,
           ASCII_WE => WE);

U2: entity work.ASCII_BUFFER 
	 port MAP(
		ASCII_DATA => KEY_DATA,
		ASCII_RD => RD,
		ASCII_WE => WE,
		CLK => CLK,
		RST => RST,
		ASCII_BUFF => TO_SEG);
		
	SSeg: entity work.SSegDriver
    port map( CLK     => CLK,
              RST     => '0',
              EN      => enl,
              SEG_0   => TO_SEG(15 downto 12),
              SEG_1   => TO_SEG(11 downto 8),
              SEG_2   => TO_SEG(7 downto 4),
              SEG_3   => TO_SEG(3 downto 0),
              DP_CTRL => dpc,
              COL_EN  => cen,
              SEG_OUT => SEG,
              DP_OUT  => DP,
              AN_OUT  => AN);
		
end Structural;

