-- write your test bench here
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY elec241_shift_register_test IS
END elec241_shift_register_test;

ARCHITECTURE v1 OF elec241_shift_register_test IS
	--constants
	--signals
	SIGNAL enable : STD_LOGIC := '1';
	SIGNAL clk : STD_LOGIC := '0';
	SIGNAL data_in : STD_LOGIC := '0';
	SIGNAL Q0 : STD_LOGIC := '0';
	SIGNAL Q1 : STD_LOGIC := '0';
	SIGNAL Q2 : STD_LOGIC := '0';
	SIGNAL Q3 : STD_LOGIC := '0';
	SIGNAL data_out : STD_LOGIC := '0';

	COMPONENT elec241_shift_register
		GENERIC (
			NUM_STAGES : NATURAL := 4
		);

		PORT (
			clk : IN STD_LOGIC;
			enable : IN STD_LOGIC;
			data_in	: IN STD_LOGIC;
			Q0 : OUT STD_LOGIC;
			Q1 : OUT STD_LOGIC;
			Q2 : OUT STD_LOGIC;
			Q3 : OUT STD_LOGIC;
			data_out : OUT STD_LOGIC
		);
		
	END COMPONENT elec241_shift_register;
	

BEGIN
	i1 : elec241_shift_register
	PORT MAP (
		enable => enable,
		clk => clk,
		data_in => data_in,
		Q0 => Q0,
		Q1 => Q1,
		Q2 => Q2,
		Q3 => Q3,
		data_out => data_out
	);

init : PROCESS
BEGIN
	WAIT;
END PROCESS init;

always : PROCESS
	variable n : integer;
	variable output_old : integer := 0;
BEGIN

	for n in 1 to 5 loop		--load zeros into register
		clk <= not clk;
		wait for 54 ps;
		clk <= not clk;
		wait for 54 ps;
	end loop;
	
	for n in 1 to 500 loop		--500 ns
		wait for 500 ps;
		if (n mod 10) = 0 then
			clk <= not clk;
		end if;
		
		
		if (n = 20) then		--data_in toggles to 1 at 20ns
			data_in <= '1';
		end if;
		
		if (n = 40) then
			data_in <= '0';
		end if;
		
		
		if (n = 108) then
			data_in <= '1';
		end if;
		
		if (n = 112) then
			data_in <= '0';
		end if;
		
		
		if (n = 230) then
			data_in <= '1';
		end if;
		
		if (n = 290) then
			data_in <= '0';
		end if;
		
		if (n = 310) then
			data_in <= '1';
		end if;
		
		if (n = 370) then
			data_in <= '0';
		end if;
		
		wait for 500 ps;
		
	end loop;

	WAIT;
END PROCESS always;

END v1;