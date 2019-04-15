function  [llik] = llik_model(x,y,theta,model,distribution)


T=length(x);

omega = theta(1);
alpha = theta(2);
beta  = theta(3);
nu = theta(4);
jota = theta(13);
ksi = theta(14);
tau1 = theta(15);
tau2 = theta(16);

% lambda = ( (gamma(1/nu)) / ((2^(2/nu))*gamma(3/nu)) )^(1/2); 

sigma(1)=var(x); 
f(1) = log(var(x));
h(1) = exp(f(1));


for t=1:T
    
    if model ~= "GAS" && model ~= "Realized_GARCH" 
        sigma(t+1) = models(x,t,sigma,theta,model);
    elseif model == "GAS"
        f(t+1) = GAS_models(x,t,f(t),h(t),theta,distribution);
        h(t+1) = exp(f(t+1)); 
    elseif model == "Realized_GARCH"
        z = x(t)/sqrt(sigma(t));                             
        epsilon(t) = y(t) - ksi - jota * sigma(t) - tau1 * z - tau2 * ((z^2)-1);
        sigma(t+1) = models(x,t,sigma,theta,model);
        
    end
end

if model == "GAS"
    sigma = h;
end


if model == 'Realized_GARCH'
    l = Realized_Likelihoods(x,sigma,epsilon,distribution,theta);
%     l = 0.5*l;
else
    l = Likelihoods(x,sigma,distribution,theta);
end



llik =mean(l);


