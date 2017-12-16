function data = data_ziegelwanger2013(varargin)
%DATA_ZIEGELWANGER2013  Data from Ziegelwanger and Majdak (2013)
%   Usage: data = data_ziegelwanger2013(flag)
%
%   DATA_ZIEGELWANGER2013(flag) returns results for different HRTF
%   databases from Ziegelwanger and Majdak (2013).
%
%   The flag may be one of:
%  
%     'ARI'         ARI database. The output has the following
%                   fields: data.results and data.subjects.
%  
%     'CIPIC'       CIPIC database. The output has the following fields: 
%                   data.results and data.subjects.
%  
%     'LISTEN'      LISTEN database. The output has the following fields.
%                   data.results and data.subjects.
%  
%     'SPHERE_ROT'  HRTF sets for a rigid sphere placed in the center of
%                   the measurement setup and varying rotation. The
%                   output has the following fields: data.results,
%                   data.subjects, data.phi, data.theta and data.radius.
%  
%     'SPHERE_DIS'  HRTF sets for a rigid sphere with various positions in
%                   the measurement setup. The output has the following fields: 
%                   data.results, data.subjects, data.xM, data.yM,
%                   data.zM and data.radius.
%  
%     'NH89'        HRTF set of listener NH89 of the ARI database: The
%                   output has the following fields: data.hM,
%                   data.meta and data.stimPar.
%  
%     'reload'      Reload previously calculated results    
%  
%     'recalc'      Recalculate the results  
%
%   The fields are given by:
%
%     data.results     Results for all HRTF sets
%
%     data.subjects    IDs for HRTF sets
%
%     data.phi         Azimuth of ear position
%
%     data.theta       Elevation of ear position
%
%     data.radius      sphere radius
%
%     data.xM          x-coordinate of sphere center
%
%     data.yM          y-coordinate of sphere center
%
%     data.zM          z-coordinate of sphere center
%
%     data             SOFA object
%
%   Requirements: 
%   -------------
%
%   1) SOFA API from http://sourceforge.net/projects/sofacoustics for Matlab (in e.g. thirdparty/SOFA)
% 
%   2) Optimization Toolbox for Matlab
%
%   3) Data in hrtf/ziegelwanger2013
% 
%   Examples:
%   ---------
% 
%   To get results from the ARI database, use:
%
%     data=data_ziegelwanger2013('ARI');
%
%   See also: ziegelwanger2013, ziegelwanger2013onaxis,
%   ziegelwanger2013offaxis, exp_ziegelwanger2013
%
%   References:
%     P. Majdak and H. Ziegelwanger. Continuous-direction model of the
%     broadband time-of-arrival in the head-related transfer functions. In
%     ICA 2013 Montreal, volume 19, page 050016, Montreal, Canada, 2013. ASA.
%     
%     H. Ziegelwanger and P. Majdak. Modeling the broadband time-of-arrival
%     of the head-related transfer functions for binaural audio. In
%     Proceedings of the 134th Convention of the Audio Engineering Society,
%     page 7, Rome, 2013.
%     
%
%   Url: http://amtoolbox.sourceforge.net/doc/humandata/data_ziegelwanger2013.php

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

% AUTHOR: Harald Ziegelwanger, Acoustics Research Institute, Vienna,
% Austria

%% ------ Check input options --------------------------------------------

% Define input flags
definput.flags.type = {'missingflag','ARI','CIPIC','LISTEN','SPHERE_DIS','SPHERE_ROT','NH89'};
definput.flags.results = {'reload','recalc'};

% Parse input options
[flags,keyvals]  = ltfatarghelper({},definput,varargin);

if flags.do_missingflag
    flagnames=[sprintf('%s, ',definput.flags.type{2:end-2}),...
        sprintf('%s or %s',definput.flags.type{end-1},definput.flags.type{end})];
    error('%s: You must specify one of the following flags: %s.',upper(mfilename),flagnames);
else
    hpath = which('hrtfinit');  % find local path of hrtf repository
    hpath = hpath(1:end-10);
    
    hpath = [hpath 'ziegelwanger2014' filesep];
    
    if ~exist([hpath filesep 'info.mat'],'file')
        urlwrite([SOFAdbURL '/ziegelwanger2014/info.mat'],[hpath filesep 'info.mat']);
    end
end

