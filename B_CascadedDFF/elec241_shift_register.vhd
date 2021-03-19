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
			Q <= D;		--Q only updates on rising edge of clock
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
		Q : out std_logic_vector(NUM_STAGES - 1 downto 0);
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
	
	signal bit_Q : std_logic_vector(NUM_STAGES - 1 downto 0);

begin

	U0 : d_flip_flop port map (clk, data_in, bit_Q(NUM_STAGES - 1));	--first flip flop

	DFF: for i in 1 to (NUM_STAGES - 1) generate
		UX : d_flip_flop port map (clk, bit_Q(NUM_STAGES - i), bit_Q(NUM_STAGES - i - 1));	--generate remaining flip flops
	end generate DFF;
	
	SIGNALS: for i in 0 to (NUM_STAGES - 1) generate
		Q(NUM_STAGES - i - 1) <= bit_Q(NUM_STAGES - i - 1);		--set Q(n) equal to flip flop signals
	end generate SIGNALS;
	
	data_out <= bit_Q(0);	--data_in shifted by NUM_STAGES
	
end rtl;