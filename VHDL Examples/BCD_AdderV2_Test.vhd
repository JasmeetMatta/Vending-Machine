entity BCD_Adder_TestV2 is
end entity;

architecture bench of BCD_Adder_TestV2 is
component BCD_AdderV2 is
	port(A,B: in bit_vector(3 downto 0);
		S: out bit_vector(7 downto 0); 
		C: out bit);
end component;

signal a_t, b_t: bit_vector (3 downto 0);
signal s_t: bit_vector(7 downto 0);
signal co_t: bit;

begin 

uut: BCD_AdderV2 port map(a_t, b_t, s_t, co_t);



a_t <= "0000", "0001" after 20 ns, "0010" after 40 ns, "0011" after 60 ns, "0100" after 80 ns, "0101" after 100 ns, "0110" after 120 ns, "0111" after 140 ns, "1000" after 160 ns, "1001" after 180 ns, "1010" after 200 ns, "1011" after 220 ns, "1100" after 240 ns, "1101" after 260 ns, "1110" after 280 ns, "1111" after 300 ns, "0000" after 320 ns; 
b_t <= "0000", "0001" after 20 ns, "0010" after 40 ns, "0011" after 60 ns, "0100" after 80 ns, "0101" after 100 ns, "0110" after 120 ns, "0111" after 140 ns, "1000" after 160 ns, "1001" after 180 ns, "1010" after 200 ns, "1011" after 220 ns, "1100" after 240 ns, "1101" after 260 ns, "1110" after 280 ns, "1111" after 300 ns, "0000" after 320 ns; 

end;

