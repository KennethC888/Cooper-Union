% SPDX-License-Identifier: GNU AGPL-3.0-or-later
% Copyright (C) 2025 Kenneth Chan <kenc0728@gmail.com>
% Kenneth Chan

clear;      
clc;        
close all;  

rng(388); 

N = 200;
k_axis_N = 0:N-1; % DFT index vector

w = ones(N, 1);

n_axis = 0:N-1;
w0 = zeros(N, 1);
w0(mod(n_axis, 4) == 3) = 1;

% Compute N-point DFTs
W_dft = fft(w);
W0_dft = fft(w0);

% Plot magnitudes
figure('Name', 'Part (b): N-point DFT Magnitudes');

% Plot for w[n]
subplot(2, 1, 1);
stem(k_axis_N, abs(W_dft), 'filled', 'LineWidth', 1.5, 'Color', 'b');
title('Magnitude of 200-point DFT of w[n]');
xlabel('k (Frequency Index)');
ylabel('|W[k]|');
grid on;
xlim([0 N-1]);

% Plot for w0[n]
subplot(2, 1, 2);
stem(k_axis_N, abs(W0_dft), 'filled', 'LineWidth', 1.5, 'Color', 'r');
title('Magnitude of 200-point DFT of w_0[n]');
xlabel('k (Frequency Index)');
ylabel('|W_0[k]|');
grid on;
xlim([0 N-1]);


N0 = 2^nextpow2(16 * N); 

% Compute N0-point DFTs (this zero-pads automatically)
W_N0 = fft(w, N0);
W0_N0 = fft(w0, N0);

% Normalize to have DC value of 1
W_N0_norm = W_N0 / sum(w);
W0_N0_norm = W0_N0 / sum(w0);

omega_axis_N0 = linspace(-pi, pi, N0);

% Plot the spectra
figure('Name', 'Part (c): N0-point Continuous Spectra');

% Plot for W(omega)
subplot(2, 1, 1);
plot(omega_axis_N0, abs(fftshift(W_N0_norm)), 'b', 'LineWidth', 1.5);
title('Normalized Magnitude Spectrum |W(\omega)|');
xlabel('Frequency (\omega) in radians');
ylabel('Magnitude');
grid on;
xlim([-pi pi]);

% Plot for W0(omega)
subplot(2, 1, 2);
plot(omega_axis_N0, abs(fftshift(W0_N0_norm)), 'r', 'LineWidth', 1.5);
title('Normalized Magnitude Spectrum |W_0(\omega)|');
xlabel('Frequency (\omega) in radians');
ylabel('Magnitude');
grid on;
xlim([-pi pi]);


A = 1;
omega0 = 0.4;
phi = 0;

% Creating signal x 
x = A * cos(omega0 * n_axis' + phi); 

% Apply the windows
xw = x .* w;
xw0 = x .* w0;

Xw_dft = fft(xw, N0);
Xw0_dft = fft(xw0, N0);

omega_axis_half = linspace(0, pi, N0/2 + 1);

% Plot the superimposed spectra
figure('Name', 'Part (d): Windowed Sinusoid Spectra');
hold on;
plot(omega_axis_half, abs(Xw_dft(1:N0/2+1)), 'b', 'LineWidth', 2);
plot(omega_axis_half, abs(Xw0_dft(1:N0/2+1)), 'r--', 'LineWidth', 1.5);
hold off;

title('Magnitude Spectra of Windowed Signal x[n]=cos(0.4n)');
xlabel('Frequency (\omega) in radians');
ylabel('Magnitude');
legend('Rectangular Window (w[n])', 'Subsampled Window (w_0[n])');
grid on;
xlim([0 pi]);


% Part (e): 
% The spectral resolution does not appear to be qualitatively
% different for the two windows.
%
% Reasoning: Spectral resolution is determined by the width of the main
% lobe of the window's spectrum. The central peak at w = 0.4 rad has the exact same width for both the
% rectangular window and the subsampled window. Although the
% subsampling has a lot of disortion with the extra peaks, it still spans the original 200 samples. 
% Additionally, the duration for both rectangular window and subsampled
% window is the same, there is not a qualitatively a difference between the
% two windows. 