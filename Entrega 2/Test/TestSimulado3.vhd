library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity Basys3_tb is
end;

architecture bench of Basys3_tb is

  component Basys3
      Port (
          sw          : in   std_logic_vector (2 downto 0);
          btn         : in   std_logic_vector (4 downto 0);
          led         : out  std_logic_vector (3 downto 0);
          clk         : in   std_logic;
          disA            : out std_logic_vector(3 downto 0);
          disB            :  out std_logic_vector(3 downto 0);
          disC            : out std_logic_vector(3 downto 0);
          disD            : out std_logic_vector(3 downto 0)
            );
  end component;

  signal sw: std_logic_vector (2 downto 0);
  signal btn: std_logic_vector (4 downto 0);
  signal led: std_logic_vector (3 downto 0);
  signal clk: std_logic := '0';
  signal disA: std_logic_vector(3 downto 0);
  signal disB: std_logic_vector(3 downto 0);
  signal disC: std_logic_vector(3 downto 0);
  signal disD: std_logic_vector(3 downto 0) ;
  signal mled: std_logic_vector(2 downto 0) ;
  signal evaluarA: std_logic_vector(3 downto 0)  := "0000";
  signal evaluarB: std_logic_vector(3 downto 0)  := "0000";
  signal evaluarC: std_logic_vector(3 downto 0)  := "0000";
  signal evaluarD: std_logic_vector(3 downto 0)  := "0000";
  signal evaluarL: std_logic_vector(2 downto 0)  := "000";
  signal evaluar: std_logic_vector(15 downto 0)  := "0000000000000000";
  
  
  constant clk_period : time := 10 ns;

begin

  uut: Basys3 port map ( sw   => sw,
                         btn  => btn,
                         led  => led,
                         clk  => clk,
                         disA => disA,
                         disB => disB,
                         disC => disC,
                         disD => disD );
mled <= led(3 downto 1);
evaluar <= evaluarA & evaluarB & evaluarC & evaluarD;
process
begin



  wait for clk_period/2;
  clk <= not clk;
  wait for clk_period/2;

  if NOW > 3000 ns then
    wait;
  end if;
