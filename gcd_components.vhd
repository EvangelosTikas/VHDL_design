library IEEE;
use IEEE.std_logic_1164.all;

entity mux8_2x1 is
	port (
		sel: in std_logic;
		inp_a,inp_b: in std_logic_vector(7 downto 0);
		mout: out std_logic_vector(7 downto 0));
end mux8_2x1;

architecture rtl of mux8_2x1 is
begin
	seq: process (sel,inp_a,inp_b)
	begin
		case sel is
			when '0' => mout<=inp_a;
			when others => mout<=inp_b;
		end case;
	end process;
end rtl;
 
library IEEE;
use IEEE.std_logic_1164.all;

entity reg8 is
	port (
		en,clk: in std_logic;
		inp: in std_logic_vector(7 downto 0);
		outp: out std_logic_vector(7 downto 0));
end reg8;

architecture rtl of reg8 is
begin
	seq: process (en,clk,inp)
	begin
		if en='1' then
			if (clk'event and clk='1') then
				outp<=inp;
			end if;
	    else
	       outp <= "00000000";
		end if;
	end process;
end rtl;
 
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity cmp8 is
	port (
		inp_a,inp_b: in std_logic_vector(7 downto 0);
		a_gt_b,a_eq_b,a_lt_b: out std_logic;
		outp: out std_logic_vector(7 downto 0));
end cmp8;

architecture behv of cmp8 is
begin
	cmb: process(inp_a,inp_b)
		variable a,b: integer;
	begin
		a:=conv_integer(inp_a);
		b:=conv_integer(inp_b);
		if (a>b) then
			a_gt_b<='1';
			a_eq_b<='0';
			a_lt_b<='0';
		elsif ((a=b) and (a>0) and (b>0)) then
			a_gt_b<='0';
			a_eq_b<='1';
			a_lt_b<='0';
		elsif (a<b) then
			a_gt_b<='0';
			a_eq_b<='0';
			a_lt_b<='1';
	    else
	        a_gt_b<='0';
			a_eq_b<='0';
			a_lt_b<='0';
		end if;
	end process;
	outp<=inp_a;
end behv;
 
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity sub8 is
	port (
		en: in std_logic;
		inp_a,inp_b: in std_logic_vector(7 downto 0);
		outp: out std_logic_vector(7 downto 0));
end sub8;

architecture behv of sub8 is
begin
	cmb: process(en,inp_a,inp_b)
		variable a,b: integer;
	begin
		if (en='1') then
			a:=conv_integer(inp_a);
			b:=conv_integer(inp_b);
			outp<=conv_std_logic_vector(a-b,8);
		end if;
	end process;
end behv;

library IEEE;
use IEEE.std_logic_1164.all;

library IEEE;
use IEEE.std_logic_1164.all;

entity fsm is
    port (clk,rst: in std_logic; gt,eq,lt: in std_logic;
    sel,ld,sub: out std_logic_vector(1 downto 0);
    out_en: out std_logic);
end fsm;

architecture fsm of fsm is
    type STATES is (S1,S2,S3,S4,S5,S6,S7,S8);
    signal state: STATES;
begin
    process (clk, rst)
    begin
        if (rst='0') then 
            state<=S1;
            sel(0) <= '1';
            sel(1) <='0'; 
            
            sub(0) <= '0';
            sub(1) <= '0'; 
  
        elsif (clk'event and clk='1') then
            case state is
                when S1 =>
                    sel(0) <= '1';
                    sel(1) <='0';                   
                    state <= S2;
                when S2 =>
                    ld(0) <= '1';
                    ld(1) <= '1';
                    state <= S3;
                    sub(0) <= '0';
                    sub(1) <= '0';
                when S3 =>
                    if(gt='1') then
                        state <= S4;
                    elsif(eq='1') then
                        state <= S6;
                    elsif(lt='1') then
                        state <= S7;
                    end if;
                when S4 =>
                    sub(0) <= '1';
                    state <= S5;
                when S6 =>
                    out_en <= '1';
                when S7 =>
                    sub(1) <= '1';
                    state <= S8;
                when S8 =>
                    sel(1) <= '1';
                    state <= S2;
                when S5 =>
                    sel(0) <= '0';
                    sub(0) <= '0';
                    sub(1) <= '0';
                    state <= S2;
                when others => 
                	ld(0) <= '0';
                    ld(1) <= '0';
                    sel(0) <= '1';
                    sel(1) <= '0';
                    out_en <='0';
                    sub(0) <= '0';
                    sub(1) <= '0';
            end case;
        end if;
    end process;

end fsm;