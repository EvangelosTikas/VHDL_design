library IEEE;
use IEEE.std_logic_1164.all;

entity bus_arbiter2 is
	port (
		clk,rst: in std_logic;
		req: in std_logic_vector(1 downto 0);
		grand: out std_logic_vector(1 downto 0));
end bus_arbiter2;

architecture rtl of bus_arbiter2 is
	type STATES is (A,B,C,D);
	signal state: STATES;
begin
	fsm: process (clk,rst,req,state)
	begin
		if (rst='0') then 
			state<=A;
		elsif (clk'event and clk='1') then
			case state is
				when A =>
					if (req="01" or req="11") then
						state<=B;
					elsif (req="10") then
						state<=D;
					end if;
				when B =>
					if (req="00") then
						state<=C;
					elsif (req="10") then
						state<=D;
					end if;
				when C =>
					if (req="01") then
						state<=B;
					elsif (req="10" or req="11") then
						state<=D;
					end if;
				when D =>
					if (req="01") then
						state<=B;
					elsif (req="00") then
						state<=A;
					end if;
				when others => null;
			end case;
		end if;
	end process;
	grand(0)<='1' when state=B else '0';
	grand(1)<='1' when state=D else '0';
end rtl;
