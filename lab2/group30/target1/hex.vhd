library IEEE;
use IEEE.std_logic_1164.all;
entity hex is
	port(
			sw0,sw1,sw2,sw3,sw4,sw5,sw6,sw7: in std_logic;
			a1,b1,c1,d1,e1,f1,g1,a2,b2,c2,d2,e2,f2,g2: out std_logic
		);
end hex;

ARCHITECTURE func of hex is
BEGIN
	a1<=(not sw0 and not sw1 and not sw2 and sw3) or (sw0 and not sw1 and sw2 and sw3) or (sw1 and not sw2 and not sw3) or (sw0 and sw1 and not sw2);
	b1<=(not sw0 and sw1 and not sw2 and sw3) or (sw1 and sw2 and not sw3) or (sw0 and sw1 and not sw3) or (sw0 and sw2 and sw3);
	c1<=(not sw0 and not sw1 and sw2 and not sw3) or (sw0 and sw1 and not sw3)or (sw0 and sw1 and sw2);
	d1<=(not sw1 and not sw2 and sw3) or (not sw0 and sw1 and not sw2 and not sw3)or (sw1 and sw2 and sw3)or (sw0 and not sw1 and sw2 and not sw3);
	e1<=(not sw0 and sw3) or(not sw0 and sw1 and not sw2)or(not sw1 and not sw2 and sw3);
	f1<=(not sw0 and not sw1 and sw3)or(not sw0 and not sw1 and sw2) or (not sw0 and sw2 and sw3)or(sw0 and sw1 and not sw2);
	g1<=(not sw0 and not sw1  and not sw2)or (not sw0 and sw1 and sw2 and sw3);
	
	a2<=(not sw4 and not sw5 and not sw6 and sw7) or (sw4 and not sw5 and sw6 and sw7) or (sw5 and not sw6 and not sw7) or (sw4 and sw5 and not sw6);
	b2<=(not sw4 and sw5 and not sw6 and sw7) or (sw5 and sw6 and not sw7) or (sw4 and sw5 and not sw7) or (sw4 and sw6 and sw7);
	c2<=(not sw4 and not sw5 and sw6 and not sw7) or (sw4 and sw5 and not sw7)or (sw4 and sw5 and sw6);
	d2<=(not sw5 and not sw6 and sw7) or (not sw4 and sw5 and not sw6 and not sw7)or (sw5 and sw6 and sw7)or (sw4 and not sw5 and sw6 and not sw7);
	e2<=(not sw4 and sw7) or(not sw4 and sw5 and not sw6)or(not sw5 and not sw6 and sw7);
	f2<=(not sw4 and not sw5 and sw7)or(not sw4 and not sw5 and sw6) or (not sw4 and sw6 and sw7)or(sw4 and sw5 and not sw6);
	g2<=(not sw4 and not sw5  and not sw6)or (not sw4 and sw5 and sw6 and sw7);
END func;