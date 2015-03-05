---------------------------------------------------
-- School: University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Engineer: Jeffrey Magina and Jon Leidhold
-- 
-- Create Date:    SPRING 2015
-- Module Name:    DEBUG UNIT_tb
-- Project Name:   DEBUG UNIT
-- Target Devices: Spartan-3E
-- Tool versions:  Xilinx ISE 14.7
-- Description: Debug Unit Test Bench
---------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY ASCII_BUFFER_tb IS
END ASCII_BUFFER_tb;
 
ARCHITECTURE behavior OF ASCII_BUFFER_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ASCII_BUFFER
    PORT(
         ASCII_DATA : IN  std_logic_vector(7 downto 0);
         ASCII_RD : IN  std_logic;
         ASCII_WE : IN  std_logic;
         CLK : IN  std_logic;
         RST : IN  std_logic;
         ASCII_BUFF : OUT  std_logic_vector(15 downto 0)
        );
     END COMPONENT;
    

   --Inputs
   signal ASCII_DATA : std_logic_vector(7 downto 0) := (others => '0');
   signal ASCII_RD : std_logic := '0';
   signal ASCII_WE : std_logic := '0';
   signal CLK : std_logic := '0';
   signal RST : std_logic := '0';

 	--Outputs
   signal ASCII_BUFF : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ASCII_BUFFER PORT MAP (
          ASCII_DATA => ASCII_DATA,
          ASCII_RD => ASCII_RD,
          ASCII_WE => ASCII_WE,
          CLK => CLK,
          RST => RST,
          ASCII_BUFF => ASCII_BUFF
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0'; wait for CLK_period/2;
		CLK <= '1'; wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   tb: process
   begin		
      -- hold reset state for 100 ns.
			wait for 100 ns;		
			report "Start Debug Test Bench!" severity Note;	
	
			ASCII_DATA <= x"32"; -- 2 key is pressed
			ASCII_WE <= '1';
			wait for CLK_period;
			ASCII_RD <= '1';
			wait for CLK_period;
			ASCII_RD <= '0';
			wait for CLK_period;		

			ASCII_DATA <= x"46"; -- F key is pressed
			ASCII_WE <= '1';
			wait for CLK_period;
			ASCII_RD <= '1';
			wait for CLK_period;
			ASCII_RD <= '0';
			wait for CLK_period;				
		
			ASCII_DATA <= x"38"; -- 8 key is pressed
			ASCII_WE <= '1';
			wait for CLK_period;
			ASCII_RD <= '1';
			wait for CLK_period;
			ASCII_RD <= '0';
			wait for CLK_period;		
		
			ASCII_DATA <= x"30"; -- 0 key is pressed
			ASCII_WE <= '1';
			wait for CLK_period;
			ASCII_RD <= '1';
			wait for CLK_period;
			ASCII_RD <= '0';
			wait for CLK_period;		
		
			ASCII_DATA <= x"0D"; -- ENTER pressed
			ASCII_WE <= '0';
			wait for CLK_period;
			ASCII_RD <= '1';
			wait for CLK_period;
			ASCII_RD <= '0';
			wait for CLK_period;	
			
			wait for 100 ns;
									
			ASCII_DATA <= x"31"; -- 1 key is pressed
			ASCII_WE <= '1';
			wait for CLK_period;
			ASCII_RD <= '1';
			wait for CLK_period;
			ASCII_RD <= '0';
			wait for CLK_period;		
		
			ASCII_DATA <= x"64"; -- d key is pressed
			ASCII_WE <= '1';
			wait for CLK_period;
			ASCII_RD <= '1';
			wait for CLK_period;
			ASCII_RD <= '0';
			wait for CLK_period;		
			
			ASCII_DATA <= x"08"; -- BACKSPACE key is pressed
			ASCII_WE <= '0';
			wait for CLK_period;
			ASCII_RD <= '1';
			wait for CLK_period;
			ASCII_RD <= '0';
			wait for CLK_period;		
			
			ASCII_DATA <= x"63"; -- c key is pressed
			ASCII_WE <= '1';
			wait for CLK_period;
			ASCII_RD <= '1';
			wait for CLK_period;
			ASCII_RD <= '0';
			wait for CLK_period;		
		
			ASCII_DATA <= x"35"; -- 5 key is pressed
			ASCII_WE <= '1';
			wait for CLK_period;
			ASCII_RD <= '1';
			wait for CLK_period;
			ASCII_RD <= '0';
			wait for CLK_period;		
		
			ASCII_DATA <= x"30"; -- 0 key is pressed
			ASCII_WE <= '1';
			wait for CLK_period;
			ASCII_RD <= '1';
			wait for CLK_period;
			ASCII_RD <= '0';
			wait for CLK_period;		
		
			ASCII_DATA <= x"0D"; -- ENTER pressed
			ASCII_WE <= '0';
			wait for CLK_PERIOD;
			ASCII_RD <= '1';
			wait for CLK_PERIOD;
			ASCII_RD <= '0';
			wait for CLK_PERIOD;

			wait for 100 ns;
      wait;
   end process;

END;
