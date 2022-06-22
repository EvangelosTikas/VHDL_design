library IEEE;
use IEEE.std_logic_1164.all;

entity bus_arbiter1 is
	port (
		clk,rst: in std_logic;
		req: in std_logic_vector(1 downto 0);
		grand: out std_logic_vector(1 downto 0));
end bus_arbiter1;

architecture rtl of bus_arbiter1 is
	type STATES is (A,B,C,D);
	signal state,next_state: STATES;
begin
	seq: process (clk,rst)
	begin
		if (rst='0') then
			state<=A;
		elsif (clk'event and clk='1') then
			state<=next_state;
		end if;
	end process;
	
cmb: process (req,state)
	begin
		next_state<=state;
		case state is
			when A =>
				if (req="01" or req="11") then
					next_state<=B;
				elsif (req="10") then
					next_state<=D;
				end if;
			when B =>
				if (req="00") then
					next_state<=C;
				elsif (req="10") then
					next_state<=D;
				end if;
			when C =>
				if (req="01") then
					next_state<=B;
				elsif (req="10" or req="11") then
					next_state<=D;
				end if;
			when D =>
				if (req="01") then
					next_state<=B;
				elsif (req="00") then
					next_state<=A;
				end if;
			when others => null;
		end case;
	end process;
	grand(0)<='1' when state=B else '0';
	grand(1)<='1' when state=D else '0';
end rtl;
