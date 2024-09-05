library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
	use IEEE.NUMERIC_STD.ALL;
entity ProcessorTopModel is
    Port ( 	IN_PORT_act : 	in  	STD_LOGIC_VECTOR (8 downto 0);
				OUT_PORT : 		out  	STD_LOGIC_VECTOR (15 downto 0);
				clk : 			in  	STD_LOGIC;
				reset : 			in  	STD_LOGIC );
end ProcessorTopModel;

architecture Behavioral of ProcessorTopModel is
-------------------signals----------------------------
signal In_port : 				std_logic_vector (31 downto 0);
signal PC_entry : 			std_logic_vector (31 downto 0);
signal PC_entry_h : 			std_logic_vector (31 downto 0);
signal PC_entry_hh :			std_logic_vector (31 downto 0);
signal PC_out : 				std_logic_vector (31 downto 0);
signal Instruction : 		std_logic_vector (31 downto 0);
signal Data_out1 : 			std_logic_vector (31 downto 0);
signal Data_out2 : 			std_logic_vector (31 downto 0);
signal Arthi_in : 			std_logic_vector (31 downto 0);
signal Alu_out : 				std_logic_vector (31 downto 0);
signal Arthi_out : 			std_logic_vector (31 downto 0);
signal Read_data_Mem : 		std_logic_vector (31 downto 0);
signal Data_in_MemToReg : 	std_logic_vector (31 downto 0);
signal Data_out_stack : 	std_logic_vector (31 downto 0);
signal Data_SRC : 			std_logic_vector (31 downto 0);
signal New_PC : 				std_logic_vector (31 downto 0);
signal RegData_in : 			std_logic_vector (31 downto 0);
signal Write_reg : 			std_logic_vector (4  downto 0);
signal JAL_mux : 				std_logic_vector (31 downto 0);
signal Sign_extended : 		std_logic_vector (31 downto 0);
signal Branch_src : 			std_logic_vector (31 downto 0);
signal Jump_reg : 			std_logic_vector (31 downto 0);
signal Alu_immediate : 		std_logic_vector (31 downto 0);
signal RegDst_in : 			std_logic_vector (4 downto 0);
signal jumpToImm : 			std_logic_vector (31 downto 0); -- for signal use not a connection --
signal MOVI_in :				std_logic_vector (31 downto 0);
----------------------CU signals---------------------------
signal out_select :			std_logic; --load for out register
signal Ijump :					std_logic;
signal RegDST :				std_logic;
signal JAL :					std_logic;
signal Reg_write :			std_logic;
signal ALU_op :				std_logic;
signal Fun_SRC	 :				std_logic;
signal Branch :				std_logic;
signal MulS :					std_logic;
signal jump :					std_logic;
signal MemWrite :				std_logic;
signal MemToReg :				std_logic;
signal StackRead :			std_logic;
signal StackWrite :			std_logic;
signal zero_load: 			std_logic;
signal InputS :				std_logic;
signal hlt_sel:				std_logic;
signal loop_ind:				std_logic;
-----------------------------------------------------
signal zero_flag:				std_logic; -- NOT A CU selection --
signal zero_reg :				std_logic; -- to save the flag
signal alu_fun:				std_logic_vector (3 downto 0);
signal IJUMP_indecate:     std_logic; -- from jump compartor
signal I_jump:					std_logic; -- anding between IJUMP , IJUMP_indecate
signal Branch_indecate:		std_logic;
signal branching	:			std_logic;
signal loop_sel	:			std_logic;
signal looop	:				std_logic;
-------------------components-------------------------
component Imemory is
    Port (	address : in   		STD_LOGIC_VECTOR (11 downto 0);
				instruction : out  	STD_LOGIC_VECTOR (31 downto 0));
end component;

component reg_files is
port(r_reg1,r_reg2,w_reg:in 		STD_LOGIC_VECTOR(4 downto 0);
		data_in:in 						STD_LOGIC_VECTOR(31 downto 0);
		w_en ,clk,clear:in 			STD_LOGIC ;
		data_out1,data_out2:out 	STD_LOGIC_VECTOR (31 downto 0));
end component;

component alsu is
    Port ( data_1 : in  			STD_LOGIC_VECTOR (31 downto 0);
           data_2 : in  			STD_LOGIC_VECTOR (31 downto 0);
           func : in  				STD_LOGIC_VECTOR (3 downto 0);
           data_out : out  		STD_LOGIC_VECTOR (31 downto 0);
           zero_flag : out  		STD_LOGIC);
