library ieee;
use ieee.std_logic_1164.all;
use work.my_components.all;

entity my_project is
port(x1, x2, x3 , x4: in std_logic;
	y: out std_logic);
end my_project;

architecture behv_pr of my_project is
signal wire1: std_logic;
signal wire2: std_logic;
signal wire3: std_logic;
signal wire4: std_logic;
signal wire5: std_logic;
signal wire6: std_logic;
signal wire7: std_logic;



begin
	u5 : not_gate port map (x2, wire1); --wire 1 is the U5 output
	u1 : and_gate port map (x3, x4, wire2); -- wire 2 is the output of and2-U1
	u7 : not_gate port map (wire2, wire3); -- wire3 is the U7 output
	u3 : or_gate port map (wire1, wire3, wire4);  --wire4 is the U3 output
	u4 : or_gate port map (wire2, wire4, wire5); -- wire5 is the U4 output
	u6 : not_gate port map (wire4, wire6);  -- wire6 is the U6 output
	u2: and_gate3 port map (x1, wire6, wire5, y);

	
	
end behv_pr;