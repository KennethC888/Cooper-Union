
% SPDX-License-Identifier: GNU AGPL-3.0-or-later
% Copyright (C) 2025 Kenneth Chan <kenc0728@gmail.com>
% Kenneth Chan
clc;
clear;
close all;
rng(388);

%% Question 1
% N is the iterations, N_vals is the sample size 
N = 1000;
spacing = 20; % This is just the spacing for the logspace
N_vals = round(logspace(1, 3, spacing)); % Taking 20 (whole numbers due to rounding) of values between 10^1 and 10^3, more points taken at beginning 
param_vals = [2, 8]; % Parameter values

% Arrays to store the final results for plotting
mse_exp = zeros(length(param_vals), length(N_vals));
bias_exp = zeros(length(param_vals), length(N_vals));
var_exp = zeros(length(param_vals), length(N_vals));

mse_ray = zeros(length(param_vals), length(N_vals));
bias_ray = zeros(length(param_vals), length(N_vals));
var_ray = zeros(length(param_vals), length(N_vals));

% Exponential Distribution Simulation
for p = 1:length(param_vals)
    mu_true = param_vals(p); 
    
    for i = 1:length(N_vals)
        n = N_vals(i); 
        mu_estimates = zeros(1, N); 
        
        for trial = 1:N
            % Used exprnd function
            x = exprnd(mu_true, n, 1); 
            mu_hat = mean(x); % From hand-derivation
            mu_estimates(trial) = mu_hat;
        end
        
        bias_exp(p, i) = mean(mu_estimates) - mu_true;
        var_exp(p, i)  = var(mu_estimates);
        mse_exp(p, i)  = mean((mu_estimates - mu_true).^2); 
    end
end

% Rayleigh Distribution Simulation 
for p = 1:length(param_vals)
    b_true = param_vals(p); 
    
    for i = 1:length(N_vals)
        n = N_vals(i); 
        b_estimates = zeros(1, N);
        
        for trial = 1:N
            % Used raylrnd function, for some reason not rayrnd
            x = raylrnd(b_true, n, 1);
            b_hat = sqrt(sum(x.^2) / (2 * n)); % From hand derivation
            b_estimates(trial) = b_hat;
        end
        
        bias_ray(p, i) = mean(b_estimates) - b_true;
        var_ray(p, i)  = var(b_estimates);
        mse_ray(p, i)  = mean((b_estimates - b_true).^2); 
    end
end

% PLOTTING TIME
% Bias
figure(1);
subplot(1,2,1); hold on; grid on;
plot(N_vals, bias_exp(1,:), 'b-', 'LineWidth', 2);
plot(N_vals, bias_exp(2,:), 'r-', 'LineWidth', 2);
title('Exponential: Bias'); xlabel('Sample Size (n)'); ylabel('Bias');
legend(['\mu = ' num2str(param_vals(1))], ['\mu = ' num2str(param_vals(2))]);

subplot(1,2,2); hold on; grid on;
plot(N_vals, bias_ray(1,:), 'b-', 'LineWidth', 2);
plot(N_vals, bias_ray(2,:), 'r-', 'LineWidth', 2);
title('Rayleigh: Bias'); xlabel('Sample Size (n)'); ylabel('Bias');
legend(['b = ' num2str(param_vals(1))], ['b = ' num2str(param_vals(2))]);

% MSE
figure(2);
subplot(1,2,1); hold on; grid on;
plot(N_vals, mse_exp(1,:), 'b-', 'LineWidth', 2);
plot(N_vals, mse_exp(2,:), 'r-', 'LineWidth', 2);
title('Exponential: MSE'); xlabel('Sample Size (n)'); ylabel('MSE');
legend(['\mu = ' num2str(param_vals(1))], ['\mu = ' num2str(param_vals(2))]);

subplot(1,2,2); hold on; grid on;
plot(N_vals, mse_ray(1,:), 'b-', 'LineWidth', 2);
plot(N_vals, mse_ray(2,:), 'r-', 'LineWidth', 2);
title('Rayleigh: MSE'); xlabel('Sample Size (n)'); ylabel('MSE');
legend(['b = ' num2str(param_vals(1))], ['b = ' num2str(param_vals(2))]);

