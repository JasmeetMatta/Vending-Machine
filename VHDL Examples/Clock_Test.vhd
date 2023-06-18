entity Clock_Test is
end entity;

architecture bench of Clock_Test is
component Clock is
	port(Clk: out bit);
end component;

signal c_t: bit;

begin 
UUT: Clock port map(c_t);
end;

