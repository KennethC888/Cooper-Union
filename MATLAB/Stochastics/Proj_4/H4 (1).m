% SPDX-License-Identifier: GNU AGPL-3.0-or-later
% Copyright (C) 2025 Kenneth Chan <kenc0728@gmail.com>
% Kenneth Chan
clc;
clear;
close all;
rng(388);

%% Question 1

% Part a 
N = 1000; 
A = 1; % Chose A = 1 since A is a known constant
variance = 1; 
sigma = sqrt(variance); 
PH0 = 0.8;
PH1 = 0.2; 

% Generate 1000 numbers, if the random number is less than 0.2, then it is
% marked as true, the rest are false. 
H_true = rand(1, N) < PH1; 

% Generate observations Y
X = sigma * randn(1, N); % Zero mean Gaussian noise
Y = H_true * A + X;      % Y = A+X if H1, Y = X if H0

% P(Y|H1) / P(Y|H0) > P(H0)/P(H1), threshold value
% Threshold comes from A/2 (midpoint) and the log of the ratio of
% probabilities of detection multiplied by uncertainty weighting factor 
thres = (variance / A) * log(PH0 / PH1) + A / 2;
H_est = Y > thres; % 1 if true, 0 if false 

P_error_empirical = sum(H_true ~= H_est) / N; % Sum of when Htrue is not equal to Hest divided by num_iterations

% Calculate Theoretical Probability of Error
P_miss_theory = normcdf(thres, A, sigma); % Type 1 error 
P_fa_theory = 1 - normcdf(thres, 0, sigma); % Type 2 error 
P_error_theory = (P_miss_theory * PH1) + (P_fa_theory * PH0);

% Display the empirical and theoretical probability of error
fprintf('Question 1a\n');
fprintf('MAP Threshold (thres): %.4f\n', thres);
fprintf('Empirical Probability of Error: %.4f\n', P_error_empirical);
fprintf('Theoretical Probability of Error: %.4f\n', P_error_theory);

% part b and c 
A_vals = [1, 3, 8]; % Test several signal amplitudes
figure; hold on;
colors = ['r', 'g', 'b'];

