--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:44:10 03/31/2015
-- Design Name:   
-- Module Name:   C:/Users/Jeff Magina/Documents/GitHub/ECE368/Project1/OPERAND_ACCESS/OP_ACCESS_tbd.vhd
-- Project Name:  OP_ACCESS
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: op_access
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
 
ENTITY OP_ACCESS_tbd IS
END OP_ACCESS_tbd;
 
ARCHITECTURE behavior OF OP_ACCESS_tbd IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT op_access
    PORT(
         CLK : IN  std_logic;
         OPCODE_IN : IN  std_logic_vector(3 downto 0);
         REG_A : IN  std_logic_vector(3 downto 0);
         IMMEDIATE : IN  std_logic_vector(7 downto 0);
         W_ADDR : IN  std_logic_vector(3 downto 0);
			OP2_MUX_SEL : IN STD_LOGIC;
         BANK_R_W : IN  std_logic;
         BANK_ENB : IN  std_logic;
			BANK_DATA : IN  STD_LOGIC_VECTOR(15 downto 0);
         DATA_IN : IN  std_logic_vector(15 downto 0);
         OPCODE_OUT : OUT  std_logic_vector(3 downto 0);
         OP1_OUT : OUT  std_logic_vector(15 downto 0);
         OP2_OUT : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal OPCODE_IN : std_logic_vector(3 downto 0) := (others => '0');
   signal REG_A : std_logic_vector(3 downto 0) := (others => '0');
   signal IMMEDIATE : std_logic_vector(7 downto 0) := (others => '0');
   signal W_ADDR : std_logic_vector(3 downto 0) := (others => '0');
	signal OP2_MUX_SEL : std_logic := '0';
   signal BANK_R_W : std_logic := '0';
   signal BANK_ENB : std_logic := '0';
	signal BANK_DATA : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
   signal DATA_IN : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal OPCODE_OUT : std_logic_vector(3 downto 0);
   signal OP1_OUT : std_logic_vector(15 downto 0);
   signal OP2_OUT : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: op_access PORT MAP (
          CLK => CLK,
          OPCODE_IN => OPCODE_IN,
          REG_A => REG_A,
          IMMEDIATE => IMMEDIATE,
          W_ADDR => W_ADDR,
			 OP2_MUX_SEL => OP2_MUX_SEL,
          BANK_R_W => BANK_R_W,
          BANK_ENB => BANK_ENB,
			 BANK_DATA => BANK_DATA,
          DATA_IN => DATA_IN,
          OPCODE_OUT => OPCODE_OUT,
          OP1_OUT => OP1_OUT,
          OP2_OUT => OP2_OUT
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
		BANK_ENB <= '1';
		W_ADDR <= x"0";
		BANK_R_W <= '1';
		BANK_DATA <= x"1111";
		
		wait for CLK_period;
		W_ADDR <= x"1";
		BANK_R_W <= '1';
      BANK_DATA <= x"1234";
		
		wait for CLK_period;
      W_ADDR <= x"2";
      BANK_R_W <= '1';
      BANK_DATA <= x"5678";
      
		wait for CLK_period;
      W_ADDR <= x"3";
      BANK_R_W <= '1';
      BANK_DATA <= x"8888";
      wait for CLK_period;
		
		OPCODE_IN <= "0011";
		REG_A <= "0001";
		IMMEDIATE <= "00100000";
		OP2_MUX_SEL <= '0';
		BANK_R_W <= '0';
      wait for CLK_period;
		
		OPCODE_IN <= "1001";
		REG_A <= "0011";
		IMMEDIATE <= "00011111";
		OP2_MUX_SEL <= '1';
		BANK_R_W <= '0';
      wait;
   end process;

END;
