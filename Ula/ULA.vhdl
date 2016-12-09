----------------------------------------------------------------------------------
-- UnB (Universidade de Brasilia)
-- Nome: Pedro Aurelio Coelho de Almeida 
-- Matricula:14/0158103
-- Data de Criacao:    14:10:03 10/13/2016 
--Nome do Modulo:    ULA - Behavioral 
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ulaMIPS is 
  generic (WSIZE : natural := 32);
	port ( OpCode:  in  std_logic_vector(3 downto 0);
	A, B: in  std_logic_vector(WSIZE-1 downto 0);
	Z: out std_logic_vector(WSIZE-1 downto 0);
	ovfl,vai,zero: out std_logic);
end ulaMIPS;

architecture behavioral of ulaMIPS is  
	signal tmp_soma,tmp_sub: std_logic_vector(WSIZE downto 0);-- para as operacaoes de soma e subtracao conterem o carry/borrow
  signal ov_soma,ov_sub: std_logic;-- sl0 indica quando slt retornou 0 e nulo indica quando a32 eh 0
	signal a32 : std_logic_vector(WSIZE-1 downto 0);
	signal menor: std_logic_vector(WSIZE-1 downto 0);
	signal num_zero: std_logic_vector(WSIZE-1 downto 0):= (others => '0');
	signal num_um: std_logic_vector(WSIZE-1 downto 0):= (0=>'1',others => '0');
	
	begin  
	tmp_soma <=  std_logic_vector(signed('0'&A) + signed('0'&B));
	tmp_sub<=  std_logic_vector(signed('0'&A) - signed('0'&B));
	ov_soma <=(A(WSIZE-1) xnor B(WSIZE-1)) and (A(WSIZE-1) xor a32(WSIZE-1));-- os bites de sinal de A e B sao iguais e o bit de sinal da soma eh diferente deles
	ov_sub <=(A(WSIZE-1) xor B(WSIZE-1)) and (B(WSIZE-1)xnor a32(WSIZE-1));--Positivo - negativo = positivo. Se o resultado  for negativo houve overflow
	-- P/ ov_sub: negativo - positivo = negativo. Se o resultado  for positivo houve overflow									
	with OpCode select 
	vai <= tmp_soma(WSIZE) when "0010",
	     tmp_soma(WSIZE) when "0011",
	     tmp_sub(WSIZE) when "0100",  
			 tmp_sub(WSIZE) when "0101",
	'0' when others;
	
	with OpCode select ovfl<= 
	ov_soma when "0010",--soma
		ov_sub	  when "0100",--subtracao
	'0' when others;
	
	with OpCode select
	 Z <= menor when "0110" ,-- slt 
	 a32 when others;

  checa_zero: process (a32,menor) begin
    if((menor=num_zero) and (OpCode="0110") ) then
      zero<='1';
    elsif (a32=num_zero and not(Opcode="0110"))  then
      zero<='1';
    else
      zero<='0';
    end if;
  end process checa_zero;

	proc_ula: process(A,B,OpCode) begin
		
		if(signed(A)<signed(B)) then
			menor <= num_zero;
		else 
			menor <= num_um;
		end if;
		
	  case OpCode is
			when  "0000" => a32<= A and B;
			when  "0001" => a32 <= A or B;
			when  "0010" => a32 <= std_logic_vector(signed(A)+signed(B));--std_logic_vector(signed(A) + signed(B));-- add A,B
			when 	"0011" => a32 <= std_logic_vector(signed(A)+signed(B)); -- addu A,B. Z recebe a soma das entradas A, B, sem overflow
			when 	"0100" => a32 <= std_logic_vector(signed(A)-signed(B));--sub A, B
			when 	"0101" => a32 <= std_logic_vector(signed(A)-signed(B));--subu A, B.Z recebe A - B, sem overflow
			when 	"0111" => a32<= A nand B; ----	nand A, B.Z recebe a operacao logica A nand B, bit a bit
			when 	"1000" => a32<= A nor B; ----	nor A, B.Z recebe a operacao logica A nor B, bit a bit
			when 	"1001" => a32<= A xor B; ----	xor A, B.Z recebe a operacao logica A xor B, bit a bit
			when 	"1010" => a32 <=std_logic_vector(shift_left(unsigned(B),to_integer(unsigned(A))));--sll A, B. Z recebe B deslocado de A bits à esquerda
			when	"1011" => a32 <= std_logic_vector(shift_right(unsigned(B), to_integer(unsigned(A))));--srl A, B Z recebe deslocamento lógico de B por A bits à direita 	
			when  "1100" => a32 <= std_logic_vector(shift_right(signed(B), to_integer(unsigned(A))));--sra A, B Z recebe deslocamento arit. de B por A bits à direita
			when others  => a32 <= (others => '0');
		end case;
	end process proc_ula;
end architecture behavioral;