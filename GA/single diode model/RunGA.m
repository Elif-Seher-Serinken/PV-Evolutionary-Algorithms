function out=RunGA(problem,params)
    %Problem
    CostFunction=problem.CostFunction;
    nVar=problem.nVar;
    VarSize=[1,nVar];
    VarMin=problem.VarMin;
    VarMax=problem.VarMax;

    %Params
    MaxIt=params.MaxIt;
    Psize=params.psize;
    pC=params.pc;
    mu=params.mu;
    beta=params.beta;
    nC=round(pC*Psize/2)*2;
    sigma=params.sigma;

    %Template for Empty Indıviduals
    empty_individual.Position=[];
    empty_individual.Cost=[];
    

    %Best Solution 
    bestsol.Cost=10000;

    %İnitialization
    pop=repmat(empty_individual,Psize,1);
    for i=1:Psize

        pop(i).Position=unifrnd(VarMin,VarMax,VarSize);
        

        pop(i).Cost=CostFunction(pop(i).Position)

        if pop(i).Cost<bestsol.Cost
            bestsol=pop(i)
        end
    end

    %bEST cOST of Iteratıons
    bestcost=ones(MaxIt,1);

    %Main Loop

    for it=1:MaxIt

        %Selection Probabilities

        c=[pop.Cost];
        avgc=mean(c);
        if avgc == 0
            c=c/avgc;
        end
        probs=exp(-beta*c);
        
        popc=repmat(empty_individual,nC/2,2);

        for k=1:nC/2

            p1=pop(RouletteWheelSelection(probs));
            p2=pop(RouletteWheelSelection(probs));

            [popc(k,1).Position,popc(k,2).Position]=UniformCrossover(p1.Position,p2.Position);
            

        end

        popc=popc(:);

        for l=1:nC
            popc(l).Position=Mutate(popc(l).Position,mu,sigma);
            

            popc(l).Cost=CostFunction(popc(l).Position);

            if popc(l).Cost <bestsol.Cost
                bestsol = popc(l);
            end

        end

        pop=SortPopulation([pop;popc]);

        pop=pop(1:Psize);

        bestcost(it)=bestsol.Cost;

        disp(['iteration' num2str(it) ': Best Cost' num2str(bestcost(it))]);

    end

    out.pop=pop;
    out.bestsol=bestsol;
    out.bestcost= bestcost;
end