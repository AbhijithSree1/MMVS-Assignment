% system identification code_random
clc 
clear all
load ramp;
load 2step.mat;
u1=reference_data.Y(3).Data';
y1=reference_data.Y(2).Data';
u2=rampsignal.Y(3).Data';
y2=rampsignal.Y(2).Data';
dry1 = iddata(y1,u1,1e-3); % sample time 1ms
dry2 = iddata(y2,u2,1e-3); % sample time 1ms
ze=merge(dry1(1:15000),dry2(22000:37000)); %selecting the range where the most change is
%ze = merge(dry(8000:14000),dry(36000:42000)); % to train both the increase and decrease in speed.
%the best training range is 0 to 15000, it provided good values for the
%same range and entire range of validation. in this puticular system, i
%have merged the data where the speed increases and decreases, except for
%the transfer function everything else looks good. especially ARX.
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
%m1 = n4sid(ze,4);
m1 = ssest(ze);
clf
compare(zv,m1,'b')
%%
m2 = arx(ze,[4,1,1]); % Estimate using ARX: 2 poles, 1 zero and 3 delays
clf
compare(zv,m2,'b')
%%
m3 = armax(ze,[4,3,4,0]); % Estimate using ARX: 2 poles, 1 zero and 3 delays
clf
compare(zv,m3,'b')
%%
m4 = tfest(ze,3,2,0.1); % Cont. time transfer function with 2 poles, 1 zero and delay of 0.2
clf
compare(zv,m4,'b')

%%
clf
compare(zv,m1,'b',m2,'r',m3,'c',m4,'g')
figure(2)
compare(zv1,m1,'b',m2,'r',m3,'c',m4,'g')

