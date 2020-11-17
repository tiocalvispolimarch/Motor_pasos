--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:47:11 11/16/2020
-- Design Name:   
-- Module Name:   C:/Xilinx/VHDL_PROGRAMS/Motor_A_pasos/Motor_pasos/prueba.vhd
-- Project Name:  Motor_pasos
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Top_Motor
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY prueba IS
END prueba;
 
ARCHITECTURE behavior OF prueba IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Top_Motor
    PORT(
         clk : IN  std_logic;
         M : IN  std_logic;
         reset : IN  std_logic;
         Mux : IN  std_logic;
         LEDS : OUT  std_logic_vector(7 downto 0);
         Q : OUT  std_logic_vector(3 downto 0);
         segmentos : OUT  std_logic_vector(7 downto 0);
         habilitacion : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal M : std_logic := '0';
   signal reset : std_logic := '0';
   signal Mux : std_logic := '0';

 	--Outputs
   signal LEDS : std_logic_vector(7 downto 0);
   signal Q : std_logic_vector(3 downto 0);
   signal segmentos : std_logic_vector(7 downto 0);
   signal habilitacion : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Top_Motor PORT MAP (
          clk => clk,
          M => M,
          reset => reset,
          Mux => Mux,
          LEDS => LEDS,
          Q => Q,
          segmentos => segmentos,
          habilitacion => habilitacion
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
			M <= '0';
         reset <= '1'; 
         Mux <= '0';
   
      wait for clk_period*10;
		reset <= '0'; 
		M <= '1';
		
      -- insert stimulus here 

      wait;
   end process;

END;
