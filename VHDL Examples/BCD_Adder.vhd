entity BCD_Adder is
	port(A,B: in bit_vector(3 downto 0);
		S: out bit_vector( 3 downto 0);
		C: out bit);
end BCD_Adder;

architecture behavioral of BCD_Adder is
	signal So, Sx: bit_vector(3 downto 0);
	signal m0: bit_vector(3 downto 0);
	signal m1,m2: bit;
	component RCA
		port( A,B: in bit_vector(3 downto 0);
			S: out bit_vector(3 downto 0);
			Co: out bit);
	end component;
begin

U1: RCA port map(A => A, B => B, S => So, Co => m1);
m2 <= (So(3) and So(2)) or (So(3) and So(1)) or m1;
U2: RCA port map(A(0)=>'0',A(1)=> m2, A(2)=> m2, A(3)=>'0', B=>So, S=>m0,Co=>C);
S <= m0;

end behavioral;
