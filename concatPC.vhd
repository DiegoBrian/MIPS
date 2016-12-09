library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.Proc_bib.all;

entity concatPC is
port (K26 : in std_logic_vector (25 downto 0);
		PC32 : in std_logic_vector (31 downto 0);
		concat32 : out std_logic_vector (31 downto 0)
		);
end entity;


architecture concatPC_arch of concatPC is
signal K28 : std_logic_vector (27 downto 0);

begin

	K28 <= std_logic_vector(signed(K26) sll 2);
	concat32 <= PC32(31 downto 28) & K28;

end architecture;