function [Y1,Y2]=UniformCrossover(x1,x2)
alpha=rand(1,7);
Y1=alpha.*x1+(1-alpha).*x2;
Y2=alpha.*x1+(1-alpha).*x2;

end

