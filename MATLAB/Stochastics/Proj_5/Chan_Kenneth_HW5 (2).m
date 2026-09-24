% SPDX-License-Identifier: GNU AGPL-3.0-or-later
% Copyright (C) 2025 Kenneth Chan <kenc0728@gmail.com>
% Kenneth Chan
clc;
clear;
close all;
rng(388);


%% 1. Parameters & Signal Generation
N_samples = 1e5;
sigma2 = 0.01;
c = [0.2, 0.5, 0.8, 0.5, 0.2];
N_vals = [1, 2, 4, 10]; 

% Target signal s[n]: i.i.d. +/- 1
s = sign(randn(N_samples, 1));
% Force zeros to 1 just in case randn hits exactly 0
s(s==0) = 1;

% Pass signal through the channel: (s * c)[n]
v = filter(c, 1, s);

% Generate white noise w[n]
w = sqrt(sigma2) * randn(N_samples, 1);

% Generate the two noise models
d_white = w;                           % Pure white noise
d_colored = filter(1, [1, -0.9], w);   % AR(1) colored noise: d[n] = 0.9d[n-1] + w[n]

% Final observations: r[n]
r_white = v + d_white;
r_colored = v + d_colored;

% Rcc[n] = sum(c[m]*c[m-n]) for lags 0 to 4.
Rcc = zeros(1, 5);
for n = 0:4
    Rcc(n+1) = sum(c(1:end-n) .* c(n+1:end));
end

fprintf('--- MMSE Results Summary (sigma^2 = %.2f) ---\n', sigma2);
fprintf('  N | White (Sim) | White (Theo) | Color (Sim) | Color (Theo) | White (XCORR)\n');
fprintf('------------------------------------------------------------------------------\n');

% Arrays to store the N=10 filters and outputs for plotting later
h_w_N10 = [];
h_c_N10 = [];
s_hat_w_N10 = [];

for N = N_vals
    % 1. Auto-correlation for White Noise
    Rrr_w = zeros(1, N);
    for n = 0:N-1
        if n < 5, Rrr_w(n+1) = Rcc(n+1); end
    end
    Rrr_w(1) = Rrr_w(1) + sigma2;
    R_mat_w = toeplitz(Rrr_w);
    
    % 2. Auto-correlation for Colored Noise
    Rrr_c = zeros(1, N);
    for n = 0:N-1
        Rdd_n = (sigma2 / 0.19) * (0.9^n);
        if n < 5
            Rrr_c(n+1) = Rcc(n+1) + Rdd_n;
        else
            Rrr_c(n+1) = Rdd_n;
        end
    end
    R_mat_c = toeplitz(Rrr_c);
    
    % 3. Cross-correlation vector Rsr (Only non-zero at lag 0)
    rsr = zeros(N, 1);
    rsr(1) = c(1);
    
    %--- Solve Normal Equations ---
    h_w = R_mat_w \ rsr;
    h_c = R_mat_c \ rsr;
    
   % --- Apply Filters & Calculate Simulated MSE ---
    s_hat_w = filter(h_w, 1, r_white);
    s_hat_c = filter(h_c, 1, r_colored);
    
    % Capture the N=10 specific data for plotting
    if N == 10
        h_w_N10 = h_w;
        h_c_N10 = h_c;
        s_hat_w_N10 = s_hat_w;
    end
    
    % Calculate MSE (ignoring the first N samples to account for filter delay)
    mse_sim_w = mean((s(N:end) - s_hat_w(N:end)).^2);
    mse_sim_c = mean((s(N:end) - s_hat_c(N:end)).^2);
    
    % Stretch Goal 1: Theoretical MSE ---
    % J_min = Rss[0] - rsr^T * h. (Since s[n] is +/- 1, Rss[0] = 1)
    mse_theo_w = 1 - rsr.' * h_w;
    mse_theo_c = 1 - rsr.' * h_c;
    
    % --- Stretch Goal 2: Empirical Correlations (XCORR) ---
    % Calculate empirical autocorrelations using standard xcorr
    [r_acorr, ~] = xcorr(r_white, N-1, 'unbiased');
    Rrr_emp = r_acorr(N:end); % Extract positive lags 0 to N-1
    
    [sr_xcorr, ~] = xcorr(s, r_white, N-1, 'unbiased');
    Rsr_emp = sr_xcorr(N:end); % Extract positive lags 0 to N-1
    
    % Solve normal equations empirically
    R_mat_emp = toeplitz(Rrr_emp);
    h_emp = R_mat_emp \ Rsr_emp;
    
    % Find Empirical MSE
    s_hat_emp = filter(h_emp, 1, r_white);
    mse_emp = mean((s(N:end) - s_hat_emp(N:end)).^2);
    
    fprintf(' %2d |   %.4f    |   %.4f   |   %.4f    |   %.4f   |    %.4f\n', ...
            N, mse_sim_w, mse_theo_w, mse_sim_c, mse_theo_c, mse_emp);
