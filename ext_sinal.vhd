library ieee;
use ieee.std_logic_1164.all;
use work.Proc_bib.all;

entity ext_sinal is
port (K16 : in std_logic_vector (15 downto 0);
		K32 : out std_logic_vector (31 downto 0)
		);
end entity;

architecture ext_sinal_arch of ext_sinal is
signal temp : std_logic_vector (31 downto 0);

begin
	temp (15 downto 0) <= K16;
	temp (31 downto 15) <= (others => K16(15));
	K32 <= temp;
end architecture;