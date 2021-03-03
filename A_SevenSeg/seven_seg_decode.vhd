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
	process(input,reset,en)
	begin

		if (en = '1') then

			output <= "1111110" when input = "0000" else -- display "0"
			     	  "0110000" when input = "0001" else -- display "1"
				  "1101101" when input = "0010" else -- display "2"
				  "1111001" when input = "0011" else -- display "3"
				  "0110011" when input = "0100" else -- display "4"
				  "1011011" when input = "0101" else -- display "5"
			     	  "1011111" when input = "0110" else -- display "6"
				  "1110000" when input = "0111" else -- display "7"
				  "1111111" when input = "1000" else -- display "8"
				  "1111011" when input = "1001" else -- display "9"
	
				  "1110111" when input = "1010" else -- display "A"
			     	  "0011111" when input = "1011" else -- display "b"
				  "1001110" when input = "1100" else -- display "C"
				  "0111101" when input = "1101" else -- display "d"
				  "1001111" when input = "1110" else -- display "E"
				  "1000111" when input = "1111";     -- display "F"

		end if;

		if (reset = '1') then
			output <= "0000000";
		end if;
	end process;
end v1;
