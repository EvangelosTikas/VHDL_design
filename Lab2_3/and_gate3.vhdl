library ieee;
use ieee.std_logic_1164.all;
use work.all;

entity and_gate3 is
port(x, y, z: in std_logic;
	w: out std_logic);
end and_gate3;

architecture behv_and3 of and_gate is
begin
	w <= x and y and z;
end behv_and3;