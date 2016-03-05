

clear
clc
S_0 = 100;
r = 0.05;
sig = 0.20;
    
X = 102;
T = 1;
    

M = 100000;  % number of sample paths
N = 10;      % number of time steps
%     double st_time = clock();
    
dt = T/N;
drift = (r - 0.5*sig*sig)*dt;
sgrt = sig*dt^0.5;
    
acc_vals = 0.0;
acc_squs = 0.0;



K=M;
D=N;
% 
% uni=rand(K,D);
% uni_normal=InvNorm(uni);

uni_normal=normrnd(0,1,M,N);

halton_=hal_seq(K,D,1e3,1e2);
halton_normal=InvNorm(halton_);

sobol_=sob_seq(K,D,1e3,1e2);
sobol_normal=InvNorm(sobol_);

% faure_= faure(K,D,6);
% % faure_= faure_0(:,D);
% faure_normal=InvNorm(faure_);
% 
% 
quasi_normal=halton_normal;
for j=1:M

  S = S_0;

  for i=1:N
%     w = normrnd(0,1);
    w=quasi_normal(j,i);

    S = S*exp(drift + sgrt*w);
  end
  
  payoff = max(0.0, S - X);
        
        acc_vals = acc_vals + payoff;
        acc_squs = acc_squs + payoff*payoff;       
end
    
     discount = exp(-r*T);
     format long
     c = discount*acc_vals/M
     se = discount*(acc_squs - acc_vals*acc_vals/M)^0.5/M



