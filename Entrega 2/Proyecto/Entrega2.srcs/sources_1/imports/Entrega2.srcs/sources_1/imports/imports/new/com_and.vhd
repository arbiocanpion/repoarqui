library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity com_and is
    Port (
        numero_derecho : in std_logic_vector(15 downto 0);
        numero_izquierdo : in std_logic_vector(15 downto 0);
        salida : out std_logic_vector(15 downto 0)
     );
end com_and;

architecture Behavioral of com_and is

begin

salida <= numero_derecho and numero_izquierdo;


end Behavioral;
