library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity OUT_P is
port ( data_out1 : in std_logic_vector (15 downto 0);
			clk: in std_logic;
			out_select: in std_logic;
			out_port : out std_logic_vector (15 downto 0));
end OUT_P;

architecture Behavioral of OUT_P is

begin

process(clk)
begin
	if(clk' event and clk = '0')then 
		if(out_select = '1') then
			out_port <= data_out1;	end if;
		end if;
end process;

end Behavioral;

