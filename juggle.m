echo on

x = 1:6
x = repmat(x, 6, 1)
x = reshape(x, 2, 3, 3, 2)
x = permute(x, [1 3 2 4])
x = reshape(x, [6 6])
x = x'

echo off
