----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:38:02 03/25/2015 
-- Design Name: 
-- Module Name:    op_access - Structural 
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


entity op_access is
	Port( CLK : IN STD_LOGIC;
			OPCODE_IN : IN STD_LOGIC_VECTOR (3 downto 0);
			REG_A : IN STD_LOGIC_VECTOR (3 downto 0);
			IMMEDIATE : IN STD_LOGIC_VECTOR (7 downto 0);
			W_ADDR : IN STD_LOGIC_VECTOR (3 downto 0);
			OP1_MUX_SEL : IN STD_LOGIC_VECTOR(1 downto 0);
			OP2_MUX_SEL : IN STD_LOGIC_VECTOR(1 downto 0);
			BANK_R_W : IN STD_LOGIC;
			BANK_ENB : IN STD_LOGIC;
			BANK_DATA : IN  STD_LOGIC_VECTOR(15 downto 0);
			DEC_REG_ADDR : OUT STD_LOGIC_VECTOR (3 downto 0);
			OPCODE_OUT  : OUT STD_LOGIC_VECTOR (3 downto 0);
			EX_FWD_IN  : IN  STD_LOGIC_VECTOR(15 downto 0);
			EX_FWD_ADDR : IN STD_LOGIC_VECTOR (3 downto 0);
			WB_FWD_IN : IN  STD_LOGIC_VECTOR(15 downto 0);
			WB_FWD_ADDR : IN STD_LOGIC_VECTOR (3 downto 0);
			OP1_OUT : OUT STD_LOGIC_VECTOR (15 downto 0);
			OP2_OUT : OUT STD_LOGIC_VECTOR (15 downto 0)
			);
end op_access;

architecture Structural of op_access is

signal REG_BANK_A_OUT, REG_BANK_B_OUT, IMM_DATA, REG_A_IN, REG_B_IN, REG_B : STD_LOGIC_VECTOR (15 downto 0);
signal OPCODE_DEL_OUT, write_address, EX_FWD_ADDR_REG, WB_FWD_ADDR_REG : STD_LOGIC_VECTOR (3 downto 0);
signal DETECT_SEL1, DETECT_SEL2 : STD_LOGIC_VECTOR(1 downto 0);

begin
	IMM_DATA <= x"00" & IMMEDIATE;
	REG_B    <= X"000" & IMMEDIATE(3 downto 0);
				 
	RegBank: entity work.register_bank
	Port Map( CLK     => CLK,
				 ADDR_A  => REG_A,
				 ADDR_B  => IMMEDIATE(7 downto 4),
				 W_ADDR  => write_address,
				 R_W     => BANK_R_W,
				 ENB     => BANK_ENB,
				 DATA_IN => BANK_DATA,
				 REG_A   => REG_BANK_A_OUT,
				 REG_B   => REG_BANK_B_OUT);
	
	OPCODE: entity work.Register_FE_4
	Port Map( CLK => CLK,
				 D   => OPCODE_IN,
				 ENB => '1',
				 Q   => OPCODE_OUT);
				 
	REGA: entity work.Register_FE_4
	Port Map( CLK => CLK,
				 D   => REG_A,
				 ENB => '1',
				 Q   => DEC_REG_ADDR);
				 
--	OPCODEDEL: entity work.Register_FE_4
--	Port Map( CLK => CLK,
--				 D   => OPCODE_DEL_OUT,
--				 ENB => '1',
--				 Q   => OPCODE_OUT);
				 
	FWD_DETECT1: entity work.Forwarding_unit
   PORT MAP( OPA_REG   => REG_A,
             EX_FWD_REG => EX_FWD_ADDR_REG,
             WB_FWD_REG => WB_FWD_ADDR_REG,
             FWD_SEL  => OP1_MUX_SEL,
             FWD_MUX_SEL   => DETECT_SEL1);
    
   OP1_MUX: entity work.MUX4to1
   PORT MAP( SEL    => DETECT_SEL1,
             DATA_0 => REG_BANK_A_OUT,
             DATA_1 => x"0000",
             DATA_2 => WB_FWD_IN,
             DATA_3 => EX_FWD_IN,
             OUTPUT => REG_A_IN);			 
				 
	OP1: entity work.Register_FE_16
	Port Map( CLK => CLK,
				 D   => REG_A_IN,
				 ENB => '1',
				 Q   => OP1_OUT);
				 
	FWD_DETECT2: entity work.Forwarding_unit
   PORT MAP( OPA_REG      => IMMEDIATE(3 downto 0),
              EX_FWD_REG  => EX_FWD_ADDR_REG,
              WB_FWD_REG  => WB_FWD_ADDR_REG,
              FWD_SEL     => OP2_MUX_SEL,
              FWD_MUX_SEL => DETECT_SEL2);		
	 
	OP2_MUX: entity work.mux4to1
	Port Map( SEL    => DETECT_SEL2,
				 DATA_0 => REG_BANK_B_OUT,
				 DATA_1 => IMM_DATA,
				 DATA_2 => WB_FWD_IN,
				 DATA_3 => EX_FWD_IN,
				 OUTPUT  => REG_B_IN);
				 
	OP2: entity work.Register_FE_16
	Port Map( CLK => CLK,
				 D   => REG_B_IN,
				 ENB => '1',
				 Q   => OP2_OUT);	 
				 
	U5:  entity work.Register_RE_4		 
	Port Map(   CLK  => CLK,
	            ENB  => '1',
               D    => W_ADDR,
               Q    => write_address);

	U6:  entity work.Register_RE_4		 
	Port Map(   CLK  => CLK,
	            ENB  => '1',
               D    => EX_FWD_ADDR,
               Q    => EX_FWD_ADDR_REG);
					
	U7:  entity work.Register_RE_4		 
	Port Map(   CLK  => CLK,
	            ENB  => '1',
               D    => WB_FWD_ADDR,
               Q    => WB_FWD_ADDR_REG);
end Structural;

