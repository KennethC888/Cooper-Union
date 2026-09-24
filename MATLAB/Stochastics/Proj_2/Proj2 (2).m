% SPDX-License-Identifier: GNU AGPL-3.0-or-later
% Copyright (C) 2025 Kenneth Chan <kenc0728@gmail.com>
% Kenneth Chan

clc;
clear;
close all;
rng(388); 

%% Problem 1: 
fprintf('Problem 1\n');
num_samples = 1e6; 

% Y is uniform [-1,1]
Y = -1 + 2 * rand(num_samples, 1);
% Uniform var is (b-a)^2 / 12
variance_Y = (1 - (-1))^2 / 12; 
E_Y = 0;   

% W in range [-0.01, 0.01] 
w1 = 0.01;
% Noisy W1 and observation X1
W1 = -w1 + (2 * w1) * rand(num_samples, 1); 
X1 = Y + W1;
variance_W1 = (w1 - (-w1))^2 / 12; 

% Bayes estimate is midpoint of the parallelogram 
min_Y1 = max(-1, X1 - w1);
max_Y1 = min(1, X1 + w1);
Y_hat_Bayes_1 = (min_Y1 + max_Y1) / 2;

% LMMSE: y hat = mean y + (covar(xy) / var x) (x - mean x)                         
E_X1 = 0;                            
Cov_YX1 = variance_Y;                
Var_X1 = variance_Y + variance_W1;   
Y_hat_LMMSE_1 = E_Y + (Cov_YX1 / Var_X1) * (X1 - E_X1);

% Calculate Empirical and Theoretical MSEs
empirical_mse_Bayes_1 = mean((Y - Y_hat_Bayes_1).^2);
empirical_mse_LMMSE_1 = mean((Y - Y_hat_LMMSE_1).^2);
theoretical_mse_Bayes_1 = (w1^2) / 3 - (w1^3) / 6;
theoretical_mse_LMMSE_1 = variance_Y * (1 - (Cov_YX1 / Var_X1));

% Print results as a table
fprintf('\nMSE Results for W in range [-0.01, 0.01] \n');
fprintf('%-15s | %-20s | %-20s\n', 'Estimator', 'Theoretical MSE', 'Empirical MSE');
fprintf('--------------------------------------------------------------\n');
fprintf('%-15s | %-20.6f | %-20.6f\n', 'LMMSE', theoretical_mse_LMMSE_1, empirical_mse_LMMSE_1);
fprintf('%-15s | %-20.6f | %-20.6f\n\n', 'Bayes MMSE', theoretical_mse_Bayes_1, empirical_mse_Bayes_1);

% Plot 1
figure(1);
scatter(X1(1:5000), Y_hat_Bayes_1(1:5000), 10, 'g', 'filled');
hold on;
% Draw LMMSE line using min and max X values
x_endpoints_1 = [min(X1), max(X1)];
y_endpoints_1 = E_Y + (Cov_YX1 / Var_X1) * (x_endpoints_1 - E_X1);
plot(x_endpoints_1, y_endpoints_1, 'r-', 'LineWidth', 2);

title('Estimators for W in range [-0.01, 0.01]'); 
xlabel('Observation X');
ylabel('Estimated Y');
legend('Bayes MMSE', 'LMMSE Line', 'Location', 'best');
grid on;

% W in range [-2, 2]
w2 = 2; 
W2 = -w2 + (2 * w2) * rand(num_samples, 1); 
X2 = Y + W2; 
variance_W2 = (w2 - (-w2))^2 / 12; 

min_Y2 = max(-1, X2 - w2);
max_Y2 = min(1, X2 + w2);
Y_hat_Bayes_2 = (min_Y2 + max_Y2) / 2;                         
E_X2 = 0;                            
Cov_YX2 = variance_Y;                
Var_X2 = variance_Y + variance_W2;   
Y_hat_LMMSE_2 = E_Y + (Cov_YX2 / Var_X2) * (X2 - E_X2);

empirical_mse_Bayes_2 = mean((Y - Y_hat_Bayes_2).^2);
empirical_mse_LMMSE_2 = mean((Y - Y_hat_LMMSE_2).^2);
theoretical_mse_Bayes_2 = 1/4; 
theoretical_mse_LMMSE_2 = variance_Y * (1 - (Cov_YX2 / Var_X2));

