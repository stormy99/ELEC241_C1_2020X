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
	
	for n in 1 to 15 loop
		wait for 2 ps;
		input <= std_logic_vector(to_unsigned(n,4));
	end loop;
	
	wait for 2 ps;
	input <= "0000";
	en <= '1';
	
	
	for n in 1 to 15 loop
		wait for 2 ps;
		input <= std_logic_vector(to_unsigned(n,4));
	end loop;
	
	wait for 2 ps;
	input <= "0000";
	en <= '0';
	reset <= '1';
	
	
	for n in 1 to 15 loop
		wait for 2 ps;
		input <= std_logic_vector(to_unsigned(n,4));
	end loop;
	
	wait for 2 ps;
	input <= "0000";
	en <= '1';
	reset <= '1';
	
	
	for n in 1 to 15 loop
		wait for 2 ps;
		input <= std_logic_vector(to_unsigned(n,4));
	end loop;

	wait for 2 ps;
	
	WAIT;
END PROCESS always;    


END seven_seg_decode_arch;