%% ARI database
if flags.do_ARI
    
    if ~flags.do_recalc && ~exist([hpath '..' filesep '..' filesep 'experiments' filesep 'exp_ziegelwanger2013_ARI.mat'],'file')
        urlwrite([SOFAdbURL '/ziegelwanger2013/exp_ziegelwanger2013_ARI.mat'],[hpath '..' filesep '..' filesep 'experiments' filesep 'exp_ziegelwanger2013_ARI.mat']);
    end
    if flags.do_recalc
        tmp=load([hpath filesep 'info.mat']);
        data=tmp.info.ARI;
        for ii=1:length(data.subjects)
            Obj=SOFAload([hpath filesep 'ARI_' data.subjects{ii} '.sofa']);
            idx=find(mod(Obj.SourcePosition(:,2),10)==0);
            Obj.Data.IR=Obj.Data.IR(idx,:,:);
            Obj.SourcePosition=Obj.SourcePosition(idx,:);
            Obj.MeasurementSourceAudioChannel=Obj.MeasurementSourceAudioChannel(idx,:);
            Obj.MeasurementAudioLatency=Obj.MeasurementAudioLatency(idx,:);
            Obj.API.M=length(idx);
            
            [Obj,tmp]=ziegelwanger2013(Obj,4,1);
            results(ii).meta=tmp;
            results(ii).meta.performance(4)=tmp.performance;
            [~,tmp]=ziegelwanger2013(Obj,1,0);
            results(ii).meta.performance(1)=tmp.performance;
            [~,tmp]=ziegelwanger2013(Obj,2,0);
            results(ii).meta.performance(2)=tmp.performance;
            [~,tmp]=ziegelwanger2013(Obj,3,0);
            results(ii).meta.performance(3)=tmp.performance;
            clear hM; clear meta; clear stimPar;
        end
        save([hpath '..' filesep '..' filesep 'experiments' filesep 'exp_ziegelwanger2013_ARI.mat'],'results');
        data.results=results;
    else
        tmp=load([hpath filesep 'info.mat']);
        data=tmp.info.ARI;
        load([hpath '..' filesep '..' filesep 'experiments' filesep 'exp_ziegelwanger2013_ARI.mat']);
        data.results=results;
    end
    
end

%% CIPIC database
if flags.do_CIPIC
    
    if ~flags.do_recalc && ~exist([hpath '..' filesep '..' filesep 'experiments' filesep 'exp_ziegelwanger2013_CIPIC.mat'],'file')
        urlwrite([SOFAdbURL '/ziegelwanger2013/exp_ziegelwanger2013_CIPIC.mat'],[hpath '..' filesep '..' filesep 'experiments' filesep 'exp_ziegelwanger2013_CIPIC.mat']);
    end
    if flags.do_recalc
        tmp=load([hpath filesep 'info.mat']);
        data=tmp.info.CIPIC;
        for ii=1:length(data.subjects)
            Obj=SOFAload([hpath filesep 'CIPIC_' data.subjects{ii} '.sofa']);

            [Obj,tmp]=ziegelwanger2013(Obj,4,1);
            results(ii).meta=tmp;
            results(ii).meta.performance(4)=tmp.performance;
            [~,tmp]=ziegelwanger2013(Obj,1,0);
            results(ii).meta.performance(1)=tmp.performance;
            [~,tmp]=ziegelwanger2013(Obj,2,0);
            results(ii).meta.performance(2)=tmp.performance;
            [~,tmp]=ziegelwanger2013(Obj,3,0);
            results(ii).meta.performance(3)=tmp.performance;
            clear hM; clear meta; clear stimPar;
        end
        save([hpath '..' filesep '..' filesep 'experiments' filesep 'exp_ziegelwanger2013_CIPIC.mat'],'results');
        data.results=results;
    else
        tmp=load([hpath filesep 'info.mat']);
        data=tmp.info.CIPIC;
        load([hpath '..' filesep '..' filesep 'experiments' filesep 'exp_ziegelwanger2013_CIPIC.mat']);
        data.results=results;
    end
    
end

