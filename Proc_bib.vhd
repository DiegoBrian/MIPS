library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package Proc_bib is

	component cntrMIPS
		port(
				clk:in std_logic;
				Op: in std_logic_vector(5 downto 0);
				OpALU,OrigBALU, OrigPC: out std_logic_vector(1 downto 0);
				OrigAALU: out std_logic;
				EscreveReg, RegDst, MemparaReg, EscrevePC, EscrevePCCond, IouD,
				EscreveMem, EscreveIR, LeMem : out std_logic;
				CtlEND: out std_logic_vector(1 downto 0)
			 );
	end component;
	
	component bregMIPS
		generic (WSIZE : natural := 32);
		port(
				clk, wren : in std_logic;
				radd1, radd2, wadd : in std_logic_vector(4 downto 0);
				wdata : in std_logic_vector(WSIZE-1 downto 0);
				r1, r2 : out std_logic_vector(WSIZE-1 downto 0)
  			 );
	end component;

	component ramtest
		port (
			address		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
			clock		: IN STD_LOGIC  := '1';
			data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			wren		: IN STD_LOGIC ;
			q		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
		);
	end component;	
	
	component ULA 
		generic (WSIZE : natural := 32);
		port ( 
				OpCode:  in  std_logic_vector(3 downto 0);
				A, B: in  std_logic_vector(WSIZE-1 downto 0);
				Z: out std_logic_vector(WSIZE-1 downto 0);
				ovfl,vai,zero: out std_logic
		);
	end component;

	component desloc2 is
	port(K32 : in std_logic_vector (31 downto 0);
		  K32_desloc : out std_logic_vector (31 downto 0)
		  );
	end component;
	
	component ext_sinal is
	port (K16 : in std_logic_vector (15 downto 0);
			K32 : out std_logic_vector (31 downto 0)
			);
	end component;
	
	component mux_2 is
	port (
	 	entrada0, entrada1	: in std_logic_vector(31 downto 0);
		selecao			: in std_logic;
		saida			: out std_logic_vector(31 downto 0));
	end component;
	
	component mux_2_5 is
	port (
	 	entrada0, entrada1	: in std_logic_vector(4 downto 0);
		selecao			: in std_logic;
		saida			: out std_logic_vector(4 downto 0));
	end component;
	
	component mux_3 is
	port (
	 	entrada0, entrada1, entrada2	: in std_logic_vector(31 downto 0);
		selecao				: in std_logic_vector(1 downto 0);
		saida				: out std_logic_vector(31 downto 0));
	end component;
	
	component mux_4_32 is
	port (
			entrada0, entrada1, entrada2, entrada3		: in std_logic_vector(31 downto 0);
			selecao						: in std_logic_vector(1 downto 0);
			saida						: out std_logic_vector(31 downto 0));
	end component;
	
	component registrador is
	port (
			entrada		: in std_logic_vector(31 downto 0);
			clk			: in std_logic;
			saida			: out std_logic_vector(31 downto 0));
	end component;
	
	component registrador_habilitacao is
	port (
			entrada		: in std_logic_vector(31 downto 0);
			clk			: in std_logic;
			habilitacao	: in std_logic;
			saida			: out std_logic_vector(31 downto 0));
	end component;
	
	component concatPC is
	port (K26 : in std_logic_vector (25 downto 0);
			PC32 : in std_logic_vector (31 downto 0);
			concat32 : out std_logic_vector (31 downto 0)
			);
	end component;

end Proc_bib;