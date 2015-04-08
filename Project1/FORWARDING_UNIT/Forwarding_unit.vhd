----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:42:15 04/07/2015 
-- Design Name: 
-- Module Name:    Forwarding_unit - Dataflow 
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

entity Forwarding_unit is
    Port( OPA_REG  : IN  STD_LOGIC_VECTOR(3 downto 0);
	       EX_FWD_REG  : IN  STD_LOGIC_VECTOR(3 downto 0);
          WB_FWD_REG  : IN  STD_LOGIC_VECTOR(3 downto 0);
          FWD_SEL : IN  STD_LOGIC_VECTOR(1 downto 0);
          FWD_MUX_SEL  : OUT STD_LOGIC_VECTOR(1 downto 0));
end Forwarding_unit;

architecture Dataflow of Forwarding_unit is
	signal PRIORITY : STD_LOGIC_VECTOR(1 downto 0);
begin
	 PRIORITY <= "10" when FWD_SEL = "00" AND OPA_REG = WB_FWD_REG ELSE
                "00";
					 
    FWD_MUX_SEL <= "01" when FWD_SEL = "01" ELSE
						 "10" when PRIORITY = "10" AND OPA_REG /= EX_FWD_REG ELSE
						 "11" when OPA_REG = EX_FWD_REG ELSE
						 "00";
end Dataflow;

