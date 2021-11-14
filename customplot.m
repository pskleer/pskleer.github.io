figure                          % create a new figure
x = 0.1:0.1:7;
plot(x, 1./x, 'r--', 'linewidth', 2); % set line color, line style and
                                      % line width
hold on                         % add the next plot in the same figure (axes)

% With fplot we only have to specify the function and the range instead of
% the x-y vectors.
fplot(@(x) sin(x)./x, [-7 7], 'b');

grid on                         % add x- and y- grid lines
axis([-7 7 -2 4]);              % change visible axis

% Change the default location and labels of the x-axis.
set(gca, 'xtick', pi*(-2:2));
set(gca, 'xticklabel', {'-2pi', 'pi', '0', 'pi', '2pi'});

% Add some labels
title('Example plot');
xlabel('Input');
ylabel('Output');
legend('Hyperbola', 'Damped sine', ...
       'Location', 'NorthWest'); % force the location of the legend
