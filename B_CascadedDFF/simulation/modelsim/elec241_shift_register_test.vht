LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY elec241_shift_register_test IS
END elec241_shift_register_test;

ARCHITECTURE v1 OF elec241_shift_register_test IS

	constant NUM_STAGES : integer := 4;		--number of bits in register
	constant clk_cycles : integer := 20;	--number of clock cycles
	
	SIGNAL enable : STD_LOGIC := '1';
	SIGNAL clk : STD_LOGIC := '0';
	SIGNAL data_in : STD_LOGIC := '0';
	SIGNAL Q : STD_LOGIC_VECTOR(NUM_STAGES - 1 downto 0);
	SIGNAL data_out : STD_LOGIC := '0';

	COMPONENT elec241_shift_register

		PORT (
			clk : IN STD_LOGIC;
			enable : IN STD_LOGIC;
			data_in	: IN STD_LOGIC;
			Q : OUT STD_LOGIC_VECTOR(NUM_STAGES - 1 downto 0);
			data_out : OUT STD_LOGIC
		);
	END COMPONENT;
	
	BEGIN
		i1 : elec241_shift_register
		PORT MAP (
			enable => enable,
			clk => clk,
			data_in => data_in,
			Q => Q,
			data_out => data_out
		);
	
	clk_gen: PROCESS
		variable ck : std_logic;
	BEGIN
		ck := '0';
		for n in 1 to (clk_cycles * 2) loop		--generate clock with 1 ns period
			wait for 500 ps;
			ck := not ck;
			CLK <= ck;
		end loop;
		WAIT;
	END PROCESS clk_gen;
	
	
	always : PROCESS
		variable data_out_check : std_logic_vector (NUM_STAGES - 1 downto 0);	--definition of array used for asserts
																				--automatically adjusts size with NUM_STAGES
								
		procedure set_data_in (						--procedure for setting data_in value
			constant time : in integer;				--(time in nanoseconds,
			constant data_in_value : in std_logic;	-- data_in value,
			constant n : in integer					-- number of for loop cycles from start) 	<- set as n
		) is
		begin
			if (n = time * 2) then					--clock period is 2 * 0.5 ns
				wait until falling_edge(clk);		--falling edge triggered
				data_in <= data_in_value;
			end if;
		end procedure set_data_in;
	
	BEGIN
		for n in 1 to (clk_cycles * 2) loop
			wait for 500 ps;
			
			set_data_in(4, '1', n);		--test high for one clock cycle, 4 to 5 ns
			set_data_in(5, '0', n);
			
			set_data_in(9, '1', n);		--test high for multiple clock cycles, 9 to 12 ns
			set_data_in(12, '0', n);
										--test low for one clock cycle, 12 to 13 ns
			set_data_in(13, '1', n);	
			set_data_in(14, '0', n);
			
			
			if (n mod 2) = 0 then		--clk rising edge
				data_out_check := data_in & data_out_check(NUM_STAGES - 1 downto 1);	--set MSB of data_out_check array to data_in
			end if;
			
			if (data_out_check(0) = '1') then		--if expected output is 1
				assert (data_out = '1')
				report "Expecting data_out to be high" severity error;	--error if actual output is 0
			else									--if expected output is 0
				assert ((data_out = '0') or (data_out = 'U'))
				report "Expecting data_out to be low" severity error;	--error if actual output is 1
			end if;
			
			--uncomment to debug
				--assert false report lf & "Array integer " & 
				--integer'image(to_integer(unsigned(data_out_check))) & lf & 
				--"Array LSB " & std_logic'image(data_out_check(0))
				--severity note;
			
		end loop;
		
		WAIT;
	END PROCESS always;
	
END v1;