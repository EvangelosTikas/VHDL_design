library ieee;
use ieee.std_logic_1164.all;
use work.all;

entity not_gate is
port(x: in std_logic;
	z: out std_logic);
end not_gate;
architecture behv_not of not_gate is
begin
	z <= not x;
end behv_not;