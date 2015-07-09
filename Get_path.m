function path = Get_path(name)
% function path = Get_path(name)
% 
% Function to retrieve support paths that change according to the runtime
% environment.
% 
% Author: Rodrigo Garc�a

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    APEX_shared = '/Users/rodrigo/VirtualBox VMs/Luxuria/share/APEX_shared/';
    LaTeX       = '/Users/rodrigo/Documents/TUe/thesis/latex/';    

    paths.APEX_stimulus     = [ APEX_shared 'stimulus/' ];
    paths.APEX_experiment   = [ APEX_shared 'experiment/' ];
    paths.APEX_result       = [ APEX_shared 'result/' ]; 
    
    paths.LaTeX_FluctuationStrength_Experiment_img = [ ...
        LaTeX ...
        'fluctuation_strength/' ...
        'experiment/' ...
        'img/' ...
    ];
    
    if ~isfield(paths,name)
        error('The requested path has not been defined!');
    end
    
    path = paths.(name);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end
