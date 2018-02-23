% This function essentially calculates the sum of wi * f(xi), which is used
% in all the Newton-Cotes methods in Question 3. Please ensure that the x
% and w arrays passed in to represent {wi, xi} pairings are of the same
% dimensions, with {wi(i), x(i)} forming a pair. 

function integral = weightPairSum(f,x,w)
    % f = the function we need to plug our x values into
    % w = vector of wi values
    % x = vector of xi values
    integral = 0;                       % set integral to 0
    for idx = 1:numel(x)                % for loop to go thru all N-values
        integral = integral + w(idx) * f(x(idx)); % accumulate sum
    end
end