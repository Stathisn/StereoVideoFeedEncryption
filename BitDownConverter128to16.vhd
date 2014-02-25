----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:03:42 02/06/2014 
-- Design Name: 
-- Module Name:    BitDownConverter128to16 - Behavioral 
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
-- This core accepts a 128 bit word and outputs that word 
-- in 16 bit chunks over 8 clock cycles from LSB to MSB.
-- To use this core you will need to keep the input signal high 
-- for 8 clock cycles. The output will change on each clock cycle
-- to the next 16 bits of the input (i.e. on clock cycle 4 bits 64 to 79
-- will be available on the output).
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

entity BitDownConverter128to16 is
    Port ( din : in  STD_LOGIC_VECTOR (127 downto 0);
			  en	: in	STD_LOGIC;
			  reset : in  STD_LOGIC;
           dout : out  STD_LOGIC_VECTOR (15 downto 0);
           clk : in  STD_LOGIC);
end BitDownConverter128to16;

architecture Behavioral of BitDownConverter128to16 is

	COMPONENT counter
	GENERIC(
	  BIT_WIDTH		:	INTEGER;
	  COUNT_ENABLE :	INTEGER;
	  DOWN_COUNT	:	INTEGER
	  );
	PORT(
	  clk : in  STD_LOGIC;
	  reset : in  STD_LOGIC;
	  en : in  STD_LOGIC;
	  count : out  STD_LOGIC_VECTOR(BIT_WIDTH - 1 downto 0));
	END COMPONENT;

signal word : std_logic_vector(127 downto 0);
signal count : std_logic_vector(2 downto 0) := "000";
signal count_reset : std_logic;
begin
	
	counter_8bit : counter 
		GENERIC MAP(
			BIT_WIDTH => 3,
			COUNT_ENABLE => 1,
			DOWN_COUNT => 0
			)
		PORT MAP(
			clk => clk,
			reset => reset,
			en => en,
			count => count);
			
	count_proc : process(clk, reset)
	begin
		if (reset = '1') then
		elsif (rising_edge(clk) and en = '1') then
			case count is
				when o"0" =>	word <= din;
									dout <= din(15 downto 0);
				when o"1" =>	dout <= word(31 downto 16);
				when o"2" =>	dout <= word(47 downto 32);
				when o"3" =>	dout <= word(63 downto 48);
				when o"4" =>	dout <= word(79 downto 64);
				when o"5" =>	dout <= word(95 downto 80);
				when o"6" =>	dout <= word(111 downto 96);
				when o"7" =>	dout <= word(127 downto 112);
				when others =>	dout <= (others => '0');
			end case;
		end if;
	end process;

	

end Behavioral;

