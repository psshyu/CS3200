function [x, w] = CompTrapezoidPairs(a,b,N)
% a = first point of integral 
% b = final point of interval
% N = number of intervals
% f = Function 
    w = zeros(N,1);
    x = zeros(N,1);
    delta_x = (b-a)/(N-1);              % change in x calculation
    wi_ends = delta_x/2;                % wi value for i = 1, N
    wi = delta_x;                       % wi value for all other i 
    
    %f = @(x) f;                         % parses the function so it's usable 
    %summation = 0;                      % set the summation to 0
    
    % i = 1 calculations
    x1 = a;                             % x1 = a + (1 - 1) * delta_x; 
    w1 = wi_ends;
    x(1) = x1;
    w(1) = w1;
    %summation = summation + w1*f(x1);
    
    % i calculations where i != 1 or N
    for i = 2:N-1
        xi = a + (i - 1) * delta_x; 
        x(i) = xi;
        w(i) = wi;
        %summation = summation + wi*f(xi);
        %fprintf('%i ', i);
    end
    
    % i = N calculation
    xN = a + (N - 1) * delta_x;
    wN = wi_ends;
    x(N) = xN;
    w(N) = wN;
    %summation = summation + wN*f(xN);
end
