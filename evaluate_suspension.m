% --Calculating a penalty to optimize the suspension with a target -5.0-- %

function total_penalty = evaluate_suspension(mount_coords)

    UCA_in = [mount_coords(1), mount_coords(2), mount_coords(3)];
    LCA_in = [mount_coords(4), mount_coords(5), mount_coords(6)];
    
    UCA_in_R = [250, 430, -150];
    LCA_in_R = [180, 140, -200]; 
    UCA_out = [520, 450, -10];
    LCA_out = [540, 150, 10];
    
    
    % --Kinematic Dynamic Loop--
    
    % Defining the sweep of Angles
    angle_sweep = deg2rad(-5) : deg2rad(0.5) : deg2rad(5);
    
    
    for i = 1:length(angle_sweep)
        tita = angle_sweep(i);

    
        % --Rotate Upper Wishbone--

        % Simulating the Movements to the 3D model
        A_UCA = UCA_in;
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
        A_LCA = LCA_in;
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
        actual_camber_array(i) = rad2deg(camber_rad);
    
    
    end
    

    %-- Penalty Calculation--

    % Initiating for Penalty    
    target_camber = -5.0; 
    total_penalty = 0;

    % Total Penalty Calculation
    for i = 1:length(actual_camber_array)
        Penalty = abs(target_camber - actual_camber_array(i));
        total_penalty = total_penalty + Penalty;    
    end
    

    if ~isreal(total_penalty) || isnan(total_penalty)
        total_penalty = 1e6; 
    end

end