%% LISTEN database
if flags.do_LISTEN
    
    if ~flags.do_recalc && ~exist([hpath '..' filesep '..' filesep 'experiments' filesep 'exp_ziegelwanger2013_LISTEN.mat'],'file')
        urlwrite([SOFAdbURL '/ziegelwanger2013/exp_ziegelwanger2013_LISTEN.mat'],[hpath '..' filesep '..' filesep 'experiments' filesep 'exp_ziegelwanger2013_LISTEN.mat']);
    end
    if flags.do_recalc
        tmp=load([hpath filesep 'info.mat']);
        data=tmp.info.LISTEN;
        for ii=1:length(data.subjects)
            if ~strcmp(data.subjects{ii},'34')
                Obj=SOFAload([hpath filesep 'LISTEN_' data.subjects{ii} '.sofa']);
                Obj.Data.SamplingRate=48000;
                
                [Obj,tmp]=ziegelwanger2013(Obj,4,1);
                results(ii).meta=tmp;
                results(ii).meta.performance(4)=tmp.performance;
                [~,tmp]=ziegelwanger2013(Obj,1,0);
                results(ii).meta.performance(1)=tmp.performance;
                [~,tmp]=ziegelwanger2013(Obj,2,0);
                results(ii).meta.performance(2)=tmp.performance;
                [~,tmp]=ziegelwanger2013(Obj,3,0);
                results(ii).meta.performance(3)=tmp.performance;
                clear hM; clear meta; clear stimPar;
            end
        end
        save([hpath '..' filesep '..' filesep 'experiments' filesep 'exp_ziegelwanger2013_LISTEN.mat'],'results');
        data.results=results;
    else
        tmp=load([hpath filesep 'info.mat']);
        data=tmp.info.LISTEN;
        load([hpath '..' filesep '..' filesep 'experiments' filesep 'exp_ziegelwanger2013_LISTEN.mat']);
        data.results=results;
    end
    
end

%% SPHERE (Displacement) database
if flags.do_SPHERE_DIS
    
    if ~flags.do_recalc && ~exist([hpath '..' filesep '..' filesep 'experiments' filesep 'exp_ziegelwanger2013_SPHERE_DIS.mat'],'file')
        urlwrite([SOFAdbURL '/ziegelwanger2013/exp_ziegelwanger2013_SPHERE_DIS.mat'],[hpath '..' filesep '..' filesep 'experiments' filesep 'exp_ziegelwanger2013_SPHERE_DIS.mat']);
    end
    if flags.do_recalc
        tmp=load([hpath filesep 'info.mat']);
        data=tmp.info.Sphere_Displacement;
        results.p_onaxis=zeros(4,2,length(data.subjects));
        results.p_offaxis=zeros(7,2,length(data.subjects));
        for ii=1:length(data.subjects)
            Obj=SOFAload([hpath filesep 'Sphere_Displacement_' data.subjects{ii} '.sofa']);
            [~,tmp]=ziegelwanger2013(Obj,4,1);
            results.p_onaxis(:,:,ii)=tmp.p_onaxis;
            results.p_offaxis(:,:,ii)=tmp.p_offaxis;
        end
        save([hpath '..' filesep '..' filesep 'experiments' filesep 'exp_ziegelwanger2013_SPHERE_DIS.mat'],'results');
        data.results=results;
    else
        tmp=load([hpath filesep 'info.mat']);
        data=tmp.info.Displacement;
        load([hpath '..' filesep '..' filesep 'experiments' filesep 'exp_ziegelwanger2013_SPHERE_DIS.mat']);
        data.results=results;
    end
    
end

%% SPHERE (Rotation) database
if flags.do_SPHERE_ROT
    
    if ~flags.do_recalc && ~exist([hpath '..' filesep '..' filesep 'experiments' filesep 'exp_ziegelwanger2013_SPHERE_ROT.mat'],'file')
        urlwrite([SOFAdbURL '/ziegelwanger2013/exp_ziegelwanger2013_SPHERE_ROT.mat'],[hpath '..' filesep '..' filesep 'experiments' filesep 'exp_ziegelwanger2013_SPHERE_ROT.mat']);
    end
    if flags.do_recalc
        tmp=load([hpath filesep 'info.mat']);
        data=tmp.info.Sphere_Rotation;
        results.p=zeros(4,2,length(data.phi));
        for ii=1:length(data.subjects)
            Obj=SOFAload([hpath filesep 'Sphere_Rotation_' data.subjects{ii} '.sofa']);
            [~,tmp]=ziegelwanger2013(Obj,4,1);
            results.p_onaxis(:,:,ii)=tmp.p_onaxis;
        end
        save([hpath '..' filesep '..' filesep 'experiments' filesep 'exp_ziegelwanger2013_SPHERE_ROT.mat'],'results');
        data.results=results;
    else
        tmp=load([hpath filesep 'info.mat']);
        data=tmp.info.Rotation;
        load([hpath '..' filesep '..' filesep 'experiments' filesep 'exp_ziegelwanger2013_SPHERE_ROT.mat']);
        data.results=results;
    end
    
end

%% ARI database (NH89)
if flags.do_NH89
    
    data=SOFAload([hpath filesep 'ARI_NH89.sofa']);
    
end
