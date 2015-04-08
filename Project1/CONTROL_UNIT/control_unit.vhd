---------------------------------------------------
-- School:     University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Engineer:   Josh Tombs
-- 
-- Create Date:    SPRING 2015
-- Module Name:    ControlUnit
-- Project Name:   UMD_RISC16
-- Target Devices: Spartan-3E
-- Tool versions:  Xilinx ISE 14.7
-- Description:    Control unit for RISC16.
---------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity control_unit is
    Port( CLK              : IN  STD_LOGIC;
			 OPA_OPCODE			: IN  STD_LOGIC_VECTOR(3 downto 0);
			 OP1_MUX_SEL		: OUT STD_LOGIC_VECTOR(1 downto 0);
		    OP2_MUX_SEL      : OUT STD_LOGIC_VECTOR(1 downto 0);
			 REG_BANK_WE		: OUT STD_LOGIC;
			 DATA_MEM_WE      : OUT STD_LOGIC;
			 WB_OPCODE        : IN STD_LOGIC_VECTOR(3 downto 0);
			 OPA_D_OUT_SEL		: OUT STD_LOGIC
          );
end control_unit;

architecture Behavioral of control_unit is
begin

	OPA: PROCESS(CLK)
    begin
        if(CLK'EVENT and CLK = '1') then
            OP1_MUX_SEL <= "00" ;    
            case OPA_OPCODE is
                when "0000" => OP2_MUX_SEL <= "00";
                when "0001" => OP2_MUX_SEL <= "00";
                when "0010" => OP2_MUX_SEL <= "00";
                when "0011" => OP2_MUX_SEL <= "00";
                when "0100" => OP2_MUX_SEL <= "00";
                when "0101" => OP2_MUX_SEL <= "01";
                when "0110" => OP2_MUX_SEL <= "01";
                when "0111" => OP2_MUX_SEL <= "10";
                when "1000" => OP2_MUX_SEL <= "10";
                when "1001" => OP2_MUX_SEL <= "01";
                when "1010" => OP2_MUX_SEL <= "01";
                when others => OP2_MUX_SEL <= "01";
            end case;        
        end if;
    end PROCESS;
	 
	WB: PROCESS(CLK)
    begin
        if(CLK'EVENT and CLK = '1') then
            case WB_OPCODE is
                when "0000"|"0001"|"0010"|"0011"|"0100"|"0101"|"0110"|"0111"|"1000" => 
                    OPA_D_OUT_SEL <= '1';
                    DATA_MEM_WE <= '0';
                    REG_BANK_WE <= '1';
                when "1001" => 
                    OPA_D_OUT_SEL <= '0';
                    DATA_MEM_WE <= '0';
                    REG_BANK_WE <= '1';
                when "1010" => 
                    OPA_D_OUT_SEL <= '0';
                    DATA_MEM_WE <= '1';
                    REG_BANK_WE <= '0';
                when others => 
                    OPA_D_OUT_SEL <= '1';
                    DATA_MEM_WE <= '0';
                    REG_BANK_WE <= '0';
            end case;
        end if;
    end PROCESS;
end Behavioral;

