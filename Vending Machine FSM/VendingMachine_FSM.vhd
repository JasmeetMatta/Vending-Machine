library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity vendingMachineFSM is
	port(--reset: in STD_LOGIC;
		Clock: in STD_LOGIC;
		CentBtn: in STD_LOGIC;
		EuroBtn: in STD_LOGIC;
		sw: in STD_LOGIC_VECTOR(1 downto 0);
		Display: out STD_LOGIC_VECTOR(7 downto 0);
		An0: out STD_LOGIC_VECTOR(7 downto 0)
	);
end entity;

architecture behaviour of vendingMachineFSM is
	type state is (Idle, Cent20, Cent40, Cent60, Cent80);
	signal current_state, next_state: state;
	--signal output: STD_LOGIC_VECTOR(3 downto 0);
	signal Disp: STD_LOGIC_VECTOR (3 downto 0);
	signal refresh_counter: STD_LOGIC_VECTOR(19 downto 0);
	--signal SecDelay: STD_LOGIC_VECTOR(26 downto 0);
	signal DataDisp,balance,returnAmount: STD_LOGIC_VECTOR(3 downto 0);
	--signal Display: STD_LOGIC_VECTOR(7 downto 0);
	signal Led_activation: STD_LOGIC_VECTOR(2 downto 0);
	signal DispenseD: STD_LOGIC;
begin

	

combinational:process(current_state, CentBtn, EuroBtn)
begin
	next_state <= current_state;
	case current_state is 
	when Idle => 
		--Disp<="0000";
		if (EuroBtn = '1') then
			next_state <= current_state;
			case sw is
			when "01" =>
                           	DispenseD <= '1'; 
			   	balance <= "0001" ;
				returnAmount <= "0110";
			when "10" =>
                           	DispenseD <= '1'; 
			   	balance <= "0001" ;
				returnAmount <= "0100";
			when "11" =>
				--output <= "0011"; -- Despense with no change          0011
                           	DispenseD <= '1'; 
			   	balance <= "0001" ;
				returnAmount <= "0000";
			when others =>
				--output <= "0000"; -- NO Despense NO change \ Nothing  0000
                           	DispenseD <= '0'; 
			   	balance <= "0000" ;
				returnAmount <= "0000";
			end case;
		elsif (CentBtn = '1') then
			next_state <= Cent20;
		else
			next_state <= current_state;
		end if;
	when Cent20 =>
		if (CentBtn = '1') then
			case sw is

			when "01" =>
				--output <= "0100";-- Despence with no change            0100
                           	DispenseD <= '1'; 
			   	balance <= "0100" ;
				returnAmount <= "0000";
				next_state <= Idle;
			when "10" =>
				--output <= "0000"; --                                 0000 
                           	DispenseD <= '0'; 
			   	balance <= "0100" ;
				returnAmount <= "0000";
				next_state <= Cent40;
			when "11" =>
				--output <= "0000"; --                                 0000
                           	DispenseD <= '0'; 
			   	balance <= "0100" ;
				returnAmount <= "0000";
				next_state <= Cent40;
			when others =>
				--output <= "0000"; --                                   0000
                           	DispenseD <= '0'; 
			   	balance <= "0000" ;
				returnAmount <= "0000";
				next_state <= current_state;
			end case;
		else
			next_state <= current_state;
		end if;
	when Cent40 =>
		if (CentBtn ='1') then
			case sw is
			when "01" =>
				--output <= "0000";--                                  0000
                           	DispenseD <= '0'; 
			   	balance <= "0000" ;
				returnAmount <= "0000";
			when "10" =>
				--output <= "0100"; --      Despense with no change     0100 
                           	DispenseD <= '1'; 
			   	balance <= "0110" ;
				returnAmount <= "0000";
				next_state <= Idle;
			when "11" =>
				--output <= "0000"; --                                 0000
                           	DispenseD <= '0'; 
			   	balance <= "0110" ;
				returnAmount <= "0000";
				next_state <= Cent60;
			when others =>
				--output <= "0000"; --                                   0000
                           	DispenseD <= '0'; 
			   	balance <= "0000" ;
				returnAmount <= "0000";
				next_state <= current_state;
			end case;
		else 
			next_state <= current_state;
		end if;
	when Cent60 => 
		if (CentBtn ='1') then
			next_state <= Cent80;
		else
			next_state <= current_state;
		end if;
	when Cent80 =>
		if (CentBtn = '1') then
			--output <= "0011"; -- despance with no change
                       	DispenseD <= '1'; 
			balance <= "0001" ;
			returnAmount <= "0000";
			next_state <= Idle;
		else
			next_state <= current_state;
		end if;
	end case;
end process;
		
			
CounterChange:process(Clock)
begin 
	if rising_edge(Clock) then
		refresh_counter <= refresh_counter+1;
		current_state <= next_state;

	end if;
end process;

	Led_activation <= Refresh_counter(19 downto 17);
	DisplayBCD: process(Led_Activation)
	begin 
		Case(Led_activation) is
		when "000" =>
			An0 <= "01111111";
			if(sw = "00") then
				DataDisp <= "0000";
			elsif(sw = "01") then
				DataDisp <= "1101";
			elsif(sw = "10") then
				DataDisp <= "0101";
			elsif(sw = "11") then
				DataDisp <= "1101";
			--else
				--DataDisp <= "0000";
			end if;
		when "001" =>
			An0 <= "10111111";
			if(sw = "11") then
				DataDisp <= "0101";
			else
				DataDisp <= "0000";
			end if;
		when"010" =>
			An0 <= "11011111";
			if(sw = "01") then
				DataDisp <= "0000";
			elsif(sw = "10") then
				DataDisp <= "0000";
			elsif(sw = "11") then
				DataDisp <= "0001";
			else
				DataDisp <= "0000";
			end if;
		when "011" =>
			An0 <= "11101111";
			if(sw = "01") then
				DataDisp <= "0110";
			elsif(sw = "10") then
				DataDisp <= "0100";
			else
				DataDisp <= "0000";
			end if;
		when "100" =>
			An0 <= "11110111";
			if DispenseD = '1' then
				DataDisp <= "1001"; --change it to Display D
			else 
				DataDisp <= "0111"; --change it to Display N=n
			end if;
		when "101" =>
			An0 <= "11111101";
			if DispenseD = '0' then
				DataDisp <= balance;
			else
				DataDisp <= returnAmount;
			end if;

		when others =>
			An0 <= "11111110";
			DataDisp <= "0000";

		end case;
	end process;
	CallDisp: process (DataDisp)
	begin
    	case DataDisp is
    		when "0000" => Display <= "00000011"; -- "0"     
    		when "0001" => Display <= "10011111"; -- "1" 
    		when "0010" => Display <= "00100101"; -- "2" 
    		when "0011" => Display <= "00001101"; -- "3" 
    		when "0100" => Display <= "10011001"; -- "4" 
    		when "0101" => Display <= "11100001"; -- "t"  CAN CHANGE IT
    		when "0110" => Display <= "01000001"; -- "6" 
    		when "0111" => Display <= "11010101"; -- "n"  CAN CHANGE IT
    		when "1000" => Display <= "00000001"; -- "8"     
    		when "1001" => Display <= "10000101"; -- "d"  CAN CHANGE IT
    		when "1010" => Display <= "00000010"; -- 0.
    		when "1011" => Display <= "10011110"; -- 1.
    		when "1100" => Display <= "00100100"; -- 2.
    		when "1101" => Display <= "01100011"; -- C
    		when "1110" => Display <= "01100001"; -- E
    		when others => Display <= "01110001"; -- F
    	end case;
	end process;
end behaviour;