end

% 4. Plotting 
figure('Name', 'MMSE Filter Results (N=10)', 'Position', [100, 100, 1200, 800]);

% --- Top Row: Scatter Plots (Grid positions 1, 2, and 3) ---
plot_range = 1000:1100;

subplot(2, 3, 1);
plot(s(plot_range), zeros(length(plot_range),1), 'bo', 'MarkerFaceColor', 'b');
title('1. Before Channel s[n]'); ylim([-2 2]); grid on;

subplot(2, 3, 2);
plot(r_white(plot_range), zeros(length(plot_range),1), 'ro', 'MarkerFaceColor', 'r');
title('2. Channel + Noise r[n]'); ylim([-2 2]); grid on;

subplot(2, 3, 3);
plot(s_hat_w_N10(plot_range), zeros(length(plot_range),1), 'go', 'MarkerFaceColor', 'g');
title('3. Equalized s[n] (N=10)', 'Interpreter', 'none');

% --- Bottom Row: Magnitude Responses (Spans grid positions 4, 5, and 6) ---
subplot(2, 3, [4, 5, 6]);
[H_w, w_w] = freqz(h_w_N10, 1, 1024);
[H_c, w_c] = freqz(h_c_N10, 1, 1024);

plot(w_w/pi, 20*log10(abs(H_w)), 'b', 'LineWidth', 2); hold on;
plot(w_c/pi, 20*log10(abs(H_c)), 'r', 'LineWidth', 2);
title('Magnitude Response of N=10 Estimation Filters');
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Magnitude (dB)');
legend('Pure White Noise Filter', 'Colored Noise Filter', 'Location', 'southwest');
grid on;


% SPDX-License-Identifier: GNU AGPL-3.0-or-later
% Complete MMSE Equalization with Stretch Goals and Look-Ahead Bonus

clc; clear; close all;
rng(388); % For reproducibility

% 1. Parameters & Signal Generation
N_samples = 1e5;
sigma2_base = 0.01;
c = [0.2, 0.5, 0.8, 0.5, 0.2];
N_vals = [1, 2, 4, 10]; 
Lc = length(c);

% Target signal s[n]: i.i.d. +/- 1
s = sign(randn(N_samples, 1));
s(s==0) = 1;

% Pass signal through the channel: v[n] = (s * c)[n]
v = filter(c, 1, s);

% Generate white noise w[n]
w = sqrt(sigma2_base) * randn(N_samples, 1);

% Generate the two noise models
d_white = w;                           % Pure white noise
d_colored = filter(1, [1, -0.9], w);   % AR(1) colored noise: d[n] = 0.9d[n-1] + w[n]

% Final observations: r[n]
r_white = v + d_white;
r_colored = v + d_colored;

% 2. Pre-calculate Theoretical Channel Autocorrelation (Rcc)
% Rcc[k] = sum(c[m]*c[m-k])
Rcc = zeros(1, Lc);
for k = 0:Lc-1
    Rcc(k+1) = sum(c(1:end-k) .* c(k+1:end));
