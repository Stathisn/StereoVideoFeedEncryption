----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:07:55 02/05/2014 
-- Design Name: 
-- Module Name:    BitUpConverter16to128 - Behavioral 
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
-- This module receives data in 16 bit words and stores multiple words
-- until 128 bits have been stored. Then ready will change to high to notify another block that
-- the 128 bit data is ready to be read. To store a further 128 bits reset must be triggered
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

entity BitUpConverter16to128 is
    Port ( din : in  STD_LOGIC_VECTOR (15 downto 0);
           dout : out  STD_LOGIC_VECTOR (127 downto 0);
			  en : in STD_LOGIC;
           --ready : out  STD_LOGIC;
           clk : in  STD_LOGIC;
           reset : in  STD_LOGIC);
end BitUpConverter16to128;

architecture Behavioral of BitUpConverter16to128 is

   COMPONENT ShiftReg16x128
   PORT(
        clk : IN  std_logic;
        din : IN  std_logic_vector(15 downto 0);
        we : IN  std_logic_vector(0 downto 0);
        dout : OUT  std_logic_vector(127 downto 0)
       );
   END COMPONENT;
	
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


	signal we : std_logic_vector(0 downto 0);
	signal count : std_logic_vector(2 downto 0);
	signal word : std_logic_vector(127 downto 0);
	
begin

   SR16x128: ShiftReg16x128 PORT MAP (
          clk => clk,
          din => din,
          we => we,
          dout => word
        );

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


	count_process : process(clk, reset)
	begin
		if (reset = '1') then
		elsif (rising_edge(clk) and en = '1') then
			if count = o"7" then
				dout <= word;
			end if;
		end if;
		
	end process;
		
	we(0) <= en;


end Behavioral;

