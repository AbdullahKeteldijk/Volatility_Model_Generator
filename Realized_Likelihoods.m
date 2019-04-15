function  [l] = Realized_Likelihoods(x,sig,epsilon,distribution,theta)

T = length(x);

nu = theta(4);
rho = theta(6);
kappa = theta(7);
sigmaeps = theta(17);
zeta = theta(18);

if distribution == 'Gaussian'
    l1 = -(1/2)*log(2*pi) - (1/2)*log(sig(1:T)) - ...
        (1/2)*(x').^2./sig(1:T) -(1/2)*log(2*pi); 
    l2 = - (1/2)*log(sigmaeps.^2) - (1/2) * (epsilon(1:T)).^2./(sigmaeps.^2);
    l = l1+l2;
%     l = -(1/2)*log(2*pi) - (1/2)*log(sig(1:T)) - (1/2)*(x').^2./sig(1:T);
elseif distribution == 'Student-t'
    l1 = log(gamma((nu+1)/2)) - log(gamma(nu/2)) - ...
        (1/2)* log((nu-2)*pi*sig(1:T)) - ((nu+1)/2)* ...
        log(1+((x').^2./((nu-2)*sig(1:T)))) - (1/2)*log(2*pi);
    l2 = - (1/2)*log(sigmaeps.^2) - (1/2) * (epsilon(1:T)).^2./(sigmaeps.^2) ;
    l = l1+l2;
elseif distribution == 'GED'
    l1 =-(1/2)*log(sig(1:T))+log(kappa)-(1/2)* abs(x'./ (sqrt(sig(1:T)) * ... 
        sqrt(gamma(1/kappa)/(2.^(2/kappa)*gamma(3/kappa) )))).^(kappa);
    l2 = -(1/2)*log(sigmaeps.^2) - (1/2) * (epsilon(1:T)).^2./(sigmaeps.^2);
    l = l1+l2;
elseif distribution == 'Log-Normal'
    l1 = log(gamma((rho+1)/2))-1/2*log((rho-2)*pi)-log(gamma(rho/2))...
        - (1/2)*log(sig(1:T))....
        -((rho+1)/2) .* log(1+(x'.^2./(sig(1:T)*(rho-2))));
    l2 = -(1/2)*log(sigmaeps.^2) - (1/2) * (epsilon(1:T)).^2./(sigmaeps.^2);
    l = l1+l2
elseif distribution == 'Skewed-Student-t'
        
    m = (gamma((nu-1)/2)/gamma(nu/2)) * sqrt((nu-2)/pi) * (zeta - (1/zeta));
    s = sqrt((zeta^2 +(1/zeta^2) - 1) + m^2);
    condition = s*(x'./sqrt(sig(1:T))) + m;
    
    if condition >= 0
        I = 1;
    else
        I = -1;
    end
    
    l1 = log(gamma((nu+1)/2)) - log(gamma(nu/2)) - 0.5*log((nu-2)*pi*sig(1:T)) ...
        + log(s) + log(2/(zeta+(1/zeta))) ...
        - ((nu+1)/2)*log(1+( (s*(x'.^2)./sqrt(sig(1:T)+ m).^2)./(nu-2)).*zeta.^(-2*I));
    l2 = - (1/2)*log(sigmaeps.^2) - (1/2) * (epsilon(1:T)).^2./(sigmaeps.^2);
    l = l1+l2;
end
l = l/2;
% saved_likelihood = mean(l1);
% name = strcat("llik_", distribution, ".mat");
% save(name, 'saved_likelihood');
end

