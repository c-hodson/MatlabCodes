%Chloe Hodson
%Username: ch15270
%Candidate number: 26822
%Student number: 1528977

clear all
close all
% allocate memory - given values
% aircraft mass (kg)
m=240000;
% wing area (m^2)
S=400;
% wing span (m)
b=60;
% cruise altitude (m)
hCruise=12000;
% cruise velocity (Mach)
vCruiseMach=0.85;
% maximum lift coefficient
CLmax=1.5;
% span efficiency 
e=0.90;
% zero lift drag co-efficient 
CD0=0.01;
% allocate memory - other required values
% gravitational constant (ms^-2)
g=9.81;
% pi
pi=4*atan(1);
%STAGE 1
% calculate atmospheric properties at cruise altitude 
% CruiseT (Kelvin), CruiseA (Pa), CruiseRho (kgm^-3)
[CruiseT, CruiseA, CruiseP, CruiseRho] = atmosisa(hCruise);
% convert cruise speed in m/s 
vCruise=vCruiseMach*CruiseA;
% calculate lower limit of velocity plot - stall speed at cruise altitude 
vStall=((2*m*g)/(CruiseRho*S*CLmax))^0.5;
% calculate upper limit of velocity plot - 1.2 x vcruise
vLimit=1.2*vCruise;
% create matrix of velocities to plot 
V=vStall:10:vLimit;
% calculate aspect ratio (AR=span sqaured/area)
AR=b^2/S;
% calcuate coefficient of lift matrix
CL=(2*m*g)./(CruiseRho*S.*(V.^2));
% calculate coefficient of drag matrix
CD=CD0+((CL.^2)./(pi*e*AR));
% calculate drag values
D=CD.*0.5*CruiseRho.*(V.^2).*S;
% plot drag against airspeed
figure;
hold all;
plot (V,D,'m-');
xlabel('Airspeed (m/s)');
ylabel('Drag (N)');
title('Predicted Drag at increasing Airspeed');
% Why does drag decrease initially with increasing airspeed, but then
% increase again at higher airspeeds?
% The aircraft will be experiencing induced drag and parasite drag. Induced
% drag is affected by the coefficient of lift. As speed increases the equation
% shows the coefficent of lift will also decrease, in turn causing a decrease
% in induced drag. Parasite drag, consisting of form and friction drag, 
% increases with speed as an increased number of particles interfering with
% the aerofoil. Initially the decrease in induced drag causes an overall 
% decrease in drag but at higher airpseeds the drag increases again due to 
% parasite drag. This can be seen in the equation for drag as similarly the
% inclusion of v^2 begins to outweigh the decrease in Cl.
% STAGE 2
% start new figure
figure;
for M=0.5*m:0.1*m:m;
% calculate lower limit of velocity plot - stall speed at cruise altitude 
vStall=((2*M*g)/(CruiseRho*S*CLmax)).^0.5;
% calculate upper limit of velocity plot - 1.2 x vcruise
vLimit=1.2*vCruise;
% create matrix of velocities to plot 
V=vStall:10:vLimit;
% calculate aspect ratio (AR=span sqaured/area)
AR=b^2/S;
% calcuate coefficient of lift matrix
CL=(2*M*g)./(CruiseRho*S.*(V.^2));
% calculate coefficient of drag matrix
CD=CD0+((CL.^2)/(pi*e*AR));
% calculate drag values
D=CD.*0.5*CruiseRho.*(V.^2).*S;
% plot drag against airspeed
hold all 
plot (V,D);
end
% labels and legend
xlabel('Airspeed (m/s)');
ylabel('Drag (N)');
title('Predicted Drag at increasing Airspeed');
legend('50% Fuel','60% Fuel','70% Fuel','80% Fuel','90% Fuel','100% Fuel','LOCATION','Northeast')
% What trend can be seen in minimum drag airspeed with increasing mass?
% Minimum drag airspeed increases as mass increases. Meaning heavier aircraft are more
% suited for faster flight.
% Why for a constant airspeed does drag increase with aircraft mass?
% Because drag is related to coefficient of lift. Lift is decreased by the increase in weight
% caused by the increase in mass. Therefore, the equation shows this also causes an increase 
% in drag. 
% STAGE 3
% create new figure for stage 3
figure;
for B=60:5:80;
% calculate new mass
Mb=100*B^2-11500*B+570000;
% calculate lower limit of velocity plot - stall speed at cruise altitude 
vStall=((2*Mb*g)/(CruiseRho*S*CLmax)).^0.5;
% calculate upper limit of velocity plot - 1.2 x vcruise
vLimit=1.2*vCruise;
% create matrix of velocities to plot 
V=vStall:10:vLimit;
% calculate aspect ratio (AR=span sqaured/area)
AR=B^2/S;
% calcuate coefficient of lift matrix
CL=(2*Mb*g)./(CruiseRho*S.*(V.^2));
% calculate coefficient of drag matrix
CD=CD0+((CL.^2)/(pi*e*AR));
% calculate drag values
D=CD.*0.5*CruiseRho.*(V.^2).*S;
% plot drag against airspeed
hold all 
plot (V,D);
end
% labels and legend
xlabel('Airspeed (m/s)');
ylabel('Drag (N)');
title('Predicted Drag at increasing Airspeed');
legend('60m','65m','70m','75m','80m','LOCATION','Northeast')
% What wing span would you recommend for the proposed design and why?
% 75m wing span as the graph shows this consistently produces the least drag.