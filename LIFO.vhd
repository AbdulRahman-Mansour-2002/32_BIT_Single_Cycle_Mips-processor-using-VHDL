library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
	use IEEE.STD_LOGIC_UNSIGNED.ALL;



entity LIFO is
	port(
		stack_in    : in  std_logic_vector(31 downto 0);
		stack_out   : out std_logic_vector(31 downto 0);
		rd, wr, clk ,reset: in std_logic
		);
end LIFO;


architecture Behavioral of LIFO is


type   mem is array (1 to 50) of std_logic_vector(31 downto 0);
signal lifo : mem ;


begin

	process(clk,reset)
	Variable last :integer range 0 to 50 := 0;
	begin
			if (reset ='1') then
				lifo <= (others => (others => '0'));
			elsif(clk' event and clk ='1') then
				if(wr ='1') then
					if (last = 50 )then 
						last := 0	;
					end if;
					lifo(last +1) <= stack_in;
					last          := last+1;
				end if;
				if(rd ='1')then
					if (last = 0)then 
						LAST := 50 ;
					end if;
					stack_out    <=  lifo(last) ;
					last         :=  last - 1;
				end if;
			end if;
	end process;


end Behavioral;