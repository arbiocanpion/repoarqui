library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity rshift is
    Port (
        numero : in std_logic_vector(15 downto 0);
        carry: out std_logic_vector(0 downto 0);
        salida : out std_logic_vector(15 downto 0)
     );
end rshift;

architecture Behavioral of rshift is

signal auxiliar : std_logic_vector(15 downto 0):= "0000000000000000";


begin


auxiliar(14 downto 0) <= numero(15 downto 1);
salida <= auxiliar;
carry(0 downto 0) <= numero(0 downto 0);

end Behavioral;