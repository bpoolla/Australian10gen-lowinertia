scomp=tmp.model;

tmp.loadflow=power_loadflow('-v2',tmp.model,'NoUpdate');

io=getlinio(tmp.model);
set_param(tmp.model,'IgnoredZcDiagnostic','none');
opt = linearizeOptions('UseFullBlockNameLabels','on');%'SampleTime',0

disp('linearizing')
tic

switch scomp
    case 'Australian14gen_following_inertia'
        tlin=50;
    case 'Australian14gen_forming_inertia'
        tlin=30;
end

tmp.lin=linearize(tmp.model,io,tlin);
tc=toc;
disp(['linearization completed in ',num2str(tc),' seconds'])



switch scomp
    
    case 'Australian14gen_following_inertia'
        disp('sanity checks on linearization')
        
        if norm(tmp.lin.D,'fro')>1e-6
            error('Feedthrough matrix is not zero');
        end
        
        etol=2e-3;
        if any(real(eig(tmp.lin.A))>etol)
            error(['the linearized system has an eigenvalue with real part larger than ',num2str(etol)])
        end
        
        
        % Sanity Check
        [tmp.Ve,tmp.De]=eig(tmp.lin.A);
        [tmp.ev.magsorted,tmp.ev.idx]=sort(abs(real(diag(tmp.De))));
        
        tmp.idx.zeroev=tmp.ev.idx(1);
        
        if norm(tmp.lin.C*tmp.Ve(:,tmp.idx.zeroev))>etol
            error('The uncontrollable mode is not unobsevable')
        end
        
        
        disp('The linearized system passed the sanity checks')
        
        tmp.n_x=size(tmp.lin.A,2);
        tmp.n_y=size(tmp.lin.C,1);
        tmp.n_u=size(tmp.lin.B,2);
        
        tmp.mstring=['lin'];
        
        nstr = min(numel(tmp.model),numel(scomp));
        
        
        if tmp.model(1:nstr)==scomp(1:nstr)
            tmp.n_vi=15;
            tmp.n_dist=6;
            tmp.n_xr=nred;
            
            tmp.idx_gen=1:10;
            tmp.idx_wgen=1:10;
            tmp.idx_ddtwgen=41:50;          
            tmp.idx_pvi=11:25;
            tmp.idx_pgen=51:60;            
            tmp.idx_qvi=26:40;
            
            tmp.n_gen=length(tmp.idx_gen);
            tmp.idx_pllw=61:2:90;
            tmp.idx_plldw=62:2:90;

            %sparsity pattern
            Ftmp=zeros(30,90);
            Ftmp(1:tmp.n_vi,tmp.idx_pllw)=eye(tmp.n_vi);
            Ftmp(tmp.n_vi+1:2*tmp.n_vi,tmp.idx_plldw)=2*eye(tmp.n_vi);
            
            tmp.SP.d=(Ftmp==1);
            tmp.SP.m=(Ftmp==2);
            clear Ftmp
            
            tmp.opt.x0=0*ones(30,1);
        end
        
    case 'Australian14gen_forming_inertia'
        
        
        tmp.n_vi=15;
        tmp.n_dist=6;
        tmp.n_xr=nred;
        
        tmp.idx_gen=1:10;
        tmp.idx_wgen=1:10;
        tmp.idx_ddtwgen=41:50;
        tmp.idx_pgen=51:60;
        
        tmp.n_gen=length(tmp.idx_gen);
        tmp.idx_p=11:25;
        tmp.idx_pvi=11:25;
        tmp.idx_qvi=26:40;
        
        tmp.idx_w=61:75;
        tmp.idx_wvi=61:75;
        
        disp('sanity checks on linearization')
        
        if norm(tmp.lin.D,'fro')>1e-6
            error('Feedthrough matrix is not zero');
        end
        
        %temporary control gain for sanity checks
        tmp.F=kron([1 1],eye(15));
        
        %temporary closed loop for sanity checks
        tmp.Acl=tmp.lin.A-tmp.lin.B(:,tmp.n_dist+1:end)*tmp.F*tmp.lin.C([tmp.idx_p,tmp.idx_w],:);
        
        
        etol=1e-5;
        if any(real(eig(tmp.Acl))>etol)
            error(['the linearized system has an eigenvalue with real part larger than ',num2str(etol)])
        end
        
        
        % Sanity Check
        [tmp.Ve,tmp.De]=eig(tmp.Acl);
        [tmp.ev.magsorted,tmp.ev.idx]=sort(abs(real(diag(tmp.De))));
        
        tmp.idx.zeroev=tmp.ev.idx(1);
        
        if norm(tmp.lin.C*tmp.Ve(:,tmp.idx.zeroev))>etol
            error('The uncontrollable mode is not unobsevable')
        end
        
        
        disp('The linearized system passed the sanity checks')
        
        tmp.n_x=size(tmp.lin.A,2);
        tmp.n_y=size(tmp.lin.C,1);
        tmp.n_u=size(tmp.lin.B,2);
        
        tmp.mstring=['lin'];
        
        %sparsity pattern
        Ftmp=zeros(tmp.n_vi,tmp.n_y);
        Ftmp(:,tmp.idx_pvi)=eye(tmp.n_vi);
        Ftmp(:,tmp.idx_wvi)=2*eye(tmp.n_vi);

        tmp.SP.p=(Ftmp==1);
        tmp.SP.w=(Ftmp==2);
        clear Ftmp
        
        tmp.opt.x0=-1*ones(30,1);
        tmp.opt.x0(16:30)=-1*ones(15,1);
end
