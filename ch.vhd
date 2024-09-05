library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ch is
port (
			Op_code : 		in 		std_logic_vector (5 downto 0);
			fun : out std_logic_vector (3 downto 0));
end ch;

architecture Behavioral of ch is
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
with op_code select
fun <= "0000" when  ADDI,
"0100" when ANDI,
"0001" when BEQ ,
"0001" when BG  ,
"0001" when BNE ,
"0001" when BS  ,
"0000" when LW  ,
"1100" when MOVI,
"0101" when ORI ,
"0000" when SW  ,
"1011" when J   ,
"1011" when JAL_1,
"1011" when JNZ ,
"1011" when JR  ,
"1011" when JZ  ,
"1011" when IN_1 ,
"1011" when MOV ,
"1011" when OUT_1 ,
"1011" when Pop ,
"1011" when Push,
"0000" when HLT ,
"1111" when Loop_1,
"1011" when NOP,
"1011" when inmem,
"0010" when cmp,
"0010" when cmpI,
"1011" when others;
end Behavioral;

