library ieee;
use ieee.std_logic_1164.all;
use work.Proc_bib.all;
use ieee.numeric_std.all;

entity desloc2 is
	port(K32 : in std_logic_vector (31 downto 0);
		  K32_desloc : out std_logic_vector (31 downto 0)
		  );
end entity;

architecture desloc2_arch of desloc2 is
signal temp : std_logic_vector (31 downto 0);

begin
	K32_desloc <= std_logic_vector(signed(K32) sll 2);
	
end desloc2_arch;