function temp=a3datablock(id,filename,device,channels)
% result=a3datablock(id,filename,device,chanenls)
%
% lf=sprintf('\n'); % enter
% tb=sprintf('\t'); % tab
% 
% Comments by Alejandro Osses, ExpORL 2013
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if (nargin<4)
    channels=0;
end

if (nargin<3)
    device='';
end

lf=sprintf('\n');
tb=sprintf('\t');

temp=['<datablock id="' id '">' lf];
if (~isempty(device))
    temp=[temp tb '<device>' device '</device>' lf];
end
temp=[temp tb '<uri>' xmlfilename(filename) '</uri>' lf];
if (channels)
   temp=[temp wraptag('channels', num2str(channels))]; 
end
temp=[temp '</datablock>' lf];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%