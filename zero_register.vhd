library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity zero_register is
port (  zero_flag : in std_logic ;
			clk 		: in std_logic;
			zero_load : in std_logic;
			zero_reg :out std_logic);
end zero_register;

architecture Behavioral of zero_register is

begin

process(clk)
begin
	if(clk' event and clk = '0') then
		if (zero_load = '1') then
			zero_reg <= zero_flag;
		end if;
	end if;
end process;
end Behavioral;

