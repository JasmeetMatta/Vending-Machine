--Jasmeet Singh Matta

entity SevenSegDis is
 	port ( An: out bit_vector(7 downto 0);
		Disp: out bit_vector( 7 downto 0);
		swt: in bit_vector(3 downto 0));
end SevenSegDis;

architecture behaviour of SevenSegDis is
signal F: bit_vector(7 downto 0);
begin
An <= "11111110";
with swt select
		F <= "11111100" when "0000",
		 "01100000" when "0001",
		 "11011010" when "0010",
		 "11110010" when "0011",
		 "01100110" when "0100",
		 "10110110" when "0101",
		 "10111110" when "0110",
		 "11100000" when "0111",
		 "11111110" when "1000",
		 "11100110" when "1001",
		 "00000010" when others;
		 
Disp <= not F;
end;
