clc;
clear ;
clear all;
tic
%%
problem.CostFunction=@(x) peak(x);
problem.nVar=7;
problem.VarMin=[0 0 0 0 0 1 1 ];
problem.VarMax=[1 exp(-6) exp(-6) 0.5 100 2 2];

%% Ga Parameters
params.MaxIt=50;
params.psize=20;
params.pc=0.7;
params.mu=0.06;
params.beta=0.8;
params.sigma=0.3;

%% run GA
out=RunGA(problem,params);

%%
%figure;
%plot(out.bestcost,'LineWidth',2);
%xlabel('Iterations');
%ylabel('Best Cost');
%grid on;
toc