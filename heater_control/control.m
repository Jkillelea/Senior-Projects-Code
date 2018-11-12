% Run a PID control law here
function Qdot = control(T, t, Ttgt, Kp, Kd, Ki)
    % TODO: Actually do the formal analysis and find the right gains
    % TODO: All the logic for differential control

    % We define a stateful variable here, which will maintain its
    % value between calls
    persistent integral_err;
    if isempty(integral_err)
        integral_err = 0;
    end

    persistent time_last;
    if isempty(time_last)
        time_last = 0;
    end
    % Sum error over all time
    if t > time_last
        dt = t - time_last;
    else
        warning('ode45 went backwards in time!');
        dt = 0;
    end
    time_last = t;

    integral_err = integral_err + (Ttgt - T)*dt;

    Qdot = Kp * (Ttgt - T) + Ki * integral_err;
    Qdot = max([Qdot, 0]); % require Qdot to greater than or equal to zero
end
