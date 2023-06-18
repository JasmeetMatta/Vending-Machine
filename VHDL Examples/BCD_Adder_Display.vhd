entity BCD_Adder_Display is
	port(A,B: in bit_vector(3 downto 0);
		F: out bit_vector( 6 downto 0);
		C: out bit);
end BCD_Adder_Display;

architecture behavioral of BCD_Adder_Display is
	signal So,m0, Sx: bit_vector(3 downto 0);
	signal m1,m2: bit;
	component RCA
		port( A,B: in bit_vector(3 downto 0);
			S: out bit_vector(3 downto 0);
			Co: out bit);
	end component;
	component BCD_Decoder
		port (ABCD: in bit_vector(3 downto 0);
			F: out bit_vector(6 downto 0));
	end component;
begin

U1: RCA port map(A => A, B => B, S => So, Co => m1);
M2 <= (So(3) and So(2)) or (So(3) and So(1)) or m1;
Sx <= '0'&m2&M2&'0';
U2: RCA port map(A => Sx, B=>B ,S=>m0,Co=>C);
U3: BCD_Decoder port map(ABCD =>m0,F=>F);

end behavioral;