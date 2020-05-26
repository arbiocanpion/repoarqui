----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/08/2020 03:19:05 AM
-- Design Name: 
-- Module Name: ALU - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
    
    Port(
        numero_derecho : in STD_LOGIC_VECTOR(15 downto 0);
        numero_izquierdo : in STD_LOGIC_VECTOR(15 downto 0);
        selAlu: in STD_LOGIC_VECTOR(2 downto 0);
        resultado: out STD_LOGIC_VECTOR(15 downto 0);
        C : out std_logic_vector(0 downto 0);
        Z : out std_logic_vector(0 downto 0);
        N : out std_logic_vector(0 downto 0)
    );
    
    
end ALU;

architecture Behavioral of ALU is
 
    
    component conjuncion

    Port (
        numero_derecho : in std_logic_vector(15 downto 0);
        numero_izquierdo : in std_logic_vector(15 downto 0);
        salida : out std_logic_vector(15 downto 0)
    );

    end component;

    component com_and

        Port(
            numero_derecho : in std_logic_vector(15 downto 0);
            numero_izquierdo : in std_logic_vector(15 downto 0);
            salida : out std_logic_vector(15 downto 0)
        );

    end component;

    component ex_or

        Port(
            numero_derecho : in std_logic_vector(15 downto 0);
            numero_izquierdo : in std_logic_vector(15 downto 0);
            salida : out std_logic_vector(15 downto 0)
        );

    end component;

    component rshift

        Port (
            numero : in std_logic_vector(15 downto 0);
            carry: out std_logic_vector(0 downto 0);
            salida : out std_logic_vector(15 downto 0)
        );

    end component;

    component lshift

        Port (
            numero : in std_logic_vector(15 downto 0);
            carry: out std_logic_vector(0 downto 0);
            salida : out std_logic_vector(15 downto 0)
        );

    end component;

    component suma

        Port(izquierdo : in STD_LOGIC_VECTOR(15 downto 0);
        derecho : in STD_LOGIC_VECTOR(15 downto 0);
        carry: out std_logic;
        s : out std_logic_vector(15 downto 0)
        );

    end component;

    component resta

        Port(izquierdo : in STD_LOGIC_VECTOR(15 downto 0);
        derecho : in STD_LOGIC_VECTOR(15 downto 0);
        carry: out std_logic;
        s : out std_logic_vector(15 downto 0)
        );

    end component;

    
signal salida: STD_LOGIC_VECTOR(15 downto 0);
signal negado : STD_LOGIC_VECTOR(15 downto 0);
signal conjuncion_vector : STD_LOGIC_VECTOR(15 downto 0);
signal disyuncion_vector : STD_LOGIC_VECTOR(15 downto 0);
signal ex_or_vector: STD_LOGIC_VECTOR(15 downto 0);
signal rshift_vector: STD_LOGIC_VECTOR(15 downto 0);
signal lshift_vector: STD_LOGIC_VECTOR(15 downto 0);
signal plus_vector: STD_LOGIC_VECTOR(15 downto 0);
signal minus_vector: STD_LOGIC_VECTOR(15 downto 0);
signal carry_plus: STD_LOGIC_VECTOR(0 downto 0);
signal carry_minus: STD_LOGIC_VECTOR(0 downto 0);
signal carry_rshift: STD_LOGIC_VECTOR(0 downto 0);
signal carry_lshift: STD_LOGIC_VECTOR(0 downto 0);
signal n_minus : STD_LOGIC_VECTOR(0 downto 0);
signal cero: STD_LOGIC_VECTOR(0 downto 0):= (others => '0');
signal carry: STD_LOGIC_VECTOR(0 downto 0);
signal resultado_previo_a_salir: STD_LOGIC_VECTOR(15 downto 0);


begin
    -- Indica que debe ser el carry segun el modo de la Alu
        
    with selAlu select
    C <= 
    carry_rshift when "111",
    carry_lshift when "110",
    carry_plus when "000",
    carry_minus when "001",
    cero when others;

    -- Indica que debe ser el output n segun el modo de la Alu

    with selAlu select
    N <= n_minus when "001",
    "0" when others;

    -- Indica que debe ser el z de la alu segun el out

    with resultado_previo_a_salir select
    Z <= "1" when "0000000000000000", "0" when others;

    with selAlu select
    resultado_previo_a_salir <= negado when "100",
            conjuncion_vector when "011",
            disyuncion_vector when "010",
            ex_or_vector when "101",
            rshift_vector when "111",
            lshift_vector when "110",
            plus_vector when "000",
            minus_vector when "001",
            salida when others;

-- cambio de n

n_minus <= not carry_minus;

-- not

negado <= not numero_izquierdo;

-- conjuncion

op_conjuncion : conjuncion port map(numero_derecho => numero_derecho, numero_izquierdo => numero_izquierdo, salida => conjuncion_vector);

--disyuncion

op_disyuncion: com_and port map(numero_derecho => numero_derecho,
numero_izquierdo => numero_izquierdo, salida => disyuncion_vector); 

-- xor

op_xor: ex_or port map(numero_derecho => numero_derecho,
numero_izquierdo => numero_izquierdo, salida => ex_or_vector);

-- rshift

op_rshif: rshift port map(numero=> numero_izquierdo,carry => carry_rshift,salida => rshift_vector); 

--lshift

op_lshif: lshift port map(numero=> numero_izquierdo,carry => carry_lshift,salida => lshift_vector); 

-- suma

op_suma: suma port map(izquierdo => numero_izquierdo, derecho => numero_derecho, carry => carry_plus(0), s=> plus_vector); 

-- resta

op_resta: resta port map(izquierdo => numero_izquierdo, derecho => numero_derecho, carry => carry_minus(0), s=> minus_vector);


resultado <= resultado_previo_a_salir;
end Behavioral;
