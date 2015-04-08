----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:41:32 03/25/2015 
-- Design Name: 
-- Module Name:    execute - Structural 
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

entity execute is
	Port( CLK           : IN STD_LOGIC;
			OPCODE        : IN STD_LOGIC_VECTOR (3 downto 0);
			OP1       	  : IN STD_LOGIC_VECTOR (15 downto 0);
			OP2       	  : IN STD_LOGIC_VECTOR (15 downto 0);
			Dec_Reg_A_IN  : IN STD_LOGIC_VECTOR (3 downto 0);
			OPA_REG_A 	  : OUT STD_LOGIC_VECTOR (15 downto 0);
			Dec_Reg_A_OUT : OUT STD_LOGIC_VECTOR (3 downto 0);
			DEC_OPCODE_OUT: OUT STD_LOGIC_VECTOR (3 downto 0);
			EX_FWD_OUT    : OUT STD_LOGIC_VECTOR (15 downto 0);
			FPU_OUT   	  : OUT STD_LOGIC_VECTOR (15 downto 0);
			CCR       	  : OUT STD_LOGIC_VECTOR (3 downto 0)
			);
end execute;

architecture Structural of execute is
signal s_ALU_OUT, s_OP1_IN, s_OP2_IN : STD_LOGIC_VECTOR (15 downto 0);

begin

U0: entity work.Register_RE_16
Port Map(	CLK => CLK,
				ENB => '1',
				D   => OP1,
				Q   => s_OP1_IN
);

U1: entity work.Register_RE_16
Port Map(	CLK => CLK,
				ENB => '1',
				D   => OP2,
				Q   => s_OP2_IN
);

OPA_REG_A <= OP1;

			
DEC_OPCODE:entity work.Register_FE_4
Port Map ( CLK => CLK,
			  ENB => '1',
			  D   => OPCODE,
			  Q   => DEC_OPCODE_OUT
			  );
			  
U2: entity work.ALU
Port Map(	CLK 		=> CLK,
            RA  		=> s_OP1_IN,    --15 downto 0 
            RB 		=> s_OP2_IN,    --15 downto 0 
            OPCODE   => OPCODE,
            CCR      => CCR,
            ALU_OUT  => s_ALU_OUT
            --LDST_OUT =>		--15 downto 0 
			  );
			  
EX_FWD_OUT <= s_ALU_OUT;

U3: entity work.Register_FE_16
Port Map(  CLK => CLK,
			  ENB => '1',
			  D   => s_ALU_OUT,
			  Q   => FPU_OUT
			  );
				 
DEC_REG_A: entity work.Register_FE_4
Port Map( CLK => CLK,
			ENB => '1',
			D   => Dec_Reg_A_IN,
			Q   => Dec_Reg_A_OUT
			);


end Structural;

