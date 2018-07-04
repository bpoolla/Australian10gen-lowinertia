function sys=tdsim(sys)

switch sys.model
    
    case 'Australian14gen_following_inertia'
        
        %simulate linearized system with reduced order
        disp('simulating linearized system with disturbance and no VI')
        tic
        
        [sys.tdsim.red.Ys,sys.tdsim.red.Ts]=step(ss(sys.red.A,sys.opt.G(:,1:sys.n_dist)*sys.dist.inp/1e8,sys.red.C,[]),sys.tend);
        
        tc=toc;
        disp(['linear simulation completed in ',num2str(tc),' seconds'])
        
        %compute damping ratios
        sys.tdsim.red.damp_ratio=min(-real(eig(sys.red.A))./(abs(eig(sys.red.A))));
        
        %simulate linearized system with reduced order and VI
        disp('simulating linearized system with disturbance and VI')
        tic
        
        [sys.tdsim.redcl.Ys,sys.tdsim.redcl.Ts]=step(ss(sys.red.A+sys.opt.B*sys.opt.F*sys.red.C,sys.opt.G(:,1:sys.n_dist)*sys.dist.inp/1e8,sys.red.C,[]),sys.tdsim.red.Ts);
        tc=toc;
        disp(['linear simulation completed in ',num2str(tc),' seconds'])
        
        %compute damping ratios
        sys.tdsim.redcl.damp_ratio=min(-real(eig(sys.red.A+sys.opt.B*sys.opt.F*sys.red.C))./(abs(eig(sys.red.A+sys.opt.B*sys.opt.F*sys.red.C))));
        
        
        
    case 'Australian14gen_forming_inertia'     
       
        %simulate linearized system with disturbance and pre-stabilising VI
        disp('simulating linearized system with disturbance and pre-stabilizing VI')
        tic
        [sys.tdsim.red.Ys,sys.tdsim.red.Ts]=step(ss(sys.Acl,sys.opt.G(:,1:sys.n_dist)*sys.dist.inp/1e8,sys.red.C,[]),sys.tend);
        tc=toc;
        disp(['linear simulation completed in ',num2str(tc),' seconds'])
        
        %compute damping ratios
        sys.tdsim.red.damp_ratio=min(-real(eig(sys.Acl))./(abs(eig(sys.Acl))));
        
        
        %simulate linearized system with disturbance and VI
        disp('simulating linearized system with disturbance and VI')
        tic
        [sys.tdsim.redcl.Ys,sys.tdsim.redcl.Ts]=step(ss(sys.red.A+sys.opt.B*sys.opt.F*sys.opt.C,sys.opt.G(:,1:sys.n_dist)*sys.dist.inp/1e8,sys.red.C,[]),sys.tdsim.red.Ts);
        tc=toc;
        disp(['linear simulation completed in ',num2str(tc),' seconds'])
        
        %compute damping ratios
        sys.tdsim.redcl.damp_ratio=min(-real(eig(sys.red.A+sys.opt.B*sys.opt.F*sys.opt.C))./(abs(eig(sys.red.A+sys.opt.B*sys.opt.F*sys.opt.C))));
        
                
end
