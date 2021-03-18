-- Quartus Prime VHDL Template
-- Four-State Moore State Machine

-- A Moore machine's outputs are dependent only on the current state.
-- The output is written only when the state changes.  (State
-- transitions are synchronous.)

library ieee;
use ieee.std_logic_1164.all;

entity seven_seg_decode is

	port(
		input	 : in	 std_logic_vector(3 downto 0); -- Binary input (0..15)
		reset	 : in	 std_logic;							 -- Asynchronous reset (sets output to blank)
		en     : in  std_logic;							 -- Input enable. Output is latched when 0
		output : out std_logic_vector(6 downto 0)  -- Decoded output for each of the 7 LEDs
	);

end entity;

architecture v1 of seven_seg_decode is
-- MODIFY THE CODE BELOW THIS LINE --
begin

	process(input,reset,en)
	begin
	
		-- Reset 'block' condition
		if (reset = '1') then
			output <= "0000000";

		-- Enable select for 7-segmented display
		elsif (en = '1') then
			case input is
				--Truth table outputs
				when "0000" => output <= "1111110";
				when "0001" => output <= "0110000";
				when "0010" => output <= "1101101";
				when "0011" => output <= "1111001";
				when "0100" => output <= "0110011";
				when "0101" => output <= "1011011";
				when "0110" => output <= "1011111";
				when "0111" => output <= "1110000";
				when "1000" => output <= "1111111";
				when "1001" => output <= "1111011";
				when "1010" => output <= "1110111";
				when "1011" => output <= "0011111";
				when "1100" => output <= "1001110";
				when "1101" => output <= "0111101";
				when "1110" => output <= "1001111";
				when "1111" => output <= "1000111";
				when others => output <= "0000000";
			end case;
		end if;
		
	end process;
end v1; -- End of architecture for 7-seg disp.
