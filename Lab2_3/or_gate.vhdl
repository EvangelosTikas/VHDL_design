library ieee;
use ieee.std_logic_1164.all;
use work.all;

entity or_gate is
port(x, y: in std_logic;
	z: out std_logic);
end or_gate;
architecture behv_or of or_gate is
begin
	z <= x or y;
end behv_or;