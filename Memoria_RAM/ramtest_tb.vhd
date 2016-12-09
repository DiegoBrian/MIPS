-- Universidade de Brasília
-- Autor: Pedro Aurélio Coelho de Almeida
-- Matricula: 14/0158103
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


ENTITY ramtest_tb IS
END ramtest_tb;

ARCHITECTURE ramtest_arch OF ramtest_tb IS
-- constants                                                 
-- signals                                                   
  signal  clock, wren :  std_logic;

  signal  address :  std_logic_vector(7 downto 0);

  signal  data : std_logic_vector(31 downto 0);

  signal  q : std_logic_vector(31 downto 0);

component ramtest
	PORT
	(
		address		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		clock		: IN STD_LOGIC  := '1';
		data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		wren		: IN STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
end component;

BEGIN
	i1 : ramtest
	PORT MAP (
-- list connections between master ports and signals
	 clock => clock,
	 wren=>wren,
	 address=>address,
	 data=>data,
	 q=>q
	);
	
Pulse : PROCESS
BEGIN
 for i in 1 to 358 loop -- faz pulso de clock somente para rodar todos os testes
    clock <= '0';
    wait for 1 ps;
    clock <= '1';
    wait for 1 ps;
  end loop;
  WAIT;
END PROCESS Pulse;
	
	
init : PROCESS                                               
                                    
BEGIN
  wren <= '0';-- escrita desabilitada
  -- laco_regs le os registradores 0 a 31
  laco_regs: for i  in 0 to 255 loop
      address <= std_logic_vector(to_unsigned(i,address'length));
      wait for 2 ps;-- espera 1 periodo do relogio (muda no flanco de descida
  end loop laco_regs;   
  wren <= '1';-- escrita habilitada
  escrita_regs: for i  in 0 to 50 loop
      address <= std_logic_vector(to_unsigned(i,address'length));
      data <= std_logic_vector(to_unsigned(i,data'length));
      wait for 2 ps;-- espera 1 periodo do relogio (muda no flanco de descida
  end loop escrita_regs;   

  wren <= '0';-- escrita desabilitada
  leitura_regs: for i  in 0 to 50 loop
      address <= std_logic_vector(to_unsigned(i,address'length));
      wait for 2 ps;-- espera 1 periodo do relogio (muda no flanco de descida
  end loop leitura_regs;   
  
  WAIT;                                                       
  END PROCESS init;      
                                                            
END ramtest_arch;

