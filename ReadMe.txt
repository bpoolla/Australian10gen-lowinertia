
This repository contains the SIMULINK models and MATLAB codes used as a benchmark system in the paper:
B.K.Poolla, D. Groß, and F. Dörfler, "Placement and Implementation of Grid-Forming and Grid-Following Virtual Inertia"

dataaustralian14gen.m generates the underlying data, load model, for the grid-following and grid-forming Virtual Inertia (VI) implementations.
Australian14gen_original.slx contains the low-inertia model without any VI devices.
Library.slx contains the custom models for the VI devices in the different implementations.

Australian14gen_following_inertia.slx contains the low-inertia model of the South-East Australian grid along with grid-following VI devices.
main_following.m contains the relevant code for the non-linear simulation of the grid-following VI implementation.

Australian14gen_forming_inertia.slx contains the low-inertia model of the South-East Australian grid along with grid-forming VI devices.
main_forming.m contains the relevant code for the non-linear simulation of the grid-following VI implementation.

The scripts 'main_following.m' and 'main_forming.m' call the following functions:
linearizesystem.m generates the linearized system models (A,B,C,D,G matrices) for analysis in either implementation.
modelreduction.m removes the zero eigenvalue due to the system Laplacian.
tdsim.m simulates the linearized models for the VI implementations.
plotvi.m generates the relevant time-domain plots for the metrics of interest.


The models are based original SIMULINK model available at https://ch.mathworks.com/matlabcentral/fileexchange/51177-australian-simplified-14-generators-ieee-benchmark

% This source code is distributed in the hope that it will be useful, but without any warranty.
% We do request that publications in which this testbed is adopted, explicitly acknowledge that fact by citing the above mentioned paper.








