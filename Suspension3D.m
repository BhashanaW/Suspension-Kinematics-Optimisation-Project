% 3D Formula Suspension Coordinates [X, Y, Z]
UCA_in_F = [250, 430, 150];
UCA_in_R = [250, 430, -150];
UCA_out  = [520, 450, -10];

LCA_in_F = [180, 140, 200];
LCA_in_R = [180, 140, -200];
LCA_out  = [540, 150, 10];

TR_in  = [200, 250, -120];
TR_out = [530, 250, -120];

WC = [600, 300, 0];
CP = [600, 0, 0];

% Group points for plotting the A-arms and Upright
UCA_plot = [UCA_in_F; UCA_out; UCA_in_R; UCA_in_F];
LCA_plot = [LCA_in_F; LCA_out; LCA_in_R; LCA_in_F];
Upright_plot = [UCA_out; LCA_out; WC; TR_out; UCA_out];
TieRod_plot = [TR_in; TR_out];
Wheel_plot = [WC; CP];

% Generate 3D Plot
figure('Name', '3D Formula Suspension', 'Color', 'w');
hold on; grid on; axis equal; view(3);

% Plot linkages using plot3
plot3(UCA_plot(:,1), UCA_plot(:,3), UCA_plot(:,2), '-o', 'LineWidth', 2, 'Color', 'b', 'DisplayName', 'Upper Wishbone');
plot3(LCA_plot(:,1), LCA_plot(:,3), LCA_plot(:,2), '-o', 'LineWidth', 2, 'Color', 'r', 'DisplayName', 'Lower Wishbone');
plot3(Upright_plot(:,1), Upright_plot(:,3), Upright_plot(:,2), '-k', 'LineWidth', 2, 'DisplayName', 'Upright Assembly');
plot3(TieRod_plot(:,1), TieRod_plot(:,3), TieRod_plot(:,2), '-g', 'LineWidth', 2, 'DisplayName', 'Tie Rod');
plot3(Wheel_plot(:,1), Wheel_plot(:,3), Wheel_plot(:,2), '--k', 'LineWidth', 1.5, 'DisplayName', 'Wheel Centerline');

% Formatting
title('Static 3D Suspension Geometry');
xlabel('X - Lateral (mm)');
ylabel('Z - Longitudinal (mm)');
zlabel('Y - Vertical (mm)');
legend('Location', 'best');
hold off;