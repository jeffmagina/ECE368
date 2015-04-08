----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    03:23:34 03/25/2015 
-- Design Name: 
-- Module Name:    RISC_MACHINE - Structural 
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

entity RISC_MACHINE is
	Port( CLK     : IN STD_LOGIC;
			PC_RESET: IN STD_LOGIC;
			RISC_INST_ENB : IN STD_LOGIC;
			CCR_OUT : OUT STD_LOGIC_VECTOR(3 downto 0);
			DATA_OUT: OUT STD_LOGIC_VECTOR (15 downto 0)
			);
end RISC_MACHINE;

architecture Structural of RISC_MACHINE is
	signal instruction_in, FETCH_out, fpu_out, OP1_out, OP2_out, s_Bank_Data, s_OPA_REG_A, EX_Forward_out: STD_LOGIC_VECTOR(15 downto 0);
	signal pc : STD_LOGIC_VECTOR (9 downto 0);
	signal DEC_immediate : STD_LOGIC_VECTOR (7 downto 0);
	signal write_address, OPA_OPCODE, DEC_opcode, DEC_reg_a, s_Dec_REG_A,s_DEC_OPCODE_OUT : STD_LOGIC_VECTOR(3 downto 0);
	signal OP1_SEL, OP2_SEL : STD_LOGIC_VECTOR (1 downto 0);
	signal bank_RW, WB_MEM_WE, WB_MUX_SEL : STD_LOGIC;
	
begin
		 U1: entity work.FETCH
		 Port Map ( CLK 	   => CLK,
						DATAIN   => instruction_in,
						INST_ENB => RISC_INST_ENB,
						INST_OUT => FETCH_out,
						PC_OUT   => pc,
						WE 		=> '0'
						);
						
		 U2: entity work.decode
		 Port Map ( CLK 		 => CLK,
						INST_IN   => FETCH_out,
						OPCODE    => DEC_opcode,
						REG_A     => DEC_reg_a,
						IMMEDIATE => DEC_immediate
						);
						
		U3: entity work.op_access
		Port Map (	CLK          => CLK,
						OPCODE_IN    => DEC_opcode,
						REG_A        => DEC_reg_a,
						IMMEDIATE    => DEC_immediate,
						W_ADDR       => Write_Address,
						OP1_MUX_SEL  => OP1_SEL,
						OP2_MUX_SEL  => OP2_SEL,
						BANK_R_W     => bank_RW,
						BANK_ENB     => '1',
						BANK_DATA    => s_Bank_Data,
						DEC_REG_ADDR => s_Dec_REG_A,
						OPCODE_OUT   => OPA_OPCODE,
						EX_FWD_IN	 => EX_Forward_out,
						EX_FWD_ADDR  => s_Dec_REG_A,
						WB_FWD_IN    => s_Bank_Data,
						WB_FWD_ADDR  => Write_Address,
						OP1_OUT      => OP1_out,
						OP2_OUT      => OP2_out
						);
						
		U4: entity work.execute
		Port Map (	CLK       	  => CLK,
						OPCODE   	  => OPA_OPCODE,
						OP1      	  => OP1_out,
						OP2      	  => OP2_out,
						Dec_Reg_A_IN  => s_Dec_REG_A,
						OPA_REG_A     => s_OPA_REG_A,
						Dec_Reg_A_OUT => Write_Address,
						DEC_OPCODE_OUT=> s_DEC_OPCODE_OUT,
						EX_FWD_OUT    => EX_Forward_out,
						FPU_OUT   	  => fpu_out,
						CCR       	  => CCR_OUT
						);
		 
		U5: entity work.write_back
		Port Map (	CLK       => CLK,
						DATA_WE   => WB_MEM_WE,
						FPU_IN    => fpu_out,
						REG_A     => s_OPA_REG_A,
						D_OUT_SEL => WB_MUX_SEL,
						WB_OUT    => s_Bank_Data
						);
						
		Cntrl_unit: entity work.control_unit
	   Port Map(  CLK         => CLK,
				  OPA_OPCODE     => DEC_opcode,
				  OP1_MUX_SEL    => OP1_SEL,
				  OP2_MUX_SEL    => OP2_SEL,
				  REG_BANK_WE    => bank_RW,
			     DATA_MEM_WE    => WB_MEM_WE,
				  WB_OPCODE      => s_DEC_OPCODE_OUT,
				  OPA_D_OUT_SEL  => WB_MUX_SEL
				  );

end Structural;

