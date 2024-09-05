
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee .numeric_std .all;


entity reg_files is
port(r_reg1,r_reg2,w_reg:in std_logic_vector(4 downto 0);
data_in:in std_logic_vector(31 downto 0);
w_en ,clk,clear:in std_logic ;
data_out1,data_out2:out std_logic_vector (31 downto 0));

end reg_files;

architecture Behavioral of reg_files is
type regs is array (0 to 31) of std_logic_vector (31 downto 0);
signal reg_file:regs;
begin
process(clk,clear)
begin 
if(clear='1')then
reg_file<=(others=>X"00000000");


elsif (clk'event and clk ='0')then 
if(w_en ='1')then 
reg_file(to_integer(unsigned(w_reg)))<=data_in;
end if;
end if ;
end process;
data_out1<=reg_file(to_integer(unsigned(r_reg1)));
data_out2<=reg_file(to_integer(unsigned(r_reg2)));
end Behavioral;

