function path = Get_path(name)
% function path = Get_path(name)
% 
% Function to retrieve support paths that change according to the runtime
% environment.
% 
% Author: Rodrigo Garc�a

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    paths = Get_TUe_paths;

    APEX_shared = ['/Users/rodrigo/VirtualBox VMs/Luxuria/share/'...
        'APEX_shared/'];
    
    LaTeX = '/Users/rodrigo/Documents/TUe/thesis/latex/';
    
    LaTeX_FluctuationStrength = [LaTeX 'topic/fluctuation_strength/'];

    paths.APEX_stimulus     = [ APEX_shared 'stimulus/' ];
    paths.APEX_experiment   = [ APEX_shared 'experiment/' ];
    paths.APEX_result       = [ APEX_shared 'result/' ];
    
    paths.LaTeX_FluctuationStrength_Experiment_img = [ ...
        LaTeX_FluctuationStrength 'experiment/' 'img/'
    ];

    paths.LaTeX_FluctuationStrength_TestBattery_img = [ ...
        LaTeX_FluctuationStrength 'test_battery/' 'img/'...
    ];

    paths.LaTeX_FluctuationStrength_Pilot_img = [ ...
        LaTeX_FluctuationStrength 'pilot/' 'img/'
    ];
    
    if ~isfield(paths,name)
        error('The requested path has not been defined!');
    end
    
    path = paths.(name);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end
