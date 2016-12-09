library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.Proc_bib.all;

entity MIPS_Multiciclo is 
	port (
		clk: in std_logic;
		rst: in std_logic:='0';
		Sel_info: in std_logic_vector(1 downto 0);
		D0,D1,D2,D3,D4,D5,D6,D7:out std_logic_vector(6 downto 0)
	);
end MIPS_Multiciclo;
	
architecture Proc of MIPS_Multiciclo is
	signal nPC: std_logic_vector(31 downto 0);
	signal Controle_PC: std_logic;
	signal PC_corr,Endereco: std_logic_vector(31 downto 0);
	signal SaidaALU: std_logic_vector(31 downto 0);
	signal IouD,EscreveIR,RegDst,MemparaReg, EscreveReg : std_logic;
	signal End_Mem: std_logic_vector(7 downto 0);
	signal SaidaMem,Instrucao: std_logic_vector(31 downto 0);
	signal rs,rt,rd,shamt: std_logic_vector(4 downto 0);
	signal Opcode, funct: std_logic_vector(5 downto 0);
	signal k16: std_logic_vector(15 downto 0); --imediato de 16 bits
	signal k26 : std_logic_vector(25 downto 0);
	signal Dado : std_logic_vector(31 downto 0);
	signal wadd,wadd_0 : std_logic_vector(4 downto 0);-- wadd_0 eh rd ou rt e wadd eh 31 ou rd ou rt(31 ou wadd_0)
	signal wdata : std_logic_vector(31 downto 0);
	signal ra: std_logic_vector(4 downto 0) :=(others=>'1');
	signal EhJal: std_logic;
	signal r1, r2 : std_logic_vector(31 downto 0);
	
	begin
	-- observacao: falta arquivos de memoria e instanciacao da memoria!!!
	PC: Registrador_habilitacao PORT MAP (entrada=> nPC, clk=> clk, 
													  habilitacao=> Controle_PC,
													  saida=> PC_corr);
	Mux_PC_Mem: Mux_2 PORT MAP(entrada0=> PC_corr, entrada1=> SaidaALU,
										selecao => IouD,
										saida => Endereco
										);
	End_Mem <= Endereco(7 downto 0);
	RI: Registrador_habilitacao PORT MAP (entrada=> SaidaMem, clk=> clk, 
													  habilitacao=> EscreveIR,
													  saida=> Instrucao);
	Opcode <= Instrucao(31 downto 26);
	rs <= Instrucao(25 downto 21);
	rt <= Instrucao(20 downto 16);
	rd <= Instrucao(15 downto 11);
	k16 <= Instrucao(15 downto 0);
	k26 <= Instrucao(25 downto 0);
	funct <= Instrucao(5 downto 0);
	shamt <= Instrucao(10 downto 6);
	
	RDM: Registrador PORT MAP (entrada=> SaidaMem, clk=> clk, 
										saida=> Dado);
	
	Mux_Rd_Rt: Mux_2_5 PORT MAP(entrada0=> rt, entrada1=> rd,
										selecao => RegDst,
										saida => wadd_0
									  );
	Mux_Dados_Escrita: Mux_2 PORT MAP(entrada0=> SaidaALU, entrada1=> Dado,
										selecao => MemparaReg,
										saida => wdata
									  );
	Mux_JAL:Mux_2_5 PORT MAP(entrada0=> wadd_0, entrada1=> ra,
										selecao => EhJal,
										saida => wadd
									  );
	BREG: bregMIPS
				GENERIC MAP(WSIZE=>32)
				PORT MAP (	clk => clk,
								wren=>EscreveReg,
								radd1=>rs,
								radd2=>rt,
								wadd=>wadd,
								wdata=>wdata,
								r1=>r1,
								r2=>r2
							 ); 						  
 

	
end architecture Proc;
