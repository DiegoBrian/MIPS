library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use work.Proc_bib.all;

entity registrador_habilitacao is
	port (
	 	entrada		: in std_logic_vector(31 downto 0);
		clk			: in std_logic;
		habilitacao	: in std_logic;
		saida			: out std_logic_vector(31 downto 0));
end entity;

architecture arch of registrador_habilitacao is 
begin
	process (clk)
	begin
		if(rising_edge(clk) and habilitacao = '1') then
			saida <= entrada;
		end if;
	end process;
end architecture;