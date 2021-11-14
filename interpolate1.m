x = [0 1 3 5 6 8 10]';
y = sin(x);
v = (0:.1:10)';
f = [interp1(x,y,v,'linear'), ...
     interp1(x,y,v,'spline'), ...
     interp1(x,y,v,'cubic')];
h = plot(x, y, '.', v, f);
set(h(1), 'markersize', 18); grid on
legend('Data', 'Linear', 'Spline', 'Cubic', 'Location', 'North');
