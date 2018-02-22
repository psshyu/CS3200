a = 0;
b = 2*pi;                           
N = [17 33 65 129 257 513];         % all the different Ns we need to calculate

integralMid = zeros(numel(N),1);
integralTrap = zeros(numel(N),1);
integralSimp = zeros(numel(N),1);
integralTrue = zeros(numel(N),1);

errorTrap = zeros(numel(N),1);
errorSimpson = zeros(numel(N),1);
errorRichardson = zeros(numel(N),1);

iplot = 0;                          % figure iterator

syms x                          % define symbolic variables
f = 1+sin(x).*cos(2.*x./3).*sin(4.*x); % symbolic function
func = matlabFunction(f);
xrange = a:b;                   % range of [a b] for error derivatives

% TRAPEZOID ERROR ESTIMATION SET-UP
f2 = diff(f,2);                 % get the 2nd derivative of f
func2 = matlabFunction(f2);     % make it into a function handle
y2 = func2(xrange);             % get 2nd derivative values over [a, b]
[f2_eta, idx2] = max(y2);       % get the max value (f2_eta) and ensure
                                % that it (idx2) is between a and b

                                
% SIMPSON'S RULE ESTIMATION SET-UP
f4 = diff(f,4);                 % pretty much the same as above, but using
func4 = matlabFunction(f4);     % the 4th derivative
y4 = func4(xrange);
[f4_eta, idx4] = max(y4);


for idx = 1:numel(N)                % for loop to go thru all N-values
    N_parts = N(idx);               % goes thru each N
    % generate {xi, wi} pairs for the 3 Newton-Cotes formulas
    [xMid, wMid] = QuadSchemeMidpoint(a,b,N_parts);
    [xTrap, wTrap] = QuadSchemeTrapezoid(a,b,N_parts);
    [xSimp, wSimp] = QuadSchemeSimpson(a,b,N_parts);
    integralMid(idx) = weightPairSum(func, xMid, wMid);
    integralTrap(idx) = weightPairSum(func, xTrap, wTrap);
    integralSimp(idx) = weightPairSum(func, xSimp, wSimp);
    integralTrue(idx) = integral(func, a, b);
    
    delta_x_trap = (b - a)/(N_parts-1);
    delta_x_simpson = (b - a)/(2.*N_parts);
    delta_x_richardson = 1;
    errorTrap(idx) = ((b - a)/12).*(delta_x_trap.^2).*f2_eta;
    errorSimpson(idx) = ((b - a)/2880).*(delta_x_simpson.^4).*f4_eta;
    errorRichardson(idx) = 0;
end

% generate plots
iplot = iplot + 1;
figure(iplot)                     % new figure
plot(N, integralMid, '-', N, integralTrue, 'g');
legend show;                      % of equidistant and cheby points
legend('Midpoint Rule', 'True Integration');
grid on;
title(sprintf('Midpoint Rule Covergence to True Integral Across N-partitions'));

iplot = iplot + 1;
figure(iplot)                     % new figure
plot(N, integralTrap, '-', N, integralTrue, 'g');
legend show;                      % of equidistant and cheby points
legend('Trapezoid Rule', 'True Integration');
grid on;
title(sprintf('Trapezoid Rule Covergence to True Integral Across N-partitions'));

iplot = iplot + 1;
figure(iplot)                     % new figure
plot(N, integralSimp, '-', N, integralTrue, 'g');
legend show;                      % of equidistant and cheby points
legend("Simpson's Rule", 'True Integration');
grid on;
title(sprintf("Simpson's Formula Covergence to True Integral Across N-partitions"));




    