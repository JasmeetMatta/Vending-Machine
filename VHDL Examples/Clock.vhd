entity Clock is 
	port(Clk: out bit);
end Clock;

architecture bheaviour of Clock is
begin
	clock: process
		begin
			Clk <= '0';
			wait for 5 ns;
			Clk <= '1';
			wait for 5 ns;
	end process;
end bheaviour;
