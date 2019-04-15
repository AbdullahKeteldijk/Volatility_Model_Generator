function  [ub, lb] = bounds(distribution, model)
 
% theta_ini = [omega_ini,alpha_ini, beta_ini, nu_ini, phi_ini,...
%         lambda_ini];

if distribution == "Gaussian"
    lb=[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];        % lower bound for theta
    ub=[1, 1, 1, 10, 1, 0, 0, 1, 1, 1, 1, 1,10, 0];        % upper bound for theta
elseif distribution == "Student-t"
    lb=[0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];        % lower bound for theta
    ub=[1, 1, 1, 10, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 0];        % upper bound for theta
elseif distribution == "GED"
    lb=[0.04, 0.06, 0.9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];        % lower bound for theta
    ub=[1, 1, 1, 1, 1, 0, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 0];        % upper bound for theta
elseif distribution == "Log-Normal"
    lb=[0, 0, 0, 0, 0, 2.0001, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];        % lower bound for theta
    ub=[1, 1, 1, 1, 1, 20, 4, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 0];        % upper bound for theta    
elseif distribution == "Skewed-Student-t" %&& model == "GAS"
    lb=[0.4, 0.06, 0.9, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];        % lower bound for theta
    ub=[1, 1, 1, 100, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 100];        % upper bound for theta 
% elseif distribution == "Skewed-Student-t" && model ~= "GAS"
%     lb=[0.4, 0.06, 0.9, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];        % lower bound for theta
%     ub=[1, 1, 1, 100, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 100];        % upper bound for theta    
% else 
%     lb=[0, 0, 0, 0];        
%     ub=[1, 1, 1, 4];
end