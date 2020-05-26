----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/08/2020 01:52:16 AM
-- Design Name: 
-- Module Name: mux_b - Behavioral
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

entity mux_a is
    Port(
         sela: in STD_LOGIC_VECTOR(1 downto 0);
         reg_a: in STD_LOGIC_VECTOR(15 downto 0);
         enviado: out STD_LOGIC_VECTOR(15 downto 0)
    );
end mux_a;

architecture Behavioral of mux_a is


begin

    with sela select
        enviado <= 
        "0000000000000001" when "10",
        "0000000000000000" when "01",
        reg_a when "00",
        "0000000000000000" when others;


end Behavioral;
