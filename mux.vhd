use IEEE.STD_LOGIC_1164.ALL;

entity mux is
    Port ( data0 : in  STD_LOGIC_VECTOR (31 downto 0);
           data1 : in  STD_LOGIC_VECTOR (31 downto 0);
           sel : in  STD_LOGIC;
           data_out : out  STD_LOGIC_VECTOR (31 downto 0));
end mux;

architecture Behavioral of mux is

begin

with sel select
data_out <= data0 when '0',
			   data1 when '1',
				(others => '0') when others;

end Behavioral;

