function output = Tsexact(t_next,Tc0,r,Ts)
    const = Tc0 - Ts;
    output = const*exp(-r*t_next);
end