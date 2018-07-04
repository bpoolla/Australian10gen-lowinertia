
close all
clear all
bdclose all

% Nonlinear system
sys.formin.model='Australian14gen_forming_inertia';
open(sys.formin.model)


%load data
dataaustralian14gen
open(sys.formin.model)

%set up filter for the RoCoF
s=tf('s');
Gf=eye(10)*(s/(.2/3*s+1));
sys.formin.filt=ss(Gf);
clear s Gf

%Linearize the nonlinear system
tmp=sys.formin;
tmp.GenPU=diag(G_data(gentestcase,2));        
linearizesystem;
sys.formin=tmp;        

% Disturbance inputs
sys.formin.dist.inp(1:6,1)=0;
sys.formin.dist.inp(4)=-250e6;
sys.formin.dist.time=15;

%Remove the zero eigenvalue
sys.formin=modelreduction(sys.formin);


% create extended Input matrices
sys.formin.opt.B=sys.formin.red.B(:,sys.formin.n_dist+1:end);
sys.formin.opt.C=sys.formin.red.C;
sys.formin.opt.G=sys.formin.red.B(:,1:sys.formin.n_dist);   
sys.formin.opt.Kv=sys.formin.opt.x0;
      
% Set the gains for non-linear simulation 
sys.formin.Kv=zeros(30,1);
sys.formin.Kv(1:2:30)=sys.formin.opt.Kv(1:sys.formin.n_vi);
sys.formin.Kv(2:2:30)=sys.formin.opt.Kv(sys.formin.n_vi+1:2*sys.formin.n_vi)*1e3/(2*pi*50);

% Form the Feedback matrix for the linear simulation
F=zeros(sys.formin.n_vi,sys.formin.n_y);
F(sys.formin.SP.p==1)=sys.formin.opt.Kv(1:sys.formin.n_vi,1);
F(sys.formin.SP.w==1)=sys.formin.opt.Kv(sys.formin.n_vi+1:2*sys.formin.n_vi,1);

sys.formin.opt.F=F;

%linear simulation
sys.formin.tend=30;
sys.formin=tdsim(sys.formin);


% Non linear simulation using the gains obtained via the H2 optimization
dist=sys.formin.dist;
disp('simulating nonlinear system with disturbance and VI')
Kvsc(2,1:1:15)=sys.formin.Kv(1:2:30)';
Kvsc(1,1:1:15)=sys.formin.Kv(2:2:30)';
sys.formin.dist.time=15;
dist.time=sys.formin.dist.time;

tic
SimOut = sim(sys.formin.model,'StopTime',int2str(sys.formin.dist.time+sys.formin.tend));
tc=toc;

idx.disttime=find(SimOut.ysim.Time>sys.formin.dist.time,1,'first');
sys.formin.tdsim.nlcl.Ts=sys.formin.tdsim.red.Ts;
sys.formin.tdsim.nlcl.Ys=interp1(SimOut.ysim.Time(idx.disttime:end)-sys.formin.dist.time,SimOut.ysim.Data(idx.disttime:end,:)-SimOut.ysim.Data(idx.disttime,:),sys.formin.tdsim.nlcl.Ts);

disp(['nonlinear simulation completed in ',num2str(tc),' seconds'])

%plot the results
plotvi(sys.formin);