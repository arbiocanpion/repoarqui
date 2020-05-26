library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Basys3 is
    Port (
        sw          : in   std_logic_vector (2 downto 0);  -- Señales de entrada de los interruptores -- Arriba   = '1'   -- Los 3 swiches de la derecha: 2, 1 y 0.
        btn         : in   std_logic_vector (4 downto 0);  -- Señales de entrada de los botones       -- Apretado = '1'   -- 0 central, 1 arriba, 2 izquierda, 3 derecha y 4 abajo.
        led         : out  std_logic_vector (3 downto 0);  -- Señales de salida  a  los leds          -- Prendido = '1'   -- Los 4 leds de la derecha: 3, 2, 1 y 0.
        clk         : in   std_logic;                      -- No Tocar - Señal de entrada del clock   -- Frecuencia = 100Mhz.
        disA            : out std_logic_vector(3 downto 0);  -- Señales de salida al display A.    
        disB            :  out std_logic_vector(3 downto 0);  -- Señales de salida al display B.     
        disC            : out std_logic_vector(3 downto 0);  -- Señales de salida al display C.    
        disD            : out std_logic_vector(3 downto 0)  -- Señales de salida al display D.  
          );
end Basys3;

architecture Behavioral of Basys3 is

-- Inicio de la declaración de los componentes.

component Reg

    Port (
        clock       : in    std_logic;
        load        : in    std_logic;
        up          : in    std_logic;
        down        : in    std_logic;
        datain      : in    std_logic_vector (15 downto 0);
        dataout     : out   std_logic_vector (15 downto 0)
          );
    end component;
    
component mux_b

    Port(
        selb: in STD_LOGIC_VECTOR(1 downto 0);
        reg_b: in STD_LOGIC_VECTOR(15 downto 0);
        data_out: in STD_LOGIC_VECTOR(15 downto 0);
        instruction_memory: in STD_LOGIC_VECTOR(15 downto 0);
        enviado: out STD_LOGIC_VECTOR(15 downto 0)
    );

end component;

component mux_a

    Port(
        sela: in STD_LOGIC_VECTOR(1 downto 0);
        reg_a: in STD_LOGIC_VECTOR(15 downto 0);
        enviado: out STD_LOGIC_VECTOR(15 downto 0)
    );

end component;

component RAM

    Port (
        clock       : in   std_logic;
        write       : in   std_logic;
        address     : in   std_logic_vector (11 downto 0);
        datain      : in   std_logic_vector (15 downto 0);
        dataout     : out  std_logic_vector (15 downto 0)
      );

end component;

component ROM 

    Port (
        address   : in  std_logic_vector(11 downto 0);
        dataout   : out std_logic_vector(32 downto 0)
          );
end component;

component ALU

    Port(
        numero_derecho : in STD_LOGIC_VECTOR(15 downto 0);
        numero_izquierdo : in STD_LOGIC_VECTOR(15 downto 0);
        selAlu: in STD_LOGIC_VECTOR(2 downto 0);
        resultado: out STD_LOGIC_VECTOR(15 downto 0);
        C : out std_logic_vector(0 downto 0);
        Z : out std_logic_vector(0 downto 0);
        N : out std_logic_vector(0 downto 0)
    );
 
end component;

component ControlUnit

    Port (
        Opcode	:	in	std_logic_vector(16 downto 0);	-- instruction to execute
        status : in std_logic_vector(2 downto 0);
        LPC		:	out	std_logic;						-- load pc
        enableA		:	out	std_logic;						-- load A
        enableB		:	out	std_logic;						-- load B
        selA		:	out	std_logic_vector(1 downto 0);	-- mux A
        selB		:	out	std_logic_vector(1 downto 0);	-- mux B
        selAlu		:	out	std_logic_vector(2 downto 0);	-- ALU
        w		:	out	std_logic						-- write RAM
    );

end component;
-- Fin de la declaración de los componentes.

-- Inicio de la declaración de señales.               

signal indicador_izquierdo : STD_LOGIC_VECTOR(4 downto 0);
signal indicador_derecho : STD_LOGIC_VECTOR(4 downto 0);
signal numero_derecho : STD_LOGIC_VECTOR(15 downto 0);
signal numero_izquierdo : STD_LOGIC_VECTOR(15 downto 0);

-- Receptor ALU

signal salida: STD_LOGIC_VECTOR(15 downto 0);

-- señales del pc

signal program_count: STD_LOGIC_VECTOR(0 downto 0);
signal addres_instructions: STD_LOGIC_VECTOR(15 downto 0);
signal addres_instructions_12: STD_LOGIC_VECTOR(11 downto 0);
signal NOT_LPC: STD_LOGIC;
signal instrucciones_para_pc: STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
signal entregable_alu_a: STD_LOGIC_VECTOR(15 downto 0);
signal entregable_alu_b: STD_LOGIC_VECTOR(15 downto 0);


