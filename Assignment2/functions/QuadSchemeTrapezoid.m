function [x, w] = QuadSchemeTrapezoid(a,b,N)
    % This function returns 2 vectors, x and w, which are the values
    % of xi and wi as obtained via composite trapezoid rule. Note that
    % this doesn't calculate any summations.
    
    % a = first point of integral 
    % b = final point of interval
    % N = number of intervals
    
    w = zeros(N,1);                     % pre-allocate vector sized N for wi values
    x = zeros(N,1);                     % pre-allocate vector sized N for xi values
    delta_x = (b-a)/(N-1);              % change in x calculation
    wi_ends = delta_x/2;                % wi value for i = 1, N
    wi = delta_x;                       % wi value for all other i 
    
    %f = @(x) f;                        % parses the function so it's usable 
    %summation = 0;                     % set the summation to 0
    
    % i = 1 calculations
    x1 = a;                             % x1 = a + (1 - 1) * delta_x; 
    x(1) = x1;                          % appends x1 value to x vector
    w(1) = wi_ends;                     % appends w1 value to w vector
    
    % i calculations where i != 1 or N
    for i = 2:N-1                       % loops i-values between 2 and N-1
        xi = a + (i - 1) * delta_x;     % calculates xi
        x(i) = xi;                      % appends xi value to x vector
        w(i) = wi;                      % appends wi value to w vector
    end
    
    % i = N calculation
    xN = a + (N - 1) * delta_x;         % calculates xN value                       
    x(N) = xN;                          % appends xN value to x vector
    w(N) = wi_ends;                     % appends wN value to w vector
    
    x = x';                             % transposition of x vector
    w = w';                             % transposition of w vector
end
