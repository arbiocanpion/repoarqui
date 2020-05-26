
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder is
    Port ( entrada_a : in STD_LOGIC;
           entrada_b : in STD_LOGIC;
           c_in : in STD_LOGIC;
           salida : out STD_LOGIC;
           c_out : out STD_LOGIC);
end full_adder;

architecture Behavioral of full_adder is
-- Declaracion de componentes

component half_adder is
    Port ( a : in STD_LOGIC;
           b : in STD_LOGIC;
           c : out STD_LOGIC;
           s : out STD_LOGIC);
end component;
--señales
signal signal_salida1 : STD_LOGIC;
signal signal_salida2 : STD_LOGIC;
signal signal_salida3 : STD_LOGIC;
signal signal_salida4 : STD_LOGIC;

begin

c_out <= signal_salida1 or signal_salida3;
salida <= signal_salida4;

-- Declaracion de instancias
inst_half_adder1: half_adder port map(
    a => entrada_a,
    b => entrada_b,
    c => signal_salida1,
    s => signal_salida2
);

inst_half_adder2: half_adder port map(
    a => signal_salida2,
    b => c_in,
    c => signal_salida3,
    s => signal_salida4
);

end Behavioral;
