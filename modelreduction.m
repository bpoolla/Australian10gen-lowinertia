function sys=modelreduction(sys)


disp('zero eigenvalue mode corresponds to the following states:')
sys.lin.StateName(abs(sys.Ve(:,sys.idx.zeroev))>1e-3)
sys.vistrings=sys.lin.StateName(abs(sys.Ve(:,sys.idx.zeroev))>1e-3);

 switch sys.model
    
    case 'Australian14gen_following_inertia' 
        
%extract buses of vi devices
sys.vistrings=cell2mat(sys.vistrings(end-sys.n_vi+1:end));

%extract bus name
sys.vistrings = sys.vistrings(:,1:5);
 
%Transformed system n=372
[U,S,V]=svd(sys.lin.A);

%shift the zero EV
sys.shift.A=U(:,1:end-1)*S(1:end-1,1:end-1)*V(:,1:end-1)';
sys.shift.B=sys.lin.B;
sys.shift.C=sys.lin.C;

%remove it
sys.rem.A=V(:,1:end-1)'*sys.shift.A*V(:,1:end-1);
sys.rem.B=V(:,1:end-1)'*sys.shift.B;
sys.rem.C=sys.shift.C*V(:,1:end-1);

% Balanced trunction may be used to reduce the system size and speed up the
% computation
%
% sys.n_xr=382;
% sys.red=balred(ss(sys.rem.A,sys.rem.B*1e8,sys.rem.C,[]),sys.n_xr,'StateElimMethod','Truncate');

sys.red=ss(sys.rem.A,sys.rem.B*1e8,sys.rem.C,[]);
sys.mstring=[sys.mstring,'rem'];

  case 'Australian14gen_forming_inertia' 
      
           
%extract buses of vi devices
sys.vistrings=cell2mat(sys.vistrings(end-sys.n_vi+1:end));

%extract bus name
sys.vistrings = sys.vistrings(:,1:6);
 

%not much to do here. Rescaling the system
scal=eye(75,75);
scal(sys.idx_wgen, sys.idx_wgen)=1e3*eye(10);
scal(sys.idx_ddtwgen, sys.idx_ddtwgen)=1e3*eye(10);
scal(sys.idx_wvi, sys.idx_wvi)=1e3*eye(15);

sys.red.A=sys.lin.A;
sys.red.B=sys.lin.B*diag([1e8*ones(6,1);ones(15,1)]);
sys.red.C=scal*sys.lin.C;


sys.mstring=[sys.mstring,'rem'];


 end