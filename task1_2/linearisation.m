%% model linearization
clear all
fourwheelvdmodelparam
mod="vdescmodelfinal";
load('delta')
%%open(mod)

%% finding operating point
opspec = operspec(mod);
% opspec.States(1).SteadyState = 0;
% opspec.States(2).SteadyState = 0;
% opspec.States(3).SteadyState = 0;
% opspec.States(4).SteadyState = 0;
% opspec.States(5).SteadyState = 0;
% opspec.States(6).SteadyState = 0;
% opspec.States(7).SteadyState = 0;

%options = findopOptions('DisplayReport','off');
op = findop(mod);

%%

%declaring inputs and outputs
io(1)=linio('vdescmodelfinal/Steering input',1,'input');
io(2)=linio('vdescmodelfinal/Sxfl',1,'input');
io(3)=linio('vdescmodelfinal/Sxfr',1,'input');
io(4)=linio('vdescmodelfinal/Sxrl',1,'input');
io(5)=linio('vdescmodelfinal/Sxrr',1,'input');
io(6)=linio('vdescmodelfinal/FourwheelVDmodel',1,'output');
io(7)=linio('vdescmodelfinal/FourwheelVDmodel',2,'output');
io(8)=linio('vdescmodelfinal/FourwheelVDmodel',3,'output');
io(9)=linio('vdescmodelfinal/FourwheelVDmodel',4,'output');
io(10)=linio('vdescmodelfinal/FourwheelVDmodel',5,'output');

%linearzing the model
[lin,op1]=linearize(mod,io)

%transfer function
linTF=zpk(lin);
