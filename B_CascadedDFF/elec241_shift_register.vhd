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
			clk	: in std_ulogic;
			D : in std_ulogic;
			Q : out std_ulogic
		);
	end component;
	
	signal bit_Q : std_logic_vector(0 to NUM_STAGES);

begin

	U0 : d_flip_flop port map (clk, data_in, bit_Q(0));				--first flip flop

	GEN: for i in 0 to (NUM_STAGES - 2) generate
		UX : d_flip_flop port map (clk, bit_Q(i), bit_Q(i + 1));	--generate remaining flip flops
	end generate GEN;
	
	Q0 <= bit_Q(0);							--set pins equal to first four flip flop signals
	Q1 <= bit_Q(1);
	Q2 <= bit_Q(2);
	Q3 <= bit_Q(3);
	data_out <= bit_Q(NUM_STAGES - 1);		--data_in shifted by NUM_STAGES
	
end rtl;