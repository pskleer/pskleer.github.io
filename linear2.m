%% First create some data to work with
beta = [1 -1 1]';               % the true coefficients
m = 5;                          % number of observations
sigma = 0.02;                   % st.dev
x = rand(m,1);                  % the locations of the observations
X = [x.^2, x, ones(m,1)]        % data/regression matrix
y = X*beta + normrnd(0, sigma, m, 1); % the perturbed y-values

%% Do the regression and some analysis
b = X\y;                        % estimate beta
yhat = X*b;                     % predictions
e = y - yhat;                   % errors
sigmahat = sqrt(e'*e/(m-length(b))); % estimate for sigma

% Display results
fprintf(1, 'Coefficients (true and estimated)\n');
fprintf(1, '%8g %8.4f\n', [beta, b]');
fprintf(1, '\nStandard deviation (true and estimated)\n');
fprintf(1, '%8g %8.4f\n', [sigma, sigmahat]');

%% Do some visualization
fun = @(x,beta) beta(1)*x.^2 + beta(2)*x + beta(3);

figure;
%plot(x, y, 'k.', 'markersize', 12);
scatter(x, y, 'k', 'filled');
hold on
fplot(@(x) fun(x,beta), [0 1], 'r');
fplot(@(x) fun(x,b), [0 1], 'b');

legend('Observations', 'True function', 'Estimated function');
