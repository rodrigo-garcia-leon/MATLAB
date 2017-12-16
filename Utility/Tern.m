function o = Tern(p,t,f)
% function o = Tern(p,t,f)
% 
% Basic ternary operator.
% 
% Inputs:
% p: Predicate.
% t: Output if true.
% f: Output if false.
% 
% Outputs:
% o: Result.
% 
% Author: Rodrigo Garc�a

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    if p
        o = t;
    else
        o = f;
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end
