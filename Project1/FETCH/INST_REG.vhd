----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:06:25 03/04/2015 
-- Design Name: 
-- Module Name:    INST_REG - Behavioral 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity INST_REG is
	Port( CLK : in STD_LOGIC;
		INST : in STD_LOGIC_VECTOR (15 downto 0);
		--OFFSET: in STD_LOGIC_VECTOR (15 downto 0);
		INST_OUT: out STD_LOGIC_VECTOR (15 downto 0));
		
end INST_REG;

architecture Structrual of INST_REG is

begin
		U1: entity work.flip_flop
		port map( CLK => CLK,
					 D_IN => INST,
					 D_OUT => INST_OUT);
end Structrual;

