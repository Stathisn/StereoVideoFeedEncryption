----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:47:37 02/13/2014 
-- Design Name: 
-- Module Name:    counter - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter is
	 Generic (
			  BIT_WIDTH		:	INTEGER := 2;
			  COUNT_ENABLE :	INTEGER := 1;
			  DOWN_COUNT	:	INTEGER := 0
			  );
			  
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           en : in  STD_LOGIC;
           count : out  STD_LOGIC_VECTOR (BIT_WIDTH - 1 downto 0));
end counter;

architecture Behavioral of counter is
signal count_s : unsigned(BIT_WIDTH - 1 downto 0) := (others => '0');
begin
	process (clk, reset)
	begin
		if (reset = '1') then
			count_s <= (others => '0');
		elsif (rising_edge(clk)) then
			if (COUNT_ENABLE = 1) then
				if (en = '1') then
					if (DOWN_COUNT = 0) then
						count_s <= count_s + 1;
					else
						count_s <= count_s - 1;
					end if;
				end if;
			else
				if (DOWN_COUNT = 0) then
					count_s <= count_s + 1;
				else
					count_s <= count_s - 1;
				end if;
			end if;
		end if;
	end process;
	
	count <= std_logic_vector(count_s);

end Behavioral;

