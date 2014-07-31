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
	signal yRConst : std_logic_vector := x"261F5C";
	signal yGConst : std_logic_vector := x"4AD7AE";
	signal yBConst : std_logic_vector := x"E88F6";

	signal cbRConst : std_logic_vector := x"261F67";
	signal cbGConstA : std_logic_vector := x"4AD7A3";
	signal cbGConstB : std_logic_vector := x"15F04E";
	signal cbBConst : std_logic_vector := x"70F70A";

	signal crRConst : std_logic_vector := x"5960A3";
	signal crGConstA : std_logic_vector := x"4AD7AD";
	signal crGConstB : std_logic_vector := x"413306";
	signal crBConst : std_logic_vector := x"E88F7";

    signal r,g,b: UNSIGNED (7 downto 0);
    signal y,cr,cb: UNSIGNED (31 downto 0);
    signal tempy,tempcr,tempcb: std_logic_vector(31 downto 0);
begin
	r <= unsigned(inport(23 downto 16));
	g <= unsigned(inport(15 downto 8));
	b <= unsigned(inport(7 downto 0));	



   y <= (unsigned(yRConst) * r) + (unsigned(yGConst) * g) + (unsigned(yBConst) * b) + 16; --23
   tempy <=std_logic_vector(y);
   cb <= (b * unsigned(cbBConst) - r * unsigned(cbRConst) - g * unsigned(cbGConstA)); --24
   tempcb <= std_logic_vector(cb);
   cr <= (unsigned(crRConst) * r) - (unsigned(crGConstA) * g) - (unsigned(crBConst) * b); --24
   tempcr <= std_logic_vector(cr);
   
   outport(31 downto 24) <= x"00";
   outport(23 downto 16) <= tempy(30 downto 23);
   outport(15 downto 8) <= tempcb(30 downto 23);
   outport(7 downto 0) <= tempcb(30 downto 23);

end Behavioral;
