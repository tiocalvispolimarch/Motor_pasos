----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:46:32 10/12/2020 
-- Design Name: 
-- Module Name:    BIN_7S - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: Decodeficador de binarioa 7 segmentos
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
use IEEE.std_logic_unsigned.all;

entity BIN_7S is
    Port ( 		M : in std_logic;
					reset : in std_logic;
					clk : in std_logic;
					CLK_MUX: IN STD_LOGIC;
					segmentos : out  STD_LOGIC_VECTOR (7 downto 0);
				 habilitacion: out STD_LOGIC_VECTOR(7 downto 0));
end BIN_7S;

architecture Behavioral of BIN_7S is
CONSTANT CONTA_SW_FIN      			  : INTEGER := 99_999;	
SIGNAL   CONTA_SWITCH 					  : INTEGER RANGE 0 TO CONTA_SW_FIN :=0;
SIGNAL   CONTADOR_PRINCIPAL 			  : INTEGER RANGE 0 TO 9 := 0;  

TYPE MAQUINA IS (UNIDADES,DECENAS,CENTENAS,MILECIMAS);       --DECLARACIÓN DE 
SIGNAL EDO_P,EDO_F : MAQUINA := UNIDADES; --LA MÁQUINA DE ESTADOS

SIGNAL   CONTA_UNIDADES,CONTA_DECENAS,CONTA_CENTENAS,CONTA_MILECIMAS : INTEGER RANGE 0 TO 9 := 0; 
SIGNAL 	BANDERA : std_logic;
begin

Conteo: process(CLK_MUX,RESET,M)
BEGIN
IF RISING_EDGE(CLK_MUX)THEN
	IF RESET = '1' THEN --CONDICIÓN PARA REINICIAR EL CONTEO CUANDO RESET = '1'
			CONTA_UNIDADES <= 0;
			CONTA_DECENAS <= 0;
			CONTA_CENTENAS <= 0;
			CONTA_MILECIMAS <= 0;
			BANDERA <= '0';
		ELSE
			IF M= '0' THEN
					CONTA_UNIDADES <= CONTA_UNIDADES +1;
					BANDERA <= '1';
						IF CONTA_UNIDADES = 9 THEN--------------CUANDO EL CONTEO DE LAS UNIDADES LLEGE A 9
							CONTA_UNIDADES <= 0;-----------------REINICIA EL CONTADOR DE LAS UNIDADES
							CONTA_DECENAS <= CONTA_DECENAS +1;---E INCREMENTA EN 1 LAS DECENAS
								IF CONTA_DECENAS = 9 THEN
									CONTA_DECENAS <= 0;
									CONTA_CENTENAS <= CONTA_CENTENAS +1;
									IF CONTA_CENTENAS = 9 THEN
										CONTA_CENTENAS <= 0;
										CONTA_MILECIMAS <= CONTA_MILECIMAS +1;
										IF CONTA_MILECIMAS = 9 THEN
											CONTA_MILECIMAS <= 0;
										END IF;
									END IF;
								END IF;
						END IF;
			ELSE 
				IF BANDERA = '0' THEN
					CONTA_UNIDADES <= 6;
					CONTA_DECENAS	<= 9;
					CONTA_CENTENAS	<= 0;
					CONTA_MILECIMAS<= 4;
					BANDERA <= '1';
				ELSE	
			   CONTA_UNIDADES <= CONTA_UNIDADES - 1;
						IF CONTA_UNIDADES = 0 THEN--------------CUANDO EL CONTEO DE LAS UNIDADES LLEGE A 9
							CONTA_UNIDADES <= 9;-----------------REINICIA EL CONTADOR DE LAS UNIDADES
							CONTA_DECENAS <= CONTA_DECENAS -1;---E INCREMENTA EN 1 LAS DECENAS
								IF CONTA_DECENAS = 0 THEN
									CONTA_DECENAS <= 9;
									CONTA_CENTENAS <= CONTA_CENTENAS -1;
									IF CONTA_CENTENAS = 0 THEN
										CONTA_CENTENAS <= 9;
										CONTA_MILECIMAS <= CONTA_MILECIMAS -1;
										IF CONTA_MILECIMAS = 0 THEN
											CONTA_MILECIMAS <= 9;
										END IF;
									END IF;
								END IF;
						END IF;
				END IF;		
			END IF;			
	END IF;
END IF;

end process; 


---MAQUINA DE ESTADOS QUE SE ENCARGA DEL SWITCHEO DE LOS TRANSISTORES-------
-------PARA ACTIVAR Y DESACTIVAR LOS DISPLAY CADA 10 MS---------------------
PROCESS(EDO_P)
BEGIN
	CASE EDO_P IS 
		WHEN UNIDADES =>
			EDO_F <= DECENAS;
			habilitacion <= NOT("00000001"); --ACTIVAMOS EL DISPLAY DE LAS UNIDADES
		WHEN DECENAS =>
			EDO_F <= CENTENAS;  --ACTIVAMOS EL DISPLAY DE LAS DECENAS
			habilitacion <= NOT("00000010");
		WHEN CENTENAS =>
			EDO_F <= MILECIMAS;
			habilitacion <= NOT("00000100");
		WHEN OTHERS => 
			EDO_F <= UNIDADES;
			habilitacion <= NOT("00001000");
	END CASE;
END PROCESS;


--CONTEO PARA UN RETRASO DE 10ms
PROCESS(CLK)
BEGIN
	IF RISING_EDGE(CLK) THEN
		CONTA_SWITCH <= CONTA_SWITCH +1;
		IF CONTA_SWITCH = CONTA_SW_FIN THEN
			CONTA_SWITCH <= 0;
			EDO_P <= EDO_F;
		END IF;
	END IF;
END PROCESS;


CONTADOR_PRINCIPAL <= CONTA_UNIDADES WHEN EDO_P = UNIDADES ELSE--MANDAMOS EL VALOR DE LAS UNIDADES CUANDO EDO_P ESTE EN UNIDADES
							 CONTA_DECENAS  WHEN EDO_P = DECENAS ELSE
							 CONTA_CENTENAS WHEN EDO_P = CENTENAS ELSE
							 CONTA_MILECIMAS;									--MANDAMOS EL VALOR DE LAS DECENAS  CUANDO EDO_P ESTE EN DECENAS	
-----------------------------------------------------------------------------

		
      segmentos <= "11000000" when CONTADOR_PRINCIPAL = 0 else--0
						 "11111001" when CONTADOR_PRINCIPAL = 1 else--1
						 "10100100" when CONTADOR_PRINCIPAL = 2 else--2					 
						 "10110000" when CONTADOR_PRINCIPAL = 3 else--3
						 "10011001" when CONTADOR_PRINCIPAL = 4 else--4					 
						 "10010010" when CONTADOR_PRINCIPAL = 5 else--5					 
						 "10000010" when CONTADOR_PRINCIPAL = 6 else--6					 
						 "11111000" when CONTADOR_PRINCIPAL = 7 else--7
						 "10000000" when CONTADOR_PRINCIPAL = 8 else--8
						 "10010000"; --9
						 				 
end Behavioral;

