library ieee;
use ieee.std_logic_1164.all;
use work.all;

entity and_gate is
port(x, y: in std_logic;
	z: out std_logic);
end and_gate;

architecture behv_and of and_gate is
begin
	z <= x and y;
end behv_and;