function bp = amtbasepath;
%AMTBASEPATH  The base path of the AMT installation
%   Usage: bp = amtbasepath;
%
%   AMTBASEPATH returns the top level directory in which the AMT
%   files are installed.
%
%   See also: amtstart
%
%   Url: http://amtoolbox.sourceforge.net/doc/amtbasepath.php

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
  
f=mfilename('fullpath');

bp = f(1:end-11);

