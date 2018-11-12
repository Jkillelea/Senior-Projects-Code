function [dT] = nonlinear_odefn(t, y, m, cp, Tsurr, Kc, Kr, control_fn)
    sigma = 1.380649e-23; % J * K−1 boltzmann constant
    T = y(1);

    QdotC = -Kc*(T - Tsurr) / (m*cp); % conduction
    QdotR = -Kr*sigma*(T^4 - Tsurr^4) / (m*cp); % radiation
    QdotE = control_fn(T, t) / (m*cp); % control

    dT = QdotC + QdotR + QdotE;
end
