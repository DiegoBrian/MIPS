library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;

entity ROM_despacho2 is
	port(
		E: in std_logic_vector(5 downto 0);
		Saida_R_2: out std_logic_vector(3 downto 0)
	);
end ROM_despacho2;

architecture Monta_ROM_despacho2 of ROM_despacho2 is

BEGIN
	with E select Saida_R_2 <=
		"0011" when "100011",
		"0101" when "101011",
		"0000" when others;
end architecture Monta_ROM_despacho2;