-- Instrucciones de la instruct 

signal instrucciones: STD_LOGIC_VECTOR(32 downto 0);

-- Señales de la ram 
signal de_la_ram: STD_LOGIC_VECTOR(15 downto 0);
signal de_la_ram_corregido: STD_LOGIC_VECTOR(15 downto 0);

-- Señales que salen desde la Alu hacia el status 

signal z: STD_LOGIC_VECTOR(0 downto 0);
signal n: STD_LOGIC_VECTOR(0 downto 0);
signal carry: STD_LOGIC_VECTOR(0 downto 0):= (others => '0');
signal entregable_status: STD_LOGIC_VECTOR(15 downto 0);


-- Estos son cosas varias, mostrador rellena la pantalla de los les

signal mostrador: STD_LOGIC_VECTOR(15 downto 0);
signal cero: STD_LOGIC_VECTOR(0 downto 0) := (others => '0');
signal uno: STD_LOGIC_VECTOR(0 downto 0):= (others => '1');
signal vector_led : STD_LOGIC_VECTOR(4 downto 0);
signal entregable_status_2: STD_LOGIC_VECTOR(15 downto 0);


--- Control Unit (aca tambien deberia ir el entregable_status)

signal LPC : std_logic := '1';
signal enableA: std_logic;
signal enableB: std_logic;
signal selA: std_logic_vector(1 downto 0);
signal selB: std_logic_vector(1 downto 0);
signal selAlu: std_logic_vector(2 downto 0);
signal w: std_logic;


-- Fin de la declaración de los señales.

begin


 NOT_LPC <= not LPC;
 instrucciones_para_pc(11 downto 0) <= instrucciones(28 downto 17);
 addres_instructions_12 <= addres_instructions(11 downto 0);
    
-- Esto setea el valor del display de A

mostrador(15 downto 8) <= numero_izquierdo(7 downto 0);
mostrador(7 downto 0) <= numero_derecho(7 downto 0);

-- Setea el valor del display del display B
    
with selB select
    de_la_ram_corregido <= de_la_ram when "10",
                           "0000000000000000" when others;
  
-- Inicio de declaración de instancias.


tabulador_izquierdo: Reg port map(clock => clk, load => enableA,up => cero(0),down => cero(0), datain => salida,dataout => numero_izquierdo);

-- Aumentador numero derecho (se define ademas que se quiere aca)

tabulador_derecho:  Reg port map(clock => clk, load => enableB, up => cero(0),down => cero(0), datain =>salida , dataout => numero_derecho);

status: Reg port map(clock => clk, load => uno(0),up => cero(0),down => cero(0),datain=> entregable_status, dataout => entregable_status_2);

program_counter: Reg port map(clock => clk, load => LPC, up => NOT_LPC,down =>cero(0),datain => instrucciones_para_pc, dataout => addres_instructions);

mux_para_a: mux_a port map(sela=>selA, reg_a => numero_izquierdo, enviado => entregable_alu_a);

mux_para_b: mux_b port map(selb=> selB, reg_b => numero_derecho,data_out=> de_la_ram_corregido,instruction_memory => instrucciones(32 downto 17) ,enviado => entregable_alu_b);

operacion_alu: ALU port map(numero_derecho =>entregable_alu_b, numero_izquierdo =>entregable_alu_a, selAlu => selAlu, resultado => salida, C=> carry, Z=> z, N=>n);

ram_func: RAM port map(clock => clk, write => w, address => instrucciones_para_pc(11 downto 0), datain => salida, dataout => de_la_ram);

rom_func: ROM port map(address => addres_instructions_12
, dataout => instrucciones);

control: ControlUnit port map(Opcode => instrucciones(16 downto 0), status => entregable_status_2(2 downto 0), LPC => LPC, enableA => enableA, enableB => enableB, selA => selA, selB => selB, selAlu => selAlu, w => w);

-- Displays 

disA <= mostrador(15 downto 12);
disB <= mostrador(11 downto 8);
disC <= mostrador(7 downto 4);
disD <= mostrador(3 downto 0);

with clk select
led(0) <= '1' when '1','0' when others;
          
-- Indica que debe ser el led(1) de la alu segun el carry

with carry(0) select
led(1) <= '1' when '1', '0' when others;

-- Indica que debe ser el led(2) de la alu segun el z

with z(0) select
led(2) <= '1' when '1','0' when others;

-- Indica que debe ser el led(3) de la alu segun el n

with n(0) select
led(3) <= '1' when '1','0' when others;

--with clk select
--  led(0 downto 0) <= "1" when uno,"0" when others;



end Behavioral;
 