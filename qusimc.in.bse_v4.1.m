

clear
clc
S_0 = 100;
r = 0.05;
sig = 0.10;
    
X = 100;
T = 1;
    

N = 10;      % number of time steps
%     double st_time = clock();
    
dt = T/N;
% drift = (r - 0.5*sig*sig)*dt;
 drift = r * dt;

sgrt = sig*dt^0.5;
     discount = exp(-r*T);

acc_vals = 0.0;
acc_squs = 0.0;



K=1000000;
D=N;

% uni=rand(K,D);
% uni_normal=InvNorm(uni);

uni_normal=normrnd(0,1,K,N);

halton_=hal_seq(K,D,1e3,1e2);
halton_normal=InvNorm(halton_);
% 
sobol_=sob_seq(K,D,1e3,1e2);
sobol_normal=InvNorm(sobol_);
% 
% faure_= faure(K,D,6);
% % faure_= faure_0(:,D);
% faure_normal=InvNorm(faure_);

for qq=1:3
    if qq==1
    quasi_normal=uni_normal;
    end
        if qq==2
    quasi_normal=halton_normal;
        end
        if qq==3
    quasi_normal=sobol_normal;
    end

dd=10;
for ww=1:dd
M = K/dd*ww;  % number of sample paths
    for se_i=1:40

acc_vals=0;
acc_squs=0;

for j=1:M
    
  S = S_0;

  for i=1:N
%     w = normrnd(0,1);
    w=quasi_normal(j,i);

%     S = S*exp(drift + sgrt*w);
    S = S*(1 + drift + sgrt*w);

    end
  
  payoff =discount * max(0.0, S - X);
        
        acc_vals = acc_vals + payoff;
        acc_squs = acc_squs + payoff*payoff;       
    end
    c(se_i,ww) = acc_vals/M;

    end
    me(qq,ww)=mean(c(:,ww));
    se(qq,ww)=std(c(:,ww));
%     se(qq,ww) = ((acc_squs/M - c(ww)^2)^0.5)/M^0.5;

end

end


plot(se(1,:),'r')
hold on
plot(se(2,:),'g')
hold on
plot(se(3,:),'b')
hold on


