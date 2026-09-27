% 1. Define Static Hardpoints (X, Y) in mm
U_in  = [260, 420]; % Upper Chassis Mount
L_in  = [160, 120]; % Lower Chassis Mount
U_out = [540, 440]; % Upper Upright Pivot
L_out = [560, 110]; % Lower Upright Pivot
WC    = [720, 315]; % Wheel Center
CP    = [720,   0]; % Contact Patch

% 2. Calculate Rigid Link Lengths (Magnitudes)
L_uca = norm(U_out - U_in);
L_lca = norm(L_out - L_in);
L_upright = norm(U_out - L_out);

% Calculate initial Camber Angle (Relative to vertical)
% Camber is determined by the upright axis (L_out to U_out)
upright_vector = U_out - L_out;
static_camber_rad = atan(upright_vector(1) / upright_vector(2));
static_camber_deg = rad2deg(static_camber_rad);

% 3. Plotting the Static Geometry
figure('Name', 'Double Wishbone 2D Kinematics', 'Color', 'w');
hold on; grid on; axis equal;

% Plot linkages
plot([U_in(1), U_out(1)], [U_in(2), U_out(2)], '-o', 'LineWidth', 2, 'Color', 'b', 'DisplayName', 'Upper Control Arm');
plot([L_in(1), L_out(1)], [L_in(2), L_out(2)], '-o', 'LineWidth', 2, 'Color', 'r', 'DisplayName', 'Lower Control Arm');
plot([U_out(1), L_out(1)], [U_out(2), L_out(2)], '-k', 'LineWidth', 2.5, 'DisplayName', 'Upright Axis');

% Plot Wheel Center and Contact Patch
plot(WC(1), WC(2), 'x', 'MarkerSize', 10, 'LineWidth', 2, 'Color', 'k', 'DisplayName', 'Wheel Center');
plot(CP(1), CP(2), 'x', 'MarkerSize', 10, 'LineWidth', 2, 'Color', 'm', 'DisplayName', 'Contact Patch');
plot([WC(1), CP(1)], [WC(2), CP(2)], '--k', 'DisplayName', 'Wheel Centerline');

% Formatting
title(sprintf('Static Geometry (Static Camber: %.2f deg)', static_camber_deg));
xlabel('Distance from Vehicle Centerline (mm)');
ylabel('Height from Ground (mm)');
legend('Location', 'best');
xlim([0, 800]);
ylim([0, 600]);
hold off;

% 4. Output Link Lengths to Command Window for Verification
fprintf('--- Static Link Lengths ---\n');
fprintf('Upper Control Arm: %.1f mm\n', L_uca);
fprintf('Lower Control Arm: %.1f mm\n', L_lca);
fprintf('Upright Length: %.1f mm\n', L_upright);