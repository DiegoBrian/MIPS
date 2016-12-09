library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use work.Proc_bib.all;

entity mux_3 is
	port (
	 	entrada0, entrada1, entrada2	: in std_logic_vector(31 downto 0);
		selecao				: in std_logic_vector(1 downto 0);
		saida				: out std_logic_vector(31 downto 0));
end entity;

architecture arch of mux_3 is 
begin
	saida <= entrada0 when (selecao = "00") else 
				entrada1 when (selecao = "01") else
				entrada2;
end architecture;