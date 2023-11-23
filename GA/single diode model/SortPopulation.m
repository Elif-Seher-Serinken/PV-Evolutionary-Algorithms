function pop = SortPopulation(pop)
%SORTPOPULATİON Summary of this function goes here
%   Detailed explanation goes here
[idx, so ]=sort([pop.Cost]);
pop=pop(so );

end

