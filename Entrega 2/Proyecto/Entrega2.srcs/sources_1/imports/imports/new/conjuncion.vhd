library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity conjuncion is
    Port (
        numero_derecho : in std_logic_vector(15 downto 0);
        numero_izquierdo : in std_logic_vector(15 downto 0);
        salida : out std_logic_vector(15 downto 0)
     );
end conjuncion;

architecture Behavioral of conjuncion is

begin

salida <= numero_derecho or numero_izquierdo;

end Behavioral;