for i = 1:length(A_vals)
    A = A_vals(i); 
    % Vary threshold to create ROC
    thres_range = linspace(-5, 8, 200);
    Pd = zeros(1, length(thres_range));
    Pf = zeros(1, length(thres_range));

    for j = 1: length(thres_range)
        Pd(j) = 1 - normcdf(thres_range(j), A, sigma);
        Pf(j) = 1 - normcdf(thres_range(j), 0, sigma); 
    end
    plot(Pf, Pd, 'Color', colors(i), 'LineWidth', 2, 'DisplayName', sprintf('A = %d', A));

    % Mark Risk point for at least one SNR (let's choose A = 3)
    if A == 3
        C_miss = 10; % Missing the target is 10x worse than false alarm cost
        C_fa = 1;    
        
        % Risk Threshold formula
        thres_risk = (variance / A) * log((C_fa * PH0) / (C_miss * PH1)) + A / 2;
        
        Pd_risk = 1 - normcdf(thres_risk, A, sigma);
        Pf_risk = 1 - normcdf(thres_risk, 0, sigma);
        
        plot(Pf_risk, Pd_risk, 'k*', 'MarkerSize', 10, 'LineWidth', 2, 'DisplayName', 'Min Risk Pt (SNR=3)');
            
        fprintf('Question 1c: Minimum Conditional Risk \n');
        fprintf('Risk Threshold (for A=3): %.4f\n\n', thres_risk);
    end
end
xlabel('Probability of False Alarm (P_F)');
ylabel('Probability of Detection (P_D)');
title('Question 1b & 1c: ROC Curves');
legend('Location', 'best');
grid on;

% Part 1d
% Model H1: Y = A + X (mean = A, variance = original variance)
% Model H0: Y = A + Z (mean = A, variance_Z > original variance)

% We can reuse the A and variance from Part 1a (A = 1, variance = 1)
variance_Z_vals = [1, 2, 5, 10, 15, 18]; % Test different variance ratios (2x, 5x, 10x larger)
A = 1; 

figure; hold on;
colors_d = ['c', 'm', 'k','b','r','g']; 

for i = 1:length(variance_Z_vals)
    variance_Z = variance_Z_vals(i);
    sigma_Z = sqrt(variance_Z); 
   
    thres_range = linspace(-10, 10, 500);
    Pd = zeros(1, length(thres_range));
    Pf = zeros(1, length(thres_range));
 
    for j = 1:length(thres_range)
        % Pd uses the original sigma (H1 model)
        Pd(j) = 1 - normcdf(thres_range(j), A, sigma);
        % Pf uses the NEW sigma_Z, and the mean is now A instead of 0 
        Pf(j) = 1 - normcdf(thres_range(j), A, sigma_Z);
    end
    plot(Pf, Pd, 'Color', colors_d(i), 'LineWidth', 2, 'DisplayName', sprintf('Var_Z / Var_X = %d', variance_Z / variance));
end
xlabel('Probability of False Alarm (P_F)');
ylabel('Probability of Detection (P_D)');
title('Question 1d: ROC with modified H_0 variance');
legend('Location', 'best');
grid on;


%% Question 2 
load Iris.mat; 
X = features; 
Y = labels; 

% Determine the sizes dynamically based on the data
num_classes = length(unique(Y)); % 3, given
num_features = size(X, 2); % 4
total_samples = size(X, 1); % 150

% split data, half train, half test
shuffled_indices = randperm(total_samples); 
train = shuffled_indices(1 : total_samples/2);
test = shuffled_indices(total_samples/2 + 1 : end);

X_train = X(train, :);
Y_train = Y(train);
X_test = X(test, :);
Y_test = Y(test);

class_means = cell(num_classes, 1); % cell is array of matrices
class_covs = cell(num_classes, 1);
prior_probs = zeros(num_classes, 1);

for i = 1:num_classes
    % Find all training rows that belong to the current class 'c'
    rows_for_curr_class_i = (Y_train == i);
    X_c = X_train(rows_for_curr_class_i, :);
    class_means{i} = mean(X_c);
    % 4x4 Covariance matrix
    class_covs{i} = cov(X_c);
    % prior probability 
    prior_probs(i) = sum(rows_for_curr_class_i) / length(Y_train);
end

% Make predictions
num_test_samples = size(X_test, 1);
Y_est = zeros(num_test_samples, 1); % Array to hold our guesses

for i = 1:num_test_samples
    current_flower = X_test(i, :);
    posteriors = zeros(num_classes, 1); % To hold the 3 probabilities
    
    % Check the probability of this flower belonging to each of the 3 classes
    for a = 1:num_classes
        % Compute the Likelihood P(Data | Class) using a 4D Gaussian
        likelihood = mvnpdf(current_flower, class_means{a}, class_covs{a});
        
        % Multiply by Prior P(Class) to get the MAP Posterior
        posteriors(a) = likelihood * prior_probs(a);
    end
    
    % Our guess is whichever class had the MAXIMUM probability
    [max_probability, best_class] = max(posteriors);
    Y_est(i) = best_class;
end

% Error calculation
mistakes = (Y_test ~= Y_est);
total_error_prob = sum(mistakes) / num_test_samples;

fprintf('Question 2 \n');
fprintf('Total Probability of Error: %.4f\n\n', total_error_prob);

% Plot the Confusion Matrix
figure;
confusionchart(Y_test, Y_est);
title('Confusion Matrix: Test Data');

%% Stretch Goal
N = 1000; 
A = 2;       % Chose A=2 for better separation 
b = 1;       % Laplacian scale parameter
PH0 = 0.8;
PH1 = 0.2; 

% Generate true hypotheses (0 for H0, 1 for H1)
H_true = rand(1, N) < PH1; 

% Generate Laplacian Noise using Inverse Transform Sampling
% U is uniform random noise between -0.5 and 0.5
U = rand(1, N) - 0.5; 
X_lap = -b * sign(U) .* log(1 - 2 * abs(U)); 

% Generate observations Y
Y = H_true * A + X_lap; % Y = A + X_lap if H1, Y = X_lap if H0

% Apply the derived Laplacian MAP threshold
thres = A / 2 + (b / 2) * log(PH0 / PH1);
H_est = Y > thres; 

% Calculate Empirical Error
mistakes = (H_true ~= H_est);
P_error_empirical = sum(mistakes) / N;

% Create a custom function to calculate the Laplacian CDF
% F(x) = 0.5 * exp((x-mu)/b)          for x < mu
% F(x) = 1 - 0.5 * exp(-(x-mu)/b)     for x >= mu
laplace_cdf = @(x, mu, b) 0.5 * exp((x - mu) ./ b) .* (x < mu) + (1 - 0.5 * exp(-(x - mu) ./ b)) .* (x >= mu);

% Calculate Theoretical Probability of Error using our custom CDF
P_miss_theory = laplace_cdf(thres, A, b); 
P_fa_theory = 1 - laplace_cdf(thres, 0, b); 
P_error_theory = (P_miss_theory * PH1) + (P_fa_theory * PH0);

fprintf('Stretch Goal \n');
fprintf('MAP Threshold (thres): %.4f\n', thres);
fprintf('Empirical Probability of Error: %.4f\n', P_error_empirical);
fprintf('Theoretical Probability of Error: %.4f\n\n', P_error_theory);

A_vals = [1, 3, 8]; % Test several signal amplitudes
figure; hold on;
colors = ['r', 'g', 'b'];

for i = 1:length(A_vals)
    A_curr = A_vals(i); 
    
    % Vary threshold to create ROC
    thres_range = linspace(-5, 8, 300);
    Pd = zeros(1, length(thres_range));
    Pf = zeros(1, length(thres_range));
    
    % Calculate probabilities for each threshold using the Laplacian CDF
    for j = 1:length(thres_range)
        Pd(j) = 1 - laplace_cdf(thres_range(j), A_curr, b);
        Pf(j) = 1 - laplace_cdf(thres_range(j), 0, b); 
    end
    
    % Plot the ROC curve for this amplitude
    plot(Pf, Pd, 'Color', colors(i), 'LineWidth', 2, 'DisplayName', sprintf('A = %d', A_curr));
end

xlabel('Probability of False Alarm (P_F)');
ylabel('Probability of Detection (P_D)');
title('Stretch Goal: ROC Curves with Laplacian Noise');
legend('Location', 'best');
grid on;
