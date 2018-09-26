function dT = proportional_model(t, y, T_target, temp_max, temp_min)
    global heater_state;
    sc_temp = y(1);

    T_SPACE        = 3;         % Kelvin
    SIGMA          = 5.6703e-8; % Boltzman Const; [W/(m^2 K^4)]
    AREA           = 0.25;      % m^2
    MASS           = 1;         % [kg]
    EMISSIVITY     = 1;         % black body assumption
    ABSORBTIVIY    = 1;         % black body assumption
    HEATER_WATTS   = 300;       % [W]
    SPECIFIC_HEAT  = 910;       % Aluminum, [J/(kg*K)]
    SUN_LOAD       = 100;       % [W]
    ORBITAL_PERIOD = 90*60;     % seconds

    Kp = 0.5;

    % Heater Controller
    heat = Kp * (T_target - sc_temp) * HEATER_WATTS;

    % Turn heater off if sc_temp > T_target
    if sc_temp > T_target
        heat = 0;
    end

    % If we're in sunglight (1 or 0)
    sun = mod(t/60, ORBITAL_PERIOD/60) > 45;

    % Radiation heat loss (black body)
    dq_dt = EMISSIVITY * SIGMA * AREA * (T_SPACE^4 - sc_temp^4) ... % Radiation loss
            + heat ...                                              % Active control
            + sun * SUN_LOAD * ABSORBTIVIY;                         % solar load

    dT = dq_dt/(SPECIFIC_HEAT*MASS);
end
