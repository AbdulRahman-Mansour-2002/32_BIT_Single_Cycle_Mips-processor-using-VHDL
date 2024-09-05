use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Dmemory is
    Port ( address : in  STD_LOGIC_VECTOR (9 downto 0);
           data_in : in  STD_LOGIC_VECTOR (31 downto 0);
           data_out : out  STD_LOGIC_VECTOR (31 downto 0);
           clk : in  STD_LOGIC;
           write_signal : in  STD_LOGIC);
end Dmemory;

architecture Behavioral of Dmemory is

type memory_type is array (0 to 1023) of std_logic_vector (31 downto 0);
signal memory : memory_type  := (
17=>X"00000031",
18=>X"00000032",
20=>X"00000033",
24=>X"00000065",
33=>X"00000034",
34=>X"00000035",
36=>X"00000036",
40=>X"00000066",
65=>X"00000037",
66=>X"00000038",
68=>X"00000039",
72=>X"00000067",
129=>X"00000068",
130=>X"00000030",
132=>X"00000069",
136=>X"00000070",
238=>X"00000031",
237=>X"00000032",
235=>X"00000033",
231=>X"00000065",
222=>X"00000034",
221=>X"00000035",
219=>X"00000036",
215=>X"00000066",
190=>X"00000037",
189=>X"00000038",
187=>X"00000039",
183=>X"00000067",
126=>X"00000068",
125=>X"00000030",
123=>X"00000069",
119=>X"00000070",
others => X"00000000");
begin
data_write : process (clk) begin 
						if ( clk' event and clk ='0') then
							if (write_signal='1') then
								memory(to_integer(unsigned(address)))<= data_in ;
							end if;
						end if;
					end process ;

data_out <= memory(to_integer(unsigned(address)));
end Behavioral;

