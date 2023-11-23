clc
clear 
clear all
tic
%%
problem.CostFunction=@(x) peak(x);
problem.nVar=5;
problem.VarMin=[0 0 0 0 1];
problem.VarMax=[1 exp(-9) 0.5 100 2 ];

%% Ga Parameters
params.MaxIt=30;
params.psize=10;
params.pc=0.7;
params.mu=0.05;
params.beta=1;
params.sigma=0.1;

%% run GA
out=RunGA(problem,params);
%%
%figure;
%plot(out.bestcost,'LineWidth',2);
%xlabel('Iterations');
%ylabel('Best Cost');
%grid on;
%toc