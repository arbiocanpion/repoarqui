library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity ControlUnit is
	Port (
		Opcode	:	in	std_logic_vector(16 downto 0);	-- instruction to execute
		status : in std_logic_vector(2 downto 0);
		LPC		:	out	std_logic;						-- load pc
		enableA		:	out	std_logic;						-- load A
		enableB		:	out	std_logic;						-- load B
		selA		:	out	std_logic_vector(1 downto 0);	-- mux A
		selB		:	out	std_logic_vector(1 downto 0);	-- mux B
		selAlu		:	out	std_logic_vector(2 downto 0);	-- ALU
		w		:	out	std_logic					-- write RAM
	);
end ControlUnit;

architecture Behavioral of ControlUnit is

signal OutSignal : std_logic_vector(10 downto 0);

begin

LPC					<= OutSignal(10);
enableA 			<= OutSignal(9);
enableB 			<= OutSignal(8);
selA				<= OutSignal(7 downto 6);
selB 				<= OutSignal(5 downto 4);
selAlu 				<= OutSignal(3 downto 1);
w					<= OutSignal(0);

-- LPC LA LB  SA SB  SAlu W
--  0   0  0  00 00  000  0   
with Opcode select OutSignal <=
	
	-- MOV
	"01001000000"						when "00000000000000000", -- A, B
	"00100010000" 						when "00000000000000001", -- B, A
	"01001110000" 						when "00000000000000010", -- A, Lit
	"00101110000" 						when "00000000000000011", -- B, Lit
	"01001100000" 						when "00000000000000100", -- A, Dir
	"00101100000" 						when "00000000000000101", -- B, Dir
	"00000010001" 						when "00000000000000110", -- Dir, A
	"00001000001" 						when "00000000000000111", -- Dir, B
	
	-- ADD
	"01000000000" 						when "00000000000001000", -- A, B
	"00100000000" 						when "00000000000001001", -- B, A
	"01000110000" 						when "00000000000001010", -- A, Lit
	"00100110000"	 					when "00000000000001011", -- B, Lit
	"01000100000" 						when "00000000000001100", -- A, (Dir)
	"00100100000" 						when "00000000000001101", -- B, (Dir)
	"00000000001" 						when "00000000000001110", -- (DIR)

	-- SUB
	"01000000010" 						when "00000000000001111", -- A, B
	"00100000010" 						when "00000000000010000", -- B, A
	"01000110010" 						when "00000000000010001", -- A, Lit
	"00100110010"						when "00000000000010010", -- B, Lit
	"01000100010" 						when "00000000000010011", -- A, (Dir)
	"00100100010"		 				when "00000000000010100", -- B, (Dir) 
	"00000000011" 						when "00000000000010101", -- (DIR)
	
	-- AND
	"01000000110" 						when "00000000000010110", -- A, B
	"00100000110" 						when "00000000000010111", -- B, A
	"01000110110" 						when "00000000000011000", -- A, Lit
	"00100110110" 						when "00000000000011001", -- B, Lit
	"01000100110"						when "00000000000011010", -- A, (Dir) 
	"00100100110"						when "00000000000011011", -- B, (Dir)
	"00000000111" 						when "00000000000011100", -- (DIR) 
	
	-- OR
	"01000000100" 						when "00000000000011101", -- A, B 
	"00100000100"						when "00000000000011110", -- B, A
	"01000110100"						when "00000000000011111", -- A, Lit
	"00100110100"						when "00000000000100000", -- B, Lit
	"01000100100"						when "00000000000100001", -- A, Dir
	"00100100100"						when "00000000000100010", -- B, Dir
	"00000000101"						when "00000000000100011", -- (DIR)

	-- XOR
	"01000001010"						when "00000000000100100", -- A, B
	"00100001010"						when "00000000000100101", -- B, A
	"01000111010"						when "00000000000100110", -- A, Lit
	"00100111010"						when "00000000000100111", -- B, Lit
	"01000101010"						when "00000000000101000", -- A, Dir
	"00100101010"						when "00000000000101001", -- B, Dir
	"00000001011"						when "00000000000101010", -- (DIR)

	-- NOT
	"01000001000"						when "00000000000101011", -- A
	"00100001000"						when "00000000000101100", -- B, A
	"00000001001"						when "00000000000101101", -- Dir, A	
	
	-- SHL
	"01000001100"						when "00000000000101110", -- A
	"00100001100"						when "00000000000101111", -- B, A
	"00000001101"						when "00000000000110000", -- Dir, A
	
	-- SHR
	"01000001100"						when "00000000000110001", -- A
	"00100001100"						when "00000000000110010", -- B, A
	"00000001101"						when "00000000000110011", -- Dir, A
	
	-- INC
	"01000000000"						when "00000000000110100", -- A
	--(esta la dejaremos como nula porque realmente se usaran dos instrucciones por)
	"00000000000"						when "00000000000110101", -- B 
	"00000000000"						when "00000000000110110", --	Dir, A
	-- lo mismo para esta
	
	-- DEC
	"00000000000"						when "00000000000110111", -- A --	
	-- aca igual (no se si haran enviar el lit o mejor dos ins no +)
	
	-- CMP	
	"00000000010"						when "00000000000111000", -- A - B
	"00000110010"						when "00000000000111001", -- A - Lit
	"00000100010"						when "00000000000111010", -- A - Mem[Dir]
	
	-- JMP
	"10000000000"     		            when "00000000000111011", -- Dir, A
	
	-- JEQ
	(status(0)) & "0000000000"		    when "00000000000111100", -- DirB, A

	-- JNE
	(not status(0)) & "0000000000"		when "00000000000111101", -- A
	
	-- JGT
	((not status(0) and not status(1))) & "0000000000"						when "00000000001000001", -- A
	
	-- JGE
	(not status(1)) & "0000000000"		when "00000000001000010", -- B, A
	
	-- JLT
	(status(1)) & "0000000000"			when "00000000001000011", -- Dir, A
	
	-- JLE
	((status(1)) xor (status(0))) & "0000000000"						when "00000000001000101", -- A
	
	-- JCR
	(status(2)) & "0000000000"						when "00000000001000110", -- B
	
	-- NOP
	"00000000000"						when "00000000001000111", -- no hace nada
	"00000000000" when others;
	
end Behavioral;