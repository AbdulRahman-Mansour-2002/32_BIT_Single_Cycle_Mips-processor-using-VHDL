library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
	use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity alsu is
    Port ( data_1 : in  STD_LOGIC_VECTOR (31 downto 0);
           data_2 : in  STD_LOGIC_VECTOR (31 downto 0);
           func : in  STD_LOGIC_VECTOR (3 downto 0);
           data_out : out  STD_LOGIC_VECTOR (31 downto 0);
           zero_flag : out  STD_LOGIC);
end alsu;

architecture Behavioral of alsu is

signal data_check,mul,res_sub : std_logic_vector(31 downto 0);

begin

with func select
	data_check <=  data_1 + data_2 					when "0000", 	-- add
						res_sub			 					when "0010",	-- sub
						data_1 and  data_2 				when "0100",   -- and
						data_1 or  data_2 				when "0101", 	-- or
						data_1 nand  data_2 				when "0110",	--nand
						data_1 xor  data_2 				when "0111",	--xor
						not (data_1) 						when "1000",	--not
						data_1(30 downto 0) & '0' 		when "1001",	--shl
						'0' & data_1(31 downto 1) 		when "1010",	--shr
						data_1 								when "1011", -- pass data1
						data_2 								when "1100", -- pass data2
						mul 									when "1101",
						data_1  + 1							when "1110",
						data_1 - 1							when "1111",
						data_1 								when others;
mul <= data_1 (15 downto 0) * data_2 (15 downto 0);			
data_out <= data_check;
zero_flag <= '1' when data_check = X"00000000" else '0';
process (data_1,data_2)
begin
		if ( data_1 < data_2) then
				res_sub <= data_2 - data_1;
		else
				res_sub <= data_1 - data_2;
		end if;
end process;
end Behavioral;

