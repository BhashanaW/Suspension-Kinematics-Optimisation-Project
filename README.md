## -- AI Suspension Kinematics Optimiser --

## Project Overview
--> Creating a system that optimizes the wishbone suspension system computationaly by using the Generic Algorithm(GA) in MATLAB. Expecting for better tyre gripping and optimized speed in corners specially designed for F1 cars.

*Current Progress*

## Phase 1 -
Before designing the system for 3D, a 2D system is being initiated. Using Lotus 32 rear suspension layout as the inspiration, a XY graph been drawn with cordinates of contact points and mount points to showcase where the adjustements happens, proving the trignomatrical logic in the code form.

**KEY ACHIVEMENTS**
--> Coordinate Mapping - Transformed physical hardpoints to a proper digital coordinate system.
--> Dynamic Simulation Loop - Using the mapped coordinates closed vector loops and circle intersection mathematics in MATLAB to simulation the movement of suspension system.
--> Kinematic Validation - Degugging the mathematical constraints to to prevent geometric inversion. Resulting in a gain curve.

## Phase 1 Update (3D Spatial Expansion) -
After identifying mathematical constraints in the 2D model, a 3D model been made expanding the 2D model into 3D space with completely new data extracted from F3 car suspension. Then further developed the design to simulate the movements to identify the required modification need to be made for better cornering and good grip with computational adjustments.

**MODIFICATIONS**
--> 3D Mathematical Model - Expanded the 2D model to 3D space by new data to evaluate the complex spacial kinematics.
--> Visualised Movements - The 3D model now simulates movements using *Rodrigues' Rotation Formula* with the use of vector cross and dot products to rotate the upper and lower wishbones around their respective non-parallel chassis mounting axes.
--> Real Time Data Extraction - Extracted the real-time relative camber angle at each millimeter of travel, establishing the baseline geometric curve for the genetic algorithm to optimize.


FILES
--> Suspension2D.m
--> Suspension3D.m
--> Simulating_Movements_to_3D_Model.m

------------------------------------------------------------------------------------------------------------------------------------

## Phase 2 -
Here, the suspension system is been evaluated where we simulated 50mm of vertical wheel travel. Also, we have made a target of -5.0 degrees of camper at full bump assuming the applied model is a high performance formula car.

**KEY ACHIVEMENTS**
--> Scorecard - Created a function that calculates the dynamic camber angle at each millimeter of travel. It outputs a penalty score based on the absolute deviation from an engineered target of -5.00 degrees of camber at full bump.

FILES
--> evaluate_suspension.m

-----------------------------------------------------------------------------------------------------------------------------------

## Phase 3 -

By completely bypassing manual adjustments we use Generic Algorithm to do the adjustments for the car. To do this we have implemented the system to Upper and Lower Front Chassis mounts.

**KEY ACHIVEMENTS**
--> Algorithm Deployment - Used MATLAB's `ga` solver to evaluate thousands of geometric combinations.
--> Physical Constraints - Defined strict boundary conditions (`lb` and `ub`) locking the optimization space to a 30mm limit around the baseline chassis mounts, ensuring physical packaging constraints are respected.
--> Results - The algorithm successfully minimized the penalty score across 200 and more generations, shifting the lower control arm inboard and altering the kinematic curve to hit the exact -5.00 degree target without geometric singularities.

FILES
--> test_run_optimization.m


