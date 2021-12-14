% system identification code step and ramp
clc 
clear all
load ramp;
load 2step.mat;
u1=reference_data.Y(3).Data';
y1=reference_data.Y(1).Data';
u2=rampsignal.Y(3).Data';
y2=rampsignal.Y(1).Data';
dry1 = iddata(y1,u1,1e-3); % sample time 1ms
dry2 = iddata(y2,u2,1e-3); % sample time 1ms
ze=merge(dry1(1:15000),dry2(22000:37000)); %selecting the range where the most change is
figure(1)
plot(ze)
hold on
ze = detrend(ze); % Removing DC levels
plot(ze);
zv = dry2(1:38578);
zv1=detrend(dry1);
zv = detrend(zv);
%%
mi = impulseest(ze,4); % Impulse response
clf
compare(zv,mi,'b')
%%
% State space model estimation
% m1 = n4sid(ze,4);
m1 = ssest(ze);
clf
compare(zv,m1,'b')
%% arx
m2 = arx(ze,[3,2,2]); 
clf
compare(zv,m2,'b')
%% armax
m3 = armax(ze,[3,1,3,0]); 
clf
compare(zv,m3,'b')
%% transfer function
m4 = tfest(ze,3,2,0.1); 
clf
compare(zv,m4,'b')

%%
clf
compare(zv,m1,'b',m2,'r',m3,'c',m4,'g')
figure(2)
compare(zv1,m1,'b',m2,'r',m3,'c',m4,'g')

