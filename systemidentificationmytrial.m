% system identification code_random
% clc 
% clear all
load random;
u2=random__1_25_mean__var_0_25__10.Y(3).Data';
y2=random__1_25_mean__var_0_25__10.Y(1).Data';
dry = iddata(y2,u2,1e-3); % sample time 0.08
ze=dry(1:15000);
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
%%
 m2 = arx(ze,[3,2,3]);
 clf
compare(zv,m2,'b')
%%
% m2 = arx(ze,[3,2,3]);
m3 = armax(ze,[4,2,4,1]);% Estimate using ARX: 2 poles, 1 zero and 3 delays
clf
compare(zv,m3,'b')
%%
m4 = tfest(ze,3,2,0.2); % Cont. time transfer function with 2 poles, 1 zero and delay of 0.2
clf
compare(zv,m4,'b')

%%
clf
compare(zv,m1,'b',m2,'r',m3,'c')
