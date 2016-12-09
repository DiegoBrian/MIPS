-- incrementador para o conjunto de microinstrucoes
library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;

entity inc is
	port(
		Estado_atual: in std_logic_vector(3 downto 0);
		Proximo_estado: out std_logic_vector(3 downto 0)
	);
end inc;

architecture Monta_inc of inc is

BEGIN
	Proximo_estado <= std_logic_vector(unsigned(Estado_atual) + 1);
end architecture Monta_inc;
