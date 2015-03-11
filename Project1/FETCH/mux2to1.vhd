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
    Port ( SEL : in  STD_LOGIC_VECTOR (2 downto 0);
           DATA : in  STD_LOGIC_VECTOR (7 downto 0);
           OUTPUT : out  STD_LOGIC);
end mux2to1;

architecture Behavioral of mux2to1 is

begin

with SEL SELect
    OUTPUT<= DATA(1) when "1" ,
             DATA(0) when "0" ,
                 '0' when others;
end Behavioral;


