function [y, trimmed] = trim_data(x, fraction, tail)
% TRIM_DATA Trims the tails of input vector
%
% y = trim_data(x, fraction, tail)
%
% For a numerical vector trims aways a certain percentage of the lowest
% and/or highest observations.
% 
% |----------+-----------------------------------------------------------|
% | Input    | Description                                               |
% |----------+-----------------------------------------------------------|
% | x        | vector with numerical data                                |
% | fraction | fraction of observations to trim away (default: 0.2)      |
% | tail     | 0: trim away high and low observations (default)          |
% |          | 1: trim away high observations only ...                   |
% |          | -1: trim away low observations only                       |
% |----------+-----------------------------------------------------------|
% |----------+-----------------------------------------------------------|
% | Output   | Description                                               |
% |----------+-----------------------------------------------------------|
% | y        | sorted vector with observations that are not trimmed away |
% | trimmed  | the trimmed observations                                  |
% |----------+-----------------------------------------------------------|

if nargin < 2 || isempty(fraction)
  % Default trim 20%.
  fraction = 0.2;
end

if nargin < 3 || isempty(tail)
  % Default trim high and low observations.
  tail = 0;
end

if tail == 0
  % Convert to one-sided fraction.
  fraction = fraction / 2;
end

x = sort(x);
n = length(x);

% Compute the number of observations to trim per tail.
k = floor(fraction * n);

switch tail
case 1
  % Trim high observations.
  y = x(1:end-k);
case -1
  % Trim low observations.
  y = x(k+1:end);
otherwise
  % Trim high and low observations.
  y = x(k+1:end-k);
end

% If second output argument required, then return the trimmed values.
if nargout > 1
  switch tail
  case 1
    trimmed = x(end-k+1:end);
  case -1
    trimmed = x(1:k);
  otherwise
    trimmed = x([1:k, end-k+1:end]);
  end
end
