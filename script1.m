% It is often a good idea to start your script with a CLEAR statement,
% which clears the workspace.
clear

% Initialize parameters
n = 10000;
m = [10; 50; 100; 500; 1000; 5000; 10000];

% Put random number generator in default state for reproducibility
rng('default')

% Get random sample of standard normal distribution
x = randn(n, 1);

for i = 1:length(m)

    % Calculate 95% confidence interval for certain sample size
    y = x(1:m(i));
    mu = mean(y);
    sigma = std(y);
    ci = mu + norminv(0.975) * sigma / sqrt(m(i)) * [-1, 1];
    
    % Print result
    fprintf('n = %5d: [%8.4f, %8.4f]\n', m(i), ci);
    
end

