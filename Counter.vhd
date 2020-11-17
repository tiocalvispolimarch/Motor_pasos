----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:04:35 11/11/2020 
-- Design Name: 
-- Module Name:    Counter - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Counter is
port (clk_sal : in std_logic;
		Reset   : in std_logic;
		M 			: in std_logic;
		Reset_salida : out std_logic 
		);
end Counter;

architecture Behavioral of Counter is

signal Cuenta_max : integer RANGE 0 TO 4096 := 0;

begin

process(clk_sal,reset,M)
begin
	if rising_edge(clk_sal) then
		if Reset = '1' then
			Cuenta_max <= 0; 
			else
				if M = '0' then
					Cuenta_max <= Cuenta_max + 1;
					Reset_salida <= '0';
					if Cuenta_max = 4096 then	
							Cuenta_max <= 0;
							Reset_salida <= '1';
					end if;
				else 
					Cuenta_max <= Cuenta_max - 1;
					Reset_salida <= '0';
					if Cuenta_max = 0 then	
							Cuenta_max <= 4096;
							Reset_salida <= '1';
					end if;
				end if;
			end if;	
	end if;
end process; 

end Behavioral;