end component;

component Dmemory is
    Port ( address : in  			STD_LOGIC_VECTOR (9 downto 0);
           data_in : in  			STD_LOGIC_VECTOR (31 downto 0);
           data_out : out  		STD_LOGIC_VECTOR (31 downto 0);
           clk : in  				STD_LOGIC;
           write_signal : in  	STD_LOGIC);
end component;

component LIFO is
	port(stack_in    : in  			STD_LOGIC_VECTOR(31 downto 0);
		stack_out   : out 			STD_LOGIC_VECTOR(31 downto 0);
		rd, wr, clk ,reset: in 		STD_LOGIC);
end component;

component mux is
    Port ( data0 : in  				STD_LOGIC_VECTOR (31 downto 0);
           data1 : in  				STD_LOGIC_VECTOR (31 downto 0);
           sel : in  				STD_LOGIC;
           data_out : out  		STD_LOGIC_VECTOR (31 downto 0));
end component;

component muxx is
    Port ( data0 : in  				STD_LOGIC_VECTOR (4 downto 0);
           data1 : in  				STD_LOGIC_VECTOR (4 downto 0);
           sel : in  				STD_LOGIC;
           data_out : out  		STD_LOGIC_VECTOR (4 downto 0));
end component;

component Control_Unit is
port (	Op_code : 		in 		STD_LOGIC_VECTOR (5 downto 0);
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
			zero_load :		out		std_logic;
			loop_ind : 		out 		std_logic;
			hlt_sel:			out		std_logic);
end component;

component alu_cu is
port (		op_code : 	in 		STD_LOGIC_VECTOR (5 downto 0);
				alu_op : 	in 		STD_LOGIC;
				fun_in : 	in 		STD_LOGIC_VECTOR (3 downto 0);
				fun : 		out 		STD_LOGIC_VECTOR (3 downto 0));
end component;

component PC is
port ( PC_entry :			in 		STD_LOGIC_VECTOR ( 31 downto 0);
		clk,reset :			in 		STD_LOGIC;
		PC_out    :			out 		STD_LOGIC_VECTOR (31 downto 0));
end component;

component zero_register is
port (  zero_flag : 		in 		STD_LOGIC ;
			clk 		: 		in 		STD_LOGIC;
			zero_load : 	in 		STD_LOGIC;
			zero_reg :		out 		STD_LOGIC);
end component;

component OUT_P is
port ( data_out1 : 		in 		STD_LOGIC_VECTOR (15 downto 0);
			clk: 				in 		STD_LOGIC;
			out_select: 	in 		STD_LOGIC;
			out_port : 		out 		STD_LOGIC_VECTOR (15 downto 0));
end component;

component JC is
port (		op_code : 	in 		STD_LOGIC_VECTOR (5 downto 0);
				zero_flag : in 		STD_LOGIC;
		IJUMP_indecate : 	out 		STD_LOGIC);
end component;

component BC is
port (	op_code : 		in 		STD_LOGIC_VECTOR (5 downto 0);
	data_out1,data_out2: in 		STD_LOGIC_VECTOR (31 downto 0);
	Branch_indecate : 	out 		STD_LOGIC);
end component;

