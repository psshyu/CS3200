%% To make my life easier, the y term is renamed as Tc

function Tcnext = ODE23(t, Tc, r, h)
    Ts = 19;
    
    syms x y;
    
    fun = @(x, y) -r*(y - Ts);
    
    S1 = fun(t, Tc);
    S2 = fun(t + h/2, Tc+h/2 * S1);
    S3 = fun(t + 3*h/4, Tc+3*(h/4)*S2);
    tnext = t + h;
    Tcnext = Tc + h/9 * (2*S1+3*S2+4*S3);
    S4 = fun(tnext, Tcnext);
    Error = h/72 * (-5*S1+6*S2+8*S3-9*S4);
end
