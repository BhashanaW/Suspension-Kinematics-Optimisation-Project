% Static Variables
U_in  = [260, 420]; 
L_in  = [160, 120]; 
U_out = [540, 440]; 
L_out = [560, 110]; 

L_uca = norm(U_out - U_in);
L_lca = norm(L_out - L_in);
L_upright = norm(U_out - L_out);

% Setup the Simulation Arrays
travel_range = -50:1:50; % Simulate from -50mm to +50mm in 1mm steps
camber_curve = zeros(length(travel_range), 1); % Empty array to store results

% The Dynamic Kinematic Loop 
for i = 1:length(travel_range)
    dz = travel_range(i);

    % New Lower Upright Pivot (moves on an arc around L_in)
    L_out_new_y = L_out(2) + dz;
    L_out_new_x = L_in(1) + sqrt(L_lca^2 - (L_out_new_y - L_in(2))^2);
    L_out_new = [L_out_new_x, L_out_new_y];

    % Circle Intersection for Upper Upright Pivot
    d = norm(U_in - L_out_new);
    a = (L_upright^2 - L_uca^2 + d^2) / (2 * d);
    h = sqrt(L_upright^2 - a^2);

    % Point P3 on the center line
    P3 = L_out_new + a * (U_in - L_out_new) / d;

    % The intersection point (U_out_new)
    U_out_new_x = P3(1) + h * (U_in(2) - L_out_new(2)) / d;
    U_out_new_y = P3(2) - h * (U_in(1) - L_out_new(1)) / d;
    U_out_new = [U_out_new_x, U_out_new_y];

    % Step C: Calculate Camber Angle for this step
    dx = U_out_new(1) - L_out_new(1);
    dy = U_out_new(2) - L_out_new(2);

    % atan2d calculates the angle relative to the horizontal X-axis in degrees
    theta_upright = atan2d(dy, dx);

    % Convert to camber (deviation from the vertical 90-degree axis)
    camber_curve(i) = 90 - theta_upright;
end

% Plot the Camber Curve (Ensure this is OUTSIDE the loop)
figure('Name', 'Camber vs. Wheel Travel', 'Color', 'w');
plot(travel_range, camber_curve, 'LineWidth', 2, 'Color', 'b');
grid on;
title('Camber Gain over 50mm Bump/Droop');
xlabel('Wheel Travel (mm) [Negative = Droop, Positive = Bump]');
ylabel('Camber Angle (Degrees)');