function m = baumgartner2014virtualexp(p,tang,rang,varargin)
%BAUMGARTNER2014VIRTUALEXP Response patterns of virtual localization experiments
%   Usage:    m = baumgartner2014virtualexp(p,tang,rang)
%
%   Input parameters:
%     p       : prediction matrix containing probability mass vectors (PMVs) 
%               for the polar response angle as a function of the polar  
%               target angle (1st dim: response angle, 2nd dim: target
%               angle)
%     rang    : polar response angles
%     tang    : polar target angles
%
%   Output parameter:
%     m       : item list of virtual experiment
%               Columns: 
%                1:4 ...   azi_target,ele_target,azi_response,ele_response
%                5:8 ...   lat_target,pol_target,lat_response,pol_response
%                9   ...   F/B-C resolved pol_response
%
%   BAUMGARTNER2014VIRTUALEXP(...) runs virtual localization experiments where the
%   response behavior is based on (predicted) polar response PMVs.
%
%   BAUMGARTNER2014VIRTUALEXP accepts the following optional parameters:
%
%     'runs',runs    	Define the number of runs. 
%                    	Default value is 1.
%
%     'targetset',ts  Define the set of polar target angles.
%                    	As default 'tang' is used.
%
%     'lat',lat     	Define the lateral target angles. 
%                    	Default value is 0 deg.
%
%   See also: baumgartner2014, plotbaumgartner2013
%
%
%   Url: http://amtoolbox.sourceforge.net/doc/modelstages/baumgartner2014virtualexp.php

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

%   References: baumgartner2014

    
% AUTHOR: Robert Baumgartner

definput.keyvals.runs = 1;
definput.keyvals.targetset = [];
definput.keyvals.lat = 0;
% definput.flags.colorbar = {'colorbar','nocolorbar'};
[flags,kv]=ltfatarghelper({'runs','targetset'},definput,varargin);

if isempty(kv.targetset)
  kv.targetset = tang;
end


%% Run experiments
nt=length(kv.targetset);
m = nan(nt*kv.runs,9);
m(:,5) = kv.lat;
m(:,6) = repmat(kv.targetset(:),kv.runs,1);
m(:,7) = kv.lat;
% kv.targetset = round(kv.targetset);
if length(tang) > 1
  tangbound = tang(:)+0.5*diff([tang(1)-diff(tang(1:2));tang(:)]);
else
  tangbound = tang;
end
post=zeros(nt,1); % indices of target positions
for ii = 1:nt
    post(ii) = find(tangbound>=kv.targetset(ii),1);
end

posr=zeros(nt,1);
for rr=1:kv.runs
  for jj = 1:nt 
    posr(jj) = discreteinvrnd(p(:,post(jj)),1);
    m(jj+(rr-1)*nt,8) = rang(posr(jj));
  end
end



end


function [ X ] = discreteinvrnd(p,n,m)
% DISCRETEINVRND implements an inversion method for a discrete distribution
% with probability mass vector p for n trials
% Usage:    [ X ] = discreteinvrnd(p,n)
%
% AUTHOR : Robert Baumgartner

if ~exist('m','var')
    m=1;
end

p = p/sum(p);   % ensure probability mass vector
c = cumsum(p);
t = max(c)*rand(n,m); % rand returns ]0,1]
X = zeros(n,m);
for jj = 1:m
    for ii = 1:n
        X(ii,jj) = find(c >= t(ii,jj) ,1);
    end
end

end
