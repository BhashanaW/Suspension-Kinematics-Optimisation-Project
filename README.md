-- AI Suspension Kinematics Optimizer--

##Project Overview
--> Creating a system that optimizes the wishbone suspension system computationaly by using the Generic Algorithm(GA) in MATLAB. Expecting for better tyre gripping and optimized speed in corners specially designed for F1 cars.

Current Progress

## Phase 1 -
Before designing the system for 3D, a 2D system is being initiated. Using Lotus 32 rear suspension layout as the inspiration, a XY graph been drawn with cordinates of contact points and mount points to showcase where the adjustements happens, proving the trignomatrical logic in the code form.

KEY ACHIVEMENTS
--> Coordinate Mapping - Transformed physical hardpoints to a proper digital coordinate system.
--> Dynamic Simulation Loop - Using the mapped coordinatesclosed vector loops and circle intersection mathematics in MATLAB to simulation the movement of suspension system.
--> Kinematic Validation - Degugging the mathematical constriants to to prevent geometric inversion. Resulting in a gain curve.

FILES
--> Suspension2D.m

