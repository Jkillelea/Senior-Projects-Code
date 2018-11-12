% Try and control a heater
% this uses matlab's built in transfer functions to be a little smarter
clear all; clc; close all;

TIME_SECONDS = 1;
TIME_MINUTES = 60*TIME_SECONDS;
TIME_HOURS   = 60*TIME_MINUTES;

T0    = 20  + 273; % 0 degC
Ttgt  = 100 + 273; % 100 degC
Tsurr = 20  + 273; % 20 degC

m     = 0.1;       % kg
cp    = 920;       % j / kg*K  MIL-HDBK-5J, Figure 3.2.1.0 Aluminum 2014-T6
Kc    = 0.31;      % W / K
sigma = 1.380649e-23; % J * K−1 boltzmann constant


% T(s) = (mc s^3 + k s^2)/(mc s^4 + k s^2 + 24*sigma)
plant = tf( [      m*cp, Kc, 0, 0], ...
            [m*cp, 0,    Kc, 0, 24*sigma])

Ki = 1.00;
Kd = 17.00;
% Integral Control
control = tf([Ki], [1, 0]) + tf([Kd, 0], [1])


system = plant*control

closed_loop = feedback(system, 1)
