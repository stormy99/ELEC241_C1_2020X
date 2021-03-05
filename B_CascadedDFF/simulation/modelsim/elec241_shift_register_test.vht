-- write your test bench here
LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY elec241_shift_register_test IS
END elec241_shift_register_test;

ARCHITECTURE v1 OF elec241_shift_register_test IS
--constants
--signals
SIGNAL clk : STD_LOGIC;
SIGNAL enable : STD_LOGIC;
SIGNAL data_in	: STD_LOGIC;
SIGNAL data_out : STD_LOGIC;

COMPONENT elec241_shift_register
	GENERIC (
	NUM_STAGES : NATURAL := 4
	);
	
	PORT (
	clk : IN STD_LOGIC;
	enable : IN STD_LOGIC;
	data_in	: IN STD_LOGIC;
	data_out : OUT STD_LOGIC
	);
END COMPONENT;


BEGIN
	i1 : elec241_shift_register
	PORT MAP (
	clk => clk,
	enable => enable,
	data_in => data_in,
	data_out => data_out
	);

init : PROCESS
BEGIN
	WAIT;
END PROCESS init;

always : PROCESS
BEGIN
	
	enable <= '0';
	data_in <= '0';
	clk <= '0';
	wait for 1 ps;
	clk <= '1';
	wait for 1 ps;
	if (data_out /= '0') then
		--assert reports / severity errors here
		assert false report "Unexpected output" & lf & 
		" data_in = " & STD_LOGIC'image(data_in) & lf &
		" enable = " & STD_LOGIC'image(enable) & lf &
		"  clk = " & STD_LOGIC'image(clk)
		severity error;
	end if;
	wait for 1 ps;
	
	enable <= '1';
	data_in <= '1';
	clk <= '1';
	wait for 1 ps;
	if (data_out /= '1') then
		assert false report "Unexpected output" & lf & 
		" data_in = " & STD_LOGIC'image(data_in) & lf &
		" enable = " & STD_LOGIC'image(enable) & lf &
		"  clk = " & STD_LOGIC'image(clk)
		severity error;
	end if;
	wait for 1 ps;
	
	WAIT;
END PROCESS always;

END v1;