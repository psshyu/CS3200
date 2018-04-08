function [t,y] = ODE23(func, t, Tc0, h)
    fun = @(t, Tc0) matlabfunction(func);
    S1 = fun(tn, yn);
    S2 = fun(tn + h/2, yn+h/2 * S1);
    S3 = fun(tn + 3*h/4, yn+3*(h/4)*S2);
    tnext = tn + h;
    ynext = yn + h/9 * (2*S1+3*S2+4*S3);
    S4 = fun(tnext, ynext);
    Error = h/72 * (-5*S1+6*S2+8*S3-9*S4);
end
