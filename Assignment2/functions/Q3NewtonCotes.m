a = 0; b = 2 * pi;                  % the domain we integrate over       
N = [17 33 65 129 257 513];         % all the different Ns we need to calculate

% Pre-emptively creating vectors full of zeros for later use below
integralMid = zeros(numel(N),1);
integralTrap = zeros(numel(N),1);
integralSimp = zeros(numel(N),1);
integralTrap2N = zeros(numel(2*N),1);
integralSimp2N = zeros(numel(2*N),1);
integralTrue = zeros(numel(N),1);
errorTrap = zeros(numel(N),1);
errorSimpson = zeros(numel(N),1);
errorTrapRichard = zeros(numel(N),1);
errorSimpRichard = zeros(numel(N),1);
errorRichardson = zeros(numel(N),1);
zeroError = zeros(numel(N),1);

% Save figure parameters
folder = 'C:\Users\Skylar\Documents\GitHub\CS3200\Assignment2\output';

syms x                                  % define symbolic variables
f = 1+sin(x).*cos(2.*x./3).*sin(4.*x);  % symbolic function
func = matlabFunction(f);               % make the above function into a useable function handle
xrange = a:b;                           % range of [a b] for error derivatives

for idx = 1:numel(N)                % for loop to go thru all N-values
    N_parts = N(idx);               % goes thru each N
    % generate {xi, wi} pairs for the 3 Newton-Cotes formulas
    [xMid, wMid] = QuadSchemeMidpoint(a,b,N_parts);     % Midpoint Rule pairs
    [xTrap, wTrap] = QuadSchemeTrapezoid(a,b,N_parts);  % Trapezoid Rule pairs
    [xSimp, wSimp] = QuadSchemeSimpson(a,b,N_parts);    % Simpson's Formula pairs
    
    % Perform Composite Integration (it's a summation, really) for the 3
    % Newton-Cotes methods. More details about weightPairSum() function can
    % be found in weightPairSum.m
    integralMid(idx) = weightPairSum(func, xMid, wMid); % Midpoint Sum
    integralTrap(idx) = weightPairSum(func, xTrap, wTrap); % Trapezoid sum
    integralSimp(idx) = weightPairSum(func, xSimp, wSimp); % Simpson's sum
    
    % This is the EXACT integration of the function over [a b]. We commonly
    % called this I_exact in class
    integralTrue(idx) = integral(func, a, b);
    
    % Estimating the derivatives and using explicit forms of error
    % Trapezoid Rule Derivative Estimation
    delta_x_trap = (b - a)/(N_parts-1); % change in x for trapezoid rule
    f2 = diff(f,2);                 % get the 2nd derivative of f
    func2 = matlabFunction(f2);     % make it into a function handle
    y2 = func2(xrange);             % get 2nd derivative values over [a, b]
    [f2_eta, idx2] = max(y2);       % get the max value (f2_eta) and ensure
                                    % that it (idx2) is between a and b

    % Simpson's Rule Derivative Estimation
    delta_x_simpson = (b - a)/(2.*N_parts); %change in x for simpson's rule
    f4 = diff(f,4);                 % pretty much the same as above, but using
    func4 = matlabFunction(f4);     % the 4th derivative where it was 2nd derivative
    y4 = func4(xrange);
    [f4_eta, idx4] = max(y4);
    
    % Explicit Error Calculations 
    errorTrap(idx) = ((b - a)/12).*(delta_x_trap.^2).*f2_eta;
    errorSimpson(idx) = ((b - a)/2880).*(delta_x_simpson.^4).*f4_eta;
    
    % Error Calculations Using Richardson's Exterpolation
    [xTrap2N, wTrap2N] = QuadSchemeTrapezoid(a,b,N_parts*2);  % Trapezoid Rule pairs w/ 2*N subintervals
    [xSimp2N, wSimp2N] = QuadSchemeSimpson(a,b,N_parts*2);    % Simpson's Formula pairs w/ 2*N subintervals
    integralTrap2N(idx) = weightPairSum(func, xTrap2N, wTrap2N); % Trapezoid sum w/ 2N subintervals
    integralSimp2N(idx) = weightPairSum(func, xSimp2N, wSimp2N); % Simpson's sum w/ 2N subintervals
    errorTrapRichard(idx) = RichardsonExtrap(integralTrap(idx), integralTrap2N(idx));
    errorSimpRichard(idx) = RichardsonExtrap(integralSimp(idx), integralSimp2N(idx));
end

% Error vectors via subtracting the exact integral by the composite
% integrals generated above. To be used in the convergence error plot. 
errorConvergeMid = integralTrue - integralMid; 
errorConvergeTrap = integralTrue - integralTrap;
errorConvergeSimp = integralTrue - integralSimp;

% generate plots
% Convergence plot showing Composite Midpoint Rule and the exact integral
figure('Name', 'Midpoint Rule Convergence')         % figure title              
plot(N, integralMid, '-', N, integralTrue, 'g');    % plotting Composite Midpoint against true integration
legend show;                                        % show legends!
legend('Composite Midpoint Rule', 'True Integration'); % set legends
grid on;                                            % turn grids on
title(sprintf('Composite Midpoint Rule Covergence to True Integral with Respect to N-partitions')); % plot title
xlabel('N')                                         % x-axis label
ylabel('Integration Values')                        % y-axis label
saveas(gcf, fullfile(folder, sprintf('MidRuleConv')), 'jpg');

% Convergence plot showing Composite Midpoint Rule Error nearing y=0
figure('Name', 'Composite Midpoint Rule Error Convergence')         % figure title              
plot(N, errorConvergeMid, '-');                     % plotting Composite Midpoint error against error = 0
legend show;                                        % show legends!
legend('Composite Midpoint Rule Error');            % set legends
grid on;                                            % turn grids on
title(sprintf('Composite Composite Midpoint Rule Error Covergence to 0 with Respect to N-partitions')); % plot title
xlabel('N')                                         % x-axis label
ylabel('Error Yielded by Integration Values')       % y-axis label
saveas(gcf, fullfile(folder, sprintf('ErrorMidRuleConv')), 'jpg');

% Convergence plot showing Composite Trapezoid Rule and the exact integral
figure('Name', 'Composite Trapezoid Rule Convergence')        % figure title              
plot(N, integralTrap, '-', N, integralTrue, 'g');   % plotting Composite Trapezoid against true integration
legend show;                                        % show legends!
legend('Composite Trapezoid Rule', 'True Integration'); % set legends
grid on;                                            % turn grids on
title(sprintf('Composite Trapezoid Rule Covergence to True Integral with Respect to N-partitions')); % plot title
xlabel('N')                                         % x-axis label
ylabel('Integration Values')                        % y-axis label
saveas(gcf, fullfile(folder, sprintf('TrapRuleConv')), 'jpg');

% Convergence plot showing Composite Trapezoid Rule Error nearing y=0
figure('Name', 'Composite Trapezoid Rule Error Convergence')         % figure title              
plot(N, errorConvergeTrap, '-');                    % plotting Composite Trapezoid error against error = 0
legend show;                                        % show legends!
legend('Composite Trapezoid Rule Error');           % set legends
grid on;                                            % turn grids on
title(sprintf('Composite Trapezoid Rule Error Covergence to 0 with Respect to N-partitions')); % plot title
xlabel('N')                                         % x-axis label
ylabel('Error Yielded by Integration Values')       % y-axis label
saveas(gcf, fullfile(folder, sprintf('ErrorTrapRuleConv')), 'jpg');

% Convergence plot showing Composite Simpson's Formula and the exact integral
figure('Name', "Composite Simpson's Rule Convergence")        % figure title                 
plot(N, integralSimp, '-', N, integralTrue, 'g');   % plotting Composite Simpson's against true integration
legend show;                                        % show legends!
legend("Composite Simpson's Rule", 'True Integration'); % set legends
grid on;                                            % turn grids on
title(sprintf("Composite Simpson's Formula Covergence to True Integral with Respect to N-partitions")); % plot title
xlabel('N')                                         % x-axis label
ylabel('Integration Values')                        % y-axis label
saveas(gcf, fullfile(folder, sprintf('SimpsonFormConv')), 'jpg');

% Convergence plot showing Composite Simpson's Error nearing y=0
figure('Name', 'Composite Simpson Formula Error Convergence')         % figure title              
plot(N, errorConvergeTrap, '-');                    % plotting Composite Simpson's error against error = 0
legend show;                                        % show legends!
legend('Composite Simpson Formula Error');          % set legends
grid on;                                            % turn grids on
title(sprintf('Composite Simpson Formula Error Covergence to 0 with Respect to N-partitions')); % plot title
xlabel('N')                                         % x-axis label
ylabel('Error Yielded by Integration Values')       % y-axis label
saveas(gcf, fullfile(folder, sprintf('ErrorSimpsonFormConv')), 'jpg');