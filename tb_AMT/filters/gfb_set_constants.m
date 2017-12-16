% This file defines global constants for the matlab gammatone filterbank
% implementation.
%
% copyright: Universitaet Oldenburg
% author   : tp
% date     : Jan 2002, Nov 2006
%
%   Url: http://amtoolbox.sourceforge.net/doc/filters/gfb_set_constants.php

% Copyright (C) 2009-2014 Peter L. Søndergaard and Piotr Majdak.
% This file is part of AMToolbox version 0.9.6
%
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>.

% filename : gfb_set_constants

global GFB_L GFB_Q GFB_PREFERED_GAMMA_ORDER GFB_GAINCALC_ITERATIONS;

GFB_L = 24.7;  % see equation (17) in [Hohmann 2002]
GFB_Q = 9.265; % see equation (17) in [Hohmann 2002]

% We will use 4th order gammatone filters:
GFB_PREFERED_GAMMA_ORDER = 4;

% The gain factors are approximated in iterations. This is the default
% number of iterations:
GFB_GAINCALC_ITERATIONS  = 100;

