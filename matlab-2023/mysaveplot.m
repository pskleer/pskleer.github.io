function mysaveplot(h, overwrite)
% MYSAVEPLOT

if nargin < 1 || isempty(h)
  h = gcf;
end

if nargin < 2
  overwrite = 0;
end

PS = [10 7];
PP = [0 0 PS];

set(h, ...
    'paperpositionmode', 'manual', ...
    'paperposition', PP, ...
    'papersize', PS, ...
    'paperunits', 'centimeters');

[new,old] = nextfile('plot.png');
if overwrite
  filename = old;
else
  filename = new;
end

print(h, '-dpng', filename);
fprintf(1, 'Saved plot to %s\n', filename);
