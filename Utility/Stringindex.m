function i = Stringindex(c,s)
% function i = Stringindex(c,s)
% 
% Returns the cell index of the given string.
% 
% Inputs:
% c: The cell array to search.
% s: The string to search.
% 
% Outputs:
% i: The cell index of the string.
% 
% Author: Rodrigo Garc�a

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    i = find(~cellfun('isempty',strfind(c,s)));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
end
