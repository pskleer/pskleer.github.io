t = 0:.1:2*pi;
x = t.^3.*sin(3*t).*exp(-t);
y = t.^3.*cos(3*t).*exp(-t);
z = t.^2;
plot3(x,y,z); grid on
