LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY seven_light IS
	PORT (
		w, x, y, z : IN STD_LOGIC_VECTOR(0 TO 2);
		a, b, c, d, e, f, g : OUT STD_LOGIC_VECTOR(0 TO 2));
END seven_light;

ARCHITECTURE logic_fun OF seven_light IS
BEGIN

	a(0) <= (NOT w(0) AND NOT x(0) AND NOT y(0) AND z(0)) OR (w(0) AND NOT x(0) AND y(0) AND z(0)) OR (x(0) AND NOT y(0) AND NOT z(0)) OR (w(0) AND x(0) AND NOT y(0));
	b(0) <= (NOT w(0) AND x(0) AND NOT y(0) AND z(0)) OR (x(0) AND y(0) AND NOT z(0)) OR (w(0) AND x(0) AND NOT z(0)) OR (w(0) AND y(0) AND z(0));
	c(0) <= (NOT w(0) AND NOT x(0) AND y(0) AND NOT z(0)) OR (w(0) AND x(0) AND NOT z(0)) OR (w(0) AND x(0) AND y(0));
	d(0) <= (NOT x(0) AND NOT y(0) AND z(0)) OR (NOT w(0) AND x(0) AND NOT y(0) AND NOT z(0)) OR (x(0) AND y(0) AND z(0)) OR (w(0) AND NOT x(0) AND y(0) AND NOT z(0));
	e(0) <= (NOT w(0) AND z(0)) OR(NOT w(0) AND x(0) AND NOT y(0)) OR (NOT x(0) AND NOT y(0) AND z(0));
	f(0) <= (NOT w(0) AND NOT x(0) AND z(0)) OR (NOT w(0) AND NOT x(0) AND y(0)) OR (NOT w(0) AND y(0) AND z(0)) OR (w(0) AND x(0) AND NOT y(0));
	g(0) <= (NOT w(0) AND NOT x(0) AND NOT y(0)) OR (NOT w(0) AND x(0) AND y(0) AND z(0));

	a(1) <= (NOT w(1) AND NOT x(1) AND NOT y(1) AND z(1)) OR (w(1) AND NOT x(1) AND y(1) AND z(1)) OR (x(1) AND NOT y(1) AND NOT z(1)) OR (w(1) AND x(1) AND NOT y(1));
	b(1) <= (NOT w(1) AND x(1) AND NOT y(1) AND z(1)) OR (x(1) AND y(1) AND NOT z(1)) OR (w(1) AND x(1) AND NOT z(1)) OR (w(1) AND y(1) AND z(1));
	c(1) <= (NOT w(1) AND NOT x(1) AND y(1) AND NOT z(1)) OR (w(1) AND x(1) AND NOT z(1)) OR (w(1) AND x(1) AND y(1));
	d(1) <= (NOT x(1) AND NOT y(1) AND z(1)) OR (NOT w(1) AND x(1) AND NOT y(1) AND NOT z(1)) OR (x(1) AND y(1) AND z(1)) OR (w(1) AND NOT x(1) AND y(1) AND NOT z(1));
	e(1) <= (NOT w(1) AND z(1)) OR(NOT w(1) AND x(1) AND NOT y(1)) OR (NOT x(1) AND NOT y(1) AND z(1));
	f(1) <= (NOT w(1) AND NOT x(1) AND z(1)) OR (NOT w(1) AND NOT x(1) AND y(1)) OR (NOT w(1) AND y(1) AND z(1)) OR (w(1) AND x(1) AND NOT y(1));
	g(1) <= (NOT w(1) AND NOT x(1) AND NOT y(1)) OR (NOT w(1) AND x(1) AND y(1) AND z(1));

	a(2) <= (NOT w(2) AND NOT x(2) AND NOT y(2) AND z(2)) OR (w(2) AND NOT x(2) AND y(2) AND z(2)) OR (x(2) AND NOT y(2) AND NOT z(2)) OR (w(2) AND x(2) AND NOT y(2));
	b(2) <= (NOT w(2) AND x(2) AND NOT y(2) AND z(2)) OR (x(2) AND y(2) AND NOT z(2)) OR (w(2) AND x(2) AND NOT z(2)) OR (w(2) AND y(2) AND z(2));
	c(2) <= (NOT w(2) AND NOT x(2) AND y(2) AND NOT z(2)) OR (w(2) AND x(2) AND NOT z(2)) OR (w(2) AND x(2) AND y(2));
	d(2) <= (NOT x(2) AND NOT y(2) AND z(2)) OR (NOT w(2) AND x(2) AND NOT y(2) AND NOT z(2)) OR (x(2) AND y(2) AND z(2)) OR (w(2) AND NOT x(2) AND y(2) AND NOT z(2));
	e(2) <= (NOT w(2) AND z(2)) OR(NOT w(2) AND x(2) AND NOT y(2)) OR (NOT x(2) AND NOT y(2) AND z(2));
	f(2) <= (NOT w(2) AND NOT x(2) AND z(2)) OR (NOT w(2) AND NOT x(2) AND y(2)) OR (NOT w(2) AND y(2) AND z(2)) OR (w(2) AND x(2) AND NOT y(2));
	g(2) <= (NOT w(2) AND NOT x(2) AND NOT y(2)) OR (NOT w(2) AND x(2) AND y(2) AND z(2));
END logic_fun;