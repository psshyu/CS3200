a = 0; b = 2 * pi;     % the domain we integrate over                             
N = [2 3 4 5];         % all the different Ns we need to calculate

% Pre-emptively creating vectors full of zeros for later use below
integralGauss = zeros(numel(N),1);
integralTrue = zeros(numel(N),1);

syms x                          % define symbolic variables
f = 1+sin(x).*cos(2.*x./3).*sin(4.*x); % symbolic function
func = matlabFunction(f);       % @(x)(f)... making it usable as a function handler
xrange = a:b;                   % range of [a b] for error derivatives

for idx = 1:numel(N)                % for loop to go thru all N-values
    N_parts = N(idx);               % goes thru each N
    integralGauss(idx) = GaussianQuad(a,b,N_parts,func); % calculates Gaussian Quadrature Integration
    integralTrue(idx) = integral(func,a,b);  % calculates true integration value
end

figure('Name', 'Gaussian Quadrature Convergence')   % figure title   
plot(N, integralGauss, '-', N, integralTrue, 'g');  % plotting Composite Gaussian Integration against the true Integral, over N
legend show;                                        % show legend
legend('Gaussian Quadrature', 'True Integration');  % label legend
grid on;                                            % show grid
title(sprintf('Gaussian Covergence to True Integral with respect to N-partitions')); % plot title
xlabel('N')                                         % x-axis label
ylabel('Integration Values')                        % y-axis label
