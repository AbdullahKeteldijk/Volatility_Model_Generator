clear all
clc
close all
%% Load Data

load returns.mat
load realizedKernell

y = r_t(1:1004);
y_r = r_t(1005:end);
real_y = realizedKernell(1:1004);
real_y_r = realizedKernell(1005:end);

T = length(y);

%% Initialize 

model = ["GARCH", "ZD-GARCH", "EGARCH", "GAS", "GJGARCH",...
         "SE-GARCH", "NGARCH" "TGARCH" "TSGARCH" "VGARCH" ...
         "Robust-GARCH" "IGARCH" "QGARCH" "MGARCH" "Realized_GARCH"];
distribution = ["Gaussian" "Student-t" "Skewed-Student-t" "Log-Normal", "GED"];

% model = ["GAS" "GARCH"];
% distribution = ["Skewed-Student-t" "Student-t" ];



% 
% model = ["GAS" "GARCH"];

%% Estimating models

options = optimset('Display','iter','TolFun',1e-12,'TolX',1e-12); 




% model = ["GARCH" ];
% distribution = ["Gaussian" "Student-t"];

no_models = length(distribution)*length(model);
no_parameters = 18;

theta_hat = zeros(no_models,no_parameters);
llik_val = zeros(no_models, 1);
% models(1)

count = 1;


progressbar('Total', 'Models','Distribution')

for i = 1:length(model)
    for j = 1:length(distribution)

        theta_ini = initialization(distribution(j), model(i));
        [ub, lb] = bounds(distribution(j), model(i));

        [theta_hat(count,1:length(theta_ini)),llik_val(count),exitflag]=...
            fmincon(@(theta) - llik_model(y,real_y,theta,model(i),distribution(j)),theta_ini,[],[],[],[],lb,ub,[],options);

        model_name(count,1) = strcat(distribution(j)," ",model(i));
        model_name(count,2) = model(i);
        model_name(count,3) = distribution(j);
        
        count = count + 1;
%             if model(i) == "Realized"
%                 load likelihood
%                 llik_val(count) = saved_likelihood;
% %                 clear saved_likelihood
%             end
        progressbar(count/no_models,i/length(model),j/length(distribution))
    end
    progressbar(count/no_models,i/length(model),j/length(distribution))
end
progressbar(count/no_models,i/length(model),j/length(distribution))

%% Predicting models


S = length(y_r);

sigma_forecast = zeros(S,no_models);
sigma_forecast(1,:) = var(y);
f_forecast = zeros(S, no_models);
f_forecast(1,:) = log(var(y));

for t = 2:S
    for i = 1:no_models
        if model_name(i,2) ~= "GAS" 
            sigma_forecast(t,i) = models(y_r,t-1,sigma_forecast(:,i),theta_hat(i,:),model_name(i,2));
        elseif model_name(i,2) == "GAS"
            f_forecast(t,i) = GAS_models(y_r,t-1,f_forecast(t-1,i),sigma_forecast(t-1,i),theta_hat(i,:),model_name(i,3));
            sigma_forecast(t,i) = exp(f_forecast(t,i));
        end
    end
end

%% NeweyWest standard errors


mTvalue = zeros(no_models, no_models);


for i = 1:no_models
    for j = 1:no_models
        vAbsForecastErrorsModel1 = abs(  sigma_forecast(:,i) - y_r );
        vAbsForecastErrorsModel2 = abs(  sigma_forecast(:,j) - y_r );
        vLossDifferential = vAbsForecastErrorsModel1 - vAbsForecastErrorsModel2;
        dMeanLossDifferential = mean(vLossDifferential);

        vResiduals = vLossDifferential - dMeanLossDifferential;
        mX = ones( size( vAbsForecastErrorsModel1, 1 ), 1 );   % kolom met enen
        dNeweyWestStdError = NeweyWest_stderror_like_EViews ( mX, vResiduals ) ;
        mTvalue(i,j) = dMeanLossDifferential/dNeweyWestStdError;
        
    end
    
end

save('DB_75.mat', 'mTvalue');
save('model_names.mat', 'model_name');

%% Heatmap DB test

xvalues = model_name(:,1);
yvalues = model_name(:,1);
h = heatmap(xvalues,yvalues,mTvalue);
figure(2)
plot(h)

%% Changing LogLikelihood of Realized GARCH

% for i = 1:no_models
%    if model_name(i,2) == "Realized_GARCH"
%        
%        name = strcat("llik_", model_name(i,3), ".mat");
%        load(name)
%        
%        llik_val(i) = saved_likelihood;
%        llik_val2 = saved_likelihood;
%    end
% end

%% AIC and BIC


AIC = zeros(no_models, 1);
BIC = zeros(no_models, 1);

for i = 1:no_models
    [AIC(i), BIC(i), LikelihoodValue(i)] = AIC_BIC(llik_val(i),T,model_name(i,2:3));    
end

%% plot
no_models
% figure(1)
% plot(sigma_forecast(:,6)) 