library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity resta is
    Port(izquierdo : in STD_LOGIC_VECTOR(15 downto 0);
         derecho : in STD_LOGIC_VECTOR(15 downto 0);
         carry: out std_logic;
         s : out STD_LOGIC_VECTOR(15 downto 0)
         );
end resta;

architecture Behavioral of resta is

    component suma is
        Port(
        izquierdo : in STD_LOGIC_VECTOR(15 downto 0);
        derecho : in STD_LOGIC_VECTOR(15 downto 0);
        carry: out std_logic;
        s : out std_logic_vector(15 downto 0)
        );
    end component;

    signal negado: STD_LOGIC_VECTOR(15 downto 0);
    signal aux_negado: STD_LOGIC_VECTOR(15 downto 0);
    signal negado_final: STD_LOGIC_VECTOR(15 downto 0);
    signal negado_final_final: STD_LOGIC_VECTOR(15 downto 0);
    signal aux_carry: std_logic;
    signal aux_carry_final: std_logic;
    signal s_prueba: std_logic_vector(15 downto 0);
    
begin


negado <= not derecho;

suma_conjugado: suma port map(izquierdo => negado, derecho => "0000000000000001", carry => aux_carry, s => aux_negado);

suma_normal: suma port map(izquierdo => izquierdo, derecho => aux_negado, carry => carry, s => negado_final);

with derecho select
    s <= izquierdo when "0000000000000000", negado_final when others;




end Behavioral;