end

fprintf('==============================================================================\n');
fprintf('  BASE MMSE RESULTS (Delay D = 0, sigma^2 = %.2f)\n', sigma2_base);
fprintf('  N | White (Sim) | White (Theo)| Color (Sim) | Color (Theo)| White (Empirical)\n');
fprintf('------------------------------------------------------------------------------\n');

for N = N_vals
    %--- Theoretical Matrices ---
    % 1. Auto-correlation for White Noise: Rrr[k] = Rcc[k] + sigma2*delta[k]
    Rrr_w = zeros(1, N);
    Rrr_w(1:min(N, Lc)) = Rcc(1:min(N, Lc));
    Rrr_w(1) = Rrr_w(1) + sigma2_base;
    R_mat_w = toeplitz(Rrr_w);
    
    % 2. Auto-correlation for Colored Noise: Rrr[k] = Rcc[k] + Rdd[k]
    Rrr_c = zeros(1, N);
    for k = 0:N-1
        % Variance of d[n] is sigma^2 / (1 - 0.9^2) = sigma^2 / 0.19
        Rdd_k = (sigma2_base / 0.19) * (0.9^k); 
        if k < Lc
            Rrr_c(k+1) = Rcc(k+1) + Rdd_k;
        else
            Rrr_c(k+1) = Rdd_k;
        end
    end
    R_mat_c = toeplitz(Rrr_c);
    
    % 3. Cross-correlation vector Rsr (No delay: D = 0)
    % p[k] = E[s[n] r[n-k]] = c[-k]. Only non-zero at k=0.
    rsr = zeros(N, 1);
    rsr(1) = c(1);
    
    % --- Solve Normal Equations (Theoretical) ---
    h_w = R_mat_w \ rsr;
    h_c = R_mat_c \ rsr;
    
    % --- Apply Filters & Calculate Simulated MSE ---
    s_hat_w = filter(h_w, 1, r_white);
    s_hat_c = filter(h_c, 1, r_colored);
    
    % MSE (ignoring initial transient)
    mse_sim_w = mean((s(N:end) - s_hat_w(N:end)).^2);
    mse_sim_c = mean((s(N:end) - s_hat_c(N:end)).^2);
    
    %--- Stretch Goal 1: Theoretical MSE ---
    % J_min = Rss[0] - rsr^T * h. (Since s[n] is +/- 1, Rss[0] = 1)
    mse_theo_w = 1 - rsr.' * h_w;
    mse_theo_c = 1 - rsr.' * h_c;
    
    % --- Stretch Goal 2: Empirical Correlations (using XCORR) ---
    % Autocorrelation of r
    [r_acorr, ~] = xcorr(r_white, N-1, 'unbiased');
    Rrr_emp = r_acorr(N:end); % Extract positive lags 0 to N-1
    
    % Cross-correlation of s and r
    [sr_xcorr, ~] = xcorr(s, r_white, N-1, 'unbiased');
    Rsr_emp = sr_xcorr(N:end); 
    
    % Solve normal equations empirically
    R_mat_emp = toeplitz(Rrr_emp);
    h_emp = R_mat_emp \ Rsr_emp;
    
    s_hat_emp = filter(h_emp, 1, r_white);
    mse_emp = mean((s(N:end) - s_hat_emp(N:end)).^2);
    
    fprintf(' %2d |   %.4f    |   %.4f    |   %.4f    |   %.4f    |    %.4f\n', ...
            N, mse_sim_w, mse_theo_w, mse_sim_c, mse_theo_c, mse_emp);
end

%BONUS POINTS: Implementing Delay (Look-Ahead)

fprintf('\n==============================================================================\n');
fprintf('  BONUS: DELAY / LOOK-AHEAD RESULTS (N = 10, White Noise, sigma^2 = %.2f)\n', sigma2_base);
fprintf('  Delay (D) | Simulated MSE | Theoretical MSE | Improvement Factor\n');
fprintf('------------------------------------------------------------------------------\n');

