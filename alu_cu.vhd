library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity alu_cu is
port (		op_code : in std_logic_vector (5 downto 0);
				alu_op : in std_logic;
				fun_in : in std_logic_vector (3 downto 0);
				fun : out std_logic_vector (3 downto 0));
end alu_cu;

architecture Behavioral of alu_cu is
signal choose : std_logic_vector (3 downto 0);
component ch
port(Op_code : in  std_logic_vector (5 downto 0);
			fun : out std_logic_vector (3 downto 0));
end component;

begin
l2: ch port map (op_code,choose);
process (alu_op,op_code,choose,fun_in)
begin
if (alu_op ='0') then
	fun <= fun_in;
else 
	fun <= choose;
end if;
end process;

end Behavioral;

