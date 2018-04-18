function dTcdt = NewtonCooling(r, Ts, Tc)
    dTcdt = -r*(Tc-Ts);
end
