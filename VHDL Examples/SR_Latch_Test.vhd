entity SR_Latch_Test is
end entity;

architecture bench of SR_Latch_Test is
component SR_Latch
	port(S,R: in bit;
		Q,Q1: inout bit);
end component;


signal s_t,r_t,q_t,q1_t: bit;

begin 

uut: SR_Latch port map(s_t,r_t,q_t,q1_t);


S_process: process
begin
	s_t <= '0';
	wait for 5 ns;
	s_t <= '1';
	wait for 5 ns;
end process;

R_process: process
begin
	r_t <= '0';
	wait for 7 ns;
	r_t <= '1';
	wait for 7 ns;
end process;
end;

