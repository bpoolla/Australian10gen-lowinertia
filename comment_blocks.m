function comment_blocks(sys)

vibus=[102; 208; 212; 215; 216; 308; 309; 312; 314; 403; 405; 410; 502; 504; 508];
lfbus=[ 24;  28;  27;  26;  25;  20;  23;  22;  21;   1;  29;  16;  18;  17;  19];

switch sys.model
    
    case 'Australian14gen_following_inertia'
        
        node='Australian14gen_inertia/Measurements_VI';
        set_param(node,'commented','off')
        
        node='Australian14gen_inertia/Measurements_low';
        set_param(node,'commented','on')    
        
        for i=1:15
            node=['Australian14gen_inertia/VI',num2str(vibus(i,:)),'_form'];
            set_param(node,'commented','on')

            node=['Australian14gen_inertia/','VI',num2str(vibus(i,:))];
            set_param(node,'commented','off')            
        end        
    case 'Australian14gen_forming_inertia'
        
        node='Australian14gen_inertia/Measurements_VI';
        set_param(node,'commented','off')
        
        node='Australian14gen_inertia/Measurements_low';
        set_param(node,'commented','on')        
        
        for i=1:15
            node=['Australian14gen_inertia/VI',num2str(vibus(i,:)),'_form'];
            set_param(node,'commented','off')

            node=['Australian14gen_inertia/','VI',num2str(vibus(i,:))];
            set_param(node,'commented','on')    
        end  
    case 'Australian14gen_low_inertia'
        
        node='Australian14gen_inertia/Measurements_VI';
        set_param(node,'commented','on')
        
        node='Australian14gen_inertia/Measurements_low';
        set_param(node,'commented','off')    
        
        for i=1:15
            node=['Australian14gen_inertia/VI',num2str(vibus(i,:)),'_form'];
            set_param(node,'commented','on')

            node=['Australian14gen_inertia/','VI',num2str(vibus(i,:))];
            set_param(node,'commented','on')    
        end          
end