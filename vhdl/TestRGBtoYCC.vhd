--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:08:06 07/30/2014
-- Design Name:   
-- Module Name:   /home/bashia/RGBtoYCC/TestRGBtoYCC.vhd
-- Project Name:  RGBtoYCC
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: RGBtoYCC
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY TestRGBtoYCC IS
END TestRGBtoYCC;
 
ARCHITECTURE behavior OF TestRGBtoYCC IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RGBtoYCC
    PORT(
         clk : IN  std_logic;
         inport : IN  std_logic_vector(31 downto 0);
         outport : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal inport : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal outport : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time :=50 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RGBtoYCC PORT MAP (
          clk => clk,
          inport => inport,
          outport => outport
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      inport <= x"000F0F0F";
		wait for clk_period;
		inport <= x"001E1E1E";
		wait for clk_period;
		inport <= x"00646464";
		wait for clk_period;
		inport <= x"00640064";
		wait for clk_period;
		inport <= x"00006464";
		wait for clk_period;
		inport <= x"00000000";
		wait for clk_period;
		inport <= x"00FFFFFF";

      wait;
   end process;

END;
