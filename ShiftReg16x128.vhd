----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:51:59 01/30/2014 
-- Design Name: 
-- Module Name:    ShiftReg16x128 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ShiftReg16x128 is
    Port ( clk : in  STD_LOGIC; -- data is shifted and saved on a rising edge
           din : in  STD_LOGIC_VECTOR (15 downto 0); -- Data to be entered
           we : in  STD_LOGIC_VECTOR(0 DOWNTO 0); 
           dout : out  STD_LOGIC_VECTOR (127 downto 0));
end ShiftReg16x128;

architecture Behavioral of ShiftReg16x128 is

COMPONENT true_dp_ram_128x1
  PORT (
    clka : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(127 DOWNTO 0);
    clkb : IN STD_LOGIC;
    web : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addrb : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    dinb : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
    doutb : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
  );
END COMPONENT;

signal shiftIn, shiftOutA, shiftOutB : std_logic_vector (127 downto 0);

begin

shiftIn <= din & shiftOutB(127 downto 16);

TrueDPMem : true_dp_ram_128x1
  PORT MAP(
    clka =>  clk,
    wea =>  "0",
    addra =>  "1",
    dina =>  shiftIn,
    douta =>  shiftOutA,
    clkb =>  clk,
    web =>  we,
    addrb =>  "1",
    dinb =>  shiftIn,
    doutb =>  shiftOutB
  );

	dout <= shiftIn;

end Behavioral;

