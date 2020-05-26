library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ex_or is
    Port (
        numero_derecho : in std_logic_vector(15 downto 0);
        numero_izquierdo : in std_logic_vector(15 downto 0);
        salida : out std_logic_vector(15 downto 0)
     );
end ex_or;

architecture Behavioral of ex_or is

begin

salida <= numero_derecho xor numero_izquierdo;


end Behavioral;


