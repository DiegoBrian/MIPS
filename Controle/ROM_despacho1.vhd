library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;

entity ROM_despacho1 is
	port(
		E: in std_logic_vector(5 downto 0);
		Saida_R_1: out std_logic_vector(3 downto 0)
	);
end ROM_despacho1;

architecture Monta_ROM_despacho1 of ROM_despacho1 is

BEGIN
	with E select Saida_R_1 <=
		"0110" when "000000",
		"1001" when "000010",
		"1000" when "000100",
		"0010" when "100011",
		"0010" when "101011",
		"1010" when "001000",-- opcode para ADDI (vai para o estado 10 no controle) 
		"1010" when "001101",-- opcode para ORI(vai para o estado 10 no controle)
		"1010" when "001100",-- opcode para ANDI (vai para o estado 10 no controle)
		"1100" when "000011",-- opcode para JAL (vai para o estado 12 no controle)		
		"0000" when others;
end architecture Monta_ROM_despacho1;
