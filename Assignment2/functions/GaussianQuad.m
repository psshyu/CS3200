function summation = GaussianQuad(a,b,N,f)

    % a = first point of integral 
    % b = final point of interval
    % N = number of intervals
    % f = function
    
    wi = zeros(5,1);                    % pre-allocate vector sized 5 for wi values
    xi = zeros(5,1);                    % pre-allocate vector sized 5 for xi values
    ba_div2 = (b-a)/2;                  % hard coded this as it's used to map xi from [-1 1] to [a b]    
    ab_div2 = (a+b)/2;                  % see above line's comment
    
    % Mapping! So all the {wi, xi} values given to us were over [-1, 1],.
    % While all the wi values remained the same, the xi values had to be
    % mapped under the following formula:
    %       xi_new = (ba_div2 * xi_old + ab_div2)
    % This had to be done for all xi values from N = 1...5. 
    switch N
        case 1
            xi(1) = 0 + ab_div2;
            wi(1) = 2;
        case 2
            xi(1) = ba_div2 * (1/sqrt(3)) + ab_div2;
            wi(1) = 1;
            xi(2) = ba_div2 * (-1/sqrt(3)) + ab_div2;
            wi(2) = 1;
        case 3
            xi(1) = ba_div2 * (-sqrt(3/5)) + ab_div2;
            wi(1) = 5/9;
            xi(2) = 0 + ab_div2;
            wi(2) = 8/9;
            xi(3) = ba_div2 * (sqrt(3/5)) + ab_div2;
            wi(3) = 5/9;
        case 4
            xi(1) = ba_div2 * (-sqrt(3+2*sqrt(6/5)/7)) + ab_div2;
            wi(1) = (18-sqrt(30))/36;
            xi(2) = ba_div2 * (-sqrt(3-2*sqrt(6/5)/7)) + ab_div2;
            wi(2) = (18+sqrt(30))/36;
            xi(3) = ba_div2 * sqrt(3-2*sqrt(6/5)/7) + ab_div2;
            wi(3) = (18+sqrt(30))/36;
            xi(4) = ba_div2 * sqrt(3+2*sqrt(6/5)/7) + ab_div2;
            wi(4) = (18-sqrt(30))/36;
        case 5
            xi(1) = ba_div2 * (-(1/3) * sqrt(5+2*sqrt(10/7))) + ab_div2;
            wi(1) = (322-13*sqrt(70))/900;
            xi(2) = ba_div2 * (-(1/3) * sqrt(5-2*sqrt(10/7))) + ab_div2;
            wi(2) = (322+13*sqrt(70))/900;
            xi(3) = 0 + ab_div2;
            wi(3) = 128/255;
            xi(4) = ba_div2 * (1/3) * sqrt(5-2*sqrt(10/7)) + ab_div2;
            wi(4) = (322+13*sqrt(70))/900;
            xi(5) = ba_div2 * (1/3) * sqrt(5+2*sqrt(10/7)) + ab_div2;
            wi(5) = (322-13*sqrt(70))/900;
        otherwise % in case if someone decides to be all fancy and enter N = 5000
            fprintf('Invalid N! Please ensure N is between 1 and 5 (inclusively');
    end
    
    summation = 0;  % clear/ reset summation to 0.
    
    for i=1:N       % N determines how many times we have to piecewise-sum this integration
        summation = summation + wi(i) * f(ba_div2 * xi(i) + ab_div2); % calculating the summation
    end
end