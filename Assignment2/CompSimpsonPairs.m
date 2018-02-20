function [x, w] = CompSimpsonPairs(a,b,N)
    % This function returns 2 vectors, x and w, which are the values
    % of xi and wi as obtained via composite Simpson formula. Note that
    % this doesn't calculate any summations.
    % a = first point of integral 
    % b = final point of interval
    % N = number of intervals
    
    w = zeros(2*N + 1,1);               % pre-allocate vector sized N for wi values
    x = zeros(2*N + 1,1);               % pre-allocate vector sized N for xi values

    delta_x = (b-a)/(2*N);              % change in x calculation

    wi_ends = delta_x/3;                % wi value when i = 1, 2N+1
    wi_even = 4*delta_x/3;              % wi value when i is even 
    wi_odd = 2*delta_x/3;               % wi value when i is odd
    
    % i = 1 calculations
    x1 = a;                             % x1 = a + (1 - 1) * delta_x; 
    x(1) = x1;                          % appends x1 value to x vector
    w(1) = wi_ends;                     % appends w1 value to w vector
    
    % i calculations where i != 1 or N
    for n = 1:N                         % loops values between 1 and N
        even_i = n * 2;
        x_even_i = a + (even_i - 1) * delta_x;     % calculates xi
        x(even_i) = x_even_i;                      % appends xi to x vector
        w(even_i) = wi_even;                       % appends wi to w vector
        
        odd_i = n * 2 + 1;
        x_odd_i = a + (odd_i - 1) * delta_x;     % calculates xi
        x(odd_i) = x_odd_i;                      % appends xi to x vector
        w(odd_i) = wi_odd;                       % appends wi to w vector
    end
    
    % i = 2N + 1 calculation; overwrites the last 2N+1 calculation
    xLast = a + (2*N) * delta_x;        % calculates xi value                       
    x(2*N+1) = xLast;                   % appends xN value to x vector
    w(2*N+1) = wi_ends;                 % appends wN value to w vector
    
    x = x';                             % transposition of x vector
    w = w';                             % transposition of w vector
end
