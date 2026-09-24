% SPDX-License-Identifier: GNU AGPL-3.0-or-later
% Copyright (C) 2025 Kenneth Chan <kenc0728@gmail.com>
% Kenneth Chan

clc;
clear;
close all;
rng(388); 

a = [1, 0.8, 0.9];
phi = [pi/2; pi/3; -((2 * pi)/5)];
f = [1000; 2000; 3500]; % This is in Hz 
fs = 10000; 
M = 1000; 
N = 1024; 

% Hamming Window 
% Generate signal through the sum
t = (0:M-1)' / fs;
x = a(1)*cos(2*pi*f(1)*t + phi(1)) + a(2)*cos(2*pi*f(2)*t + phi(2)) + a(3)*cos(2*pi*f(3)*t + phi(3));

xw = x .* hamming(M);
X = fft(xw, N);
% Create frequency vector for plotting (-fs/2 to fs/2)
freq_vector = (-N/2 : N/2-1) * (fs / N);

% Plot the full magnitude spectrum
figure(1);
plot(freq_vector), 20*log10(abs(fftshift(X)));
title('Full DFT Spectrum (Hamming Window)');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
grid on;
axis([-fs/2 fs/2 -100 50]);
disp('Plot 1: Full DFT spectrum generated.');

% Plot the non-negative frequency spectrum
figure(2);
freq_pos = (0:N/2) * (fs/N);
plot(freq_pos, 20*log10(abs(X(1:N/2+1))));
title('DFT Spectrum - Non-Negative Frequencies');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
grid on;
axis([0 fs/2 -100 50]);

fprintf('\n\n\n'); % Spacer

% Part 3: Calculate peak index 
disp('Peak Index Calculation');
k1 = round(f(1) * N / fs);
k2 = round(f(2) * N / fs);
k3 = round(f(3) * N / fs);

fprintf('For f1 = %.1f kHz, peaks are at k = %d and N-k = %d\n', f(1)/1000, k1, N-k1);
fprintf('For f2 = %.1f kHz, peaks are at k = %d and N-k = %d\n', f(2)/1000, k2, N-k2);
fprintf('For f3 = %.1f kHz, peaks are at k = %d and N-k = %d\n', f(3)/1000, k3, N-k3);
fprintf('All six positive indices are: %d, %d, %d, %d, %d, %d\n', ...
        k1, k2, k3, N-k3, N-k2, N-k1);

fprintf('\n\n');


% New parameters
fs2 = 20e6;     % 20 MHz
f2 = 6e6;    % 6 MHz
M2 = 500;       % Samples
N2 = 512;       % DFT size

% Bin Space Calculation
delta_f = fs2 / N2;
fprintf('(a) The bin spacing is: %.1f Hz\n\n', delta_f);

% Peak Indices
k0_exact = f2 * N2 / fs2;
k0 = round(k0_exact);
k_neg = N2 - k0;
fprintf('(b) The theoretical peak is at k = %.2f.\n', k0_exact);
fprintf('    The closest integer indices are k = %d and k = %d.\n\n', k0, k_neg);

% DFT Comparison: Rectangular vs. Chebyshev
disp('Part (c)');
% Generate signal
t2 = (0:M2-1)' / fs2;
x2 = cos(2*pi*f2*t2);

w_rect = rectwin(M2);
w_rect = w_rect / norm(w_rect);
w_cheb = chebwin(M2, 30); % 30 dB peak sidelobe level
w_cheb = w_cheb / norm(w_cheb);

% Apply windows and compute DFTs
X_rect = fft(x2 .* w_rect, N2);
X_cheb = fft(x2 .* w_cheb, N2);

% Zoomed-in plot
k_range = (k0 - 10) : (k0 + 10);
figure(3);
plot(k_range, abs(X_rect(k_range + 1)), 'b-o', 'LineWidth', 1.5, 'MarkerSize', 5);
hold on;
plot(k_range, abs(X_cheb(k_range + 1)), 'r--s', 'LineWidth', 1.5, 'MarkerSize', 5);
hold off;
title('DFT Magnitude Comparison (Noiseless)');
xlabel('DFT Bin Index k');
ylabel('Magnitude |X(k)|');
legend('Rectangular Window', 'Chebyshev Window (-30 dB)');
grid on;
disp('Plot 3: Zoomed-in comparison of Rectangular vs. Chebyshev windows generated.');
fprintf('\n');

% Analysis with AWGN
disp('(d) Analyzing signals with 20 dB SNR...');
P_signal = 0.5;
% Calculate noise power for 20 dB SNR
SNR_dB = 20;
P_noise = P_signal / (10^(SNR_dB / 10));
sigma = sqrt(P_noise);

% Generate noise and add to signal
noise = sigma * randn(M2, 1);
x2_noisy = x2 + noise;

% Apply windows 
X_rect_noisy = fft(x2_noisy .* w_rect, N2);
X_cheb_noisy = fft(x2_noisy .* w_cheb, N2);

% Plot full spectrum for Rect
freq2 = (-N2/2 : N2/2-1) * (fs2 / N2);
figure(4);
plot(fftshift(freq2)/1e6, 20*log10(abs(fftshift(X_rect_noisy))));
title('Noisy Spectrum (SNR=20dB) - Rectangular Window');
xlabel('Frequency (MHz)');
ylabel('Magnitude (dB)');
grid on;

% Plot full spectrum for Chebyshev window
figure(5);
plot(fftshift(freq2)/1e6, 20*log10(abs(fftshift(X_cheb_noisy))));
title('Noisy Spectrum (SNR=20dB) - Chebyshev Window');
xlabel('Frequency (MHz)');
ylabel('Magnitude (dB)');
grid on;

% Final superimposed zoomed graph with frequency in Hertz
figure(6);
freq_range_Hz = k_range * delta_f;
plot(freq_range_Hz/1e6, 20*log10(abs(X_rect_noisy(k_range + 1))), 'b-o', 'LineWidth', 1.5);
hold on;
plot(freq_range_Hz/1e6, 20*log10(abs(X_cheb_noisy(k_range + 1))), 'r--s', 'LineWidth', 1.5);
hold off;
title('Zoomed-in Noisy DFTs (SNR=20dB)');
xlabel('Frequency (MHz)');
ylabel('Magnitude (dB)');
legend('Rectangular', 'Chebyshev');
grid on;
