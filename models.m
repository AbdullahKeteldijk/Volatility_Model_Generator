function  [sigma] = models(x,t,sigma,theta,model);

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

if model == 'GARCH'  

    sigma = omega + alpha*x(t)^2 + beta*sigma(t);

elseif model == 'ZD-GARCH'

    sigma =  alpha*x(t)^2 + beta*sigma(t);
    
elseif model == 'EGARCH'

    sigma = exp( omega + beta*log(sigma(t)) + alpha*((abs(x(t))/sqrt(sigma(t))) - ...
            (sqrt(2/pi))) + phi*(x(t)/sqrt(sigma(t))) ); 

elseif model == 'GJGARCH'

    epsilon = x(t) / (sqrt(sigma(t)));    
    sigma = omega + beta * sigma(t) + beta2 * sigma(t) *...
        (epsilon^2) + beta3 * sigma(t) * (max(0,-epsilon)^2);
 
elseif model == 'SE-GARCH'
%     sigma = omega + alpha*(x(t)^2) + beta*sigma(t);
%     epsilon = x(t)/sqrt(sigma(t));
    sigma   = omega + alpha* x(t)^2 * sigma(t) + beta*sigma(t);
    
elseif model == 'NGARCH'
    
    epsilon = x(t)/sqrt(sigma(t)); 
    sigma   = omega + beta * sigma(t) + beta2 * sigma(t) * ((epsilon-c)^2);

elseif model == 'MGARCH'
    
    epsilon = x(t)/sqrt(sigma(t)); 
    sigma = exp( omega + alpha * (log(epsilon^2+1)) + alpha * log(sigma(t)+1));

elseif model == 'TGARCH'
    
    epsilon = x(t)/sqrt(sigma(t));
    sigma   = (omega + beta * sqrt(sigma(t)) + beta2 * sqrt(sigma(t)) *...
        abs(epsilon) + beta3 * sqrt(sigma(t)) * max(0,-epsilon))^2;

elseif model == 'TSGARCH'
    
    epsilon = x(t)/sqrt(sigma(t));
    sigma   = (omega + beta * sqrt(sigma(t)) + beta2 * sqrt(sigma(t)) * abs(epsilon))^2;
    
elseif model == 'VGARCH'
    
    epsilon = x(t)/sqrt(sigma(t));
    sigma   =  beta * sigma(t) + beta2 * ((epsilon-c).^2);
    
elseif model == 'Robust-GARCH'
    
    epsilon = x(t)/sqrt(sigma(t));
    sigma = omega + alpha * ((x(t)+delta).^2/(1+psi^(-1)*x(t)^2))+ beta * sigma(t);

elseif model == 'IGARCH'  

    sigma = omega + alpha*x(t)^2 + (1-alpha)*sigma(t);

elseif model == 'QGARCH'  

    sigma = omega + alpha*x(t)^2 + beta*sigma(t) + beta3*x(t);

elseif model == 'Realized_GARCH'  

    sigma = omega + alpha*x(t)^2 + beta*sigma(t);
end