----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:44:34 03/20/2014 
-- Design Name: 
-- Module Name:    bitwiseXOR - Behavioral 
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

entity bitwiseXOR is
	 Generic (
			  BIT_WIDTH		:	INTEGER := 16
			  );
    Port ( in1 : in  STD_LOGIC_VECTOR(BIT_WIDTH - 1 downto 0);
           in2 : in  STD_LOGIC_VECTOR(BIT_WIDTH - 1 downto 0);
           output : out  STD_LOGIC_VECTOR(BIT_WIDTH - 1 downto 0));
end bitwiseXOR;

architecture Behavioral of bitwiseXOR is
signal bitwiseXOR_sig : std_logic_vector(BIT_WIDTH - 1 downto 0);
begin
	GEN_XOR:
	for I in 0 to BIT_WIDTH - 1 generate
		output(I) <= in1(I) XOR in2(I);
	end generate GEN_XOR;

end Behavioral;