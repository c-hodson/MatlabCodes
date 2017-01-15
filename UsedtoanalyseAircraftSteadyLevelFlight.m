clear all
close all
% aircraft mass (kg)
m=70300;
% wing area (m^2)
S=162;
% wing span (m)
b=40.4;
% cruise altitude (m)
hCruise=8500;
% maximum lift coefficient
CLmax=1.5;
% gravitational acceleration (m/s^2)
g=9.81;
% cruise velocity (Mach)
Mcruise=0.57;
% calculate atmospheric properties at cruise altitude 
[TCruise, aCruise, PCruise, rhoCruise] = atmosisa(hCruise);
% calculate cruise speed in m/s 
Vcruise=Mcruise*aCruise;
% calculate stall speed at cruise altitude 
Vstall=((2*m*g)/(rhoCruise*S*CLmax))^0.5;
% define range of velocities of interest
V=Vstall:10:(Vcruise*1.2);
% calculate CL for steady level flight at cruise altitude 
CL=(2*m*g)./(rhoCruise*S.*(V.^2));
% create plot of V vs CL
figure; 
plot(V,CL,'b-o'); 
xlabel('V m/s');
ylabel('CL');
title('Steady Level Flight at 8500m');
ylim([0 1.8]);
xlim([100 200]);

% define range of altitudes (m)
height=0:2000:10000;
% find length of vector of heights
nHeight=length(height);
% calculate atmospheric properties at each altitude
[T, a, P, rho] = atmosisa(height);
% calculate V vs CL for each altitude
for iHeight=1:nHeight
% define velocity range 
Vstall=((2*m*g)./(rho.*(iHeight).^0.5));
V=Vstall:10:Vcruise*1.2;
% calculate CL for velocity range 
CLheight{iHeight}=(2*m*g)/(rho*(iHeight).*(V.^2));
% store velocity vector
Vheight{iHeight}=V;
% create plot of V vs CL
figure;
hold all 
plot(V,CL,'b-o'); 
xlabel('V m/s');
ylabel('CL');
title('Steady Level Flight');
ylim([0 1.8]);
xlim([0 10000]);
end
