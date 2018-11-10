% Try and control a heater
clear all; clc; close all;

TIME_SECONDS = 1;
TIME_MINUTES = 60*TIME_SECONDS;
TIME_HOURS   = 60*TIME_MINUTES;

T0    = 20  + 273; % 0 degC
Ttgt  = 100 + 273; % 100 degC
Tsurr = 20  + 273; % 20 degC

m     = 0.1;       % kg
cp    = 920;       % j / kg*K  MIL-HDBK-5J, Figure 3.2.1.0 Aluminum 2014-T6
Kc    = 0.01;      % W / K
Kr    = 0.001;     % W / K^4

y0 = [T0];
time_max = 2*TIME_HOURS; % seconds

Kp = 1;
Kd = 0;
Ki = 0.003;
control_fn = @(T) control(T, Ttgt, Kp, Kd, Ki);

[t, y] = ode45(@(t, y) odefn(t, y, m, cp, Tsurr, Kc, Kr, control_fn), [0, time_max], y0);

figure; hold on; grid on;
plot(t, y - 273, 'linewidth', 2)
plot([0, max(t)], [Ttgt, Ttgt] - 273, 'r-')
xlabel('time (seconds)')
ylabel('temperature (deg C)')