% Variance
figure(3);
subplot(1,2,1); hold on; grid on;
plot(N_vals, var_exp(1,:), 'b-', 'LineWidth', 2);
plot(N_vals, var_exp(2,:), 'r-', 'LineWidth', 2);
title('Exponential: Variance'); xlabel('Sample Size (n)'); ylabel('Variance');
legend(['\mu = ' num2str(param_vals(1))], ['\mu = ' num2str(param_vals(2))]);

subplot(1,2,2); hold on; grid on;
plot(N_vals, var_ray(1,:), 'b-', 'LineWidth', 2);
plot(N_vals, var_ray(2,:), 'r-', 'LineWidth', 2);
title('Rayleigh: Variance'); xlabel('Sample Size (n)'); ylabel('Variance');
legend(['b = ' num2str(param_vals(1))], ['b = ' num2str(param_vals(2))]);

% Answers to questions: 
% As the sample size increases, the MSE, bias, and variance of both exponential and Rayleigh distributions 
% approach zero. This means that as we observe more, our guess will be closer to the true parameter. 

% The plots show that the estimators have higher MSE and Variance when the true underlying 
% parameter is larger (mu = 5 has a higher MSE and variance compared to mu = 2)  
% The curves for the larger parameters are higher on the graphs. The variance for exponential and Rayleigh 
% distribution is mu^2 and proportional to b^2, respectively. This means
% that a higher mu and b will have higher variance and therefore, "worse
% performance."

%% Question 2
disp('Question 2 RESULTS');
load('data.mat'); 

% Ensure 'data' is a column vector just in case
data = data(:); 
n_data = length(data);

% Compute the Max-Likelihood Estimates
mu_hat_data = mean(data);
b_hat_data = sqrt(sum(data.^2) / (2 * n_data));

fprintf('Estimated Exponential Parameter (mu_hat): %.4f\n', mu_hat_data);
fprintf('Estimated Rayleigh Parameter (b_hat): %.4f\n', b_hat_data);

% 3. Numerical Justification: Compute Log-Likelihoods
% We plug the data and our estimates back into the log-likelihood equations 
% we derived in Part 1. The higher value wins.

% Exponential Log-Likelihood
ll_exp = -n_data * log(mu_hat_data) - (1/mu_hat_data) * sum(data);

% Rayleigh Log-Likelihood
ll_ray = sum(log(data)) - 2 * n_data * log(b_hat_data) - sum(data.^2) / (2 * b_hat_data^2);

fprintf('Log-Likelihood (Exponential): %.4f\n', ll_exp);
fprintf('Log-Likelihood (Rayleigh): %.4f\n', ll_ray);

if ll_exp > ll_ray
    disp('Numerical Conclusion: The data likely comes from an EXPONENTIAL distribution.');
else
    disp('Numerical Conclusion: The data likely comes from a RAYLEIGH distribution.');
end

figure(4);
hold on; grid on;
histogram(data, 'Normalization', 'pdf', 'FaceColor', [0.7 0.7 0.7], 'EdgeColor', 'w');

x_vals = linspace(0, max(data)*1.1, 1000);

% Calculate the theoretical PDFs using our estimated parameters
pdf_exp = (1/mu_hat_data) * exp(-x_vals / mu_hat_data);
pdf_ray = (x_vals ./ b_hat_data^2) .* exp(-x_vals.^2 / (2 * b_hat_data^2));

% Plot the PDFs over the histogram
plot(x_vals, pdf_exp, 'r-', 'LineWidth', 2.5);
plot(x_vals, pdf_ray, 'b-', 'LineWidth', 2.5);
title('Distribution Fit Comparison');
xlabel('Data Value');
ylabel('Probability Density');
legend('Mystery Data', 'Fitted Exponential', 'Fitted Rayleigh', 'Location', 'best');

% Question 2:

% Graph Justification:
% The data was clearly drawn from a Rayleigh distribution.
% Based on figure 4, the histogram best fits the blue curve, which is the fitted Rayleigh PDF 

% Numerical Justification:
% Based on the Maximum Likelihood calculations, the log-likelihood for the 
% Rayleigh distribution is 1365.52 which is significantly higher than the log-likelihood for the Exponential 
% distribution, which is 1053.4625, and a higher log-likelihood indicates a
% higher probability of producing the data in data.mat
