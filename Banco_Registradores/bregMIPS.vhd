-- Universidade de Brasília (UnB)
-- Autor: Pedro Aurélio Coelho de Almeida
-- Matricula: 14/0158103
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bregMIPS is

  generic (WSIZE : natural := 32);

  port (

  clk, wren : in std_logic;

  radd1, radd2, wadd : in std_logic_vector(4 downto 0);

  wdata : in std_logic_vector(WSIZE-1 downto 0);

  r1, r2 : out std_logic_vector(WSIZE-1 downto 0));

end bregMIPS;

architecture BREG of bregMIPS is   
  type vet_WSIZE is array (natural range <>) of std_logic_vector(WSIZE-1 downto 0);-- define um registardor como um veotr de tamanho WSIZE
  signal regs: vet_WSIZE(31 downto 0):=((others=> (others=>'0')));-- cria vetor de registradores
  signal end1, end2,end_escrita: integer range 0  to 31;-- enderecoes de leitura  
  
  BEGIN
  end1 <= to_integer(unsigned(radd1));
  end2 <= to_integer(unsigned(radd2));
  end_escrita <= to_integer(unsigned(wadd));     
  
  r1 <= regs(end1);
  r2 <= regs(end2);
  
    escrita_breg: process(clk) begin
      if (rising_edge(clk)) then
        if (wren ='1') then 
          if(end_escrita>0) then
            regs(end_escrita) <= wdata;
          end if;  
        end if;        
      end if;
    end process escrita_breg;

end architecture BREG;