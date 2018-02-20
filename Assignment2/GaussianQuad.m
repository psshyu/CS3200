function wif = GaussianQuad(a,b,N,f)

    % a = first point of integral 
    % b = final point of interval
    % N = number of intervals
    % f = function
    
    wi = zeros(5,1);                     % pre-allocate vector sized 5 for wi values
    xi = zeros(5,1);                     % pre-allocate vector sized 5 for xi values
    switch N
        case 1
            xi(1) = 0;
            wi(1) = 2;
        case 2
            xi(1) = 1/sqrt(3);
            wi(1) = 1;
            xi(2) = -1/sqrt(3);
            wi(2) = 1;
        case 3
            xi(1) = -sqrt(3/5);
            wi(1) = 5/9;
            xi(2) = 0;
            wi(2) = 8/9;
            xi(3) = sqrt(3/5);
            wi(3) = 5/9;
        case 4
            xi(1) = -sqrt(3+2*sqrt(6/5)/7);
            wi(1) = (18-sqrt(30))/36;
            xi(2) = -sqrt(3-2*sqrt(6/5)/7);
            wi(2) = (18+sqrt(30))/36;
            xi(3) = sqrt(3-2*sqrt(6/5)/7);
            wi(3) = (18+sqrt(30))/36;
            xi(4) = sqrt(3+2*sqrt(6/5)/7);
            wi(4) = (18-sqrt(30))/36;
        case 5
            xi(1) = -(1/3)*sqrt(5+2*sqrt(10/7));
            wi(1) = (322-13*sqrt(70))/900;
            xi(2) = -(1/3)*sqrt(5-2*sqrt(10/7));
            wi(2) = (322+13*sqrt(70))/900;
            xi(3) = 0;
            wi(3) = 128/255;
            xi(4) = (1/3)*sqrt(5-2*sqrt(10/7));
            wi(4) = (322+13*sqrt(70))/900;
            xi(5) = (1/3)*sqrt(5+2*sqrt(10/7));
            wi(5) = (322-13*sqrt(70))/900;
        otherwise
            fprintf('Invalid N! Please ensure N is between 1 and 5 (inclusively');
    end
    %x = x(x ~= 0);
    %w = w(w ~= 0);
    fprintf('%i ', xi);
    wif = zeros(5,1);
    
    f = @(x) f;
    summation = 0;
    ba_div2 = (b-a)/2;
    ab_div2 = (a+b)/2;
    
    for i=1:N
        xi = ba_div2 * xi(i) + ab_div2;
        func = f(xi);
        sum = wi(i)* func;
    end
    
    %summation = summation * ba_div2;
    %fprintf('\n %i ', summation);
end