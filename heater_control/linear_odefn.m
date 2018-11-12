function [dT] = linear_odefn(t, y, m, cp, Tsurr, Kc, Kr, control_fn)
    sigma = 1.380649e-23; % J * K−1 boltzmann constant
    dT = y(1);

    QdotC = -Kc*dT             / (m*cp); % conduction
    QdotR = -(4*Kr*sigma*dT^3) / (m*cp); % radiation
    QdotE = control_fn(dT, t)  / (m*cp); % control

    dT = QdotC + QdotR + QdotE;
end
