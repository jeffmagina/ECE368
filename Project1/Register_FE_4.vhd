----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:40:28 04/08/2015 
-- Design Name: 
-- Module Name:    Register_FE_4 - Behavioral 
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

entity Register_FE_4 is
PORT (   CLK : in  STD_LOGIC;
			ENB : in  STD_LOGIC;
			  D : in  STD_LOGIC_VECTOR(3 DOWNTO 0);
           Q : out STD_LOGIC_VECTOR(3 DOWNTO 0) 
			  );
end Register_FE_4;

architecture Behavioral of Register_FE_4 is

begin
    PROCESS (CLK)
    BEGIN
        IF (CLK'EVENT AND CLK = '0') THEN
            IF ENB = '1' THEN
                Q <= D ;
            END IF;
        END IF;
    END PROCESS;

end Behavioral;


