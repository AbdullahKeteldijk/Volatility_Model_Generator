function  [theta_ini] = bounds(distribution, model)

if distribution == "Gaussian"
    omega_ini = 0.1;  % initial value for omega
    alpha_ini = 0.1;  % initial value for alpha
    beta_ini  = 0.8;   % initial value for beta
    nu_ini = 0;        % degrees of freedom
    phi_ini = 0.1;     % parameter of EGARCH
    rho_ini = 4;       % parameter of Log-Normal distribution
    kappa_ini = 0;     % shape parameter GED distribution
    beta2_ini = 0.5;    % parameter for GJGARCH
    beta3_ini = 0.25;   % parameter for GJGARCH
    c_ini = 0.2;            % parameter for NGARCH
    delta_ini = 0.5;
    psi_ini = 0.1;
    jota_ini = 0.1;
    ksi_ini = 0.1;
    tau1_ini = 0.1;
    tau2_ini = 0.1;
    sigmaeps_ini = 0.1;
    zeta_ini = 0;
    theta_ini = [omega_ini,alpha_ini, beta_ini, nu_ini, phi_ini, ... 
        rho_ini, kappa_ini, beta2_ini, beta3_ini, c_ini, delta_ini, ...
        psi_ini, jota_ini, ksi_ini, tau1_ini, tau2_ini, sigmaeps_ini, zeta_ini];
elseif distribution == "Student-t"
    omega_ini = 0.1;  % initial value for omega
    alpha_ini = 0.1;  % initial value for alpha
    beta_ini  = 0.8;   % initial value for beta
    nu_ini = 2;
    phi_ini = 0.1;
    rho_ini = 4;       % Lambda in Log-Normal distribution
    kappa_ini = 2;
    beta2_ini = 0.5;    % parameter for GJGARCH
    beta3_ini = 0.25;   % parameter for GJGARCH
    c_ini = 0.2;            % parameter for NGARCH
    delta_ini = 0.5;
    psi_ini = 0.1;
    jota_ini = 0.1;
    ksi_ini = 0.1;
    tau1_ini = 0.1;
    tau2_ini = 0.1;
    sigmaeps_ini = 0.1;
    zeta_ini = 0;
    theta_ini = [omega_ini,alpha_ini, beta_ini, nu_ini, phi_ini, ... 
        rho_ini, kappa_ini, beta2_ini, beta3_ini, c_ini, delta_ini, ...
        psi_ini, jota_ini, ksi_ini, tau1_ini, tau2_ini, sigmaeps_ini, zeta_ini];
elseif distribution == "GED" 
    omega_ini = 0.1;  % initial value for omega
    alpha_ini = 0.1;  % initial value for alpha
    beta_ini  = 0.8;   % initial value for beta
    nu_ini = 0;
    phi_ini = 0;
    rho_ini = 0;
    kappa_ini = 2;
    beta2_ini = 0.5;    % parameter for GJGARCH
    beta3_ini = 0.25;   % parameter for GJGARCH
    c_ini = 0.2;            % parameter for NGARCH
    delta_ini = 0.5;    % parameter for Robust-GARCH
    psi_ini = 0.1;      % Lamda in Robust-GARCH model
    jota_ini = 0.1;
    ksi_ini = 0.1;
    tau1_ini = 0.1;
    tau2_ini = 0.1;
    sigmaeps_ini = 0.1;
    zeta_ini = 0;
    theta_ini = [omega_ini,alpha_ini, beta_ini, nu_ini, phi_ini, ... 
        rho_ini, kappa_ini, beta2_ini, beta3_ini, c_ini, delta_ini, ...
        psi_ini, jota_ini, ksi_ini, tau1_ini, tau2_ini, sigmaeps_ini, zeta_ini];
elseif distribution == "Log-Normal"
    omega_ini = 0.1;  % initial value for omega
    alpha_ini = 0.1;  % initial value for alpha
    beta_ini  = 0.8;   % initial value for beta
    nu_ini = 2;
    phi_ini = 0.1;
    rho_ini = 4;
    kappa_ini = 0;
    beta2_ini = 0.5;    % parameter for GJGARCH
    beta3_ini = 0.25;   % parameter for GJGARCH
    c_ini = 0.2;            % parameter for NGARCH
    delta_ini = 0.5;
    psi_ini = 0.1;
    jota_ini = 0.1;
    ksi_ini = 0.1;
    tau1_ini = 0.1;
    tau2_ini = 0.1;
    sigmaeps_ini = 0.1;
    zeta_ini = 0;
    theta_ini = [omega_ini,alpha_ini, beta_ini, nu_ini, phi_ini, ... 
        rho_ini, kappa_ini, beta2_ini, beta3_ini, c_ini, delta_ini, ...
        psi_ini, jota_ini, ksi_ini, tau1_ini, tau2_ini, sigmaeps_ini, zeta_ini];
 elseif distribution == "Skewed-Student-t"
    omega_ini = 0.3;  % initial value for omega
    alpha_ini = 0.3;  % initial value for alpha
    beta_ini  = 1.8;   % initial value for beta
    nu_ini = 4;
    phi_ini = 0.1;
    rho_ini = 4;
    kappa_ini = 0;
    beta2_ini = 0.5;    % parameter for GJGARCH
    beta3_ini = 0.25;   % parameter for GJGARCH
    c_ini = 0.2;            % parameter for NGARCH
    delta_ini = 0.5;
    psi_ini = 0.1;
    jota_ini = 0.1;
    ksi_ini = 0.1;
    tau1_ini = 0.1;
    tau2_ini = 0.1;
    sigmaeps_ini = 0.1;
    zeta_ini = 4;
    theta_ini = [omega_ini,alpha_ini, beta_ini, nu_ini, phi_ini, ... 
        rho_ini, kappa_ini, beta2_ini, beta3_ini, c_ini, delta_ini, ...
        psi_ini, jota_ini, ksi_ini, tau1_ini, tau2_ini, sigmaeps_ini, zeta_ini];
    
end