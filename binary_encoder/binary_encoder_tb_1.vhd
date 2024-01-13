library ieee;
use ieee.std_logic_1164.all;

entity binary_encoder_tb is
end binary_encoder_tb;

architecture TB_ARCHITECTURE of binary_encoder_tb is
	component binary_encoder
	port(
		a : in std_logic;
		b : in std_logic;
		c : in std_logic;
		d : in std_logic;
		exists : inout std_logic;
		encode : out std_logic_vector(1 downto 0));
end component;

	signal a : std_logic:='0';
	signal b : std_logic:='0';
	signal c : std_logic:='0';
	signal d : std_logic:='0';
	signal exists : std_logic;
	signal encode : std_logic_vector(1 downto 0);

begin
	UUT : binary_encoder
		port map
			(a => a,
			b => b,
			c => c,
			d => d,
			exists => exists,
			encode => encode );

	a<=not a after 25 ns;
	b<=not b after 50 ns;
	c<=not c after 100 ns;
	d<=not d after 200 ns;
end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_binary_encoder of binary_encoder_tb is
	for TB_ARCHITECTURE
		for UUT : binary_encoder
			use entity work.binary_encoder(binary_encoder);
		end for;
	end for;
end TESTBENCH_FOR_binary_encoder;
