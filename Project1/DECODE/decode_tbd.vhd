--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:45:55 03/24/2015
-- Design Name:   
-- Module Name:   C:/Users/Jeff Magina/Documents/GitHub/ECE368/Project1/DECODE/decode_tbd.vhd
-- Project Name:  decode
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: decode
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
 
ENTITY decode_tbd IS
END decode_tbd;
 
ARCHITECTURE behavior OF decode_tbd IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT decode
    PORT(
         CLK : IN  std_logic;
         INST_IN : IN  std_logic_vector(15 downto 0);
         OPCODE : OUT  std_logic_vector(3 downto 0);
         REG_A : OUT  std_logic_vector(3 downto 0);
         REG_B : OUT  std_logic_vector(3 downto 0);
         IMMEDIATE : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal INST_IN : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal OPCODE : std_logic_vector(3 downto 0);
   signal REG_A : std_logic_vector(3 downto 0);
   signal REG_B : std_logic_vector(3 downto 0);
   signal IMMEDIATE : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: decode PORT MAP (
          CLK => CLK,
          INST_IN => INST_IN,
          OPCODE => OPCODE,
          REG_A => REG_A,
          REG_B => REG_B,
          IMMEDIATE => IMMEDIATE
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
		INST_IN <= x"0FC0";
      wait for CLK_period;
		
		INST_IN <= x"1671";
		wait for CLK_period;
		
		INST_IN <= x"467A";
		wait for CLK_period;
		
		INST_IN <= x"0682";
		wait for CLK_period;
		
		wait for 100 ns;
      wait;
   end process;

END;
