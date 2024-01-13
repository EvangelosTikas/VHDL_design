-------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.06.2022 07:04:19
-- Design Name: 
-- Module Name: gcd_tb3 - Behavioral
-- Project Name: 
-- Lab05, 5.5.3, Testbench with For Loop (and C Function)
-- THIS IS THE THIRD AND LAST PART OF LAB5
-- Involves loop over a range of numbers for the testebench
-- 
-- Revision 0.01 - File Created

----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;



entity gcd_tb3 is

end gcd_tb3;

architecture tb_architecture of gcd_tb3 is

component gcd_calc is
    port(clk,rst: in std_logic;
		x_i,y_i: in std_logic_vector(7 downto 0);
		data_o: out std_logic_vector(7 downto 0));
	end component;
    
    -- stimulus signals to drive the input
    signal clk : std_logic := '0';
    signal rst : std_logic := '0';
    signal x_i : std_logic_vector(7 downto 0) := "00000000";
    signal y_i : std_logic_vector(7 downto 0) := "00000000";
    -- outputs
    signal data_o : std_logic_vector(7 downto 0) := "00000000";
    constant clock_period : time := 10 ns;
    
    -- start testing the uut with the port map first
    begin
    
        UUT : gcd_calc
        port map
        	( clk=> clk,
            rst => rst,
            x_i => x_i,
            y_i => y_i,
            data_o => data_o);
        --Now read and write from a loop but define the clock
       
    clk <= not clk after clock_period / 2;

        
    gcd: process
    
      --create the function for gcd calculations
        function gcd_f (x_i , y_i : std_logic_vector(7 downto 0))
        return std_logic_vector is
        variable x,y : std_logic_vector(7 downto 0);
        
        begin
			x:=x_i; y:= y_i;
            while (x /= y) loop
               
                if (x> y) then
                    x := std_logic_vector(unsigned(x(7 downto 0)) - unsigned(y_i(7 downto 0)));
                	else 
                        y :=std_logic_vector(unsigned(y(7 downto 0)) - unsigned(x_i(7 downto 0)));
                end if;
            end loop;
            
            return x;
        end;
        
        
        begin  
            rst <= '0';
            clk <='1';
            wait for clock_period;
            rst <= '1';
            for i in 0 to 4 loop
                for j in 0 to 4 loop
                    x_i(i) <= '1';
                    y_i(j) <= '1';
                    wait for 5 ns;
                    assert(data_o = gcd_f(x_i, y_i))
                    report "Error not yet calculated!";
                end loop;
            end loop;    
        wait;
    end process;


end tb_architecture;

configuration testbench_for_gcd_calc3 of gcd_tb3 is
	for tb_architecture
    	for UUT : gcd_calc
        	use entity work.gcd_calc(gcd_calc);
        end for;
    end for;
end testbench_for_gcd_calc3; 