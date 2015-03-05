---------------------------------------------------
-- School: University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Engineer: Jeffrey Magina and Jon Leidhold
-- 
-- Create Date:    SPRING 2015
-- Module Name:    ALUwithINPUT
-- Project Name:   ALUwithINPUT
-- Target Devices: Spartan-3E
-- Tool versions:  Xilinx ISE 14.7
-- Description: ALU for Lab 1 Part 5
-- eight switches control whats input
-- gets stored in register A when button 4
-- is clicked and stored in register B when
-- button 3 is clicked. Button 2 
---------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.all;

entity ALUwithINPUT is
    Port ( 	CLK   : in  STD_LOGIC;
				SW		: in  STD_LOGIC_VECTOR (7 downto 0);
				BTN	: in  STD_LOGIC_VECTOR (3 downto 0);
				SEG 	: out STD_LOGIC_VECTOR (6 downto 0);
				LED   : out STD_LOGIC_VECTOR (3 downto 0);
				DP  	: out STD_LOGIC;
				AN  	: out STD_LOGIC_VECTOR (3 downto 0));
end ALUwithINPUT;

architecture Structural of ALUwithINPUT is

	 signal cen    							   : STD_LOGIC := '0';
    signal enl 								   : STD_LOGIC := '1';
    signal dpc, BC_OUTPUT 				   	: STD_LOGIC_VECTOR (3 downto 0) := "1111";
	 signal TO_SEG, F1_OUT, F2_OUT, F3_OUT : STD_LOGIC_VECTOR (7 downto 0);
	 
begin

    ----- Structural Components: -----
	 
	--Button Debounce Controller 
   BUTTON_CONTROLLER: entity work.buttoncontrol	
	port map( CLK    => CLK,
				 BTN    => BTN,
			    OUTPUT => BC_OUTPUT);

	-- Create three flipflops
	-- Send data from switches after button click
   FlipFlop1: entity work.flip_flop
	port map( 	CLK   => BC_OUTPUT(3),
				D_IN  => SW(7 downto 0),
				D_OUT => F1_OUT);
	 
	FlipFlop2: entity work.flip_flop
	port map(  CLK   => BC_OUTPUT(2),
				D_IN  => SW(7 downto 0),
				D_OUT => F2_OUT);
	 
	FlipFlop3: entity work.flip_flop
	port map( 	CLK   => BC_OUTPUT(1),
				D_IN  => SW(7 downto 0),
				D_OUT => F3_OUT);
				
	--Map ALU values using Flip flop values
	--and LED display
	ALU: entity work.ALU
    port map( CLK 	=> CLK,
				RA       => F1_OUT,
				RB       => F2_OUT,
				OPCODE   => F3_OUT(3 downto 0),
				ALU_OUT  => TO_SEG,
				CCR 	 	=> LED(3 downto 0));
			  
	-- Control Seven Segment display
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
		  
    ----- End Structural Components -----

end Structural;
