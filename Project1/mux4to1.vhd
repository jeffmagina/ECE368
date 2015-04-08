----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:41:24 04/08/2015 
-- Design Name: 
-- Module Name:    mux4to1 - Behavioral 
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

entity mux4to1 is
    Port ( SEL : in  STD_LOGIC_VECTOR (1 downto 0);
	        DATA_0 : in  STD_LOGIC_VECTOR (15 downto 0);
           DATA_1 : in  STD_LOGIC_VECTOR (15 downto 0);
			  DATA_2 : in  STD_LOGIC_VECTOR (15 downto 0);
           DATA_3 : in  STD_LOGIC_VECTOR (15 downto 0);
           OUTPUT : out STD_LOGIC_VECTOR (15 downto 0));
end mux4to1;

architecture Behavioral of mux4to1 is

begin

with SEL SELect
    OUTPUT<= DATA_0 when "00" ,
				 DATA_1 when "01" ,
             DATA_2 when "10" ,
				 DATA_3 when "11" ,
             x"0000" when others;
end Behavioral;

