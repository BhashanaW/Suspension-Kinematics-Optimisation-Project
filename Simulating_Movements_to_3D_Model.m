% Defining the sweep of Angles
angle_sweep = deg2rad(-5) : deg2rad(0.5) : deg2rad(5);

% Plotting the Movement in 3D
figure("Name",'3D Suspension Kinematics');
hold on; grid on; axis equal;
xlabel ('X - Lateral (mm)'); 
ylabel ('Y - Vertical (mm)'); 
zlabel ('Z - Longitudinal (mm)');
view(3);

for i = 1:length(angle_sweep)
    tita = angle_sweep(i);

    cla; 

    % --Rotate Upper Wishbone--

    % Simulating the Movements to the 3D model
    A_UCA = UCA_in_F;
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
    A_LCA = LCA_in_F;
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



    % --- Calculate Dynamic Camber ---

    % Vector pointing from the lower pivot to the upper pivot
    upright_vec = P_new_UCA - P_new_LCA;

    % Camber is the angle in the X-Y plane 
    % atan( dx / dy ) gives the angle from the vertical
    camber_rad = atan(upright_vec(1) / upright_vec(2)); 
    camber_deg = rad2deg(camber_rad);

    % Print the data to the command window
    fprintf('Bump Angle: %5.1f deg | Camber: %6.2f deg\n', rad2deg(tita), camber_deg);



    % --Visualizing the Movement--
   
    UCA_plot = [UCA_in_F; P_new_UCA; UCA_in_R; UCA_in_F];
    LCA_plot = [LCA_in_F; P_new_LCA; LCA_in_R; LCA_in_F];

    Upright_plot = [P_new_UCA; P_new_LCA]; 

    plot3(UCA_plot(:,1), UCA_plot(:,3), UCA_plot(:,2), '-o', 'LineWidth', 2, 'Color', 'b', 'DisplayName', 'Upper Wishbone');
    plot3(LCA_plot(:,1), LCA_plot(:,3), LCA_plot(:,2), '-o', 'LineWidth', 2, 'Color', 'r', 'DisplayName', 'Lower Wishbone');
    plot3(Upright_plot(:,1), Upright_plot(:,3), Upright_plot(:,2), '-k', 'LineWidth', 2, 'DisplayName', 'Upright Assembly');

    % Keep axis limits fixed
    xlim([-100 800]); ylim([-300 300]); zlim([0 500]); 

    % Render the frame
    pause(0.05); 

end