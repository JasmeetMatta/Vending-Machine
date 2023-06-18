entity BCD_AdderV2 is
	port(A,B: in bit_vector(3 downto 0);
		S: out bit_vector( 7 downto 0);
		C: out bit);
end BCD_AdderV2;

architecture behavioral of BCD_AdderV2 is

-- signal
	signal F0,F1,F2,F3: bit_vector (7 downto 0);
	signal So, Sx ,Sl: bit_vector(3 downto 0);
	--signal m0: bit_vector(3 downto 0);
	signal m0,m1,m2,m3: bit;

--component
	component BCD_Filter
		port(A,B: in bit_vector(3 downto 0);
			CinA,CinB: in bit;
			Sa,Sb: out bit_vector (7 downto 0));
	end component;
	component RCAV2
		port( A,B: in bit_vector(3 downto 0);
			S: out bit_vector(3 downto 0);
			Cin: in bit;
			Co: out bit);
	end component;

--behaviour
begin

-- To decompose 4 bit binary to BCD
U1: BCD_Filter port map(A=> A, B=> B,CinA=>'0',CinB=>'0', Sa => F0, Sb => F1);
-- To Add Least BCD Bytes created By Filter
U2: RCAV2 port map(A=>F0(3 downto 0), B=>F1(3 downto 0), Cin => '0', S =>So, Co => m0);
-- To Add High BCD Bytes created By Filter
U3: RCAV2 port map(A=>F0(7 downto 4), B=>F1(7 downto 4), Cin => m0, S =>Sx, Co => m1);
-- To Again Calculate if greater than 9
U4: BCD_Filter port map(A=>Sx, B=> So,CinA=>m1,CinB=>'0', Sa => F2, Sb => F3);
-- To add the carry of LCB tp HCB
U5: RCAV2 port map(A=>F2(3 downto 0), B=> F3(7 downto 4), Cin=>'0', S => Sl, Co => m3);
S <= Sl&F3(3 downto 0);
C <= m1;

end behavioral;
