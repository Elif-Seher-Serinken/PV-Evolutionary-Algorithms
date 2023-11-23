function i=RouletteWheelSelection(probs)
r=rand*sum(probs);
c=cumsum(probs);


i= find(r<=c,1,"first");
end

