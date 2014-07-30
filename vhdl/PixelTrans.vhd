----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/29/2014 11:01:09 PM
-- Design Name: 
-- Module Name: 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

constant yRConst : integer := 2498396;
constant yGConst : integer := 4904878;
constant yBConst : integer := 952566;

constant cbRConst : integer := 2498407;
constant cbGConstA : integer := 4904867;
constant cbGConstB : integer := 1437774;
constant cbBConst : integer := 7403274;

constant crRConst : integer := 5857443;
constant crGConstA : integer := 4904877;
constant crGConstB : integer := 4272902;
constant crBConst : integer := 952567;

entity PixelTransform is
    Port ( clk : in STD_LOGIC;
           inport : in STD_LOGIC_VECTOR (31 downto 0);
           outport : out STD_LOGIC_VECTOR (31 downto 0));
end PixelTransform;

architecture Behavioral of PixelTransform is
    signal r,g,b,y,cr,cb: UNSIGNED (7 downto 0);
begin
    y <= ((yRConst * r + yGConst * g + yBConst * b) sra 23) + 16;
    cb <= (b * cbBConst - r * cbRConst - g * cbGConstA) sra 24;
    cr <= (crRConst * r - crGConstA * g - crBConst * b) sra 24;

    process(clk)
    begin
         --FILL THIS IN WITH FUCKTIONALITY!
    
    end process;

end Behavioral;



