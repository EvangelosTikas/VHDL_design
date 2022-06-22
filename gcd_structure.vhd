library IEEE;
use IEEE.std_logic_1164.all;

entity gcd_calc is
	port (
		clk,rst: in std_logic;
		x_i,y_i: in std_logic_vector(7 downto 0);
		data_o: out std_logic_vector(7 downto 0));
end gcd_calc;

architecture gcd_calc of gcd_calc is
	
component mux8_2x1 
		port (sel: in std_logic;
			inp_a,inp_b: in std_logic_vector(7 downto 0);
			mout: out std_logic_vector(7 downto 0));
	end component;	
component reg8 
		port (en,clk: in std_logic;
			inp: in std_logic_vector(7 downto 0);
			outp: out std_logic_vector(7 downto 0));
	end component;
	
component cmp8 
		port (inp_a,inp_b: in std_logic_vector(7 downto 0);
			a_gt_b,a_eq_b,a_lt_b: out std_logic;
			outp: out std_logic_vector(7 downto 0));
	end component;
	
component sub8
		port (en: in std_logic;
			inp_a,inp_b: in std_logic_vector(7 downto 0);
			outp: out std_logic_vector(7 downto 0));
	end component;
	
component fsm
		port (clk,rst: in std_logic; 
		    gt,eq,lt: in std_logic;
			sel,ld,sub: out std_logic_vector(1 downto 0);
			out_en: out std_logic);
	end component;
	signal muxx_o,regx_o,subx_o: std_logic_vector(7 downto 0);
	signal muxy_o,regy_o,suby_o: std_logic_vector(7 downto 0);
	signal cmp_o: std_logic_vector(7 downto 0);
	signal x_sel,y_sel,x_ld,y_ld,x_sub,y_sub: std_logic;
	signal x_gt_y,x_eq_y,x_lt_y,data_en: std_logic;
	
begin
	mux_x: mux8_2x1 port map (x_sel,subx_o,x_i,muxx_o);
	mux_y: mux8_2x1 port map (y_sel,y_i,suby_o,muxy_o);
	reg_x: reg8 port map (x_ld,clk,muxx_o,regx_o);
	reg_y: reg8 port map (y_ld,clk,muxy_o,regy_o);
	cmp: cmp8 port map
		(regx_o,regy_o,x_gt_y,x_eq_y,x_lt_y,cmp_o);
	sub_x: sub8 port map (x_sub,regx_o,regy_o,subx_o);
	sub_y: sub8 port map (y_sub,regy_o,regx_o,suby_o);
	reg_out: reg8 port map (data_en,clk,cmp_o,data_o);
	ctrl: fsm port map
		(clk,rst,
		x_gt_y,x_eq_y,x_lt_y,
		sel(0)=>x_sel,sel(1)=>y_sel,
		ld(0)=>x_ld,ld(1)=>y_ld,
		sub(0)=>x_sub,sub(1)=>y_sub,out_en=>data_en);
end gcd_calc;
