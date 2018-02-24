% Calculates the error given by the Richardson's Exterpolation function.
% Instead of using delta_x as an input variable, N is used.
function errorh = RichardsonExtrap(NIntegral, twoNIntegral)
    % NIntegral = Integral of function with N-subintervals
    % twoNIntegral = Integral of function with 2N-subintervals
    errorh = (4/3)*(-NIntegral+twoNIntegral);
end