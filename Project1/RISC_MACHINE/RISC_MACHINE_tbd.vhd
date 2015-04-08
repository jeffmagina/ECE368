--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:46:18 04/07/2015
-- Design Name:   
-- Module Name:   C:/Users/Jeff Magina/Documents/GitHub/ECE368/Project1/RISC_MACHINE/RISC_MACHINE_tbd.vhd
-- Project Name:  RISC_MACHINE
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: RISC_MACHINE
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY RISC_MACHINE_tbd IS
END RISC_MACHINE_tbd;
 
ARCHITECTURE behavior OF RISC_MACHINE_tbd IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RISC_MACHINE
    PORT(
         CLK : IN  std_logic;
         PC_RESET : IN  std_logic;
			RISC_INST_ENB : IN STD_LOGIC;
         CCR_OUT : OUT  std_logic_vector(3 downto 0);
         DATA_OUT : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal PC_RESET : std_logic := '0';
	signal RISC_INST_ENB : std_logic := '0';


 	--Outputs
   signal CCR_OUT : std_logic_vector(3 downto 0);
   signal DATA_OUT : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RISC_MACHINE PORT MAP (
          CLK => CLK,
          PC_RESET => PC_RESET,
			 RISC_INST_ENB => RISC_INST_ENB,
          CCR_OUT => CCR_OUT,
          DATA_OUT => DATA_OUT
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   tb: process
   begin		
      -- hold reset state for 100 ns.
		RISC_INST_ENB <= '1';

      wait for 100 ns;	
      wait;
   end process;

END;
