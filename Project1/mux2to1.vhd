----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:06:40 03/11/2015 
-- Design Name: 
-- Module Name:    mux2to1 - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mux2to1 is
    Port ( SEL : in  STD_LOGIC;
	        DATA_0 : in  STD_LOGIC_VECTOR (15 downto 0);
           DATA_1 : in  STD_LOGIC_VECTOR (15 downto 0);
           OUTPUT : out  STD_LOGIC_VECTOR (15 downto 0)	);
end mux2to1;

architecture Behavioral of mux2to1 is

begin

with SEL SELect
    OUTPUT<=   DATA_0 when '0' ,
					DATA_1 when '1' ,
                 x"0000" when others;
end Behavioral;


