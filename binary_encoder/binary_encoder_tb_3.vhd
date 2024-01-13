library ieee;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity binary_encoder_tb is
end binary_encoder_tb;

architecture TB_ARCHITECTURE of binary_encoder_tb is
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
-- Observed signals -signals mapped to the output ports of tested entity
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
		function exists_behavior (a,b,c,d: std_logic) 
		return std_logic is
		begin
			if (a='1') or (b='1') or (c='1') or (d='1') then
				return '1';
			else
				return '0';
			end if;
		end exists_behavior;
		function encode_behavior (a,b,c,d: std_logic)
 			return std_logic_vector is
		begin
			if (a='1') then
				return "11";
			elsif (b='1') then 
				return "10";
			elsif (c='1') then
				return "01";
			else
				return "00";
			end if;
		end encode_behavior;
	begin
		for a1 in std_logic'('0') to std_logic'('1') loop
			for b1 in std_logic'('0') to std_logic'('1') loop
				for c1 in std_logic'('0') to std_logic'('1') loop
					for d1 in std_logic'('0') to std_logic'('1') loop
						a<=a1;
						b<=b1;
						c<=c1;
						d<=d1;
						wait for 5 ns;
						assert(exists=exists_behavior(a,b,c,d))
						report "Error on signal exists!";	 
						assert(encode=encode_behavior(a,b,c,d))
						report "Error on signal encode!";
					end loop;
				end loop;
			end loop;
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
