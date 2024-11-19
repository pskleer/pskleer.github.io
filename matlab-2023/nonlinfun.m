function [f,Jf] = nonlinfun(a,x)

% We split the computation, because we can reuse the results in the Jacobian
% evaluation.
y = exp(a(2)*x);
f = a(1)*y;

% Return the Jacobian only if asked for
if nargout > 1
  Jf = [y, x.*f];
end