% Print results as a table
fprintf('MSE Results for W in range [-2, 2] \n');
fprintf('%-15s | %-20s | %-20s\n', 'Estimator', 'Theoretical MSE', 'Empirical MSE');
fprintf('--------------------------------------------------------------\n');
fprintf('%-15s | %-20.6f | %-20.6f\n', 'LMMSE', theoretical_mse_LMMSE_2, empirical_mse_LMMSE_2);
fprintf('%-15s | %-20.6f | %-20.6f\n\n', 'Bayes MMSE', theoretical_mse_Bayes_2, empirical_mse_Bayes_2);

% Plot 2
figure(2);
scatter(X2(1:5000), Y_hat_Bayes_2(1:5000), 10, 'g', 'filled'); 
hold on;
% Draw LMMSE line using min and max X values
x_endpoints_2 = [min(X2), max(X2)];
y_endpoints_2 = E_Y + (Cov_YX2 / Var_X2) * (x_endpoints_2 - E_X2);
plot(x_endpoints_2, y_endpoints_2, 'r-', 'LineWidth', 2);

title('Estimators for W in range [-2, 2]'); 
xlabel('Observation X');
ylabel('Estimated Y');
legend('Bayes MMSE', 'LMMSE Line', 'Location', 'best');
grid on;

%% Problem 2
mu_Y = 1;
mu_R = 0; 
num_samples = 1e6;   
N = 30; % number of observations       

% Pair 1: Made up a variance for y and r
var_Y_1 = 3;
var_R_1 = 8;

% Pair 2: Made up another variance for y and r
var_Y_2 = 6;
var_R_2 = 1;

% Setup empty arrays to store MSE results
% zeros(A,B) is A rows and N columns
empirical_MSE_1 = zeros(N, 1); 
theoretical_MSE_1 = zeros(N, 1);
empirical_MSE_2 = zeros(N, 1);
theoretical_MSE_2 = zeros(N, 1);

% Loop through N observations 
for i = 1:N
    % Generate Y and R, true signal and noise respectively, they are both Gaussian variables, mu_R is 0 btw
    Y1 = mu_Y + sqrt(var_Y_1) * randn(num_samples, 1);
    R1 = mu_R + sqrt(var_R_1) * randn(num_samples, i);
    % X is the true signal plus the noise
    X1 = Y1 + R1; 
    
    % Calculate the sample mean of the N observations
    % mean(X1,2) means that the rows are averaged into an N x 1 col, each
    % entry is the average of the row. Example:
    % 1 2 3 
    % 3 4 1
    % Result is :
    %  2 
    % 8/3

    X_bar_1 = mean(X1, 2);
    
    % Apply the N-observation LMMSE formula
    % Var X bar = Var Y + Var R bar, R bar = R / i 
    var_X_bar_1 = var_Y_1 + (var_R_1 / i);
    Y_hat_1 = mu_Y + (var_Y_1 / var_X_bar_1) * (X_bar_1 - mu_Y);
    
    % Record Empirical and Theoretical MSE, same formula as problem 1 
    empirical_MSE_1(i) = mean((Y1 - Y_hat_1).^2);
    theoretical_MSE_1(i) = (var_Y_1 * (var_R_1 / i)) / (var_Y_1 + (var_R_1 / i));
   
    % Repeat the exact same process for the second pair of variances
    Y2 = mu_Y + sqrt(var_Y_2) * randn(num_samples, 1);
    R2 = sqrt(var_R_2) * randn(num_samples, i);
    X2 = Y2 + R2;
    
    X_bar_2 = mean(X2, 2);
    var_X_bar_2 = var_Y_2 + (var_R_2 / i);
    Y_hat_2 = mu_Y + (var_Y_2 / var_X_bar_2) * (X_bar_2 - mu_Y);
    
    empirical_MSE_2(i) = mean((Y2 - Y_hat_2).^2);
    theoretical_MSE_2(i) = (var_Y_2 * (var_R_2 / i)) / (var_Y_2 + (var_R_2 / i));
    
end

% Plotting TIME
figure(3);
hold on; grid on;

% Plot Pair 1 (Blue)
plot(1:N, theoretical_MSE_1, 'b-', 'LineWidth', 2);
scatter(1:N, empirical_MSE_1, 30, 'b', 'filled');

% Plot Pair 2 (Red)
plot(1:N, theoretical_MSE_2, 'r-', 'LineWidth', 2);
scatter(1:N, empirical_MSE_2, 30, 'r', 'filled');

