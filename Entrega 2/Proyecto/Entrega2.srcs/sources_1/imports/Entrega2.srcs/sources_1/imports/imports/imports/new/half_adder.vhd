
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity half_adder is
    Port ( a : in STD_LOGIC;
           b : in STD_LOGIC;
           c : out STD_LOGIC;
           s : out STD_LOGIC);
end half_adder;

architecture Behavioral of half_adder is

begin
--A B| C S
--0 0| 0 0 
--0 1| 0 1
--1 0| 0 1
--1 1| 1 0

c <= a and b;

s <= a xor b;

end Behavioral;
