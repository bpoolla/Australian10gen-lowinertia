
This repository contains the SIMULINK models and MATLAB codes used as a benchmark system in the paper:
B. K. Poolla, D. Groß, and F. Dörfler, "Placement and Implementation of Grid-Forming and Grid-Following Virtual Inertia and Fast Frequency Response", IEEE Transactions on Power Systems.

dataaustralian14gen.m generates the underlying data, load model, for the grid-following and grid-forming Virtual Inertia (VI) implementations.
Australian14gen_inertia.slx contains the low-inertia model with both grid-forming and grid-following VI devices.
Library.slx contains the custom models for the VI devices in the different implementations.
comment_blocks.m contains the code to configure the model into one of the three test cases (low-inertia, grid-following VI, grid-forming VI). 
run_sim.m contains the relevant code for the non-linear simulation.
optimgains.mat contains optimized gains for the grid-following and grid-forming VI devices.

The models are based original SIMULINK model available at https://ch.mathworks.com/matlabcentral/fileexchange/51177-australian-simplified-14-generators-ieee-benchmark

% This source code is distributed in the hope that it will be useful, but without any warranty.
% We do request that publications in which this testbed is adopted, explicitly acknowledge that fact by citing the above mentioned paper.








