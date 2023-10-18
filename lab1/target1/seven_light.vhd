LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY seven_light IS
	PORT (
		w, x, y, z : IN BIT;
		a, b, c, d, e, f, g : OUT BIT);
END seven_light;

ARCHITECTURE logic_fun OF seven_light IS
BEGIN

	a <= (NOT w AND NOT x AND NOT y AND z) OR (w AND NOT x AND y AND z) OR (x AND NOT y AND NOT z) OR (w AND x AND NOT y);
	b <= (NOT w AND x AND NOT y AND z) OR (x AND y AND NOT z) OR (w AND x AND NOT z) OR (w AND y AND z);
	c <= (NOT w AND NOT x AND y AND NOT z) OR (w AND x AND NOT z) OR (w AND x AND y);
	d <= (NOT x AND NOT y AND z) OR (NOT w AND x AND NOT y AND NOT z) OR (x AND y AND z) OR (w AND NOT x AND y AND NOT z);
	e <= (NOT w AND z) OR(NOT w AND x AND NOT y) OR (NOT x AND NOT y AND z);
	f <= (NOT w AND NOT x AND z) OR (NOT w AND NOT x AND y) OR (NOT w AND y AND z) OR (w AND x AND NOT y);
	g <= (NOT w AND NOT x AND NOT y) OR (NOT w AND x AND y AND z);
END logic_fun;