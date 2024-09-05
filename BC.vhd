library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity BC is
port (		op_code : in std_logic_vector (5 downto 0);
				data_out1,data_out2: in std_logic_vector (31 downto 0);
				Branch_indecate : out std_logic);
end BC;

architecture Behavioral of BC is
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
L3:process (op_code,data_out1,data_out2)
	begin
		if op_code= BEQ and data_out1 = data_out2 then
			Branch_indecate <= '1';
		elsif op_code= BG and data_out1 > data_out2 then
			Branch_indecate <= '1';
		elsif op_code= BNE and data_out1 /= data_out2 then
			Branch_indecate <= '1';
		elsif op_code= BS and data_out1 < data_out2 then
			Branch_indecate <= '1';
		else Branch_indecate <= '0';
		end if;
	end process;

end Behavioral;

