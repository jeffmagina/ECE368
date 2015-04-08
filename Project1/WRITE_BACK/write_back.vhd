----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:43:03 03/25/2015 
-- Design Name: 
-- Module Name:    write_back - Structural 
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
Use ieee.std_logic_unsigned.all;
Use ieee.std_logic_arith.all;

entity write_back is
	Port( CLK       : IN STD_LOGIC;
			DATA_WE   : IN STD_LOGIC;
			FPU_IN    : IN STD_LOGIC_VECTOR (15 downto 0);
			REG_A		 : IN STD_LOGIC_VECTOR (15 downto 0);
			D_OUT_SEL : IN STD_LOGIC;
			WB_OUT    : OUT STD_LOGIC_VECTOR (15 downto 0)
			);
end write_back;

architecture Structural of write_back is
signal s_Reg_Out, s_Reg_A_Out, s_Data_Mem_Out, s_MUX_WB_OUT : STD_LOGIC_VECTOR (15 downto 0);
signal InvCLK : STD_LOGIC;

begin
	InvCLK <= not CLK;
	
	U0: entity work.Register_RE_16
	Port Map( CLK => CLK,
				 ENB => '1',
					D => FPU_IN,
					Q => s_Reg_Out
					);
					
	U1: entity work.Register_RE_16
	Port Map( CLK => CLK,
				 ENB => '1',
					D => REG_A,
					Q => s_Reg_A_Out
					);
				 
	U2: entity work.Data_MEM
	Port Map(  CLKA   => InvCLK,
              WEA(0) => DATA_WE,
              ADDRA  => s_Reg_Out(7 downto 0),  -- (7 DOWNTO 0)
              DINA   => s_Reg_A_Out,   -- (15 DOWNTO 0)
              CLKB   => CLK,
              ADDRB  => FPU_IN(7 downto 0),  -- (7 DOWNTO 0)
              DOUTB  => s_Data_Mem_Out);
				  
	U3: entity work.mux2to1
	Port Map( SEL    => D_OUT_SEL,
				 DATA_0 => s_Data_Mem_Out,
				 DATA_1 => s_Reg_Out,
				 OUTPUT => WB_OUT
				 );

end Structural;

