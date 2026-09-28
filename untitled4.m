% Simulating the Movements to the 3D model
A = UCA_in_F;
B = UCA_in_R;

% Setting up k to find Unit Vector
k = (B - A) / norm(B - A);

% New Pivot Point
P = UCA_out;
v = P - A;

% Rotating v by suspension angle tita (using cross and dot products)
v_rot = v * cos(tita) + cross(k, v) * sin(tita) + k * dot(k, v) * (1 - cos(tita));

% Translating Back
P_new = A + v_rot;