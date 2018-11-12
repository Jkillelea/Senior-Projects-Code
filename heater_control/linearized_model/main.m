% Compare linearized and nonlinear models of heater dynamics
clear all; clc;

m     = 0.1;       % kg
cp    = 920;       % j / kg*K  MIL-HDBK-5J, Figure 3.2.1.0 Aluminum 2014-T6
Kc    = 0.31;      % W / K
sigma = 1.380649e-23; % J * K−1 boltzmann constant

Tsurr = 20 + 273.15; % 20 degC
T0    = Tsurr;

Kc = 1;
Kr = 1;

% Full nonlinear
Tdot = @(T) (Kc.*(Tsurr - T) + Kr*sigma.*(Tsurr^4 - T.^4))./(m*cp)

% Linearized
Tdot_lin = @(delT) -(Kc*delT + 4*Kr*sigma*(T0^3)*delT)./(m*cp)

% T_min = -100 + 273.15;
T_min = 0;
% T_max =  100 + 273.15;
T_max = 500;

T_range = linspace(T_min, T_max, 10);

figure; hold on; grid on;

% Nonlinear
T = Tdot(T_range)
plot(T_range, T, 'b-', 'linewidth', 2, 'displayname', 'nonlinear')

% Linear
T_lin = Tdot_lin(T_range - T0)
plot(T_range, T_lin, 'r*', 'linewidth', 2, 'displayname', 'linear model')

xlabel('degrees Kelvin')
ylabel('degrees Kelvin / second')
legend('show')

