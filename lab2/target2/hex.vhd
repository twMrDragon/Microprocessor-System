LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY hex IS
	PORT (
		sw0, sw1, sw2, sw3, sw4, sw5, sw6, sw7 : IN STD_LOGIC;
		a1, b1, c1, d1, e1, f1, g1, a2, b2, c2, d2, e2, f2, g2 : OUT STD_LOGIC
	);
END hex;

ARCHITECTURE func OF hex IS
BEGIN
	a1 <= (NOT sw0 AND NOT sw1 AND NOT sw2 AND sw3) OR (sw0 AND NOT sw1 AND sw2 AND sw3) OR (sw1 AND NOT sw2 AND NOT sw3) OR (sw0 AND sw1 AND NOT sw2);
	b1 <= (NOT sw0 AND sw1 AND NOT sw2 AND sw3) OR (sw1 AND sw2 AND NOT sw3) OR (sw0 AND sw1 AND NOT sw3) OR (sw0 AND sw2 AND sw3);
	c1 <= (NOT sw0 AND NOT sw1 AND sw2 AND NOT sw3) OR (sw0 AND sw1 AND NOT sw3) OR (sw0 AND sw1 AND sw2);
	d1 <= (NOT sw1 AND NOT sw2 AND sw3) OR (NOT sw0 AND sw1 AND NOT sw2 AND NOT sw3) OR (sw1 AND sw2 AND sw3) OR (sw0 AND NOT sw1 AND sw2 AND NOT sw3);
	e1 <= (NOT sw0 AND sw3) OR(NOT sw0 AND sw1 AND NOT sw2) OR (NOT sw1 AND NOT sw2 AND sw3);
	f1 <= (NOT sw0 AND NOT sw1 AND sw3) OR (NOT sw0 AND NOT sw1 AND sw2) OR (NOT sw0 AND sw2 AND sw3) OR (sw0 AND sw1 AND NOT sw2);
	g1 <= (NOT sw0 AND NOT sw1 AND NOT sw2) OR (NOT sw0 AND sw1 AND sw2 AND sw3);

	a2 <= (NOT sw4 AND NOT sw5 AND NOT sw6 AND sw7) OR (sw4 AND NOT sw5 AND sw6 AND sw7) OR (sw5 AND NOT sw6 AND NOT sw7) OR (sw4 AND sw5 AND NOT sw6);
	b2 <= (NOT sw4 AND sw5 AND NOT sw6 AND sw7) OR (sw5 AND sw6 AND NOT sw7) OR (sw4 AND sw5 AND NOT sw7) OR (sw4 AND sw6 AND sw7);
	c2 <= (NOT sw4 AND NOT sw5 AND sw6 AND NOT sw7) OR (sw4 AND sw5 AND NOT sw7) OR (sw4 AND sw5 AND sw6);
	d2 <= (NOT sw5 AND NOT sw6 AND sw7) OR (NOT sw4 AND sw5 AND NOT sw6 AND NOT sw7) OR (sw5 AND sw6 AND sw7) OR (sw4 AND NOT sw5 AND sw6 AND NOT sw7);
	e2 <= (NOT sw4 AND sw7) OR(NOT sw4 AND sw5 AND NOT sw6) OR (NOT sw5 AND NOT sw6 AND sw7);
	f2 <= (NOT sw4 AND NOT sw5 AND sw7) OR (NOT sw4 AND NOT sw5 AND sw6) OR (NOT sw4 AND sw6 AND sw7) OR (sw4 AND sw5 AND NOT sw6);
	g2 <= (NOT sw4 AND NOT sw5 AND NOT sw6) OR (NOT sw4 AND sw5 AND sw6 AND sw7);
END func;