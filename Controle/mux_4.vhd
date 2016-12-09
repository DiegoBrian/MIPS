library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;

entity mux_4 is
	port(
		E0,E1,E2,E3: in std_logic_vector(3 downto 0);
		Sel: in std_logic_vector(1 downto 0);
		Saida: out std_logic_vector(3 downto 0)
	);
end mux_4;

architecture Monta_mux of mux_4 is

BEGIN
	with Sel select Saida <=
		E0 when "00",
		E1 when "01",
		E2 when "10",
		E3 when "11",
		"0000" when others;
end architecture Monta_mux;
