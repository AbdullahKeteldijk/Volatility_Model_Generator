function  [f] = models(x,t,f,h,theta,distribution);

T = length(x);
mu = 0;

omega = theta(1);
alpha = theta(2);
beta = theta(3);
nu = theta(4);
rho = theta(6);
kappa = theta(7);
zeta = theta(18);

if distribution == "Gaussian"
    score = ( (x(t)-mu)^2 - h)/(2*h);
elseif distribution == "Student-t"
    score = -1/2 + (nu+1)/2 *(x(t)^2/((nu-2)*h))/ ... 
            (1+ (x(t)^2/ ( (nu-2) *h)));
elseif distribution == "GED"
    lambda = (gamma(1/nu))/((2^(2/nu))*gamma(3/nu));
    score = -1/2 + (nu/4) * abs( x(t)/(lambda*h^0.5) )^nu;
        %Something is wrong with the GED score function. The nu parameter 
        %keeps converging to infinity.
elseif distribution == "Log-Normal"
    score = 1/2*( ((rho+1)*x(t)^2)/( ((rho-2)*exp(h)) +x(t)^2) -1);
elseif distribution == "Skewed-Student-t"
    
    m = (gamma((nu-1)/2)/gamma(nu/2)) * sqrt((nu-2)/pi) * (zeta - (1/zeta));
    s = sqrt((zeta^2 +(1/zeta^2) - 1) + m^2);
    condition = s*(x(t)/sqrt(h)) + m;
    
    if condition >= 0
        I = 1;
    else
        I = -1;
    end
    
   score = -1/2 + ((nu+1)/2) * s* (x(t)/sqrt(h)) * condition / ( zeta^(2*I) * (nu-2) +  condition^2 );
    
end

f  = omega + alpha*score + beta*f;

    
    

end