----------------------------------------------------------------------------------
-- Aristotle University of Thessaloniki, MSc Electronic Physics (Radioelectrology)
-- Physics Department
-- Engineer: Tikas Evangelos
-- 
-- Create Date: 08.06.2022 21:46:16
-- Design Name: GCD calculator
-- Module Name: gcd_tb - TB_ARCHITECTURE
-- Project Name: Lab 05


-- This is the testbench for 5.5.2 (the one with the TEXTIO)
-- NOTE: YOU CAN ONLY INPUT A VALUE ONCE IN inputs.txt, since signals will keep their value untill changed 
library IEEE;
use IEEE.std_logic_1164.all;
use STD.TEXTIO.all;


entity gcd_calc_tb is
end gcd_calc_tb;

architecture tb_architecture of gcd_calc_tb is
	file IN_VECTORS: TEXT open READ_MODE is "inputs.txt";
    file OUT_VECTORS: TEXT open WRITE_MODE is "outputs.txt";
	
    
    component gcd_calc is
    port(clk,rst: in std_logic;
		x_i,y_i: in std_logic_vector(7 downto 0);
		data_o: out std_logic_vector(7 downto 0));
	end component;
    
    --stimulus signals to drive the input/output
    signal clk,rst : std_logic;
    signal x_i, y_i : std_logic_vector(7 downto 0);
    signal data_o : std_logic_vector(7 downto 0);
    
    --begin testing the uut with the port map first
    begin
    
        UUT : gcd_calc
        port map
        	( clk=> clk,
            rst => rst,
            x_i => x_i,
            y_i => y_i,
            data_o => data_o);
        --Now read and write from .txt to addd stimuli    
        process
          --create some variables to handle read,write and signals
        	variable IN_BUF: LINE;
            variable OUT_BUF: LINE;
            variable clk_var, rst_var: bit;
            variable x_var, y_var : bit_vector(7 downto 0);
        begin
        	while not ENDFILE(IN_VECTORS) loop --loop over the input file
            	READLINE(IN_VECTORS, IN_BUF); --read the file
                READ(IN_BUF, clk_var);
                READ(IN_BUF, rst_var);
                READ(IN_BUF, x_var);
                READ(IN_BUF, y_var);
                clk <= to_stdulogic(clk_var); --assign variables to signals
                rst <= to_stdulogic(rst_var); --mapping accordingly
                x_i <= to_stdlogicvector(x_var);
                y_i <= to_stdlogicvector(y_var);
      			
      			wait for 5 ns;
               	
                WRITE(OUT_BUF, STRING'("data_o= "));
                WRITE(OUT_BUF, to_bitvector(data_o));
                WRITELINE(OUT_VECTORS, OUT_BUF);
            end loop;
              wait;
                
end process;
end tb_architecture;

configuration testbench_for_gcd_calc of gcd_calc_tb is
	for tb_architecture
    	for UUT : gcd_calc
        	use entity work.gcd_calc(gcd_calc);
        end for;
    end for;
end testbench_for_gcd_calc;    
