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
ssize=10; %sürü boyutu
d=5; % çýkýþ parametreleri sayýsý
c1=1.2; 
c2=1.2;
inertia = 0.3;
max_iteration = 30;

min1 = 0;
max1= 1;
min2 = 10^-8;
max2 = 10^-5;
min3 = 0.001;
max3 = 0.1;
min4 = 0;
max4 = 100;
min5 = 1;
max5 = 2;
%particle konum matrisi
swarm_Iph = unifrnd(min1,max1,[ssize,1]);
swarm_Isd = unifrnd(min2,max2,[ssize,1]);
swarm_Rs=unifrnd(min3,max3,[ssize,1]);
swarm_Rp=unifrnd(min4,max4,[ssize,1]);
swarm_a=unifrnd(min5,max5,[ssize,1]);
swarm=[swarm_Iph,swarm_Isd,swarm_Rs,swarm_Rp,swarm_a];
%save SWARM.TXT swarm -ASCII
%load SWARM.TXT 
%%
%swarm = SWARM ;
%Baþlangýç cost deðeri oluþturma
costval = ones(ssize,1);
%baþlangýç hýzlarý sýfýr olduðu için sýfýrlardan oluþan swarm matrisi büyüklüðünde hýz matrisi oluþturma.
velocity=zeros(ssize,d);
%baþlangýç için parçacýðýn en iyi pozisyonu sýfýrlardan oluþan swarm matrisi büyüklüðünde atanýr.
pbestpos=zeros(ssize,d);



%swarm(:,1)=min1+(max1-min1)*rand(ssize,1); 
%swarm(:,2)=min2+(max2-min2)*rand( ssize,1); 
%swarm(:,3)=min3+(max3-min3)*rand(ssize,1); 
%swarm(:,4)=min4+(max4-min4)*rand(ssize,1); 
%swarm(:,5)=min5+(max5-min5)*rand(ssize,1); 


for iteration=1:max_iteration
    for i=1:ssize
        for j=1:5
            
            swarm(i,j)=swarm(i,j)+velocity(i,j);

            if (swarm(i,1)<min1 || swarm(i,1)>max1)
                swarm(i,1)=min1+(max1-min1)*rand;
            end
            if (swarm(i,2)<min2 || swarm(i,2)>max2)
                swarm(i,2)=min2+(max2-min2)*rand;
            end
            if (swarm(i,3)<min3 || swarm(i,3)>max3)
                swarm(i,3)=min3+(max3-min3)*rand;
            end
            if (swarm(i,4)<min4 || swarm(i,4)>max4)
                swarm(i,4)=min4+(max4-min4)*rand;
            end
            if (swarm(i,5)<min5 || swarm(i,5)>max5)
                swarm(i,5)=min5+(max5-min5)*rand;
            end

           
            a=swarm(i,1);
            b=swarm(i,2);
            c=swarm(i,3);
            d=swarm(i,4);
            e=swarm(i,5);
            
            %Is(i)= (d/(c+d)).*(a - (b*10^-6).*(exp(q.*(Isc.*c)/(k.*(T+(273.15)).*e))-1));
            Is = a - (b)*(exp(q*(Isc*c)/(k*(T+(273.15))*e))-1) - (Isc*c)/d;
            fark = sqrt(mean((Isc-Is).^2));
            func=fark;

            if(func<costval(i,1))
                pbestpos(i,j)=swarm(i,j);              
            end
            costval(i,1)=func;
        end
    end 
    [temp,best]= min(costval);

    for i=1:ssize
        for j=1:5
            velocity(i,j)=inertia*rand*velocity(i,j)+c1*rand*(pbestpos(i,j)-swarm(i,j))+c2*rand*(swarm(best,j)-swarm(i,j));
          
        end
    end

   
   hata(iteration)=temp;
   
   %inertia = inertia - inertia*0.1

[iteration swarm(best,:)]
end
iteration=1:max_iteration;

%%

figure
plot(iteration,hata);
grid on;
savefig cost.fig 
swarm
swarm(best,:)

costval
toc
%% final elapsed time 323.45 seconds

