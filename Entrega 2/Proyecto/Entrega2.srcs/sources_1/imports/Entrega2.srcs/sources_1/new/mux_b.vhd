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

entity mux_b is
    Port(
         selb: in STD_LOGIC_VECTOR(1 downto 0);
         reg_b: in STD_LOGIC_VECTOR(15 downto 0);
         data_out: in STD_LOGIC_VECTOR(15 downto 0);
         instruction_memory: in STD_LOGIC_VECTOR(15 downto 0);
         enviado: out STD_LOGIC_VECTOR(15 downto 0)
    );
end mux_b;

architecture Behavioral of mux_b is

begin

    with selb select
        enviado <=
        "0000000000000000" when "01",
        data_out when "10",
        reg_b when "00",
        instruction_memory when others;


end Behavioral;
