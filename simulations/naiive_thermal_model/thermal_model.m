% A basic model where the heater is turned
% on if things get too cold and turned off 
% if things get too hot

function dT = thermal_model(t, y, temp_max, temp_min)
    global heater_state;

    T_SPACE        = 3;         % Kelvin
    SIGMA          = 5.6703e-8; % Boltzman Const; [W/(m^2 K^4)]
    AREA           = 0.25;      % m^2
    MASS           = 1;         % [kg]
    EMISSIVITY     = 1;         % black body assumption
    ABSORBTIVIY    = 1;         % black body assumption
    HEATER_WATTS   = 300;       % [W]
    SPECIFIC_HEAT  = 910;       % Aluminum, [J/(kg*K)]
    SUN_LOAD       = 500;       % [W]
    ORBITAL_PERIOD = 90*60;     % seconds

    sc_temp = y(1);

    % Switch heater on if too cold, off if too hot
    if sc_temp < temp_min
        heater_state = 1;
    elseif sc_temp > temp_max
        heater_state = 0;
    end

    % If we're in sunglight
    sun = mod(t/60, ORBITAL_PERIOD/60) > 45;

    dq_dt = EMISSIVITY * SIGMA * AREA * (T_SPACE^4 - sc_temp^4) ... % radiation loss
            + heater_state * HEATER_WATTS                       ... % heat control
            + sun * SUN_LOAD * ABSORBTIVIY;                         % solar load

    dT = dq_dt/(SPECIFIC_HEAT*MASS);
end
