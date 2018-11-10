function [dT] = odefn(t, y, m, cp, Tsurr, Kc, Kr, control_fn)
    sigma = 1.380649e-23; % J * K−1 boltzmann constant
    T = y(1);

    QdotC = -Kc*(T - Tsurr);
    QdotR = -Kr*sigma*(T^4 - Tsurr^4);
    QdotE = control_fn(T);
    % disp(QdotE)

    dT = (QdotC + QdotR + QdotE) / (m*cp);
end
