% system identification code_random torque output
clc 
clear all
load random;
u2=random__1_25_mean__var_0_25__10.Y(3).Data';
y2=random__1_25_mean__var_0_25__10.Y(2).Data';
dry = iddata(y2,u2,1e-3); % sample time 1ms
ze=dry(1:15000);
figure(1)
plot(ze)
hold on
ze = detrend(ze); % Removing DC levels
plot(ze);
zv = dry(15000:33000);
zv = detrend(zv);
%%
mi = impulseest(ze,4); % Impulse response
clf
%showConfidence(bodeplot(mi));
compare(zv,mi,'b')
%%
% State space model estimation
% m1 = n4sid(ze,3); %better than ssest bcs we can provide the order
m1 = ssest(ze);
clf
showConfidence(stepplot(m1));
compare(zv,m1,'b')
%% ARX
 m2 = arx(ze,[3,2,3]);
 clf
compare(zv,m2,'b')
%% ARMAX
% m2 = arx(ze,[3,2,3]);
m3 = armax(ze,[4,3,4,2]);
clf
compare(zv,m3,'b')
%% Transfer function
m4 = tfest(ze,3,2,0.2); 
clf
compare(zv,m4,'b')

%%
clf
compare(zv,m1,'b',m2,'r',m3,'c')
