function vals = Extract_values(c)
% function vals = Extract_values(c)
% 
% Extract values from cell array of answers structs.
% 
% Inputs:
% c: The cell array to use.
% 
% Outputs:
% vals: The extracted values.
% 
% Author: Rodrigo Garc�a

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    vals = cellfun(@(x)x.val,c);
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end
    