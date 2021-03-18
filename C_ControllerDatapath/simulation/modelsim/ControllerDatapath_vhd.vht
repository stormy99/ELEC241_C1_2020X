-- Copyright (C) 2019  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and any partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details, at
-- https://fpgasoftware.intel.com/eula.

-- ***************************************************************************
-- This file contains a Vhdl test bench template that is freely editable to   
-- suit user's needs .Comments are provided in each section to help the user  
-- fill out necessary details.                                                
-- ***************************************************************************
-- Generated on "02/25/2021 16:08:31"
                                                            
-- Vhdl Test Bench template for design  :  ControllerDatapath_vhd
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;
                            

ENTITY ControllerDatapath_vhd_tst IS
END ControllerDatapath_vhd_tst;
ARCHITECTURE ControllerDatapath_vhd_arch OF ControllerDatapath_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL ACC : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL CLK : STD_LOGIC;
SIGNAL DATA : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL EN_ACC : STD_LOGIC;
SIGNAL EN_R1 : STD_LOGIC;
SIGNAL EN_R2 : STD_LOGIC;
SIGNAL R1 : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL R2 : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL RESET : STD_LOGIC;
SIGNAL SEL_ACC : STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL SEL_R1 : STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL SEL_R2 : STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL SEL_SUM : STD_LOGIC_VECTOR(1 DOWNTO 0);
COMPONENT ControllerDatapath_vhd
	PORT (
	ACC : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	CLK : IN STD_LOGIC;
	DATA : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	EN_ACC : IN STD_LOGIC;
	EN_R1 : IN STD_LOGIC;
	EN_R2 : IN STD_LOGIC;
	R1 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	R2 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	RESET : IN STD_LOGIC;
	SEL_ACC : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
	SEL_R1 : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
	SEL_R2 : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
	SEL_SUM : IN STD_LOGIC_VECTOR(1 DOWNTO 0)
	);
END COMPONENT;
BEGIN
	i1 : ControllerDatapath_vhd
	PORT MAP (
-- list connections between master ports and signals
	ACC => ACC,
	CLK => CLK,
	DATA => DATA,
	EN_ACC => EN_ACC,
	EN_R1 => EN_R1,
	EN_R2 => EN_R2,
	R1 => R1,
	R2 => R2,
	RESET => RESET,
	SEL_ACC => SEL_ACC,
	SEL_R1 => SEL_R1,
	SEL_R2 => SEL_R2,
	SEL_SUM => SEL_SUM
	);

init : PROCESS                                               
-- variable declarations                                     
BEGIN

	RESET <= '0';
	wait for 1 ps;
	RESET <= '1';
                                                        
   WAIT;                                           
END PROCESS init;  

clk_process : PROCESS
		VARIABLE ck : STD_LOGIC;
BEGIN
	
	ck := '1';
    for n in 1 to 30 loop
        ck := not ck;
		  wait for 1 ps;
        CLK <= ck;
    end loop;
	
	WAIT;
END PROCESS clk_process;   
                                                                   
always : PROCESS                                                                                 
BEGIN  

	wait until rising_edge(RESET);
	
	-- 3A: (R1 <- 00000010)
	EN_R1 <= '1';
	DATA <= "00000010";
	SEL_R1 <= "00";
	wait until rising_edge(CLK);
	
	-- 3B: (R2 <- R1)
	EN_R2 <= '1';
	SEL_R2 <= "01";
	wait until rising_edge(CLK);
	
	-- 3C: (ACC <- 00000001)
	EN_R1 <= '0';
	EN_R2 <= '0';
	EN_ACC <= '1';
	DATA <= "00000001";
	SEL_ACC <= "00";
	wait until rising_edge(CLK);
	
	-- 3D: (R1 <- ACC)
	EN_R1 <= '1'; 			
	SEL_R1 <= "01";
	wait until rising_edge(CLK);
	
	-- 3E: (ACC <- ACC + R1)
	SEL_SUM <= "01";
	SEL_ACC <= "11";
	wait until rising_edge(CLK);
	
	-- 3F: (R1 <- 01000000), (R2 <- 00000000), (ACC <- 00000001) [simultaneously]
	EN_ACC <= '1'; 			
	SEL_ACC <= "01";
	
	EN_R1 <= '1';
	DATA <= "01000000";
	SEL_R1 <= "00";
	
	EN_R2 <= '1';
	SEL_R2 <= "11";
	wait until rising_edge(CLK);
	
	-- 3G: (ACC <- ACC + R2), (R2 <- R1), (R1 <- 00100000) [simultaneously]
	SEL_SUM <= "10";
	SEL_ACC <= "11";
	EN_ACC <= '1';
	
	EN_R2 <= '1';
	SEL_R2 <= "01";
	
	EN_R1 <= '1';
	DATA <= "00100000";
	SEL_R1 <= "00";
	wait until rising_edge(CLK);
	
	--  4: (ACC <- [00000001 + 00000001 + 10000000 + 01000000 + 00000001 + 00100000])
	
	wait until rising_edge(CLK);
	
	WAIT;                                                        
END PROCESS always;  
                                        
END ControllerDatapath_vhd_arch;
