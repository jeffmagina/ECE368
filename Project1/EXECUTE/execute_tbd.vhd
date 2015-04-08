--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:02:59 04/04/2015
-- Design Name:   
-- Module Name:   C:/Users/Jeff Magina/Documents/GitHub/ECE368/Project1/EXECUTE/execute_tbd.vhd
-- Project Name:  Execute
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: execute
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
 
ENTITY execute_tbd IS
END execute_tbd;
 
ARCHITECTURE behavior OF execute_tbd IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT execute
    PORT(
         CLK : IN  std_logic;
         OPCODE : IN  std_logic_vector(3 downto 0);
         OP1 : IN  std_logic_vector(15 downto 0);
         OP2 : IN  std_logic_vector(15 downto 0);
         FPU_OUT : OUT  std_logic_vector(15 downto 0);
         CCR : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal OPCODE : std_logic_vector(3 downto 0) := (others => '0');
   signal OP1 : std_logic_vector(15 downto 0) := (others => '0');
   signal OP2 : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal FPU_OUT : std_logic_vector(15 downto 0);
   signal CCR : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: execute PORT MAP (
          CLK => CLK,
          OPCODE => OPCODE,
          OP1 => OP1,
          OP2 => OP2,
          FPU_OUT => FPU_OUT,
          CCR => CCR
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
      wait for 100 ns;	
		
		-- Add Reg A to Reg B
		OPCODE <= x"0";
		OP1  <= x"0003";
		OP2  <= x"0001";

		wait for CLK_period;
		
		-- Subtract Reg A from Reg B 
		OPCODE <= x"1";
		OP1  <= x"000F";
		OP2  <= x"0003";
		
		wait for CLK_period;

		--  And
		OPCODE <= x"2";
		OP1  <= x"CC0F";
		OP2  <= x"DE03";
		
		wait for CLK_period;
		
		-- OR
		OPCODE <= x"3";
		OP1  <= x"CC0F";
		OP2  <= x"0D13";
		
		wait for CLK_period;
		
		-- MOV
		OPCODE <= x"4";
		OP1  <= x"000F";
		OP2  <= x"0003";
		
		wait for CLK_period;
		
		-- ADDI
		OPCODE <= x"5";
		OP1  <= x"000F";
		OP2  <= x"0003";
		
		wait for CLK_period;
		
		-- ANDI
		OPCODE <= x"6";
		OP1  <= x"000F";
		OP2  <= x"0003";
		
		wait for CLK_period;
		
		-- SL
		OPCODE <= x"7";
		OP1  <= x"000F";
		OP2  <= x"0003";
		
		wait for CLK_period;
		
		-- SR
		OPCODE <= x"8";
		OP1  <= x"000F";
		OP2  <= x"0003";
		
		wait for CLK_period;
		
		-- LW
		OPCODE <= x"9";
		OP1  <= x"000F";
		OP2  <= x"0003";
		
		wait for CLK_period;
		
		--SW
		OPCODE <= x"A";
		OP1  <= x"000F";
		OP2  <= x"1002";

      wait;
   end process;

END;
