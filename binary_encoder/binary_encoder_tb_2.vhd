library ieee;
use ieee.std_logic_1164.all;
use STD.TEXTIO.all;

	-- Add your library and packages declaration here ...

entity binary_encoder_tb is
end binary_encoder_tb;

architecture TB_ARCHITECTURE of binary_encoder_tb is
 	file IN_VECTORS: TEXT open READ_MODE is "inputs.txt";
	file OUT_VECTORS: TEXT open WRITE_MODE is "outputs.txt";
	-- Component declaration of the tested unit
	component binary_encoder
	port(
		a : in std_logic;
		b : in std_logic;
		c : in std_logic;
		d : in std_logic;
		exists : inout std_logic;
		encode : out std_logic_vector(1 downto 0) );
end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal a : std_logic;
	signal b : std_logic;
	signal c : std_logic;
	signal d : std_logic;
	-- Observed signals - signals mapped to the output ports of tested entity
	signal exists : std_logic;
	signal encode : std_logic_vector(1 downto 0);

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : binary_encoder
		port map
			(a => a,
			b => b,
			c => c,
			d => d,
			exists => exists,
			encode => encode );

	-- Add your stimulus here ...
	process
		variable IN_BUF: LINE;
		variable OUT_BUF: LINE;
		variable a_var,b_var,c_var,d_var : bit;
	begin
		while not ENDFILE(IN_VECTORS) loop
			READLINE(IN_VECTORS,IN_BUF);
			READ(IN_BUF,a_var);
			READ(IN_BUF,b_var);
			READ(IN_BUF,c_var);
			READ(IN_BUF,d_var);
			a<=to_stdulogic(a_var);
			b<=to_stdulogic(b_var);
			c<=to_stdulogic(c_var);
			d<=to_stdulogic(d_var);
			wait for 5 ns;
		WRITE(OUT_BUF,STRING'("Exists= "));
		WRITE(OUT_BUF,to_bit(exists));
		WRITE(OUT_BUF,STRING'(", Encode= "));
		WRITE(OUT_BUF,to_bitvector(encode));
		WRITELINE(OUT_VECTORS,OUT_BUF);
	end loop;
	wait;
end process;	
end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_binary_encoder of binary_encoder_tb is
	for TB_ARCHITECTURE
		for UUT : binary_encoder
			use entity work.binary_encoder(binary_encoder);
		end for;
	end for;
end TESTBENCH_FOR_binary_encoder;
