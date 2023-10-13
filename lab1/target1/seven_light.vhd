library IEEE;
use IEEE.std_logic_1164.all;
entity seven_light is
	port(w,x,y,z : in bit;
		  a,b,c,d,e,f,g:out bit);
end seven_light;

architecture logic_fun of seven_light is
begin

a<=(not w and not x and not y and z) or (w and not x and y and z) or (x and not y and not z) or (w and x and not y);
b<=(not w and x and not y and z) or (x and y and not z) or (w and x and not z) or (w and y and z);
c<=(not w and not x and y and not z) or (w and x and not z)or (w and x and y);
d<=(not x and not y and z) or (not w and x and not y and not z)or (x and y and z)or (w and not x and y and not z);
e<=(not w and z) or(not w and x and not y)or(not x and not y and z);
f<=(not w and not x and z)or(not w and not x and y) or (not w and y and z)or(w and x and not y);
g<=(not w and not x  and not y)or (not w and x and y and z);
end logic_fun;
