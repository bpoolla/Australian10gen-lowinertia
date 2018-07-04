
close all
clear all
bdclose all

%Nonlinear Model
sys.follin.model='Australian14gen_following_inertia';

% Disturbance inputs
sys.follin.dist.inp(1:6,1)=0;
sys.follin.dist.inp(4)=-250e6;
sys.follin.dist.time=20;

%load data
dataaustralian14gen
open(sys.follin.model)

%set up filter for the RoCoF
s=tf('s');
Gf=eye(10)*(s/(.2/3*s+1));
sys.follin.filt=ss(Gf);
clear s Gf

%Linearize the nonlinear system
tmp=sys.follin;
tmp.GenPU=diag(G_data(gentestcase,2));
linearizesystem;
sys.follin=tmp;

sys.follin.opt.m0=sum(2*G_data(genrem,4).*G_data(genrem,2)./(2*pi*50))/sys.follin.n_vi; %in MW / (rad/s^2)
sys.follin.opt.d0=sum(G_data(genrem,2)*1/(2*pi*50*0.05))/sys.follin.n_vi; %in MW / (rad/s)
sys.follin.opt.x0=-[ones(sys.follin.n_vi,1)*sys.follin.opt.d0;ones(sys.follin.n_vi,1)*sys.follin.opt.m0]./(1e2/(2*pi*50)); %to 100MW, 50 Hz base

%Remove the zero eigenvalue
sys.follin=modelreduction(sys.follin);

               
% Gains for non-linear simulation, input in the optimization is in
% 100 MW base, input in the nonlinear model is in W.
sys.follin.opt.alpha=100 *[1.5752;3.0736;2.4685;2.5607;2.3273;1.3412;1.4971;2.4483;1.8394;0.7652;1.8701;    7.2121;    3.3551;    3.8545;    2.3868;    0.0599;    0.1003;    0.0148;    0.2209;    0.0755;    0.0075;    0.0394;    0.3280;    0.0210;    0.0312;    0.1314;    0.0914;    1.7089;    1.6426;    1.6138];
        
% Gains for linear simulation 
sys.follin.opt.d=-sys.follin.opt.alpha(1:sys.follin.n_vi,1);
sys.follin.opt.m=-sys.follin.opt.alpha(sys.follin.n_vi+1:2*sys.follin.n_vi,1);

% Form the feedback matrix for the linearized system
F=zeros(30,90);
F(sys.follin.SP.d==1)=sys.follin.opt.d;
F(sys.follin.SP.m==1)=sys.follin.opt.m;
sys.follin.opt.F=F;

sys.follin.opt.B=[sys.follin.red.B(:,sys.follin.n_dist+1:end),sys.follin.red.B(:,sys.follin.n_dist+1:end)];
sys.follin.opt.G=sys.follin.red.B(:,1:sys.follin.n_dist);

sys.follin.tend=30;
sys.follin=tdsim(sys.follin);

% Non linear simulation without VI
dist=sys.follin.dist;
disp('simulating nonlinear system with disturbance and without VI')
tic
SimOut = sim(sys.follin.model,'StopTime',int2str(sys.follin.dist.time+sys.follin.tend));
tc=toc;

idx.disttime=find(SimOut.ysim.Time>sys.follin.dist.time,1,'first');
sys.follin.tdsim.nl.Ts=sys.follin.tdsim.red.Ts;

sys.follin.tdsim.nl.Ys=interp1(SimOut.ysim.Time(idx.disttime:end)-sys.follin.dist.time,SimOut.ysim.Data(idx.disttime:end,:)-SimOut.ysim.Data(idx.disttime,:),sys.follin.tdsim.nl.Ts);

disp(['nonlinear simulation completed in ',num2str(tc),' seconds'])

% Non linear simulation with VI
disp('simulating nonlinear system with disturbance and VI')
alpha=-sys.follin.opt.alpha*1e8;
sys.follin.dist.time=10;
dist.time=sys.follin.dist.time;
tic
SimOut = sim(sys.follin.model,'StopTime',int2str(sys.follin.dist.time+sys.follin.tend));
tc=toc;

idx.disttime=find(SimOut.ysim.Time>sys.follin.dist.time,1,'first');
sys.follin.tdsim.nlcl.Ts=sys.follin.tdsim.red.Ts;
sys.follin.tdsim.nlcl.Ys=interp1(SimOut.ysim.Time(idx.disttime:end)-sys.follin.dist.time,SimOut.ysim.Data(idx.disttime:end,:)-SimOut.ysim.Data(idx.disttime,:),sys.follin.tdsim.nlcl.Ts);    

disp(['nonlinear simulation completed in ',num2str(tc),' seconds'])


%plot the results
plotvi(sys.follin);