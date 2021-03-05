-- write your test bench here
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY elec241_shift_register_test IS
END elec241_shift_register_test;

ARCHITECTURE v1 OF elec241_shift_register_test IS
--constants
--signals
SIGNAL clk : STD_LOGIC := '0';
SIGNAL enable : STD_LOGIC := '0';
SIGNAL data_in	: STD_LOGIC := '0';
SIGNAL data_out : STD_LOGIC := '0';

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
	variable n : integer;
	variable output_old : integer := 0;
BEGIN

	for n in 1 to 32 loop	--two loops through all logic combinations

		if ((n + 1) mod 2) = 0 then				--4 ps toggle + 2 ps offset
			wait for 2 ps;
			clk <= not clk;
		end if;

		if (n mod 4) = 0 then					--8 ps toggle
			data_in <= not data_in;
		end if;

		if (n mod 8) = 0 then					--16 ps toggle
			enable <= not enable;
		end if;

		if ((output_old /= to_integer(unsigned'('0' & data_out))) and (enable = '0')) then
			assert false report "Unexpected output - output changed while enable was 0" severity error;		--if the output changes when enable is 0
		end if;

		if ((output_old /= to_integer(unsigned'('0' & data_out))) and clk = '0') then
			assert false report "Unexpected output - output changed while clock was not rising" severity error;		--if the output changes when the clock is not rising
		end if;

		if (enable = '1' and clk = '1') then
			if ((data_in = '1') and (data_out = '0')) then
				assert false report "Unexpected output - output did not change" severity error;
			end if;
			if ((data_in = '0') and (data_out = '1')) then
				assert false report "Unexpected output - output did not change" severity error;
			end if;
		end if;

		if ((n + 1) mod 2) = 0 then				--4 ps toggle + 2 ps offset

			--uncomment to print output_old and data_out
			--report "output_old = " & integer'image(output_old) & lf &
			--"           data_out = " & integer'image(to_integer(unsigned'('0' & data_out)));

			output_old := to_integer(unsigned'('0' & data_out));
			wait for 2 ps;
		end if;

	end loop;

	WAIT;
END PROCESS always;

END v1;