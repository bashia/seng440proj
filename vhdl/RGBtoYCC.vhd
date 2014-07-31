

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


entity RGBtoYCC is
    Port ( clk : in STD_LOGIC;
           inport : in STD_LOGIC_VECTOR (31 downto 0);
           outport : out STD_LOGIC_VECTOR (31 downto 0));
end RGBtoYCC;



architecture Behavioral of RGBtoYCC is
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

    signal r,g,b,y,cr,cb: UNSIGNED (7 downto 0);
begin
	r <= unsigned(inport(23 downto 16));
	g <= unsigned(inport(15 downto 8));
	b <= unsigned(inport(7 downto 0));

   y <= shift_right((yRConst * r + yGConst * g + yBConst * b) ,23) + 16;
   cb <= shift_right((b * cbBConst - r * cbRConst - g * cbGConstA), 24);
   cr <= shift_right((crRConst * r - crGConstA * g - crBConst * b), 24);
	
	outport(23 downto 16) <= std_logic_vector(y);
	outport(15 downto 8) <= std_logic_vector(cb);
	outport(7 downto 0) <= std_logic_vector(cr);

    process(clk)
    begin
         
    end process;

end Behavioral;