title('Scenario 2: LMMSE Error vs. Number of Observations');
xlabel('Number of Observations (N)');
ylabel('Mean Squared Error (MSE)');
legend(sprintf('Theoretical (Var\\_Y=%d, Var\\_R=%d)', var_Y_1, var_R_1), ...
       sprintf('Empirical (Var\\_Y=%d, Var\\_R=%d)', var_Y_1, var_R_1), ...
       sprintf('Theoretical (Var\\_Y=%d, Var\\_R=%d)', var_Y_2, var_R_2), ...
       sprintf('Empirical (Var\\_Y=%d, Var\\_R=%d)', var_Y_2, var_R_2), ...
       'Location', 'northeast');

%% Problem 3
fprintf('Problem 3\n');

% Load the given data
load('SATs (2).mat'); 
X = double(SAT_Math);  
Y = double(SAT_Verbal); 

% Create empty (arrays) for the 3 groups: all data, total score between 1150 and 1250, and total score greater than 1320.
X_group1 = []; Y_group1 = []; 
X_group2 = []; Y_group2 = []; 
X_group3 = []; Y_group3 = [];

% PARSE THE DATA
for i = 1:length(X)
    % Check to make sure not NaN 
    if ~isnan(X(i)) && ~isnan(Y(i))
        
        % Put them in Bucket 1 [a, b, c, d... 34], each new data appends behind the last entered data
        X_group1(end+1) = X(i);
        Y_group1(end+1) = Y(i);
        
        % Calculate their total score to see if they fit in the other buckets
        total_score = X(i) + Y(i);
        
        % Check if they belong in Bucket 2
        if total_score >= 1150 && total_score <= 1250
            X_group2(end+1) = X(i);
            Y_group2(end+1) = Y(i);
        end
        
        % Check if they belong in Bucket 3
        if total_score > 1320
            X_group3(end+1) = X(i);
            Y_group3(end+1) = Y(i);
        end
        
    end
end

% Group the buckets together so we can easily plot them
X_groups = {X_group1, X_group2, X_group3};
Y_groups = {Y_group1, Y_group2, Y_group3};

labels = {'1: All Data', '2: 1150 <= Total <= 1250', '3: Total > 1320'};
scatter_colors = {[0.7 0.7 0.7], [0.5 0.7 1], [1 0.5 0.5]}; 
line_colors = {'k', 'b', 'r'}; 

% Plotting TIME
figure(4);
hold on; grid on;

% Loop through 3 categories to do the math and draw the lines
for i = 1:3
    
    % Get current bucket
    X_sub = X_groups{i};
    Y_sub = Y_groups{i};
    
    % Mean
    mu_X = mean(X_sub);
    mu_Y = mean(Y_sub);
    
    % Covar matrix 
    C = cov(X_sub, Y_sub);
    var_X = C(1, 1);
    cov_XY = C(1, 2);
    
    % LMMSE slope and intercept
    slope = cov_XY / var_X;
    intercept = mu_Y - slope * mu_X;
    
    % Scatterplot! 
    scatter(X_sub, Y_sub, 20, scatter_colors{i}, 'filled', 'DisplayName', [labels{i} ' (Data)']);
    
    % Plot the LMMSE straight line
    x_line = [min(X_sub), max(X_sub)];
    y_line = slope * x_line + intercept;
    plot(x_line, y_line, line_colors{i}, 'LineWidth', 3, 'DisplayName', [labels{i} ' (Fit)']);
    fprintf('Subset %s:\n', labels{i});
    fprintf('Equation: Y_hat = %.4f * X + %.4f\n\n', slope, intercept);
end

title('Scenario 3: Estimating SAT Verbal from Math');
xlabel('SAT Math Score (X)');
ylabel('SAT Verbal Score (Y)');
legend('Location', 'northeastoutside');

% COMMENT
fprintf('--- Observations on Estimator Behavior ---\n');
fprintf('When computed over the entire range (All Data), the estimator shows a strong positive slope.\n');
fprintf('However, when restricting the data to smaller subsets based on total score (e.g., 1150-1250),\n');
fprintf('the variance of the X subset shrinks drastically. Because the LMMSE slope is Cov(X,Y)/Var(X),\n');
fprintf('this restricted range decreases the correlation between the variables, resulting in much flatter\n');
fprintf('slopes for the subset estimators compared to the overall population.\n');