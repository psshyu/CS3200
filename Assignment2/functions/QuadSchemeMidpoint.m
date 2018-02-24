function [x, w] = QuadSchemeMidpoint(a,b,N)
    % This function returns 2 vectors, x and w, which are the values
    % of xi and wi as obtained via composite midpoint rule. Note that
    % this doesn't calculate any summations.
    
    % a = first point of integral 
    % b = final point of interval
    % N = number of intervals
    
    w = zeros(N,1);                     % pre-allocate vector sized N for wi values
    x = zeros(N,1);                     % pre-allocate vector sized N for xi values
    
    delta_x = (b-a)/N;                  % change in x calculation
    wi = delta_x;                       % wi value for all other i 
    
    %f = @(x) f;                        % parses the function so it's usable 
    %summation = 0;                     % set the summation to 0
    
    % i calculations from i = 1 to  N
    for i = 1:N                       % loops i-values between 2 and N-1
        xi = a + (i - 0.5) * delta_x;     % calculates xi
        x(i) = xi;                      % appends xi value to x vector
        w(i) = wi;                      % appends wi value to w vector
    end
    
    x = x';                             % transposition of x vector
    w = w';                             % transposition of w vector
end