----------------------------------------------------------- NOT WORIKING (FOR FUTURE WORK IN SHAA ALLAH ---------------------------------------------------
--component keypad is
--
--	port (
--	  clk      : in  std_logic;
--	  rst      : in  std_logic;
--	  -- input
--	  col    : in  std_logic_vector(3 downto 0);
--	  output	: out std_logic;
--	  row    : out std_logic_vector(3 downto 0);
--	  ascii  : out std_logic_vector(7 downto 0));
--end component;

begin
---------------------------------------Mapping----------------------------------------------------------
control_unit_label: control_unit port map (instruction (31 downto 26),out_select,Ijump,RegDST,JAL,Reg_write,ALU_op,Fun_SRC,Branch,MULS,jump,MemWrite,MemToReg,StackRead,StackWrite,InputS,zero_load,loop_ind,hlt_sel);
Imemory_label: Imemory 				port map (PC_OUT (11 downto 0),instruction);
Inst_reg_files: reg_files 			PORT MAP	(instruction (25 downto 21),instruction (20 downto 16),write_reg,regdata_in,reg_write,clk,reset,data_out1,data_out2);
alu_CU_label :	alu_CU				port map (instruction (31 downto 26),alu_op,instruction (3 downto 0),alu_fun);
alsu_label: 	alsu 					port map (data_out1,arthi_in,alu_fun,alu_out,zero_flag);
Dmemory_label: dmemory 				port map (arthi_out (9 downto 0),data_out2,Read_data_Mem,clk,MemWrite);
stack_label:	lifo					port map (data_out1,Data_out_stack,StackRead,StackWrite,clk,reset);
PC_label :		PC 					port map (PC_entry_h,clk,reset,PC_OUT);
zero_label :   zero_register     port map (zero_flag,clk,zero_load,zero_reg);
out_label  :   out_p					port map (data_out1(15 downto 0),clk,out_select,out_port);
jump_compartor : JC					port map (instruction (31 downto 26),zero_reg,IJUMP_indecate);
branch_comparotor: BC				port map (instruction (31 downto 26),data_out1,data_out2,Branch_indecate);
--Keypad_label:	keypad				port map	(clk,reset,in_port_act,
----------- we have 13 mux ------------
regDST_mux : 			muxx 			port map (data0 => Instruction (20 downto 16), 	data1 => Instruction (15 downto 11),	sel => regDST,		data_out => RegDst_in);
writeReg_mux : 		muxx			port map (data0 => RegDst_in, 						data1 => "11110",								sel => jal,			data_out => write_reg);
funSRC_mux : 			mux 			port map (data0 => data_out2, 						data1 => MOVI_in,						sel => fun_src,	data_out => arthi_in);
MulS_mux : 				mux 			port map (data0 => alu_out, 							data1 => IN_PORT,								sel => muls,		data_out => arthi_out);
MemToReg_mux : 		mux 			port map (data0 => Read_data_Mem, 					data1 => arthi_out,							sel => memToReg,	data_out => Data_in_MemToReg);
stackToReg_mux : 		mux 			port map (data0 => Data_in_MemToReg, 				data1 => Data_out_stack,					sel => stackread,	data_out => Data_SRC);
JAL_Stack_mux : 		mux 			port map (data0 => Data_SRC, 							data1 => New_PC,								sel => JAL,			data_out => JAL_mux);
Input_mux :				mux			port map (data0 => JAL_mux, 							data1 => IN_PORT,								sel => InputS,		data_out => RegData_in);
Branch_mux :			mux			port map (data0 => New_PC, 							data1 => Alu_immediate,						sel => branching,	data_out => Branch_SRC);
jump_mux :				mux			port map (data0 => Branch_SRC, 						data1 => data_out1,							sel => jump,		data_out => jump_reg);
Ijump_mux :				mux			port map (data0 => Jump_reg, 							data1 => jumpToImm,							sel => I_jump,		data_out => PC_entry);
hlt_mux :				mux 			port map (data0 => PC_entry_hh, 						data1 => PC_out,								sel => hlt_sel,	data_out => PC_entry_h);
loop_mux:				mux			port map (data0 => PC_entry, 							data1 => jumpToImm,							sel => looop,		data_out => PC_entry_hh);
---------------------------------------------------------------------------------------------------------
looop <= (Ijump and loop_sel and loop_ind);
loop_sel <= '1' when data_out1 /=X"00000000" else '0';
--------------------------------------
New_PC <= std_logic_vector (unsigned (PC_out)+1);
Alu_immediate <=  std_logic_vector (unsigned (New_PC) + unsigned(Sign_extended));
jumpToImm   <= (PC_out (31 downto 16) & Instruction (15 downto 0));
I_jump <= Ijump and IJUMP_indecate;
branching <= branch and branch_indecate;
In_port <= "00000000000000000000000" & In_port_act;
Sign_extended <= 	instruction (15) & instruction (15) &instruction (15) &instruction (15) &
						instruction (15) & instruction (15) &instruction (15) &instruction (15) &
						instruction (15) & instruction (15) &instruction (15) &instruction (15) &
						instruction (15) & instruction (15) &instruction (15) &instruction (15) & 
						instruction (15 downto 0);
MOVI_in <= 	("0000000000000000" & Sign_extended(15 downto 0)) when instruction (31 downto 26 ) = "001000"
				else Sign_extended;
end Behavioral;