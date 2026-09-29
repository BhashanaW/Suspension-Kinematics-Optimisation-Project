% --Camber Plot Comparison Graph--

bump_sweep_deg = -5 : 0.5 : 5;
bump_sweep_rad = deg2rad(bump_sweep_deg);

% Initiating Arrays to Store Results
baseline_camber = zeros(1, length(bump_sweep_rad));
optimized_camber = zeros(1, length(bump_sweep_rad));

% Static Coordinates
UCA_in_R = [250, 430, -150];
LCA_in_R = [180, 140, -200]; 
UCA_out  = [520, 450, -10];
LCA_out  = [540, 150, 10];


% --Baseline Chamber--


for i = 1:length(bump_sweep_rad)
    tita = bump_sweep_rad(i);

    baseline_UCA_in = [260, 420, -140]; 
    baseline_LCA_in = [160, 120, -190];


    % --Rotate Upper Wishbone--

    % Simulating the Movements to the 3D model
    A_UCA = baseline_UCA_in;
    B_UCA = UCA_in_R;

    % Setting up k to find Unit Vector
    k_UCA = (B_UCA - A_UCA) / norm(B_UCA - A_UCA);

    % New Pivot Point
    P_UCA = UCA_out;
    v_UCA = P_UCA - A_UCA;

    % Rotating v by suspension angle tita
    v_rot_UCA = v_UCA * cos(tita) + cross(k_UCA, v_UCA) * sin(tita) + k_UCA * dot(k_UCA, v_UCA) * (1 - cos(tita));

    % Translating Back
    P_new_UCA = A_UCA + v_rot_UCA;



    % --Rotate Lower Wishbone--

    % Simulating the Movements to the 3D model
    A_LCA = baseline_LCA_in;
    B_LCA = LCA_in_R;

    % Setting up k to find Unit Vector
    k_LCA = (B_LCA - A_LCA) / norm(B_LCA - A_LCA);

    % New Pivot Point
    P_LCA = LCA_out;
    v_LCA = P_LCA - A_LCA;

    % Rotating v by suspension angle tita
    v_rot_LCA = v_LCA * cos(tita) + cross(k_LCA, v_LCA) * sin(tita) + k_LCA * dot(k_LCA, v_LCA) * (1 - cos(tita));

    % Translating Back
    P_new_LCA = A_LCA + v_rot_LCA;

    % Calculate Baseline Dynamic Camber
    upright_vec = P_new_UCA - P_new_LCA;
    camber_rad = atan(upright_vec(1) / upright_vec(2)); 
    baseline_camber(i) = rad2deg(camber_rad);

end


% --Calculate Optimized Chamber--


for i = 1:length(bump_sweep_rad)
    tita = bump_sweep_rad(i);

    % Optimized Front Mounts
    Optimized_UCA_in = [255.4640, 424.3583, -167.9114]; 
    Optimized_LCA_in = [132.5522, 138.8964, -204.7307];


    % --Rotate Upper Wishbone--

    % Simulating the Movements to the 3D model
    A_UCA = Optimized_UCA_in;
    B_UCA = UCA_in_R;

    % Setting up k to find Unit Vector
    k_UCA = (B_UCA - A_UCA) / norm(B_UCA - A_UCA);

    % New Pivot Point
    P_UCA = UCA_out;
    v_UCA = P_UCA - A_UCA;

    % Rotating v by suspension angle tita
    v_rot_UCA = v_UCA * cos(tita) + cross(k_UCA, v_UCA) * sin(tita) + k_UCA * dot(k_UCA, v_UCA) * (1 - cos(tita));

    % Translating Back
    P_new_UCA = A_UCA + v_rot_UCA;



    % --Rotate Lower Wishbone--

    % Simulating the Movements to the 3D model
    A_LCA = Optimized_LCA_in;
    B_LCA = LCA_in_R;

    % Setting up k to find Unit Vector
    k_LCA = (B_LCA - A_LCA) / norm(B_LCA - A_LCA);

    % New Pivot Point
    P_LCA = LCA_out;
    v_LCA = P_LCA - A_LCA;

    % Rotating v by suspension angle tita
    v_rot_LCA = v_LCA * cos(tita) + cross(k_LCA, v_LCA) * sin(tita) + k_LCA * dot(k_LCA, v_LCA) * (1 - cos(tita));

    % Translating Back
    P_new_LCA = A_LCA + v_rot_LCA;

    % Calculate Optimized Dynamic Camber
    upright_vec = P_new_UCA - P_new_LCA;
    camber_rad = atan(upright_vec(1) / upright_vec(2)); 
    optimized_camber(i) = rad2deg(camber_rad);

end


% --Plotting the Graphs--

figure('Name', 'Suspension Kinematics: Baseline vs Optimized');
hold on; grid on;

plot(bump_sweep_deg, baseline_camber, '-r^', 'LineWidth', 2, 'DisplayName', 'Baseline Geometry');
plot(bump_sweep_deg, optimized_camber, '-go', 'LineWidth', 2, 'DisplayName', 'GA Optimized Geometry');

yline(-5.0, '--k', 'Target Camber (-5.0°)', 'LineWidth', 1.5, 'LabelHorizontalAlignment', 'left');

% --Formatting--

title('Dynamic Camber Curve - Bump vs Droop Travel');
xlabel('Suspension Travel Angle (Degrees)');
ylabel('Camber Angle (Degrees)');
legend('Location', 'southwest');
hold off;