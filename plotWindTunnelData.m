% plotWindTunnelData.m
%
%Script for AENG11301 lab 1 to plot wind tunnel data
% load in experimental data - contains cell array "wtData"
load('WindTunnelData.mat');
% plot data for 0 deg flap deployment
figure;
plot(wtData{1,2}(:,1),wtData{1,2}(:,2),'x-');
title('0 deg flap setting');
xlabel('angle of incidence, \alpha (deg)');
ylabel('C_L');

% find CLmax and AoA occurs at for 0 deg flap setting 
[CLmax,index] = max(wtData{1,2}(:,2)); 
CLmaxAoA=wtData{1,2}(index,1);
hold all 
plot(CLmaxAoA, CLmax,'ro');

% fit line of best fit to linear portion 
nPoints=4; % defines how many points to exclude from fit
fittingData=wtData{1,2}(1:end-nPoints,:); 
polyCoeff=polyfit(fittingData(:,1),fittingData(:,2),1);
CLfit=polyval(polyCoeff,fittingData(:,1)); 
plot(fittingData(:,1),CLfit,'k:');

% plot data for each flap setting and collect CLmax data
% calculate number of flap settings
nFlap=size(wtData,1);
% create a new figure to plot all data on
figure;
hold all

% use a for loop to look at each row of the cell array
for iFlap=1:nFlap
% find CLmax and CLmaxAOA for each setting 
[CLmaxFlap(iFlap),index] = max(wtData{iFlap,2}(:,2)); 
CLmaxAoAFlap(iFlap)=wtData{iFlap,2}(index,1);
% store flap setting 
flapAngle(iFlap)=wtData{iFlap,1};
% trim data for fitting 
fittingData=wtData{iFlap,2}(1:end-nPoints,:);
% fit linear polynomial to trimmed data 
polyCoeff=polyfit(fittingData(:,1),fittingData(:,2),1);
% store CL gradient 
CLslopeFlap(iFlap)=polyCoeff(1,2);
% plot AoA vs CL 
plot(wtData{iFlap,2}(:,1),wtData{iFlap,2}(:,2),'x-');
end

% label plot axes
xlabel('angle of incidence, \alpha (deg)');
ylabel('C_L');
% add legend by converting numeric matrix to strings
legend(num2str(flapAngle'));

% plot effect of flap settings on CLmax and linear slope
figure; 
subplot(3,1,1);
plot(flapAngle,CLmaxFlap,'-o')
xlabel('Flap angle (deg)');
ylabel('C_{Lmax}');
subplot(3,1,2); 
plot(flapAngle,CLmaxAoAFlap,'-o')
xlabel('Flap angle (deg)');
ylabel('\alpha at C_{Lmax} (deg)');
subplot(3,1,3); 
plot(flapAngle,CLslopeFlap,'-o')
xlabel('Flap angle (deg)');
ylabel('C_L gradient (1/deg)');
% load in aerofoil profile -contains matrix "nacaProfile"
load('NACA66(215)216profile.mat');
% plot CL curve for 0deg flap
figure;
subplot(1,2,1)
plot(wtData{1,2}(:,1),wtData{1,2}(:,2),'x-');
hold on
% create marker for current AoA storing handle to object
CLHandle=plot(wtData{1,2}(1,1),wtData{1,2}(1,2),'ro');
xlabel('angle of incidence, \alpha (deg)');
ylabel('C_L');
% plot aerofoil profile storing handle to object
subplot(1,2,2)
nacaHandle=plot(nacaProfile(:,1),nacaProfile(:,2),'k-');
axis equal
xlim([-50,150]);
% convert AoA angles to negative for sign convention
% used in rotation matrices
theta=-1*wtData{1,2}(:,1);
% calculate number of AoA angles
nTheta=length(theta);
% use a for loop to create animation of AoA
for iTheta = 1:nTheta
% define rotation matrix
rot=[cosd(theta(iTheta)), -sind(theta(iTheta))
sind(theta(iTheta)), cosd(theta(iTheta))];
% rotate nacaProfile data
rotProfile=rot*nacaProfile';
% update X and Y data for aerofoil outline
set(nacaHandle,'XData',rotProfile(1,:))
set(nacaHandle,'YData',rotProfile(2,:))
% update X and Y data for current AoA marker
set(CLHandle,'XData',wtData{1,2}(iTheta,1))
set(CLHandle,'YData',wtData{1,2}(iTheta,2))
% draw updated data
drawnow
% pause for 0.5 seconds to display figure
pause(0.5)
end