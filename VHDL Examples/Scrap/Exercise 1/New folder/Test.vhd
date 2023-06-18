entity HA is
	port (a: in bit;
		b: in bit;
		s: out bit;
		co: out bit);
end HA;

architecture behavioral of HA is 
begin 
	s<= a xor b;
	co<= a and b;
end behavioral;
