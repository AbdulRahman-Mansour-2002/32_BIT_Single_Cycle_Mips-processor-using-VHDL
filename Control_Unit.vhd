library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Control_Unit is
port (	Op_code : 		in 		std_logic_vector (5 downto 0);
			out_select : 	out		std_logic; --load for out register
			Ijump :			out		std_logic;
			RegDST :			out		std_logic;
			JAL :				out		std_logic;
			Reg_write :		out		std_logic;
			ALU_op :			out		std_logic;
			Fun_SRC	 :		out		std_logic;
			Branch :			out		std_logic;
			MulS :			out		std_logic;
			jump :			out		std_logic;
			MemWrite :		out		std_logic;
			MemToReg :		out		std_logic;
			StackRead :		out		std_logic;
			StackWrite :	out		std_logic;
			InputS :			out		std_logic;
			zero_load: 		out		std_logic;
			loop_ind : out std_logic;
			hlt_sel:			out		std_logic);
end Control_Unit;

architecture Behavioral of Control_Unit is
constant alu : 	std_logic_vector(5 downto 0):= "000000";
constant ADDI: 	std_logic_vector(5 downto 0):= "000001";
constant ANDI: 	std_logic_vector(5 downto 0):= "000010";
constant BEQ : 	std_logic_vector(5 downto 0):= "000011";
constant BG  : 	std_logic_vector(5 downto 0):= "000100";
constant BNE : 	std_logic_vector(5 downto 0):= "000101";
constant BS  : 	std_logic_vector(5 downto 0):= "000110";
constant LW  : 	std_logic_vector(5 downto 0):= "000111";
constant MOVI: 	std_logic_vector(5 downto 0):= "001000";
constant ORI : 	std_logic_vector(5 downto 0):= "001001";
constant SW  : 	std_logic_vector(5 downto 0):= "001010";
constant J   : 	std_logic_vector(5 downto 0):= "001011";
constant JAL_1:	std_logic_vector(5 downto 0):= "001100";
constant JNZ : 	std_logic_vector(5 downto 0):= "001101";
constant JR  : 	std_logic_vector(5 downto 0):= "001110";
constant JZ  : 	std_logic_vector(5 downto 0):= "001111";
constant IN_1 :	std_logic_vector(5 downto 0):= "010000";
constant MOV : 	std_logic_vector(5 downto 0):= "010001";
constant OUT_1:	std_logic_vector(5 downto 0):= "010010";
constant Pop : 	std_logic_vector(5 downto 0):= "010011";
constant Push: 	std_logic_vector(5 downto 0):= "010100";
constant HLT : 	std_logic_vector(5 downto 0):= "010101";
constant Loop_1:	std_logic_vector(5 downto 0):= "010110";
constant NOP : 	std_logic_vector(5 downto 0):= "010111";
constant inmem : 	std_logic_vector(5 downto 0):= "011000";
constant cmp : 	std_logic_vector(5 downto 0):= "011001";
constant cmpI : 	std_logic_vector(5 downto 0):= "011010";

