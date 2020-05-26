library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity suma is
    Port(izquierdo : in STD_LOGIC_VECTOR(15 downto 0);
         derecho : in STD_LOGIC_VECTOR(15 downto 0);
         carry: out std_logic;
         s : out std_logic_vector(15 downto 0)
         );

end suma;

architecture Behavioral of suma is

component full_adder is
    Port ( entrada_a : in STD_LOGIC;
    entrada_b : in STD_LOGIC;
    c_in : in STD_LOGIC;
    salida : out STD_LOGIC;
    c_out : out STD_LOGIC);
end component;

signal carry_interno: std_logic_vector(15 downto 0);

begin

primer_bit: full_adder port map(entrada_a => izquierdo(0), entrada_b => derecho(0), c_in => '0', salida => s(0), c_out => carry_interno(0));



segundo_bit: full_adder port map(entrada_a => izquierdo(1), entrada_b => derecho(1), c_in => carry_interno(0), salida => s(1), c_out => carry_interno(1));
tercer_bit: full_adder port map(entrada_a => izquierdo(2), entrada_b => derecho(2), c_in => carry_interno(1), salida => s(2), c_out => carry_interno(2));

cuarto_bit: full_adder port map(entrada_a => izquierdo(3), entrada_b => derecho(3), c_in => carry_interno(2), salida => s(3), c_out => carry_interno(3));

quinto_bit: full_adder port map(entrada_a => izquierdo(4), entrada_b => derecho(4), c_in => carry_interno(3), salida => s(4), c_out => carry_interno(4));

sexto_bit: full_adder port map(entrada_a => izquierdo(5), entrada_b => derecho(5), c_in => carry_interno(4), salida => s(5), c_out => carry_interno(5));

septimo_bit: full_adder port map(entrada_a => izquierdo(6), entrada_b => derecho(6), c_in => carry_interno(5), salida => s(6), c_out => carry_interno(6));

octavo_bit: full_adder port map(entrada_a => izquierdo(7), entrada_b => derecho(7), c_in => carry_interno(6), salida => s(7), c_out => carry_interno(7));

noveno_bit: full_adder port map(entrada_a => izquierdo(8), entrada_b => derecho(8), c_in => carry_interno(7), salida => s(8), c_out => carry_interno(8));

decimo_bit: full_adder port map(entrada_a => izquierdo(9), entrada_b => derecho(9), c_in => carry_interno(8), salida => s(9), c_out => carry_interno(9));

decimo_primer_bit: full_adder port map(entrada_a => izquierdo(10), entrada_b => derecho(10), c_in => carry_interno(9), salida => s(10), c_out => carry_interno(10));

decimo_segundo_bit: full_adder port map(entrada_a => izquierdo(11), entrada_b => derecho(11), c_in => carry_interno(10), salida => s(11), c_out => carry_interno(11));

decimo_tercer_bit: full_adder port map(entrada_a => izquierdo(12), entrada_b => derecho(12), c_in => carry_interno(11), salida => s(12), c_out => carry_interno(12));

decimo_cuarto_bit: full_adder port map(entrada_a => izquierdo(13), entrada_b => derecho(13), c_in => carry_interno(12), salida => s(13), c_out => carry_interno(13));

decimo_quinto_bit: full_adder port map(entrada_a => izquierdo(14), entrada_b => derecho(14), c_in => carry_interno(13), salida => s(14), c_out => carry_interno(14));

decimo_sexto_bit: full_adder port map(entrada_a => izquierdo(15), entrada_b => derecho(15), c_in => carry_interno(14), salida => s(15), c_out => carry_interno(15));

carry <= carry_interno(15);

end Behavioral;
