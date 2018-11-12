% Try and control a heater
clear all; clc; close all;

TIME_SECONDS = 1;
TIME_MINUTES = 60*TIME_SECONDS;
TIME_HOURS   = 60*TIME_MINUTES;

T0    = 20  + 273; % 0   degC
Ttgt  = 100 + 273; % 100 degC
Tsurr = 25  + 273; % 20  degC

m     = 0.1;   % kg
cp    = 920;   % j / kg*K  MIL-HDBK-5J, Figure 3.2.1.0 Aluminum 2014-T6
Kc    = 0.01;  % W / K
Kr    = 0.001; % W / K^3 (units wrong?)

time_max = TIME_HOURS; % seconds

Kp = 0.5;
Kd = 0; % unimplemented
Ki = 0.0001; % implemented in a very bad way

control_fn = @(T, t) control(T, t, Ttgt, Kp, Kd, Ki);

figure; hold on; grid on;

% Nonlinear simulation
disp('nonlinear')
[t_full, y_full] = ode45(@(t, y) nonlinear_odefn(t, y, m, cp, Tsurr, Kc, Kr, control_fn), [0, time_max], Tsurr);
plot(t_full/TIME_HOURS, y_full - 273, 'b', 'linewidth', 2, 'displayname', 'Nonlinear Model')

% Linearized model
disp('linear')
[t_lin, y_lin] = ode45(@(t, y) linear_odefn(t, y, m, cp, Tsurr, Kc, Kr, control_fn), [0, time_max], Tsurr);
plot(t_lin/TIME_HOURS,  y_lin - 273, 'r',  'linewidth', 2, 'displayname', 'Linearized Model')

% Target temperature
plot([0, time_max/TIME_HOURS], [Ttgt,  Ttgt]  - 273, 'r-', 'displayname', 'Target Temperature')
plot([0, time_max/TIME_HOURS], [Tsurr, Tsurr] - 273, 'b-', 'displayname', 'Ambient Temperature')

title(sprintf('Temperature over time (K_p = %f, K_I = %f)', Kp, Ki))
xlabel('Time (hours)')
ylabel('Temperature (deg C)')
legend('show')
