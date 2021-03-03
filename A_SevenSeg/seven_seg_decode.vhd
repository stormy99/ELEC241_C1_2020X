-- Quartus Prime VHDL Template
-- Four-State Moore State Machine

-- A Moore machine's outputs are dependent only on the current state.
-- The output is written only when the state changes.  (State
-- transitions are synchronous.)

library ieee;
use ieee.std_logic_1164.all;

entity seven_seg_decode is

	port(
		input	 : in	 std_logic_vector(3 downto 0);		-- Binary input (0..15)
		reset	 : in	 std_logic;								-- Asynchronous reset (sets output to blank)
		en     : in  std_logic;								-- Input enable. Output is latched when 0
		output : out std_logic_vector(6 downto 0)  -- Decoded output for each of the 7 LEDs
	);

end entity;

architecture v1 of seven_seg_decode is
-- MODIFY THE CODE BELOW THIS LINE --
begin
	
	with input select
		output <= "1111110" when "0000", -- display "0"
		     	  "0110000" when "0001", -- display "1"
			  "1101101" when "0010", -- display "2"
			  "1111001" when "0011", -- display "3"
			  "0110011" when "0100", -- display "4"
			  "1011011" when "0101", -- display "5"
		     	  "1011111" when "0110", -- display "6"
			  "1110000" when "0111", -- display "7"
			  "1111111" when "1000", -- display "8"
			  "1111011" when "1001", -- display "9"

			  "1110111" when "1010", -- display "A"
		     	  "0011111" when "1011", -- display "b"
			  "1001110" when "1100", -- display "C"
			  "0111101" when "1101", -- display "d"
			  "1111001" when "1110", -- display "E"
			  "1000111" when "1111", -- display "F"
			  
			  "0000000" when others;

end v1;
