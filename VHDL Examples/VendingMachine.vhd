-- Jasmeet Singh Matta
-- 2023
-- Hardware Engineering
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;


entity vendingMachine is
	port(sw0: in STD_LOGIC_VECTOR(1 downto 0);
		Clk : in  STD_LOGIC;
		ResetBtn: in STD_LOGIC;
		EnterBtn: in STD_LOGIC;
		Cent10Btn: in STD_LOGIC;
		Cent20Btn: in STD_LOGIC;
		Cent50Btn: in STD_LOGIC;
		Euro1Btn: in STD_LOGIC;
		JA : inout  STD_LOGIC_VECTOR (7 downto 0);
		An0 : out  STD_LOGIC_VECTOR (7 downto 0);
           	Seg : out  STD_LOGIC_VECTOR (7 downto 0)
);
end entity;

architecture behaviour of vendingMachine is

	signal Refresh_counter: STD_LOGIC_VECTOR( 19 downto 0);
	signal Led_activation: STD_LOGIC_VECTOR(2 downto 0);
	signal DataDisp: STD_LOGIC_VECTOR(3 downto 0);
	signal Decode: STD_LOGIC_VECTOR (3 downto 0);
	Signal Cent10,Cent20,Cent50,Euro1: STD_LOGIC_VECTOR (3 downto 0) := "0000";

component Decoder is --Dont have to use it at a moment;
	Port (
		clk : in  STD_LOGIC;
          	Row : in  STD_LOGIC_VECTOR (3 downto 0);
		Col : out  STD_LOGIC_VECTOR (3 downto 0);
		DecodeOut : out  STD_LOGIC_VECTOR (3 downto 0));
	end component;

component BCD_Filter is
	port(
		A,B: in bit_vector(3 downto 0);
		CinA,CinB: in bit;
		Sa,Sb: out bit_vector( 7 downto 0));
end component;

begin
	C0: Decoder port map (clk=>clk, Row =>JA(7 downto 4), Col=>JA(3 downto 0), DecodeOut=> Decode);

	Refresh: process(Clk ,ResetBtn)
	begin 
   		if(ResetBtn='1') then
        		refresh_counter <= (others => '0');
    		elsif(rising_edge(Clk)) then
        		refresh_counter <= refresh_counter+1;
    		end if;
	end Process;
	


	Cent10count: process(Cent10Btn)
	begin 
   		if(Cent10Btn='1') then
        		Cent10 <= Cent10 +1;
    		end if;
	end Process;


	Cent20count: process(Cent20Btn)
	begin 
   		if(Cent20Btn='1') then
        		Cent20 <= Cent20 +1;
    		end if;
	end Process;


	Cent50count: process(Cent50Btn)
	begin 
   		if(Cent50Btn='1') then
        		Cent50 <= Cent50 +1;
    		end if;
	end Process;

	Euro1Count: process(Euro1Btn)
	begin 
   		if(Euro1Btn='1') then
        		Euro1 <= Euro1 +1;
    		end if;
	end Process;




	Store: Process(Clk,sw0) -- need to create MSP for the coffee or tea 
	begin
		if(sw0 = "00") then

	end Process;

	Enter: process(EnterBtn) -- when pressed one need to calculate total ammount user inputed, delivery or not, change or not and reset everything
	begin
		if(EnterBtn ='1') then
			Data = 
	end process;

	Led_activation <= Refresh_counter(19 downto 17);
	DisplayBCD: process(Led_Activation)
	begin 
		Case(Led_activation) is
		when "000" =>
			An0 <= "01111111";
			if(sw0 = "00") then
				DataDisp <= "0000";
			elsif(sw0 = "01") then
				DataDisp <= "1100";
			elsif(sw0 = "10") then
				DataDisp <= "1111";
			elsif(Sw0 = "11") then
				DataDisp <= "1100";
			end if;
		when "001" =>
			An0 <= "10111111";
			if(Sw0 = "11") then
				DataDisp <= "1111";
			end if;
		when"010" =>
			An0 <= "11011111";
			if(sw0 = "01") then
				DataDisp <= "0000";
			elsif(sw0 = "10") then
				DataDisp <= "0000";
			elsif(sw0 = "11") then
				DataDisp <= "0001";
			end if;
		when "011" =>
			An0 <= "11101111";
			if(sw0 = "01") then
				DataDisp <= "0110";
			elsif(sw0 = "10") then
				DataDisp <= "0100";
			elsif(sw0 = "11") then
				DataDisp <= "0000";
			end if;
		when "100" =>
			An0 <= "11110111";
			DataDisp <= "0000"; --change it to Display Price/Amount added and D for Delivery, and something for change;
		when others =>
			An0 <= "11111110";
			DataDisp <= Decode;
		end case;
	end process;
	
end behaviour;
