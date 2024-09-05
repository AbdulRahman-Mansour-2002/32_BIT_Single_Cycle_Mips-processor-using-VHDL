library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PC is
port ( PC_entry :in std_logic_vector ( 31 downto 0);
		clk,reset :in std_logic;
		PC_out    :out std_logic_vector (31 downto 0));
end PC;

architecture Behavioral of PC is

begin
process(clk,reset)
begin
	if(reset = '1') then
			PC_out <= X"00000000";
	else
		if(clk' event and clk = '0') then
			PC_out <= PC_entry;
		end if;
	end if;
end process;

end Behavioral;

