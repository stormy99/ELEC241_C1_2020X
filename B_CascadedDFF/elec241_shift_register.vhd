-- Quartus Prime VHDL Template
-- Basic Shift Register

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity my_AND is

	port (
		A : in std_logic;
		B : in std_logic;
		Y : out std_logic
	);

end entity;

architecture logic of my_AND is
begin

	Y <= A and B after 10 ps;
	
end architecture logic;




library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity my_NOT is

	port (
		A : in std_logic;
		Y : out std_logic
	);

end entity;

architecture logic of my_NOT is
begin

	Y <= not A after 20 ps;
	
end architecture logic;




library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity my_NAND is

	port (
		A : in std_logic;
		B : in std_logic;
		Y : out std_logic
	);

end entity;

architecture logic of my_NAND is
	
	component my_NOT
		port (
			A : in std_logic;
			Y : out std_logic
		);
	end component;
	
	component my_AND
		port (
			A : in std_logic;
			B : in std_logic;
			Y : out std_logic
		);
	end component;
	
	signal I : std_logic;
	
begin
	
	U1 : my_AND port map (A, B, I);
	U2 : my_NOT port map (I, Y);
	
end architecture logic;




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

	component my_NAND
		port (
			A : in std_logic;
			B : in std_logic;
			Y : out std_logic
		);
	end component;
	
	component my_NOT
		port (
			A : in std_logic;
			Y : out std_logic
		);
	end component;
	
	component my_AND
		port (
			A : in std_logic;
			B : in std_logic;
			Y : out std_logic
		);
	end component;
	
	signal CI1, CI2, CI3, CI4, I1, I2, I3, QS, QB : std_logic;

begin
	
	U1 : my_NOT port map (clk, CI1);	--using propegation delay for clk rising edge trigger
	U2 : my_NOT port map (CI1, CI2);
	U3 : my_NOT port map (CI2, CI3);
	U4 : my_AND port map (clk, CI3, CI4);
	
	U5 : my_NOT port map (D, I1);
	U6 : my_NAND port map (D, CI4, I2);
	U7 : my_NAND port map (I1, CI4, I3);
	U8 : my_NAND port map (I3, QS, QB);
	U9 : my_NAND port map (I2, QB, QS);
	
	Q <= QS;
	
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