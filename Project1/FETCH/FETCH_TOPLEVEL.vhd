----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:35:41 03/04/2015 
-- Design Name: 
-- Module Name:    FETCH_TOPLEVEL - Structural 
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
use work.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
Use ieee.std_logic_unsigned.all;
Use ieee.std_logic_arith.all;
-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FETCH_TOPLEVEL is
Port ( CLK : in STD_LOGIC;
		 DATAIN : in STD_LOGIC_VECTOR( 15 downto 0);
		 INST_OUT : out STD_LOGIC_VECTOR( 15 downto 0);
		 WE : in STD_LOGIC_VECTOR);--INC : out STD_LOGIC_VECTOR(9 downto 0
end FETCH_TOPLEVEL;

architecture Structural of FETCH_TOPLEVEL is

	signal instruction : STD_LOGIC_VECTOR (15 downto 0) := (OTHERS => '0');
	--signal DATAIN : STD_LOGIC_VECTOR (15 downto 0) := (OTHERS => '0');
	signal PC : STD_LOGIC_VECTOR (9 downto 0) := (OTHERS => '0');
	signal INC : STD_LOGIC_VECTOR (9 downto 0) := (OTHERS => '0');
begin
	U1: entity work.INST_REG
	port map( CLK => CLK,
				 INST => instruction, 
				 INST_OUT => INST_OUT);
				 
	U2: entity work.INST_MEM
   port map( CLKA  => CLK,
              WEA(0)=> WE,
              ADDRA => PC,  -- (9 DOWNTO 0)
              DINA  => PC,   -- (15 DOWNTO 0)
              DOUTA => instruction); -- (15 DOWNTO 0)
				  
	INC <= (PC + "0000000001");	  
	
	U3: entity work.ProgramCounter
	port map ( CLK => CLK,
				  NEW_PC => INC,
				  PC_OUT => PC);

end Structural;

