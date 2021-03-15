-- Quartus Prime VHDL Template
-- Basic Shift Register

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity d_flip_flop is

	port (
		clk : in std_logic;
		D : in std_logic;
		Q : out std_logic
	);

end entity;

architecture logic of d_flip_flop is

begin
	
	process(clk, D)
	begin
		if (rising_edge(clk)) then
			Q <= D;
		end if;
	end process;
	
end architecture logic;




library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity elec241_shift_register is

	generic (
		NUM_STAGES : natural := 4
	);

	port (
		clk : in std_logic;
		enable : in std_logic;
		data_in : in std_logic;
		Q0 : out std_logic;
		Q1 : out std_logic;
		Q2: out std_logic;
		Q3 : out std_logic;
		data_out : out std_logic
	);

end entity;

architecture rtl of elec241_shift_register is

	component d_flip_flop
		port (
			clk	: in std_logic;
			D : in std_logic;
			Q : out std_logic
		);
	end component;
	
	component my_AND
		port (
			A : in std_logic;
			B : in std_logic;
			Y : out std_logic
		);
	end component;

	signal Q0S, Q1S, Q2S, Q3S : std_logic;

begin

	U1 : d_flip_flop port map (clk, data_in, Q0S);
	U2 : d_flip_flop port map (clk, Q0S, Q1S);
	U3 : d_flip_flop port map (clk, Q1S, Q2S);
	U4 : d_flip_flop port map (clk, Q2S, Q3S);
	
	Q0 <= Q0S;
	Q1 <= Q1S;
	Q2 <= Q2S;
	Q3 <= Q3S;
	data_out <= Q3S;
	
end rtl;