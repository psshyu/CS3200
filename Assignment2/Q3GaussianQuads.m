a = 0;
b = 2 * pi;                           
N = [2 3 4 5];         % all the different Ns we need to calculate

integralGauss = zeros(numel(N),1);
integralTrue = zeros(numel(N),1);
iplot = 0;                          % figure iterator


syms x                          % define symbolic variables
f = 1+sin(x).*cos(2.*x./3).*sin(4.*x); % symbolic function
func = matlabFunction(f);       % @(x)(f)
xrange = a:b;                   % range of [a b] for error derivatives

for idx = 1:numel(N)                % for loop to go thru all N-values
    N_parts = N(idx);               % goes thru each N
    integralGauss(idx) = GaussianQuad(a,b,N_parts,func);
    integralTrue(idx) = integral(func,a,b);
end

iplot = iplot + 1;
figure(iplot)                     % new figure
plot(N, integralGauss, '-', N, integralTrue, 'g');
legend show;                      % of equidistant and cheby points
legend('Gauss Quadrature', 'True Integration');
grid on;
title(sprintf('Gaussian Covergence to True Integral Across N-partitions'));


    