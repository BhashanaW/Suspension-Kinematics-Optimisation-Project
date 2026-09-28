% --AI Suspension Optimizer--


% Baseline Front mounts
baseline_UCA_in = [260, 420, -140]; %Replace with actual data from phase 1
baseline_LCA_in = [160, 120, -190];

baseline_coords = [baseline_UCA_in, baseline_LCA_in];

% Setting Lower and Upper Bounds
lb = baseline_coords - 30;
ub = baseline_coords + 30;

% Initiating how many tests to run
opts = optimoptions('ga', 'Display', 'iter', 'PopulationSize', 100);

% Running tests
num_vars = 6;
[optimized_coords, best_score] = ga(@evaluate_suspension, num_vars, [], [], [], [], lb, ub, [], opts);

% Displaying the Results
disp('--Optimization Complete--');
disp('Optimized the UCA Front Mount - ');
disp(optimized_coords(1:3));
disp('Optimized the LCA Front Mount - ');
disp(optimized_coords(4:6));
disp(['Final Penalty Score - ', num2str(best_score)]);