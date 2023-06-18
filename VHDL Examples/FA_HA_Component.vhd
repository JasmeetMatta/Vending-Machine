entity FA is 
	port(A: in bit;
		B: in bit;
		Cin: in bit;
		S: out bit;
		Cout: out bit);
end FA;

architecture behavioural of FA is 
	signal An,Bn,Cn : bit;
	signal m0,m1,m2,m3 : bit;
	component HA
		port(A: in bit;
			B: in bit;
			c: out bit;
			s: out bit);
	end component;
begin

U1: HA port map (A=>A, B=>B, c=>m0, s=>m1);
U2: HA port map (A=>m1, B=>Cin, c=>m2, s=>m3);
Cout <= m0 or m2;
S <= m3;
end behavioural;

