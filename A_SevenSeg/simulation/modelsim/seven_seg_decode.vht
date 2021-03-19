LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                
USE ieee.numeric_std.all;

ENTITY seven_seg_decode_vhd_tst IS
END seven_seg_decode_vhd_tst;

ARCHITECTURE seven_seg_decode_arch OF seven_seg_decode_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL en : STD_LOGIC;
SIGNAL input : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL output : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL reset : STD_LOGIC;

procedure FOR_ERROR_CHECK (expected_output : IN STD_LOGIC_VECTOR(6 DOWNTO 0);	--procedure checks if output is equal to expected output
						   n : IN integer;										--if assert is triggered it prints input, enable, reset, and n number of loops
						   signal output : IN STD_LOGIC_VECTOR(6 DOWNTO 0)) is
begin
	assert output = expected_output report "Unexpected output" & lf & 
	"  input = " & integer'image(to_integer(unsigned(input))) & lf &
	"      n = " & integer'image(n) & lf &
	" enable = " & STD_LOGIC'image(en) & lf &
	"  reset = " & STD_LOGIC'image(reset)
	severity error;
end FOR_ERROR_CHECK;

procedure ERROR_CHECK (expected_output : IN STD_LOGIC_VECTOR(6 DOWNTO 0);	--procedure checks if output is equal to expected output
					   signal output : IN STD_LOGIC_VECTOR(6 DOWNTO 0)) is	--if assert is triggered it prints input, enable, reset
begin
	assert output = expected_output report "Unexpected output" & lf & 
	"  input = " & integer'image(to_integer(unsigned(input))) & lf &
	" enable = " & STD_LOGIC'image(en) & lf &
	"  reset = " & STD_LOGIC'image(reset)
		severity error;
end ERROR_CHECK;

COMPONENT seven_seg_decode
	PORT (
	en : IN STD_LOGIC;
	input : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	output : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	reset : IN STD_LOGIC
	);
END COMPONENT;

BEGIN
	i1 : seven_seg_decode
	PORT MAP (
	en => en,
	input => input,
	output => output,
	reset => reset
	);


init : PROCESS
BEGIN
	WAIT;                                                       
END PROCESS init; 


always : PROCESS                                              
	variable n : integer;
BEGIN

	input <= "0000";
	en <= '0';
	reset <= '0';
	wait for 1 ps;
	ERROR_CHECK("UUUUUUU", output);		--procedure that checks if output is equal to expected output
	wait for 1 ps;
	
	for n in 1 to 15 loop
		input <= std_logic_vector(to_unsigned(n,4));	--input equal to 1 to 15
		wait for 1 ps;
		FOR_ERROR_CHECK("UUUUUUU", n, output);		--procedure that checks if output is equal to expected output in a for loop
		wait for 1 ps;
	end loop;
	
	input <= "0000";
	en <= '1';
	wait for 1 ps;
	ERROR_CHECK("1111110", output);
	wait for 1 ps;
	
	
	for n in 1 to 15 loop
		input <= std_logic_vector(to_unsigned(n,4));	--input equal to 1 to 15
		wait for 1 ps;
		if ((output /= "0110000" and n = 1)		--checks if output is correct with different values of n
		or	(output /= "1101101" and n = 2)
		or	(output /= "1111001" and n = 3)
		or	(output /= "0110011" and n = 4)
		or	(output /= "1011011" and n = 5)
		or	(output /= "1011111" and n = 6)
		or	(output /= "1110000" and n = 7)
		or	(output /= "1111111" and n = 8)
		or	(output /= "1111011" and n = 9)
		or	(output /= "1110111" and n = 10)
		or	(output /= "0011111" and n = 11)
		or	(output /= "1001110" and n = 12)
		or	(output /= "0111101" and n = 13)
		or	(output /= "1001111" and n = 14)
		or	(output /= "1000111" and n = 15)) then		--assert triggers if there are any errors. prints input, n, enable, reset
			assert false report "Unexpected output" & lf & 
			"  input = " & integer'image(to_integer(unsigned(input))) & lf &
			"      n = " & integer'image(n) & lf &
			" enable = " & STD_LOGIC'image(en) & lf &
			"  reset = " & STD_LOGIC'image(reset)
			severity error;
		end if;
		wait for 1 ps;
	end loop;
	
	input <= "0000";
	en <= '0';
	reset <= '1';
	wait for 1 ps;
	ERROR_CHECK("0000000", output);
	wait for 1 ps;
	
	
	for n in 1 to 15 loop
		input <= std_logic_vector(to_unsigned(n,4));	--input equal to 1 to 15
		wait for 1 ps;
		FOR_ERROR_CHECK("0000000", n, output);
		wait for 1 ps;
	end loop;
	
	input <= "0000";
	en <= '1';
	reset <= '1';
	wait for 1 ps;
	ERROR_CHECK("0000000", output);
	wait for 1 ps;
	
	
	for n in 1 to 15 loop
		input <= std_logic_vector(to_unsigned(n,4));	--input equal to 1 to 15
		wait for 1 ps;
		FOR_ERROR_CHECK("0000000", n, output);
		wait for 1 ps;
	end loop;
	
	WAIT;
END PROCESS always;


END seven_seg_decode_arch;
