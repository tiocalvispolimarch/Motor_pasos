----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:33:23 11/10/2020 
-- Design Name: 
-- Module Name:    Maquina_estados - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_arith.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Maquina_estados is
 Port ( 	  rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           M 	: in  STD_LOGIC;
           Q 	: out STD_LOGIC_VECTOR (3 downto 0);
			  contador: out STD_LOGIC_VECTOR(3 downto 0));
end Maquina_estados;

architecture Behavioral of Maquina_estados is

   type estados is (A, B, C, D, E, F, G, H); 
   signal presente, siguiente : estados; 
	signal cuenta : STD_LOGIC_VECTOR(3 downto 0);
begin
	NEXT_STATE_DECODE: process (presente, M)
   begin
      siguiente <= A;  --default is to stay in current state
      case (presente) is
         when A =>
				Q <= "1000";
            if M = '0' then
               siguiente <= B;
				--	contador <= contador + 1;
					
				else
				   siguiente <= H;
            end if;
         when B =>
            Q <= "1100";
				if M = '0' then
               siguiente <= C;
				else
				   siguiente <= A;
            end if;
         when C =>
				Q <= "0100";
            if M = '0' then
               siguiente <= D;
				else
				   siguiente <= B;
            end if;
			when D =>
				Q <= "0110";
            if M = '0' then
               siguiente <= E;
				else
				   siguiente <= C;
            end if;
         when E =>
				Q <= "0010";
            if M = '0' then
               siguiente <= F;
				else
				   siguiente <= D;
            end if;
			when F =>
				Q <= "0011";
            if M = '0' then
               siguiente <= G;
				else
				   siguiente <= E;
            end if;
			when G =>
				Q <= "0001";
            if M = '0' then
               siguiente <= H;
				else
				   siguiente <= F;
            end if;
			when others =>
				Q <= "1001";
            if M = '0' then
               siguiente <= A;
				else
				   siguiente <= G;
            end if;
      end case;      
   end process;
	


SYNC_PROC: process (clk)
   begin
      if (clk'event and clk = '1') then
         if (rst = '1') then
            presente <= A;
            --Q <= "00";
         else
            presente <= siguiente;      
         end if;        
      end if;
   end process;
	




end Behavioral;

