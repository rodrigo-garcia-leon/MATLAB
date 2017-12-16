%DEMO_MAY2011 Demo of the May et al. (2011)
%  
%   This script does not work unless speakers1234 is provided
%
%
%   See also: may2011
%
%   Url: http://amtoolbox.sourceforge.net/doc/demos/demo_may2011.php

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

% Load a test signal.
[signal,fs]=competingtalkers('five_speakers');

% Perform localization
out = may2011(signal,fs);


%% Plot results
% 
% 
% Plot frame-based azimuth estimates
figure;
plot(out.azFrames,'k.','linewidth',2);
xlabel('Number of frames')
ylabel('Azimuth (deg)')
title('Frame-based azimuth estimates')
xlim([-inf inf])
ylim([-90 90])
grid on;
axis xy;

% Find all active sources, make no assumptions
nSources = inf;

% Histogram analysis of frame-based localization estimates
estAzimuth_GMM(out,'HIST',nSources);

% Plot time-frequency-based azimuth estimates
figure;
imagesc(out.azimuth,[-90 90]);
xlabel('Number of frames')
ylabel('Number of gammatone channels')
title('Time-frequency-based azimuth estimates')
colorbar;
cbarlabel('Azimuth (deg)')
axis xy;

% Plot binaural cues
figure;
imagesc(out.itd,[-1e-3 1e-3]);
xlabel('Number of frames')
ylabel('Number of gammatone channels')
title('Interaural time difference (ITD)')
colorbar;
cbarlabel('ITD (ms)')
axis xy;

figure;
imagesc(out.ild);
xlabel('Number of frames')
ylabel('Number of gammatone channels')
title('Interaural level difference (ILD)')
colorbar;
cbarlabel('ILD (dB)')
axis xy;

figure;
imagesc(out.ic);
xlabel('Number of frames')
ylabel('Number of gammatone channels')
title('Interaural coherence (IC)')
colorbar;
cbarlabel('IC')
axis xy;

% Arrange open figures on screen
arrange(1:6,[3 2])