N_bonus = 10;
D_vals = [0, 1, 2, 3, 4, 5]; 
Rrr_w_bonus = zeros(1, N_bonus);
Rrr_w_bonus(1:min(N_bonus, Lc)) = Rcc(1:min(N_bonus, Lc));
Rrr_w_bonus(1) = Rrr_w_bonus(1) + sigma2_base;
R_mat_bonus = toeplitz(Rrr_w_bonus);

mse_base_D0 = 0;
best_D = 0; best_mse = 1; best_h = []; best_shat = [];

for D = D_vals
    % Calculate cross-correlation vector with delay:
    % p[k] = E[s[n-D] r[n-k]] = c[D-k]
    rsr_d = zeros(N_bonus, 1);
    for k_idx = 1:N_bonus
        k = k_idx - 1; 
        m = D - k;
        if m >= 0 && m < Lc
            rsr_d(k_idx) = c(m+1);
        end
    end
    
    h_d = R_mat_bonus \ rsr_d;
    
    % Simulate
    s_hat_d = filter(h_d, 1, r_white);
    
    % Shift estimate backwards by D to align with original s[n] for MSE calculation
    valid_idx = (N_bonus + D) : N_samples;
    % Compare s[n-D] against s_hat_d[n]
    mse_sim_d = mean((s(valid_idx - D) - s_hat_d(valid_idx)).^2);
    mse_theo_d = 1 - rsr_d.' * h_d;
    
    if D == 0
        mse_base_D0 = mse_sim_d;
        imp_factor = 1.0;
    else
        imp_factor = mse_base_D0 / mse_sim_d;
    end
    
    if mse_sim_d < best_mse
        best_mse = mse_sim_d;
        best_D = D;
        best_h = h_d;
        best_shat = s_hat_d;
    end
    
    fprintf('     %d      |    %.4f     |    %.4f     |      %.2fx\n', ...
            D, mse_sim_d, mse_theo_d, imp_factor);
end
fprintf(' -> Best performance achieved with Delay D = %d\n', best_D);

% MULTIPLE VARIANCES: Magnitude Responses (N=10)

variances = [0.01, 0.1, 0.5];
H_w_all = zeros(512, length(variances));
H_c_all = zeros(512, length(variances));

for i = 1:length(variances)
    v2 = variances(i);
    
    % White
    Rrr_w_v = zeros(1, 10);
    Rrr_w_v(1:min(10, Lc)) = Rcc(1:min(10, Lc));
    Rrr_w_v(1) = Rrr_w_v(1) + v2;
    h_w_v = toeplitz(Rrr_w_v) \ rsr; % Delay D=0 for baseline comparison
    [H_w_v, f] = freqz(h_w_v, 1, 512);
    H_w_all(:, i) = H_w_v;
    
    % Color
    Rrr_c_v = zeros(1, 10);
    for k = 0:9
        Rdd_k = (v2 / 0.19) * (0.9^k); 
        if k < Lc
            Rrr_c_v(k+1) = Rcc(k+1) + Rdd_k;
        else
            Rrr_c_v(k+1) = Rdd_k;
        end
    end
    h_c_v = toeplitz(Rrr_c_v) \ rsr;
    [H_c_v, ~] = freqz(h_c_v, 1, 512);
    H_c_all(:, i) = H_c_v;
end

% PLOTTING

figure('Name', 'MMSE Equalization & Filter Analysis', 'Position', [100, 100, 1200, 800]);

% --- TOP ROW: Scatter Plots ---
% Using the best delayed filter from the Bonus section to show clear constellation
plot_range = 1000:1100;

subplot(2, 3, 1);
plot(s(plot_range), zeros(length(plot_range),1), 'bo', 'MarkerFaceColor', 'b');
title('1. Before Channel s[n]'); ylim([-2 2]); grid on;

subplot(2, 3, 2);
plot(r_white(plot_range), zeros(length(plot_range),1), 'ro', 'MarkerFaceColor', 'r');
title('2. Channel + Noise r[n]'); ylim([-2 2]); grid on;

