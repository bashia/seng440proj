

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
	constant yRConst : std_logic_vector := x"261F5C";
	constant yGConst : std_logic_vector := x"4AD7AE";
	constant yBConst : std_logic_vector := x"E88F6";

	constant cbRConst : std_logic_vector := x"261F67";
	constant cbGConstA : std_logic_vector := x"4AD7A3";
	constant cbGConstB : std_logic_vector := x"15F04E";
	constant cbBConst : std_logic_vector := x"70F70A";

	constant crRConst : std_logic_vector := x"5960A3";
	constant crGConstA : std_logic_vector := x"4AD7AD";
	constant crGConstB : std_logic_vector := x"413306";
	constant crBConst : std_logic_vector := x"E88F7";

    signal r,g,b,y,cr,cb: UNSIGNED (7 downto 0);
begin
	r <= unsigned(inport(23 downto 16));
	g <= unsigned(inport(15 downto 8));
	b <= unsigned(inport(7 downto 0));

   y <= shift_right((unsigned(yRConst) * r + unsigned(yGConst) * g + unsigned(yBConst) * b) ,23) + 16;
   cb <= shift_right((b * unsigned(cbBConst) - r * unsigned(cbRConst) - g * unsigned(cbGConstA)), 24);
   cr <= shift_right((unsigned(crRConst) * r - unsigned(crGConstA) * g - unsigned(crBConst) * b), 24);
	
	outport(23 downto 16) <= std_logic_vector(y);
	outport(15 downto 8) <= std_logic_vector(cb);
	outport(7 downto 0) <= std_logic_vector(cr);

    process(clk)
    begin
         
    end process;

end Behavioral;