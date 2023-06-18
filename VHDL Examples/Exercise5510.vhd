entity fourPin is
	port (A: in bit;
		B: in bit;
		C: in bit;
		D: in bit;
		F: out bit);
end fourPin;

architecture behavioral of fourPin is
	signal ABCD: bit_vector (3 downto 0);
begin 
	ABCD <= A&B&C&D;
	with ABCD select
	F <= '1' when ("0001"),
		'1' when ("0011"),
		'1' when ("1001"), 
		'1' when ("1011"),
		'0' when others;
end behavioral;
