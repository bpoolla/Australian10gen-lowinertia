function plotvi(sys)

switch sys.model
    case 'Australian14gen_following_inertia'
        for i=1:15
            vilabel{i}=sys.vistrings(i,3:end);
        end
        
        cy=[255, 170, 51]/255;
        cb=[39, 58, 95]/255;
        
        figure(10011)
        b=bar([-sys.opt.d,-sys.opt.m]*1e2/(2*pi*50),'grouped'); % The units were in MW/pu
        b(2).FaceColor=cy;
        b(1).FaceColor=cb;
        legend('damping[MW s/rad]','inertia[MW s^2/rad]','orientation','horizontal','location','northwest')
        set(gca,'xticklabel',vilabel)
        grid on
        box on
        
        figure(10021),clf
        subplot(4,5,1)
        plot(sys.tdsim.red.Ts,50*sys.tdsim.red.Ys(:,sys.idx_wgen))
        grid on
        box on
        xlabel('t [s]')
        ylabel('\omega [Hz]')
        title('linear, reduced, open loop')
        
        subplot(4,5,2)
        plot(sys.tdsim.red.Ts,50*sys.tdsim.red.Ys(:,sys.idx_ddtwgen))
        grid on
        box on
        xlabel('t [s]')
        ylabel('\dot \omega [Hz/s]')
        title('linear, reduced, open loop')        
        
        subplot(4,5,3)
        plot(sys.tdsim.red.Ts,sys.GenPU*sys.tdsim.red.Ys(:,sys.idx_pgen)')
        grid on
        box on
        xlabel('t [s]')
        ylabel('P_{gen} [MW]')
        title('linear, reduced, open loop')     
        
        subplot(4,5,4)
        plot(sys.tdsim.red.Ts,100*sys.tdsim.red.Ys(:,sys.idx_pvi))
        grid on
        box on
        xlabel('t [s]')
        ylabel('P_{vi} [MW]') 
        title('linear, reduced, open loop')       
        
        subplot(4,5,5)
        plot(sys.tdsim.red.Ts,100*sys.tdsim.red.Ys(:,sys.idx_qvi))
        grid on
        box on
        xlabel('t [s]')
        ylabel('Q_{vi} [MW]')
        title('linear, reduced, open loop')       
        
        
        subplot(4,5,6)
        plot(sys.tdsim.nl.Ts,50*sys.tdsim.nl.Ys(:,sys.idx_wgen))
        grid on
        box on
        xlabel('t [s]')
        ylabel('\omega [Hz]')
        title('nonlinear,  open loop')    
        
        subplot(4,5,7)
        plot(sys.tdsim.nl.Ts,50*sys.tdsim.nl.Ys(:,sys.idx_ddtwgen))
        grid on
        box on
        xlabel('t [s]')
        ylabel('\dot \omega [Hz/s]')
        title('nonlinear,  open loop')          
        
        subplot(4,5,8)
        plot(sys.tdsim.nl.Ts,sys.GenPU*sys.tdsim.nl.Ys(:,sys.idx_pgen)')
        grid on
        box on
        xlabel('t [s]')
        ylabel('P_{gen} [MW]')
        title('nonlinear,  open loop')    
        
        subplot(4,5,9)
        plot(sys.tdsim.nl.Ts,100*sys.tdsim.nl.Ys(:,sys.idx_pvi))
        grid on
        box on
        xlabel('t [s]')
        ylabel('P_{vi} [MW]') 
        title('nonlinear,  open loop')    
        
        subplot(4,5,10)
        plot(sys.tdsim.nl.Ts,100*sys.tdsim.nl.Ys(:,sys.idx_qvi))
        grid on
        box on
        xlabel('t [s]')
        ylabel('Q_{vi} [MW]')
        title('nonlinear,  open loop')    
        
        subplot(4,5,11)
        plot(sys.tdsim.redcl.Ts,50*sys.tdsim.redcl.Ys(:,sys.idx_wgen))
        grid on
        box on
        xlabel('t [s]')
        ylabel('\omega [Hz]')
        title('linear, reduced, closed loop')
        
        subplot(4,5,12)
        plot(sys.tdsim.redcl.Ts,50*sys.tdsim.redcl.Ys(:,sys.idx_ddtwgen))
        grid on
        box on
        xlabel('t [s]')
        ylabel('\dot \omega [Hz/s]')
        title('linear, reduced, closed loop')        
        
        subplot(4,5,13)
        plot(sys.tdsim.redcl.Ts,sys.GenPU*sys.tdsim.redcl.Ys(:,sys.idx_pgen)')
        grid on
        box on
        xlabel('t [s]')
        ylabel('P_{gen} [MW]')
        title('linear, reduced, closed loop')     
        
        subplot(4,5,14)
        plot(sys.tdsim.redcl.Ts,100*sys.tdsim.redcl.Ys(:,sys.idx_pvi))
        grid on
        box on
        xlabel('t [s]')
        ylabel('P_{vi} [MW]') 
        title('linear, reduced, closed loop')       

        subplot(4,5,15)
        plot(sys.tdsim.redcl.Ts,100*sys.tdsim.redcl.Ys(:,sys.idx_qvi))
        grid on
        box on
        xlabel('t [s]')
        ylabel('Q_{vi} [MW]') 
        title('linear, reduced, closed loop')   

        subplot(4,5,16)
        plot(sys.tdsim.nlcl.Ts,50*sys.tdsim.nlcl.Ys(:,sys.idx_wgen))
        grid on
        box on
        xlabel('t [s]')
        ylabel('\omega [Hz]')
        title('nonlinear,  closed loop')   
        
        subplot(4,5,17)
        plot(sys.tdsim.nlcl.Ts,50*sys.tdsim.nlcl.Ys(:,sys.idx_ddtwgen))
        grid on
        box on
        xlabel('t [s]')
        ylabel('\dot \omega [Hz/s]')
        title('nonlinear,  closed loop')         
        
        subplot(4,5,18)
        plot(sys.tdsim.nlcl.Ts,sys.GenPU*sys.tdsim.nlcl.Ys(:,sys.idx_pgen)')
        grid on
        box on
        xlabel('t [s]')
        ylabel('P_{gen} [MW]')
        title('nonlinear,  closed loop')  
        
        subplot(4,5,19)
        plot(sys.tdsim.nlcl.Ts,100*sys.tdsim.nlcl.Ys(:,sys.idx_pvi))
        grid on
        box on
        xlabel('t [s]')
        ylabel('P_{vi} [MW]') 
        title('nonlinear,  closed loop')  
        
        subplot(4,5,20)
        plot(sys.tdsim.nlcl.Ts,100*sys.tdsim.nlcl.Ys(:,sys.idx_qvi))
        grid on
        box on
        xlabel('t [s]')
        ylabel('Q_{vi} [MW]') 
        title('nonlinear,  closed loop')      
        
        
       
        
        
    case 'Australian14gen_forming_inertia'
        
        for i=1:15
            vilabel{i}=sys.vistrings(i,3:end);
        end
        
        cy=[255, 170, 51]/255;
        cb=[39, 58, 95]/255;
        
        m_opt=-sys.Kv(1:2:30).^-1*100;
        d_opt=sys.Kv(2:2:30)./sys.Kv(1:2:30)*100;
        m_opt(m_opt=='inf')=0;
        d_opt(d_opt=='inf')=0;
        
        figure(1001)
        b=bar([d_opt,m_opt],'grouped');
        b(2).FaceColor=cy;
        b(1).FaceColor=cb;
        legend('damping [MW s/rad]','inertia [MW s^2/rad]','orientation','horizontal','location','northwest')
        set(gca,'xticklabel',vilabel)
        grid on
        box on
        
        
 
        figure(1002),clf
       
        
        subplot(2,4,1)
        plot(sys.tdsim.redcl.Ts,50*sys.tdsim.redcl.Ys(:,sys.idx_wgen)/1000)
        grid on
        box on
        xlabel('t [s]')
        ylabel('\omega [Hz]')
        title('linear, reduced, closed loop')
        
        subplot(2,4,2)
        plot(sys.tdsim.redcl.Ts,50*sys.tdsim.redcl.Ys(:,sys.idx_ddtwgen)/1000)
        grid on
        box on
        xlabel('t [s]')
        ylabel('\dot \omega [Hz/s]')
        title('linear, reduced, closed loop')        
        
        subplot(2,4,3)
        plot(sys.tdsim.redcl.Ts,sys.GenPU*sys.tdsim.redcl.Ys(:,sys.idx_pgen)')
        grid on
        box on
        xlabel('t [s]')
        ylabel('P_{gen} [MW]')
        title('linear, reduced, closed loop')     
        
        subplot(2,4,4)
        plot(sys.tdsim.redcl.Ts,100*sys.tdsim.redcl.Ys(:,sys.idx_pvi))
        grid on
        box on
        xlabel('t [s]')
        ylabel('P_{vi} [MW]') 
        title('linear, reduced, closed loop')       


        subplot(2,4,5)
        plot(sys.tdsim.nlcl.Ts,50*sys.tdsim.nlcl.Ys(:,sys.idx_wgen))
        grid on
        box on
        xlabel('t [s]')
        ylabel('\omega [Hz]')
       title('nonlinear,  closed loop')    
        
        subplot(2,4,6)
        plot(sys.tdsim.nlcl.Ts,50*sys.tdsim.nlcl.Ys(:,sys.idx_ddtwgen))
        grid on
        box on
        xlabel('t [s]')
        ylabel('\dot \omega [Hz/s]')
        title('nonlinear,  closed loop')      
        
        subplot(2,4,7)
        plot(sys.tdsim.nlcl.Ts,sys.GenPU*sys.tdsim.nlcl.Ys(:,sys.idx_pgen)')
        grid on
        box on
        xlabel('t [s]')
        ylabel('P_{gen} [MW]')
        title('nonlinear,  closed loop') 
        
        subplot(2,4,8)
        plot(sys.tdsim.nlcl.Ts,100*sys.tdsim.nlcl.Ys(:,sys.idx_pvi))
        grid on
        box on
        xlabel('t [s]')
        ylabel('P_{vi} [MW]') 
        title('nonlinear,  closed loop')              
                
end
