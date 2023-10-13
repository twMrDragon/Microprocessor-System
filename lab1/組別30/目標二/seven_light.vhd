library IEEE;
use IEEE.std_logic_1164.all;
entity seven_light is
	port(w,x,y,z : in std_logic_vector(0 to 2);
		  a,b,c,d,e,f,g:out std_logic_vector(0 to 2));
end seven_light;

architecture logic_fun of seven_light is
begin

a(0)<=(not w(0) and not x(0) and not y(0) and z(0)) or (w(0) and not x(0) and y(0) and z(0)) or (x(0) and not y(0) and not z(0)) or (w(0) and x(0) and not y(0));
b(0)<=(not w(0) and x(0) and not y(0) and z(0)) or (x(0) and y(0) and not z(0)) or (w(0) and x(0) and not z(0)) or (w(0) and y(0) and z(0));
c(0)<=(not w(0) and not x(0) and y(0) and not z(0)) or (w(0) and x(0) and not z(0))or (w(0) and x(0) and y(0));
d(0)<=(not x(0) and not y(0) and z(0)) or (not w(0) and x(0) and not y(0) and not z(0))or (x(0) and y(0) and z(0))or (w(0) and not x(0) and y(0) and not z(0));
e(0)<=(not w(0) and z(0)) or(not w(0) and x(0) and not y(0))or(not x(0) and not y(0) and z(0));
f(0)<=(not w(0) and not x(0) and z(0))or(not w(0) and not x(0) and y(0)) or (not w(0) and y(0) and z(0))or(w(0) and x(0) and not y(0));
g(0)<=(not w(0) and not x(0)  and not y(0))or (not w(0) and x(0) and y(0) and z(0));

a(1)<=(not w(1) and not x(1) and not y(1) and z(1)) or (w(1) and not x(1) and y(1) and z(1)) or (x(1) and not y(1) and not z(1)) or (w(1) and x(1) and not y(1));
b(1)<=(not w(1) and x(1) and not y(1) and z(1)) or (x(1) and y(1) and not z(1)) or (w(1) and x(1) and not z(1)) or (w(1) and y(1) and z(1));
c(1)<=(not w(1) and not x(1) and y(1) and not z(1)) or (w(1) and x(1) and not z(1))or (w(1) and x(1) and y(1));
d(1)<=(not x(1) and not y(1) and z(1)) or (not w(1) and x(1) and not y(1) and not z(1))or (x(1) and y(1) and z(1))or (w(1) and not x(1) and y(1) and not z(1));
e(1)<=(not w(1) and z(1)) or(not w(1) and x(1) and not y(1))or(not x(1) and not y(1) and z(1));
f(1)<=(not w(1) and not x(1) and z(1))or(not w(1) and not x(1) and y(1)) or (not w(1) and y(1) and z(1))or(w(1) and x(1) and not y(1));
g(1)<=(not w(1) and not x(1)  and not y(1))or (not w(1) and x(1) and y(1) and z(1));

a(2)<=(not w(2) and not x(2) and not y(2) and z(2)) or (w(2) and not x(2) and y(2) and z(2)) or (x(2) and not y(2) and not z(2)) or (w(2) and x(2) and not y(2));
b(2)<=(not w(2) and x(2) and not y(2) and z(2)) or (x(2) and y(2) and not z(2)) or (w(2) and x(2) and not z(2)) or (w(2) and y(2) and z(2));
c(2)<=(not w(2) and not x(2) and y(2) and not z(2)) or (w(2) and x(2) and not z(2))or (w(2) and x(2) and y(2));
d(2)<=(not x(2) and not y(2) and z(2)) or (not w(2) and x(2) and not y(2) and not z(2))or (x(2) and y(2) and z(2))or (w(2) and not x(2) and y(2) and not z(2));
e(2)<=(not w(2) and z(2)) or(not w(2) and x(2) and not y(2))or(not x(2) and not y(2) and z(2));
f(2)<=(not w(2) and not x(2) and z(2))or(not w(2) and not x(2) and y(2)) or (not w(2) and y(2) and z(2))or(w(2) and x(2) and not y(2));
g(2)<=(not w(2) and not x(2)  and not y(2))or (not w(2) and x(2) and y(2) and z(2));
end logic_fun;