begin
L1:process (op_code)
		begin
				if ( op_code = alu) 		then
						out_select 	<= '0';	Ijump 		<= '0';		RegDST 		<= '1';		JAL 			<= '0';
						Reg_write 	<= '1';	ALU_op 		<= '0';		Fun_SRC	 	<= '0';		Branch 		<= '0';
						MulS 			<= '0';	jump 			<= '0';		MemWrite 	<= '0';		loop_ind 	<= '0';
						MemToReg 	<= '1';	StackRead 	<= '0';		StackWrite 	<= '0';
						InputS 		<= '0'; 	zero_load 	<= '1'; 		hlt_sel 		<= '0';
				elsif(op_code = ADDI)	then
						out_select 	<= '0';	Ijump 		<= '0';		RegDST 		<= '0';		JAL 			<= '0';
						Reg_write 	<= '1';	ALU_op 		<= '1';		Fun_SRC	 	<= '1';		Branch 		<= '0';
						MulS 			<= '0';	jump 			<= '0';		MemWrite 	<= '0';		loop_ind 	<= '0';
						MemToReg 	<= '1';	StackRead 	<= '0';		StackWrite 	<= '0';
						InputS 		<= '0'; 	zero_load 	<= '1'; 		hlt_sel 		<= '0';
				elsif(op_code = ANDI)	then
						out_select 	<= '0';	Ijump 		<= '0';		RegDST 		<= '0';		JAL 			<= '0';
						Reg_write 	<= '1';	ALU_op 		<= '1';		Fun_SRC	 	<= '1';		Branch 		<= '0';
						MulS 			<= '0';	jump 			<= '0';		MemWrite 	<= '0';		loop_ind 	<= '0';
						MemToReg 	<= '1';	StackRead 	<= '0';		StackWrite 	<= '0';
						InputS 		<= '0'; 	zero_load 	<= '1'; 		hlt_sel 		<= '0';
				elsif(op_code = BEQ)		then
						out_select 	<= '0';	Ijump 		<= '0';		RegDST 		<= '0';		JAL 			<= '0';
						Reg_write 	<= '0';	ALU_op 		<= '1';		Fun_SRC	 	<= '0';		Branch 		<= '1';
						MulS 			<= '0';	jump 			<= '0';		MemWrite 	<= '0';		loop_ind 	<= '0';
						MemToReg 	<= '1';	StackRead 	<= '0';		StackWrite 	<= '0';
						InputS 		<= '0'; 	zero_load 	<= '1'; 		hlt_sel 		<= '0';
				elsif(op_code = BG)		then
						out_select 	<= '0';	Ijump 		<= '0';		RegDST 		<= '0';		JAL 			<= '0';
						Reg_write 	<= '0';	ALU_op 		<= '1';		Fun_SRC	 	<= '0';		Branch 		<= '1';
						MulS 			<= '0';	jump 			<= '0';		MemWrite 	<= '0';		loop_ind 	<= '0';
						MemToReg 	<= '1';	StackRead 	<= '0';		StackWrite 	<= '0';
						InputS 		<= '0'; 	zero_load 	<= '1'; 		hlt_sel 		<= '0';
				elsif(op_code = BNE)		then
						out_select 	<= '0';	Ijump 		<= '0';		RegDST 		<= '0';		JAL 			<= '0';
						Reg_write 	<= '0';	ALU_op 		<= '1';		Fun_SRC	 	<= '0';		Branch 		<= '1';
						MulS 			<= '0';	jump 			<= '0';		MemWrite 	<= '0';		loop_ind 	<= '0';
						MemToReg 	<= '1';	StackRead 	<= '0';		StackWrite 	<= '0';
						InputS 		<= '0'; 	zero_load 	<= '1'; 		hlt_sel 		<= '0';
				elsif(op_code = BS)		then
						out_select 	<= '0';	Ijump 		<= '0';		RegDST 		<= '0';		JAL 			<= '0';
						Reg_write 	<= '0';	ALU_op 		<= '1';		Fun_SRC	 	<= '0';		Branch 		<= '1';
						MulS 			<= '0';	jump 			<= '0';		MemWrite 	<= '0';		loop_ind 	<= '0';
						MemToReg 	<= '1';	StackRead 	<= '0';		StackWrite 	<= '0';
						InputS 		<= '0'; 	zero_load 	<= '1'; 		hlt_sel 		<= '0';
				elsif(op_code = LW)		then
						out_select 	<= '0';	Ijump 		<= '0';		RegDST 		<= '0';		JAL 			<= '0';
						Reg_write 	<= '1';	ALU_op 		<= '1';		Fun_SRC	 	<= '1';		Branch 		<= '0';
						MulS 			<= '0';	jump 			<= '0';		MemWrite 	<= '0';		loop_ind 	<= '0';
						MemToReg 	<= '0';	StackRead 	<= '0';		StackWrite 	<= '0';
						InputS 		<= '0'; 	zero_load 	<= '0'; 		hlt_sel 		<= '0';
				elsif(op_code = MOVI)	then
						out_select 	<= '0';	Ijump 		<= '0';		RegDST 		<= '0';		JAL 			<= '0';
						Reg_write 	<= '1';	ALU_op 		<= '1';		Fun_SRC	 	<= '1';		Branch 		<= '0';
						MulS 			<= '0';	jump 			<= '0';		MemWrite 	<= '0';		loop_ind 	<= '0';
						MemToReg 	<= '1';	StackRead 	<= '0';		StackWrite 	<= '0';
						InputS 		<= '0'; 	zero_load 	<= '1'; 		hlt_sel 		<= '0';
				elsif(op_code = ORI)		then
						out_select 	<= '0';	Ijump 		<= '0';		RegDST 		<= '0';		JAL 			<= '0';
						Reg_write 	<= '1';	ALU_op 		<= '1';		Fun_SRC	 	<= '1';		Branch 		<= '0';
						MulS 			<= '0';	jump 			<= '0';		MemWrite 	<= '0';		loop_ind 	<= '0';
						MemToReg 	<= '1';	StackRead 	<= '0';		StackWrite 	<= '0';
						InputS 		<= '0'; 	zero_load 	<= '0'; 		hlt_sel 		<= '0';
				elsif(op_code = SW)		then
						out_select 	<= '0';	Ijump 		<= '0';		RegDST 		<= '0';		JAL 			<= '0';
						Reg_write 	<= '0';	ALU_op 		<= '1';		Fun_SRC	 	<= '1';		Branch 		<= '0';
						MulS 			<= '0';	jump 			<= '0';		MemWrite 	<= '1';		loop_ind 	<= '0';
						MemToReg 	<= '1';	StackRead 	<= '0';		StackWrite 	<= '0';
						InputS 		<= '0'; 	zero_load 	<= '0'; 		hlt_sel 		<= '0';
				elsif(op_code = J)		then
						out_select 	<= '0';	Ijump 		<= '1';		RegDST 		<= '0';		JAL 			<= '0';
						Reg_write 	<= '0';	ALU_op 		<= '1';		Fun_SRC	 	<= '0';		Branch 		<= '0';
						MulS 			<= '0';	jump 			<= '0';		MemWrite 	<= '0';		loop_ind 	<= '0';
						MemToReg 	<= '1';	StackRead 	<= '0';		StackWrite 	<= '0';
						InputS 		<= '0'; 	zero_load 	<= '0'; 		hlt_sel 		<= '0';
				elsif(op_code = JAL_1)	then
						out_select 	<= '0';	Ijump 		<= '1';		RegDST 		<= '1';		JAL 			<= '1';
						Reg_write 	<= '1';	ALU_op 		<= '1';		Fun_SRC	 	<= '0';		Branch 		<= '0';
						MulS 			<= '0';	jump 			<= '0';		MemWrite 	<= '0';		loop_ind 	<= '0';
						MemToReg 	<= '1';	StackRead 	<= '0';		StackWrite 	<= '0';
						InputS 		<= '0'; 	zero_load 	<= '0'; 		hlt_sel 		<= '0';
				elsif(op_code = JNZ)		then
						out_select 	<= '0';	Ijump 		<= '1';		RegDST 		<= '0';		JAL 			<= '0';
						Reg_write 	<= '0';	ALU_op 		<= '1';		Fun_SRC	 	<= '0';		Branch 		<= '0';
						MulS 			<= '0';	jump 			<= '0';		MemWrite 	<= '0';		loop_ind 	<= '0';
						MemToReg 	<= '1';	StackRead 	<= '0';		StackWrite 	<= '0';
						InputS 		<= '0'; 	zero_load 	<= '0'; 		hlt_sel 		<= '0';
				elsif(op_code = JR)		then
						out_select 	<= '0';	Ijump 		<= '0';		RegDST 		<= '0';		JAL 			<= '0';
						Reg_write 	<= '0';	ALU_op 		<= '1';		Fun_SRC	 	<= '0';		Branch 		<= '0';
						MulS 			<= '0';	jump 			<= '1';		MemWrite 	<= '0';		loop_ind 	<= '0';
						MemToReg 	<= '1';	StackRead 	<= '0';		StackWrite 	<= '0';
						InputS 		<= '0'; 	zero_load 	<= '0'; 		hlt_sel 		<= '0';
				elsif(op_code = JZ)		then
						out_select 	<= '0';	Ijump 		<= '1';		RegDST 		<= '0';		JAL 			<= '0';
						Reg_write 	<= '0';	ALU_op 		<= '1';		Fun_SRC	 	<= '0';		Branch 		<= '0';
						MulS 			<= '0';	jump 			<= '0';		MemWrite 	<= '0';		loop_ind 	<= '0';
						MemToReg 	<= '1';	StackRead 	<= '0';		StackWrite 	<= '0';
						InputS 		<= '0'; 	zero_load 	<= '0'; 		hlt_sel 		<= '0';
				elsif(op_code = IN_1)	then
						out_select 	<= '0';	Ijump 		<= '0';		RegDST 		<= '0';		JAL 				<= '0';
						Reg_write 	<= '1';	ALU_op 		<= '1';		Fun_SRC	 	<= '0';		Branch 		<= '0';
						MulS 			<= '0';	jump 			<= '0';		MemWrite 	<= '0';		loop_ind 	<= '0';
						MemToReg 	<= '1';	StackRead 	<= '0';		StackWrite 	<= '0';
						InputS 		<= '1'; 	zero_load 	<= '0'; 		hlt_sel 		<= '0';
				elsif(op_code = MOV)		then
						out_select 	<= '0';	Ijump 		<= '0';		RegDST 		<= '0';		JAL 			<= '0';
						Reg_write 	<= '1';	ALU_op 		<= '1';		Fun_SRC	 	<= '0';		Branch 		<= '0';
						MulS 			<= '0';	jump 			<= '0';		MemWrite 	<= '0';		loop_ind 	<= '0';
						MemToReg 	<= '1';	StackRead 	<= '0';		StackWrite 	<= '0';
						InputS 		<= '0'; 	zero_load 	<= '0'; 		hlt_sel 		<= '0';
				elsif(op_code = OUT_1)	then 
						out_select 	<= '1';	Ijump 		<= '0';		RegDST 		<= '0';		JAL 			<= '0';
						Reg_write 	<= '0';	ALU_op 		<= '1';		Fun_SRC	 	<= '0';		Branch 		<= '0';
						MulS 			<= '0';	jump 			<= '0';		MemWrite 	<= '0';		loop_ind 	<= '0';
						MemToReg 	<= '1';	StackRead 	<= '0';		StackWrite 	<= '0';
						InputS 		<= '0'; 	zero_load 	<= '0'; 		hlt_sel 		<= '0';
				elsif(op_code = POP)		then
						out_select 	<= '0';	Ijump 		<= '0';		RegDST 		<= '0';		JAL 			<= '0';
						Reg_write 	<= '1';	ALU_op 		<= '1';		Fun_SRC	 	<= '0';		Branch 		<= '0';
						MulS 			<= '0';	jump 			<= '0';		MemWrite 	<= '0';		loop_ind 	<= '0';		
						MemToReg 	<= '1';	StackRead 	<= '1';		StackWrite 	<= '0';
						InputS 		<= '0'; 	zero_load 	<= '0'; 		hlt_sel 		<= '0';
				elsif(op_code = PUSH)	then
						out_select 	<= '0';	Ijump 		<= '0';		RegDST 		<= '0';		JAL 			<= '0';
						Reg_write 	<= '0';	ALU_op 		<= '1';		Fun_SRC	 	<= '0';		Branch 		<= '0';
						MulS 			<= '0';	jump 			<= '0';		MemWrite 	<= '0';		loop_ind 	<= '0';
						MemToReg 	<= '1';	StackRead 	<= '0';		StackWrite 	<= '1';
						InputS 		<= '0'; 	zero_load 	<= '0'; 		hlt_sel 		<= '0';
				elsif(op_code = HLT)		then 
						out_select 	<= '0';	Ijump 		<= '0';		RegDST 		<= '0';		JAL 			<= '0';
						Reg_write 	<= '0';	ALU_op 		<= '0';		Fun_SRC	 	<= '0';		Branch 		<= '0';
						MulS 			<= '0';	jump 			<= '0';		MemWrite 	<= '0';		loop_ind 	<= '0';
						MemToReg 	<= '1';	StackRead 	<= '0';		StackWrite 	<= '0';
						InputS 		<= '0'; 	zero_load 	<= '0'; 		hlt_sel 		<= '1';
				elsif(op_code = LOOP_1)	then
						out_select 	<= '0';	Ijump 		<= '1';		RegDST 		<= '0';		JAL 			<= '0';
						Reg_write 	<= '1';	ALU_op 		<= '1';		Fun_SRC	 	<= '1';		Branch 		<= '0';
						MulS 			<= '0';	jump 			<= '0';		MemWrite 	<= '0';		loop_ind 	<= '1';
						MemToReg 	<= '1';	StackRead 	<= '0';		StackWrite 	<= '0';
						InputS 		<= '0'; 	zero_load 	<= '1'; 		hlt_sel 		<= '0';
				elsif(op_code = NOP)		then
						out_select 	<= '0';	Ijump 		<= '0';		RegDST 		<= '0';		JAL 			<= '0';
						Reg_write 	<= '0';	ALU_op 		<= '1';		Fun_SRC	 	<= '0';		Branch 		<= '0';
						MulS 			<= '0';	jump 			<= '0';		MemWrite 	<= '0';		loop_ind 	<= '0';
						MemToReg 	<= '1';	StackRead 	<= '0';		StackWrite 	<= '0';
						InputS 		<= '0'; 	zero_load 	<= '0'; 		hlt_sel 		<= '0';
				elsif(op_code = INMEM)	then
						out_select 	<= '0';	Ijump 		<= '0';		RegDST 		<= '0';		JAL 			<= '0';
						Reg_write 	<= '0';	ALU_op 		<= '1';		Fun_SRC	 	<= '0';		Branch 		<= '0';
						MulS 			<= '1';	jump 			<= '0';		MemWrite 	<= '1';		loop_ind 	<= '0';
						MemToReg 	<= '1';	StackRead 	<= '0';		StackWrite 	<= '0';
						InputS 		<= '0'; 	zero_load 	<= '0';		hlt_sel 		<= '0';
				elsif(op_code = cmp)	then
						out_select 	<= '0';	Ijump 		<= '0';		RegDST 		<= '0';		JAL 			<= '0';
						Reg_write 	<= '0';	ALU_op 		<= '1';		Fun_SRC	 	<= '0';		Branch 		<= '0';
						MulS 			<= '0';	jump 			<= '0';		MemWrite 	<= '0';		loop_ind 	<= '0';
						MemToReg 	<= '1';	StackRead 	<= '0';		StackWrite 	<= '0';
						InputS 		<= '0'; 	zero_load 	<= '1';		hlt_sel 		<= '0';
				elsif(op_code = cmpI)	then
						out_select 	<= '0';	Ijump 		<= '0';		RegDST 		<= '0';		JAL 			<= '0';
						Reg_write 	<= '0';	ALU_op 		<= '1';		Fun_SRC	 	<= '1';		Branch 		<= '0';
						MulS 			<= '0';	jump 			<= '0';		MemWrite 	<= '0';		loop_ind 	<= '0';
						MemToReg 	<= '1';	StackRead 	<= '0';		StackWrite 	<= '0';
						InputS 		<= '0'; 	zero_load 	<= '1';		hlt_sel 		<= '0';
				else -- hlt also
						out_select 	<= '0';	Ijump 		<= '0';		RegDST 		<= '0';		JAL 			<= '0';
						Reg_write 	<= '0';	ALU_op 		<= '0';		Fun_SRC	 	<= '0';		Branch 		<= '0';
						MulS 			<= '0';	jump 			<= '0';		MemWrite 	<= '0';		loop_ind 	<= '0';
						MemToReg 	<= '1';	StackRead 	<= '0';		StackWrite 	<= '0';
						InputS 		<= '0'; 	zero_load 	<= '0'; 		hlt_sel 		<= '1';				end if;
		end process;
end Behavioral;

