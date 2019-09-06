-- Created By Hikuga @ 2019
-- Altera Cyclone II EP2C5T144C8N

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;

entity UART_TX is 
	generic (
		frequency 	: positive := 50000000;
		baudrate		: positive := 115200;
		contoh		: string := "mama muda"
	);
	port(
		clk 		: in std_logic;
		TX_SEND 	: out std_logic
	);
end entity;

architecture RTL of UART_TX is

	function rev_str (constant arg : string) return string is
	begin
		if arg'length < 1 then return "";
		else
			return( arg(arg'length) &
				rev_str(arg(1 to arg'length - 1))
			);
	 end if;
	end function rev_str;                   -- Mike Treseler 

constant txrate	: integer := (frequency/baudrate);
signal pulse 		: std_logic := '1';
signal data_mode	: natural range 0 to 3 := 0;
-- signal nextcount	: positive range 20 to 100 := 20;
signal count 		: positive range 1 to 50000000 := txrate; -- inisialisasi 
signal txbit		: std_logic_vector ((contoh'length*8)-1 downto 0) := CONV_STD_LOGIC_VECTOR(string'pos(rev_str(contoh)), contoh'length*8); -- konversi dari char ke digit biner
signal cbit 		: integer range 0 to txbit'length := 0;

begin
	p1 : process(clk)
	begin
		if (clk'event and clk = '1') then

			if count = 0 and data_mode = 0 then
				count <= txrate;
				pulse <= '0';
				data_mode <= 1;
			elsif (count = 0 and data_mode = 1) and cbit < txbit'length then
				count <= txrate;
				pulse <= txbit(cbit);
				cbit <= cbit + 1;
				if cbit = (txbit'length-1) or (cbit+1) mod 8 = 0 then
					data_mode <= 2;					
				end if;
			elsif count = 0 and data_mode = 2 then
				pulse <= '1';
				if cbit <(txbit'length-1) then
					count <= txrate;
					data_mode <= 0;
				end if;
			else
				count <= count - 1;				
			end if;
			
			--send : for sendbit in txbit'length-1 downto 0 loop
			--	TX_SEND <= txbit(sendbit);
			--	delay2 : for i in 0 to (txrate-1) loop			
			--	end loop delay2;
			--end loop send;
		end if;
	end process;
	
	TX_SEND <= pulse;
	
end architecture;
			
			
