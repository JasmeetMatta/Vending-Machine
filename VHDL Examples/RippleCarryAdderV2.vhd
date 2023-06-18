entity RCAV2 is 
	port(A,B: in bit_vector(3 downto 0);
		Cin: in bit;
		S: out bit_vector(3 downto 0);
		Co: out bit);
end RCAV2;

architecture behavioral of RCAV2 is
	signal m0, m1, m2, m3, m4: bit;
	component FA 
		port(A,B,Cin: in bit;
			Cout,S: out bit);
	end component;

begin

U1: FA port map(A=>A(0), B=>B(0),Cin=> Cin,S=>S(0),Cout=>m0);
U2: FA port map(A=>A(1), B=>B(1),Cin=>m0, S=>S(1),Cout=>m1);
U3: FA port map(A=>A(2), B=>B(2),Cin=>m1, S=>S(2),Cout=>m2);
U4: FA port map(A=>A(3), B=>B(3),Cin=>m2, S=>S(3),Cout=>m3);
Co <= m3;

end behavioral;
