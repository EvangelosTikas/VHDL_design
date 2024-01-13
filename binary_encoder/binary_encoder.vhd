library IEEE;
use IEEE.std_logic_1164.all;

entity binary_encoder is
   port (
      a: in std_logic;
      b: in std_logic;
      c: in std_logic;
      d: in std_logic;
      exists: inout std_logic;
      encode: out std_logic_vector (1 downto 0));
end binary_encoder;

architecture binary_encoder of binary_encoder is
begin
      encode(1) <= a or b when exists='1' else 'Z';
      encode(0) <= a or ((not b) and c) when exists='1'
          else 'Z';
      exists <= a or b or c or d;
end binary_encoder;
