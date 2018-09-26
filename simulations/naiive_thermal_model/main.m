clear all; clc; close all;

SECOND = 1;
MINUTE = 60*SECOND;
HOUR   = 60*MINUTE;

global heater_state;
heater_state = 0;

initial_state = [300]; % degrees kelvin

abs_temp_max = 273 + 50; %  50 C
abs_temp_min = 273 - 20; % -20 C
temp_max = 273 + 30; %  30 C
temp_min = 273 - 10; % -10 C
time_max = 1.5*HOUR;

[t, y] = ode45(@(t, y) thermal_model(t, y, temp_max, temp_min),        ...
                                                        [0, time_max], ...
                                                        initial_state);
figure; hold on; grid on;
title('On/Off Control');
plot(t, y);
% Targeted limits
plot([0, time_max], [temp_min, temp_min], 'b--');
plot([0, time_max], [temp_max, temp_max], 'r--');
% Absolute limits
plot([0, time_max], [abs_temp_min, abs_temp_min], 'b-');
plot([0, time_max], [abs_temp_max, abs_temp_max], 'r-');


T_target = 300; % kelvin
[t, y] = ode45(@(t, y) proportional_model(t, y, T_target, temp_max, temp_min),        ...
                                                        [0, time_max], ...
                                                        initial_state);
figure; hold on; grid on;
title('Proportional Control');
plot(t, y);
% Target temperature
plot([0, time_max], [T_target, T_target], 'g--');
% Absolute Limits
plot([0, time_max], [abs_temp_min, abs_temp_min], 'b-');
plot([0, time_max], [abs_temp_max, abs_temp_max], 'r-');
