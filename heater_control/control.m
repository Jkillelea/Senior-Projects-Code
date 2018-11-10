% Run a PID control law here
function Qdot = control(T, Ttgt, Kp, Kd, Ki)
    % TODO: Actually do the formal analysis and find the right gains
    % TODO: All the logic for differential control

    % We define a stateful variable here, which will maintain its
    % value between calls
    persistent integral_err;
    if isempty(integral_err)
        integral_err = 0;
    end
    % Sum error over all time
    integral_err = integral_err + (Ttgt - T);

    Qdot = Kp * (Ttgt - T) + Ki * integral_err;
    Qdot = max([Qdot, 0]); % require Qdot to greater than or equal to zero
end
