close all
clear all
bdclose all

% Configuration of the nonlinear system
sys.model='Australian14gen_forming_inertia';
%sys.model='Australian14gen_following_inertia';
%sys.model='Australian14gen_low_inertia';



open('Australian14gen_inertia');
comment_blocks(sys);


%set up filter for the RoCoF
s=tf('s');
Gf=eye(10)*(s/(.2/3*s+1));
sys.formin.filt=ss(Gf);

%set up filter for the active power injection by VI
Gf=eye(15)*(1/(0.03*s+1));
sys.formin.pfilt=ss(Gf);

clear s Gf

tmp=sys.formin;
tmp.GenPU=diag(G_data(gentestcase,2));
sys.formin=tmp;

%time tripping and reconnecting a generator
dist.tgen=[200 201];

%time tripping and reconnecting a the line between area 3 and 5
dist.tsplit=[200 201];

%disturbance inputs and time
dist.inp(6)=-150e6;
dist.time=15;

%Simulation time
sys.tend=dist.time+15;
load optimgains.mat


disp('simulating nonlinear system')

tic
SimOut = sim('Australian14gen_inertia','StopTime',int2str(sys.tend));
tc=toc;
