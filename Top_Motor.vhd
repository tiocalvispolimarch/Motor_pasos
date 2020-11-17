----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:25:54 11/11/2020 
-- Design Name: 
-- Module Name:    Top_Motor - Behavioral 
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

entity Top_Motor is
port (clk  : in std_logic; 
		M	  : in std_logic;
		reset: in std_logic;
		Mux  : in std_logic;
		LEDS : out std_logic_vector(7 downto 0);
		Q	  : out std_logic_vector(3 downto 0);
		segmentos : out  STD_LOGIC_VECTOR (7 downto 0);
      habilitacion: out STD_LOGIC_VECTOR(7 downto 0));
end Top_Motor;

architecture Behavioral of Top_Motor is

component Maquina_estados is
Port ( 	  rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           M 	: in  STD_LOGIC;
           Q 	: out STD_LOGIC_VECTOR (3 downto 0);
			  contador: out STD_LOGIC_VECTOR(3 downto 0));
end component;

component BIN_7S is
    Port(M : in std_logic;
			reset 		: in std_logic;
			clk 			: in std_logic;
			CLK_MUX     : IN STD_LOGIC;
			segmentos   : out  STD_LOGIC_VECTOR (7 downto 0);
			habilitacion: out STD_LOGIC_VECTOR(7 downto 0));
end component;


component Mux2X1 is
    Port ( sel : in  STD_LOGIC;
           In0 : in  STD_LOGIC;
           In1 : in  STD_LOGIC;
           sal : out  STD_LOGIC);
end component;

component Timer1s is
    Port (   rst : in   STD_LOGIC;
             clk : in   STD_LOGIC;
           clk1s : inout  STD_LOGIC);
end component;

component Timer200ms is
    Port (   rst : in   STD_LOGIC;
             clk : in   STD_LOGIC;
           clk1s : inout  STD_LOGIC);
end component;

component Counter is
port (clk_sal : in std_logic;
		Reset   : in std_logic;
		M 			: in std_logic;
		Reset_salida : out std_logic 
		);
end component;

signal Frec1,Frec2 : std_logic;
signal sal_clk	    :	std_logic;
signal Reset_salida: std_logic;
signal datos		 : std_logic_vector(3 downto 0);

begin

U1: Maquina_estados port map(Reset_salida,sal_clk,M,Q,datos);  
U2: Mux2X1 port map(MUX,Frec1,Frec2,sal_clk);
U3: Timer1s port map(reset,clk,Frec1);
U4: Timer200ms port map(reset,clk,Frec2);
U5: BIN_7S port map(M,Reset_salida,clk,sal_clk,segmentos,habilitacion);
U6: Counter port map(sal_clk,reset,M,Reset_salida);

end Behavioral;

