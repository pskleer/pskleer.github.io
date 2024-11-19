function [X,f] = knapsack_error(v, w, c)
% KNAPSACK Solves the unbounded knapsack problem using dynamic programming
%
%   [X,f] = knapsack(v, w, c)
%
% In the unbounded knapsack problem the number of items for each type is
% unlimited.
%
% | Input | Description                             |
% |-------+-----------------------------------------|
% | v     | Vector with item values (>=0)           |
% | w     | Vector with item weights (integer, >=0) |
% | c     | Knapsack capacity (integer, >=0)        |
%
% | Output | Description                          |
% |--------+--------------------------------------|
% | X      | Assignment matrix for all capacities |
% | f      | Value vector for all capacities      |

%% Error checking
if ~isvector(v) || ~isvector(w) || length(v)~=length(w)
  error('The values and weights must be vectors of the same dimension.');
end

if any(v<0)
  error('All values must be nonnegative');
end

if any(w<0) || any(w~=round(w))
  error('All weights must be nonnegative integers');
end

if c<0 || c~=round(c)
  error('The capacity must be a nonnegative integer');
end

%% Initialize
n = length(v);
X = zeros(c+1, n);              % assignment for capacity k-1
f = zeros(c+1, 1);              % f(k) = optimal value for capacity k-1
g = repmat(0, 1, n);

%% Dynamic programming: loop over all capacities from 1 to c
for k = 1:c

  % Check which items can be included for this capacity
  i = (k >= w);

  % If we use item i then the total value is the value of item i plus the
  % value of the remaining capacity.
  g(i) = v(i) + f(c-w(i)+1)';

  % Get the item with the highest value
  [maxg, j] = max(g);

  if maxg > f(k)
    % Result is better than the result for capacity k-1
    f(k+1) = maxg;
    X(k+1,:) = X(c-w(j)+1,:);
    X(k+1,j) = X(k+1,j)+1;
  else
    % Keep result for capacity k-1
    f(k+1) = f(k);
    X(k+1,:) = X(k,:);
  end

end

% Remove capacity 0
f = f(2:end);
X = X(2:end,:);
