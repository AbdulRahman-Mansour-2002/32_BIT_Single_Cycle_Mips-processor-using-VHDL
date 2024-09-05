library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity JC is
port (		op_code : in std_logic_vector (5 downto 0);
				zero_flag : in std_logic;
				IJUMP_indecate : out std_logic);
end JC;

architecture Behavioral of JC is
constant alu : std_logic_vector(5 downto 0) := "000000";
constant ADDI: std_logic_vector(5 downto 0) := "000001";
constant ANDI: std_logic_vector(5 downto 0) := "000010";
constant BEQ : std_logic_vector(5 downto 0) := "000011";
constant BG  : std_logic_vector(5 downto 0) := "000100";
constant BNE : std_logic_vector(5 downto 0) := "000101";
constant BS  : std_logic_vector(5 downto 0) := "000110";
constant LW  : std_logic_vector(5 downto 0) := "000111";
constant MOVI: std_logic_vector(5 downto 0) := "001000";
constant ORI : std_logic_vector(5 downto 0) := "001001";
constant SW  : std_logic_vector(5 downto 0) := "001010";
constant J   : std_logic_vector(5 downto 0) := "001011";
constant JAL_1:std_logic_vector(5 downto 0) := "001100";
constant JNZ : std_logic_vector(5 downto 0) := "001101";
constant JR  : std_logic_vector(5 downto 0) := "001110";
constant JZ  : std_logic_vector(5 downto 0) := "001111";
constant IN_1 : std_logic_vector(5 downto 0):= "010000";
constant MOV : std_logic_vector(5 downto 0) := "010001";
constant OUT_1 :std_logic_vector(5 downto 0):= "010010";
constant Pop : std_logic_vector(5 downto 0) := "010011";
constant Push: std_logic_vector(5 downto 0) := "010100";
constant HLT : std_logic_vector(5 downto 0) := "010101";
constant Loop_1:std_logic_vector(5 downto 0):= "010110";
constant NOP : std_logic_vector(5 downto 0) := "010111";
constant inmem : std_logic_vector(5 downto 0):= "011000";
constant cmp : 	std_logic_vector(5 downto 0):= "011001";
constant cmpI : 	std_logic_vector(5 downto 0):= "011010";

begin
L3:process (op_code,zero_flag)
	begin
		if op_code= j or op_code= jAL_1 then
			IJUMP_indecate <= '1';
		elsif op_code = JZ then
			if zero_flag = '1' then IJUMP_indecate <= '1'; else IJUMP_indecate <= '0'; end if;
		elsif op_code =JNZ then 
			if zero_flag = '0' then IJUMP_indecate <= '1'; else IJUMP_indecate <= '0'; end if;
		else IJUMP_indecate <= '0';
		end if;
	end process;

end Behavioral;

