entity HA is 
	port(A: in bit;
		B: in bit;
		S: out bit;
		C: out bit);
end HA;

architecture behavioural of HA is
begin
	S <= A xor B;
	C <= A and B;
end behavioural;