subplot(2, 3, 3);
% Shift by best_D for visual alignment in scatter plot
plot(best_shat(plot_range + best_D), zeros(length(plot_range),1), 'go', 'MarkerFaceColor', 'g');
title(sprintf('3. Equalized s[n] (N=10, D=%d)', best_D)); ylim([-2 2]); grid on;

% --- BOTTOM ROW: Magnitude Responses by Variance ---
subplot(2, 3, [4, 5, 6]);
colors = lines(3);
hold on;
for i = 1:length(variances)
    plot(f/pi, 20*log10(abs(H_w_all(:, i))), '-', 'Color', colors(i,:), 'LineWidth', 2, ...
        'DisplayName', sprintf('White Noise (\\sigma^2=%.2f)', variances(i)));
    plot(f/pi, 20*log10(abs(H_c_all(:, i))), '--', 'Color', colors(i,:), 'LineWidth', 2, ...
        'DisplayName', sprintf('Colored Noise (\\sigma^2=%.2f)', variances(i)));
end
title('Magnitude Response of N=10 Estimation Filters across Variances');
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Magnitude (dB)');
legend('Location', 'southwest');
grid on; hold off;

disp('Execution Complete. Check plotted figures and command window tables.');

%% WRITE-UP / COMMENTARY ON RESULTS
%{
1. The Impact of Filter Length (N) on MSE
As required by the prompt, the tables generated by the simulation show that 
the Mean Squared Error strictly decreases as the filter length N increases 
from 1 to 10. Every time we increase N, we give the MMSE filter an additional 
"degree of freedom" to weight previous observations. More taps allow the filter 
to better invert the channel's Inter-Symbol Interference (ISI) and average out 
the Gaussian noise. The jump from N=1 to N=4 provides a massive reduction in MSE, 
while going from N=4 to N=10 provides a smaller, incremental refinement. 

2. Theoretical vs. Empirical Results (Stretch Goals 1 & 2)
The script successfully validates both stretch goals. The simulated MSE matches 
the theoretical minimum MSE (J_min) almost perfectly. When using the xcorr 
function to empirically estimate the autocorrelation (R_rr) and cross-correlation 
(R_sr) matrices from the raw data, the resulting filter coefficients and MSE 
are nearly identical to the pencil-and-paper theoretical derivations. This happens 
because our sample size (100,000) is large enough for the empirical averages to 
tightly converge to the true statistical expectations.

3. Pure White Noise vs. Filtered (Colored) Noise
The magnitude response plots for N=10 reveal how the optimal Wiener filter 
adapts to different interference environments. Pure white noise has a flat 
frequency spectrum. The filtered noise, however, is generated via an 
Auto-Regressive (AR) process that acts as a strong low-pass filter, concentrating 
its power at lower frequencies. To minimize overall error, the magnitude response 
for the colored noise filter exhibits a deep "notch" at the lower frequencies 
compared to the white noise filter. It intentionally suppresses those lower frequency 
bands, sacrificing some of the target signal's energy because the colored noise 
is overwhelmingly strong there. Furthermore, as variance increases, the filter 
scales its overall magnitude down to avoid amplifying the noise floor.

4. The "Look-Ahead" Advantage (Delay Bonus)
By default, the standard MMSE setup tries to estimate s[n] using current and past 
observations with no delay. However, the highest energy tap in the channel c[n] 
is at index 2 (0.8). If we insist on estimating s[n] right at index n, the filter 
only sees the weak 0.2 precursor tap. By introducing a delay of D=2 (estimating 
s[n-2] instead of s[n]), the filter is now "looking ahead." It uses the current 
observation r[n] to process the main 0.8 peak of the delayed signal, while using 
r[n-1] and r[n-2] to cancel out postcursor ISI. The simulation shows that setting 
D=2 drops the MSE drastically compared to D=0. Giving the filter permission to wait 
until the signal's maximum energy has arrived at the receiver is the most effective 
way to improve equalizer performance.
%}