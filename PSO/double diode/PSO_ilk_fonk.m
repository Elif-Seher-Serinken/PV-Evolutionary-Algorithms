clc
clear all
tic
%ýph , Io,Rs,Rp,a sýrasýyla elde edilmek istenen parametrelerdir ve sürü
%buna göre oluþturulmuþtur.
%PV üretici deðerleri
Isc = 0.7603;
Voc = 0.5728;
Vmp = 0.4507;
Imp= 0.6894;
Pmp= 0.3107;
T = 33;
N= 1;
k=1.38*10.^-23;
q= 1.6*10.^-19;
Vt=(N*T*k)./q;

%PSO için deðiþtirilebilen sürü deðiþkenleri aþagýdadýr. 
ssize=15; %sürü boyutu
d=7; % çýkýþ parametreleri sayýsý
c1=1.2; 
c2=1.2;
inertia = 0.6;
max_iteration = 50;

min1 = 0;
max1= 1;
min2 = 0;
max2 = 10^-6;
min3 = 0;
max3 = 0.5;
min4 = 0;
max4 = 100;
min5 = 1;
max5 = 2;
min6 = 0;
max6 = 10^-6;
min7 = 1;
max7 = 2;
%particle konum matrisi
swarm_Iph = unifrnd(min1,max1,[ssize,1]);
swarm_Isd1 = unifrnd(min2,max2,[ssize,1]);
swarm_Isd2 = unifrnd(min6,max6,[ssize,1]);
swarm_Rs=unifrnd(min3,max3,[ssize,1]);
swarm_Rp=unifrnd(min4,max4,[ssize,1]);
swarm_a1=unifrnd(min5,max5,[ssize,1]);
swarm_a2=unifrnd(min7,max7,[ssize,1]);
swarm=[swarm_Iph,swarm_Isd1,swarm_Isd2,swarm_Rs,swarm_Rp,swarm_a1,swarm_a2];
%save SWARM.TXT swarm -ASCII
%load SWARM.TXT 

%swarm = SWARM ;
%Baþlangýç cost deðeri oluþturma
costval = ones(ssize,1);
%baþlangýç hýzlarý sýfýr olduðu için sýfýrlardan oluþan swarm matrisi büyüklüðünde hýz matrisi oluþturma.
velocity=zeros(ssize,d);
%baþlangýç için parçacýðýn en iyi pozisyonu sýfýrlardan oluþan swarm matrisi büyüklüðünde atanýr.
pbestpos=zeros(ssize,d);






for iteration=1:max_iteration
    for i=1:ssize
        for j=1:7
            
            swarm(i,j)=swarm(i,j)+velocity(i,j);

            if (swarm(i,1)<min1 || swarm(i,1)>max1)
                swarm(i,1)=min1+(max1-min1)*rand;
            end
            if (swarm(i,2)<min2 || swarm(i,2)>max2)
                swarm(i,2)=min2+(max2-min2)*rand;
            end
            if (swarm(i,3)<min6 || swarm(i,3)>max6)
                swarm(i,3)=min6+(max6-min6)*rand;
            end
            if (swarm(i,4)<min3 || swarm(i,4)>max3)
                swarm(i,4)=min3+(max3-min3)*rand;
            end
            if (swarm(i,5)<min4 || swarm(i,5)>max4)
                swarm(i,5)=min4+(max4-min4)*rand;
            end
            if (swarm(i,6)<min5 || swarm(i,6)>max5)
                swarm(i,6)=min5+(max5-min5)*rand;
            end
            if (swarm(i,7)<min7 || swarm(i,7)>max7)
                swarm(i,7)=min7+(max7-min7)*rand;
            end

           
            a=swarm(i,1);
            b=swarm(i,2);
            b1= swarm(i,3);
            c=swarm(i,4);
            d=swarm(i,5);
            e=swarm(i,6);
            e1=swarm(i,7);
            %Is(i)= (d/(c+d)).*(a - (b*10^-6).*(exp(q.*(Isc.*c)/(k.*(T+(273.15)).*e))-1));
            Is(i) = a - b*(exp(q*(-Isc*c)/(k*(T+(273.15))*e))-1) -b1*(exp(q*(-Isc*c)/(k*(T+(273.15))*e1))-1)- (Isc*c)/d;
            fark = sqrt(mean((Isc-Is(i)).^2));
            func=fark;

            if(func<costval(i,1))
                pbestpos(i,j)=swarm(i,j);              
            end
            costval(i,1)=func;
        end
    end 
    [temp,best]= min(costval);

    for i=1:ssize
        for j=1:7
            velocity(i,j)=inertia*rand*velocity(i,j)+c1*rand*(pbestpos(i,j)-swarm(i,j))+c2*rand*(swarm(best,j)-swarm(i,j));
          
        end
    end
  
   
   hata(iteration)=temp;
   
   inertia = inertia ;

[iteration swarm(best,:)]
end
iteration=1:max_iteration;

%%
%
%figure
%plot(iteration,hata);
%grid on;
%savefig cost.fig 
%swarm
swarm(best,:)

costval
hata(1,50)
toc
%% final elapsed time 323.45 seconds

