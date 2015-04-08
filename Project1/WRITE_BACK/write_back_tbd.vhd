--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:13:53 04/06/2015
-- Design Name:   
-- Module Name:   C:/Users/Jeff Magina/Documents/GitHub/ECE368/Project1/WRITE_BACK/write_back_tbd.vhd
-- Project Name:  Write_Back
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: write_back
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
 
ENTITY write_back_tbd IS
END write_back_tbd;
 
ARCHITECTURE behavior OF write_back_tbd IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT write_back
    PORT(
         CLK       : IN STD_LOGIC;
			DATA_WE   : IN STD_LOGIC;
			FPU_IN    : IN STD_LOGIC_VECTOR (15 downto 0);
			REG_A		 : IN STD_LOGIC_VECTOR (15 downto 0);
			D_OUT_SEL : IN STD_LOGIC;
			WB_OUT    : OUT STD_LOGIC_VECTOR (15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
	signal DATA_WE : std_logic := '0';
   signal FPU_IN : std_logic_vector(15 downto 0) := (others => '0');
   signal REG_A : std_logic_vector(15 downto 0) := (others => '0');
	signal D_OUT_SEL : std_logic := '0';

 	--Outputs
   signal WB_OUT : std_logic_vector(15 downto 0):= (others => '0');

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: write_back PORT MAP (
          CLK => CLK,
          DATA_WE => DATA_WE,
			 FPU_IN => FPU_IN,
			 REG_A => REG_A,
			 D_OUT_SEL => D_OUT_SEL,
          WB_OUT => WB_OUT
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
      wait for 100 ns;	

		FPU_IN    <= x"0003";
      REG_A      <= x"1234";
      wait for CLK_PERIOD;
      -- Don't care what WB_OUT because WE is low
      DATA_WE      <= '1';
      wait for CLK_PERIOD;
        
        
      -- Simulating a Load 
      FPU_IN    <= x"0002";
      wait for CLK_PERIOD;
		
      DATA_WE      <= '0';
      D_OUT_SEL <= '0';        
      wait for CLK_PERIOD;
      
        
      -- Storing FFFF into DATA MEM
      FPU_IN    <= x"0001";
      REG_A      <= x"FFFF";
      wait for CLK_PERIOD;
		
      DATA_WE      <= '1';
      wait for CLK_PERIOD;
		
      FPU_IN    <= x"0000";
      REG_A      <= x"0001";
      wait for CLK_PERIOD;
		
      DATA_WE      <= '1';
      wait for CLK_PERIOD;
      
      -- Simulating Load from data memory
      FPU_IN     <= x"0001";
      wait for CLK_PERIOD;
		
      DATA_WE      <= '0';
      D_OUT_SEL <= '0';        
      wait for CLK_PERIOD;
     
      FPU_IN    <= x"0000";
      wait for CLK_PERIOD;
		
      DATA_WE      <= '0';
      D_OUT_SEL <= '0';        
      wait for CLK_PERIOD;
       
      -- Simulating FPU Data to Register
      FPU_IN     <= x"00FF";
      wait for CLK_PERIOD;
		
      DATA_WE       <= '0';
      D_OUT_SEL  <= '1';
      wait for CLK_PERIOD;
     
      FPU_IN     <= x"00CC";
      wait for CLK_PERIOD;
		
      DATA_WE       <= '0';
      D_OUT_SEL  <= '1';
      wait for CLK_PERIOD;

      wait;
   end process;

END;
