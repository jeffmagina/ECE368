--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:26:06 03/11/2015
-- Design Name:   
-- Module Name:   C:/Users/Jeff Magina/Documents/GitHub/ECE368/Project1/FETCH/FETCH_TOPLEVEL_tbd.vhd
-- Project Name:  FETCH
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: FETCH_TOPLEVEL
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
 
ENTITY FETCH_TOPLEVEL_tbd IS
END FETCH_TOPLEVEL_tbd;
 
ARCHITECTURE behavior OF FETCH_TOPLEVEL_tbd IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT FETCH_TOPLEVEL
    PORT(
         CLK : IN  std_logic;
         DATAIN : IN  std_logic_vector(15 downto 0);
         INST_OUT : OUT  std_logic_vector(15 downto 0);
         WE : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal DATAIN : std_logic_vector(15 downto 0) := (others => '0');
   signal WE : std_logic := '0';

 	--Outputs
   signal INST_OUT : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: FETCH_TOPLEVEL PORT MAP (
          CLK => CLK,
          DATAIN => DATAIN,
          INST_OUT => INST_OUT,
          WE => WE
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
      wait for 20 ns;	
		
		report "Start Debug Test Bench!" severity Note;
		WE <= '1';
		DATAIN <= x"0FC0";
      wait for CLK_period;
		
		WE <= '1';
		DATAIN <= x"1671";
		wait for CLK_period;
		
		WE <= '1';
		DATAIN <= x"467A";
		wait for CLK_period;
		
		WE <= '1';
		DATAIN <= x"0682";
		wait for CLK_period;
		
		wait for 100 ns;
      wait;
   end process;

END;
