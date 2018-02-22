a = 0;
b = 2*pi;                           
N = [17 33 65 129 257 513];         % all the different Ns we need to calculate
integralMid = zeros(numel(N),1);
integralTrap = zeros(numel(N),1);
integralSimp = zeros(numel(N),1);
integralTrue = zeros(numel(N),1);
iplot = 0;                          % figure iterator

func = @(x)(1+sin(x).*cos(2.*x./3).*sin(4.*x)); %f(x) as given in Question 3

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
    

    %{
    fMid = func(xMid);
    fTrap = func(xTrap);
    fSimp = func(xSimp);
    % generate plots
    iplot = iplot + 1;
    figure(iplot)                     % new figure

    plot(xMid, fMid, '-', xTrap, fTrap, 'ob', xSimp, fSimp, 'or');% plotting the errors of polyinterp  
    legend show;                      % of equidistant and cheby points
    legend('Midpoint Rule', 'Trapezoid Rule', 'Simpson Rule');
    grid on;
    title(sprintf('Newton-Cotes Covergence (N = %2.0f)', N_parts));
    %}
    

end

    % generate plots
    iplot = iplot + 1;
    figure(iplot)                     % new figure

    plot(N, integralMid, '-', N, integralTrap, '.-', N, integralSimp, '--', N, integralTrue, 'g');
    legend show;                      % of equidistant and cheby points
    legend('Midpoint Rule', 'Trapezoid Rule', 'Simpson Rule');
    grid on;
    title(sprintf('Newton-Cotes Covergence Across N partitions'));

