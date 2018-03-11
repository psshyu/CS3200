a = 0; b = 2*pi;     % the domain we integrate over                             
N = [2 3 4 5];         % all the different Ns we need to calculate

% Save parameters
folder = 'C:\Users\Skylar\Documents\GitHub\CS3200\Assignment2\output';

% Pre-emptively creating vectors full of zeros for later use below
integralGauss = zeros(numel(N),1);
integralTrue = zeros(numel(N),1);
errorGauss = zeros(numel(N),1);
syms x                          % define symbolic variables
f = 1+sin(x).*cos(2.*x./3).*sin(4.*x); % symbolic function
func = matlabFunction(f);       % @(x)(f)... making it usable as a function handler
xrange = a:b;                   % range of [a b] for error derivatives

for idx = 1:numel(N)                % for loop to go thru all N-values
    N_parts = N(idx);               % goes thru each N
    integralGauss(idx) = GaussianQuad(a,b,N_parts,func); % calculates Gaussian Quadrature Integration
    integralTrue(idx) = integral(func,a,b);  % calculates true integration value
    errorGauss(idx)= integralTrue(idx) - integralGauss(idx);
end

figure('Name', 'Gaussian Quadrature Convergence')   % figure title   
plot(N, integralGauss, '-', N, integralTrue, 'g');  % plotting Composite Gaussian Integration against the true Integral, over N
legend show;                                        % show legend
legend('Gaussian Quadrature', 'True Integration');  % label legend
grid on;                                            % show grid
title(sprintf('Gaussian Covergence to True Integral with respect to N-partitions')); % plot title
xlabel('N')                                         % x-axis label
ylabel('Integration Values')                        % y-axis label
saveas(gcf, fullfile(folder, sprintf('GaussQuadConv')), 'jpg');

figure('Name', 'Gaussian Quadrature Error Convergence')   % figure title   
plot(N, errorGauss, '-');  % plotting Composite Gaussian Integration Error against 0 Error, over N
legend show;                                        % show legend
legend('Gaussian Quadrature Error');                % label legend
grid on;                                            % show grid
title(sprintf('Gaussian Error Covergence to 0 Error with Respect to N-partitions')); % plot title
xlabel('N')                                         % x-axis label
ylabel('Error of Integration Values')                        % y-axis label
saveas(gcf, fullfile(folder, sprintf('ErrorGaussQuadConv')), 'jpg');
