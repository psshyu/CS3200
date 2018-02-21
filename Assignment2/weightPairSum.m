function integral = weightPairSum(f,x,w)
    % f = calculates sum(wi*f(xi))
    % w = vector of wi values
    % x = vector of xi values
    integral = 0;
    for idx = 1:numel(x)                % for loop to go thru all N-values
        integral = integral + w(idx) * f(x(idx));
    end
end