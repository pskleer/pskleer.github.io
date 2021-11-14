% Define function and true parameter
a = [4; -1];
truefun = @(x)(nonlinfun(a,x)); % the true function

% Create a data set
x = (0:0.1:1)';
y = truefun(x) + 0.3*randn(size(x)); % add some noise

%% Try to estimate parameter 'a' using data (x,y)

% initial estimate, no lower/upper bounds
a0 = [1; 1]; lb = []; ub = [];

% Change some solver options: gradient is specified as second output
% argument of function (SpecifyObjectiveGradient) and check whether this
% gradient is correct (CheckGradients)
opt = optimoptions('lsqcurvefit', ...
                   'Display', 'iter', ...
                   'SpecifyObjectiveGradient', true, ...
                   'CheckGradients', true);

% Estimate 'a'
ahat = lsqcurvefit(@nonlinfun, a0, x, y, lb, ub, opt);

% Anonymous function for the estimated function by pluggin in the estimate
estimfun = @(x) nonlinfun(ahat,x);

% Plot the results
clf; plot(x, y, '.');
hold on; grid on
fplot(truefun, [0 1], 'r');
fplot(estimfun, [0 1], 'm');
legend('data', 'true function', 'estimated function');
