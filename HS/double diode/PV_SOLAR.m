function z = PV_SOLAR(x)
 a=x(1,1);
 b=x(1,2);
 b1=x(1,3);
 c=x(1,4);
 d=x(1,5);
 e=x(1,6);
 e1= x(1,7);
 
 Isc = 0.7603;
 Voc = 0.5728;
 Vmp = 0.4507;
 Imp= 0.6894;
 Pmp= 0.3107;
 T = 50;
 N= 1;
 k=1.38*10.^-23;
 q= 1.6*10.^-19;
 %Is= (d/(c+d))*(a - (b)*(exp(q*(Isc*c)/(k*(T+(273.15))*e))-1));
 IL = a - b*(exp(q*(-Isc*c)/(k*(T+(273.15))*e))-1) -b1*(exp(q*(-Isc*c)/(k*(T+(273.15))*e1))-1)- (Isc*c)/d;
 fark = sqrt(mean((Isc-IL).^2));
 z=fark; 
end
