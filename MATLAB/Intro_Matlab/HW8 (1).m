% SPDX-License-Identifier: GNU AGPL-3.0-or-later
% Copyright (C) 2025 Kenneth Chan <kenc0728@gmail.com>
% Kenneth Chan

clear all;
close all;
clc;

% Initialize variables
N = 1e6;

v = 5; 
student_t_scale = sqrt(v/(v-2)); 
students_t_random_variables = trnd(v, N, 1) * student_t_scale;

alpha = 0.544; 
gauss = randn(N, 1);
Cauchy_dist = alpha * tan((pi * gauss) - 0.5);

p_gaussian = mean(abs(gauss) > 2);
p_t_dist = mean(abs(students_t_random_variables) > 2);
p_cauchy = mean(abs(Cauchy_dist) > 2);

figure;
plot(1:N, gauss);
hold on;
plot([1 N], [2 2], 'r--');
plot([1 N], [-2 -2], 'r--');
title('Gaussian Data');
ylim([-10 10]); 

figure;
plot(1:N, students_t_random_variables);
hold on;
plot([1 N], [2 2], 'r--');
plot([1 N], [-2 -2], 'r--');
title('Student''s t Data');
ylim([-10 10]);

figure;
plot(1:N, Cauchy_dist);
hold on;
plot([1 N], [2 2], 'r--');
plot([1 N], [-2 -2], 'r--');
title('Cauchy Data');

% Part C
num_segments = 10;
segment_size = N / num_segments;

gaussian_segments = reshape(gauss, segment_size, num_segments);
t_segments = reshape(students_t_random_variables, segment_size, num_segments);
cauchy_segments = reshape(Cauchy_dist, segment_size, num_segments);

gauss_mean = mean(gaussian_segments);
student_t_mean = mean(t_segments);
Cauchy_mean = mean(cauchy_segments);

disp('Gaussian segment means:'); disp(gauss_mean);
disp('Student''s t segment means:'); disp(student_t_mean);
disp('Cauchy segment means:'); disp(Cauchy_mean);

% Part 2a
b = [1, 0.4, 0.2]; 
a = [1, -1.6, 0.81]; 

zeros_H = roots(b); 
poles_H = roots(a); 

figure;
zplane(b, a);
title('Pole-Zero Plot of H(z)');

if (all(abs(zeros_H) < 1))
    disp("This is minimum phase"); 
end

% Part 2b
N = 1e5; 
v_noise = sqrt(2) * randn(N, 1); 
x = filter(b, a, v_noise);

m = 6;
r_x = zeros(m + 1, 1); 

for i = 0:m
    r_x(i+1) = x(1:N-i)' * x(1+i:N) / N;
end

l_range = -6:6;
rx_symmetric = [flip(r_x(2:end)); r_x];

figure;
stem(l_range, rx_symmetric, 'filled');
xlabel('Lag m'); ylabel('r_x[m]');
title('Autocorrelation Estimate');

R = toeplitz(r_x);
disp(R); 

e = eig(R); 
disp(e); 
if (all(e) > 0)
    disp("Positive, definite"); 
end

X = toeplitz(x(m+1:end), flip(x(1:m+1)));
R2 = (X'*X)/size(X,1);

disp('Alternative matrix R2:'); disp(R2);
disp('Norm difference ||R1-R2||:'); disp(norm(R-R2));

% 2c
[s_est, w] = pwelch(x,hamming(512),256,512);

figure;
plot(w, s_est);
title('Estimated PSD');
xlabel('Frequency (rad/sample)');
ylabel('PSD');

[z, p, k] = tf2zpk(b, a);
pole_angle = angle(p(1));
fprintf('Pole angle: %.4f rad\n', pole_angle);

[~, idx] = max(s_est);
w_0 = w(idx);
fprintf('Peak frequency: %.4f rad/sample\n', w_0);

% 2d
fprintf('Length of x right before 2d: %d\n', length(x)); % Debug print

l = 6;
[a_est, varv] = aryule(x, 4);
fprintf('Estimated variance: %.4f (true: 2)\n', varv);

v0 = sqrt(varv) * randn(length(x), 1);
x0 = filter(1, a_est, v0);

lags = -l:l;
rx = zeros(length(lags), 1);
rx0 = zeros(length(lags), 1);

for idx = 1:length(lags)
    m_lag = lags(idx);
    if m_lag >= 0
        rx(idx) = mean(x(1:end-m_lag) .* x(1+m_lag:end));
        rx0(idx) = mean(x0(1:end-m_lag) .* x0(1+m_lag:end));
    else
        rx(idx) = mean(x(1-m_lag:end) .* x(1:end+m_lag));
        rx0(idx) = mean(x0(1-m_lag:end) .* x0(1:end+m_lag));
    end
end

figure;
stem(lags, rx, 'b', 'filled'); hold on;
stem(lags, rx0, 'r');
legend('Original', 'AR(4)');
title('Correlation Comparison');
xlabel('Lag m');
ylabel('Correlation');

figure;
stem(1:100, x(1:100), 'b', 'filled'); hold on;
stem(1:100, x0(1:100), 'r');
legend('Original', 'AR(4)');
title('Time Series Comparison');
xlabel('Sample Index');
ylabel('Amplitude');