end process;

  stimulus: process
  begin
  
    -- Put initialisation code here

    -- INCIO
    wait for 20 ns;
    -- MOV A,240 
    evaluarA <= (disA xor "1111");
    evaluarB <= (disB xor "0000");
    evaluarC <= (disC xor "0000");
    evaluarD <= (disD xor "0000");
    wait for 20 ns;
    -- MOV B,225 
    evaluarA <= (disA xor "1111");
    evaluarB <= (disB xor "0000");
    evaluarC <= (disC xor "1110");
    evaluarD <= (disD xor "0001");
    wait for 20 ns;
    -- AND A,B   
    evaluarA <= (disA xor "1110");
    evaluarB <= (disB xor "0000");
    evaluarC <= (disC xor "1110");
    evaluarD <= (disD xor "0001");
    wait for 20 ns;
    -- MOV B,196 
    evaluarA <= (disA xor "1110");
    evaluarB <= (disB xor "0000");
    evaluarC <= (disC xor "1100");
    evaluarD <= (disD xor "0100");
    wait for 20 ns;
    -- AND B,A   
    evaluarA <= (disA xor "1110");
    evaluarB <= (disB xor "0000");
    evaluarC <= (disC xor "1100");
    evaluarD <= (disD xor "0000");
    wait for 20 ns;
    -- MOV A,192 
    evaluarA <= (disA xor "1100");
    evaluarB <= (disB xor "0000");
    evaluarC <= (disC xor "1100");
    evaluarD <= (disD xor "0000");
    wait for 20 ns;
    -- AND A,144 
    evaluarA <= (disA xor "1000");
    evaluarB <= (disB xor "0000");
    evaluarC <= (disC xor "1100");
    evaluarD <= (disD xor "0000");
    wait for 20 ns;
    -- MOV A,13 
    evaluarA <= (disA xor "0000");
    evaluarB <= (disB xor "1101");
    evaluarC <= (disC xor "1100");
    evaluarD <= (disD xor "0000");
    wait for 20 ns;
    -- AND B,11 
    evaluarA <= (disA xor "0000");
    evaluarB <= (disB xor "1101");
    evaluarC <= (disC xor "0000");
    evaluarD <= (disD xor "1001");
    wait for 20 ns;
    -- MOV A,1 
    evaluarA <= (disA xor "0000");
    evaluarB <= (disB xor "0001");
    evaluarC <= (disC xor "0000");
    evaluarD <= (disD xor "1001");
    wait for 20 ns;
    -- MOV B,3 
    evaluarA <= (disA xor "0000");
    evaluarB <= (disB xor "0001");
    evaluarC <= (disC xor "0000");
    evaluarD <= (disD xor "0011");
    wait for 20 ns;
    -- OR A,B 
    evaluarA <= (disA xor "0000");
    evaluarB <= (disB xor "0011");
    evaluarC <= (disC xor "0000");
    evaluarD <= (disD xor "0011");
    wait for 20 ns;
    -- MOV B,6 
    evaluarA <= (disA xor "0000");
    evaluarB <= (disB xor "0011");
    evaluarC <= (disC xor "0000");
    evaluarD <= (disD xor "0110");
    wait for 20 ns;
    -- OR B,A 
    evaluarA <= (disA xor "0000");
    evaluarB <= (disB xor "0011");
    evaluarC <= (disC xor "0000");
    evaluarD <= (disD xor "0111");
    wait for 20 ns;
    -- MOV A,B 
    evaluarA <= (disA xor "0000");
    evaluarB <= (disB xor "0111");
    evaluarC <= (disC xor "0000");
    evaluarD <= (disD xor "0111");
    wait for 20 ns;
    -- OR A,17 
    evaluarA <= (disA xor "0001");
    evaluarB <= (disB xor "0111");
    evaluarC <= (disC xor "0000");
    evaluarD <= (disD xor "0111");
    wait for 20 ns;
    -- MOV A,13 
    evaluarA <= (disA xor "0000");
    evaluarB <= (disB xor "1101");
    evaluarC <= (disC xor "0000");
    evaluarD <= (disD xor "0111");
    wait for 20 ns;
    -- OR B,11 
    evaluarA <= (disA xor "0000");
    evaluarB <= (disB xor "1101");
    evaluarC <= (disC xor "0000");
    evaluarD <= (disD xor "1111");
    wait for 20 ns;
    -- MOV A,15 
    evaluarA <= (disA xor "0000");
    evaluarB <= (disB xor "1111");
    evaluarC <= (disC xor "0000");
    evaluarD <= (disD xor "1111");
    wait for 20 ns;
    -- MOV B,21 
    evaluarA <= (disA xor "0000");
    evaluarB <= (disB xor "1111");
    evaluarC <= (disC xor "0001");
    evaluarD <= (disD xor "0101");
    wait for 20 ns;
    -- XOR A,B 
    evaluarA <= (disA xor "0001");
    evaluarB <= (disB xor "1010");
    evaluarC <= (disC xor "0001");
    evaluarD <= (disD xor "0101");
    wait for 20 ns;
    -- XOR B,A 
    evaluarA <= (disA xor "0001");
    evaluarB <= (disB xor "1010");
    evaluarC <= (disC xor "0000");
    evaluarD <= (disD xor "1111");
    wait for 20 ns;
    -- MOV A,15 
    evaluarA <= (disA xor "0000");
    evaluarB <= (disB xor "1111");
    evaluarC <= (disC xor "0000");
    evaluarD <= (disD xor "1111");
    wait for 20 ns;
    -- XOR A,3 
    evaluarA <= (disA xor "0000");
    evaluarB <= (disB xor "1100");
    evaluarC <= (disC xor "0000");
    evaluarD <= (disD xor "1111");
    wait for 20 ns;
    -- XOR B,7 
    evaluarA <= (disA xor "0000");
    evaluarB <= (disB xor "1100");
    evaluarC <= (disC xor "0000");
    evaluarD <= (disD xor "1011");
    wait for 20 ns;
    -- MOV A,1 
    evaluarA <= (disA xor "0000");
    evaluarB <= (disB xor "0001");
    evaluarC <= (disC xor "0000");
    evaluarD <= (disD xor "1011");
    wait for 20 ns;
    -- NOT A 
    evaluarA <= (disA xor "1111");
    evaluarB <= (disB xor "1110");
    evaluarC <= (disC xor "0000");
    evaluarD <= (disD xor "1011");
    wait for 20 ns;
    -- NOT B,A 
    evaluarA <= (disA xor "1111");
    evaluarB <= (disB xor "1110");
    evaluarC <= (disC xor "0000");
    evaluarD <= (disD xor "0001");
    wait for 20 ns;
    -- MOV A,2 
    evaluarA <= (disA xor "0000");
    evaluarB <= (disB xor "0010");
    evaluarC <= (disC xor "0000");
    evaluarD <= (disD xor "0001");
    wait for 20 ns;
    -- SHL A 
    evaluarA <= (disA xor "0000");
    evaluarB <= (disB xor "0100");
    evaluarC <= (disC xor "0000");
    evaluarD <= (disD xor "0001");
    wait for 20 ns;
    -- SHL B,A 
    evaluarA <= (disA xor "0000");
    evaluarB <= (disB xor "0100");
    evaluarC <= (disC xor "0000");
    evaluarD <= (disD xor "1000");
    wait for 20 ns;
    -- SHR A 
    evaluarA <= (disA xor "0000");
    evaluarB <= (disB xor "0010");
    evaluarC <= (disC xor "0000");
    evaluarD <= (disD xor "1000");
    wait for 20 ns;
    -- MOV A,32 
    evaluarA <= (disA xor "0010");
    evaluarB <= (disB xor "0000");
    evaluarC <= (disC xor "0000");
    evaluarD <= (disD xor "1000");
    wait for 20 ns;
    -- SHR B,A 
    evaluarA <= (disA xor "0010");
    evaluarB <= (disB xor "0000");
    evaluarC <= (disC xor "0001");
    evaluarD <= (disD xor "0000");
    wait for 20 ns;
    -- Put test bench stimulus code here
      
          wait;
end process;

end;