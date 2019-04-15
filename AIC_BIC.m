function  [AIC, BIC, LikelihoodValue] = AIC_BIC(llik_val,T,names)

model_name = names(1);
distribution_name = names(2);

% Checking number of parameters in model

if model_name == "ZD-GARCH" 
    k = 2;
elseif model_name == "EGARCH" || model_name == "NGARCH" || model_name == "TGARCH"
    k = 4;
elseif model_name == "GJGARCH" 
    k = 5;
else
    k = 3;
end

% Checking number of extra parameters in distribution
if distribution_name == "Gaussian"
    k = k;
elseif distribution_name ~= "Gaussian"
    k = k+1;
end

% Checking number of extra parameters in returns type
if distribution_name == "Standard"
    k = k;
elseif distribution_name ~= "Realized"
    k = k+1;
end

% Calculating AIC and BIC
LikelihoodValue = -llik_val*T;
AIC = 2*k-2*LikelihoodValue;
BIC = log(T)*k-2*LikelihoodValue;

end