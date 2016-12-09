library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;


entity mux_2_5 is
	port (
	 	entrada0, entrada1	: in std_logic_vector(4 downto 0);
		selecao			: in std_logic;
		saida			: out std_logic_vector(4 downto 0));
end entity;

architecture arch of mux_2_5 is 
begin
	saida <= entrada0 when (selecao = '0')	else entrada1;
end architecture;