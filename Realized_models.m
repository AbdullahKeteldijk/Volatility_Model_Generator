function  [sigma epsilon] = Realized_epsilons(x,y,t,sigma,theta,model);

T = length(x);
omega=theta(1);
alpha=theta(2);
beta=theta(3);
phi=theta(5);
beta2 = theta(8);    % parameter for GJGARCH
beta3 = theta(9);   % parameter for GJGARCH
c = theta(10);
delta = theta(11);
psi = theta(12);
jota = theta(13);
ksi = theta(14);
tau1 = theta(15);
tau2 = theta(16);

if model == 'GARCH'  
    
    z = x(t)/sqrt(sigma(t));                             % y(t,1) is de T x 1 vector met open to closed returns
    epsilon = y(t) - ksi - jota * sigma(t) - tau1 * z - tau2 * ((z^2)-1);
    sigma   = omega + beta*sigma(t) + alpha * y(t);     % y(t,2) is de T x 1 vector met Realized Kernels     

% elseif model == 'ZD-GARCH'
% 
%     sigma =  alpha*x(t)^2 + beta*sigma(t);
%     
% elseif model == 'EGARCH'
% 
%     sigma = exp( omega + beta*log(sigma(t)) + alpha*((abs(x(t))/sqrt(sigma(t))) - ...
%             (sqrt(2/pi))) + phi*(x(t)/sqrt(sigma(t))) ); 
%     
    
end
end