s(1) = 100;
mu = 0.1;
sigma = 0.5;
T = 1;
N = 365
dt = T/N;

for j=1:1
    
    for i = 1:N
      dX = randn*sqrt(dt);
%       s(i+1) = s(i)*(1 +mu*dt + sigma*dX); % muler
      s(i+1) = s(i)*exp((mu - 0.5*sigma*sigma)*dt + sigma*dX);   %Ito's    
    end
    
plot(s)
hold on;
end
