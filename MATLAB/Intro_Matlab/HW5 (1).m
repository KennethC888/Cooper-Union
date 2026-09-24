% SPDX-License-Identifier: GNU AGPL-3.0-or-later
% Copyright (C) 2025 Kenneth Chan <kenc0728@gmail.com>
% Kenneth Chan

clear all;
close all;
clc;

%% Specifications
sample_rate = 40e6;               % Sampling rate for digital filters
rp = 1.5;                   % Passband ripple in dB
rs = 30;                    % Stopband attenuation in dB

%% Filter Design

% 1. Analog Elliptic Filter
wp = [10e6, 13e6] * 2 * pi;
ws = [9e6, 14e6] * 2 * pi;
[n_ana_ellip, wn_ana_ellip] = ellipord(wp, ws, rp, rs, 's');
[z_ana_ellip, p_ana_ellip, k_ana_ellip] = ellip(n_ana_ellip, rp, rs, wn_ana_ellip, 's');
[b_ana_ellip, a_ana_ellip] = zp2tf(z_ana_ellip, p_ana_ellip, k_ana_ellip);

% 2. Analog Chebyshev Type I Filter
[n_ana_cheb1, wn_ana_cheb1] = cheb1ord(wp, ws, rp, rs, 's');
[z_ana_cheb1, p_ana_cheb1, k_ana_cheb1] = cheby1(n_ana_cheb1, rp, wn_ana_cheb1, 's');
[b_ana_cheb1, a_ana_cheb1] = zp2tf(z_ana_cheb1, p_ana_cheb1, k_ana_cheb1);

% 3. Digital Elliptic Filter
fdpass = [10e6, 13e6] / (sample_rate/2);
fdstop = [9e6, 14e6] / (sample_rate/2);
[n_digi_ellip, wn_digi_ellip] = ellipord(fdpass, fdstop, rp, rs);
[z_digi_ellip, p_digi_ellip, k_digi_ellip] = ellip(n_digi_ellip, rp, rs, wn_digi_ellip);
[b_digi_ellip, a_digi_ellip] = zp2tf(z_digi_ellip, p_digi_ellip, k_digi_ellip);

% 4. Digital Chebyshev Type I Filter
[n_digi_cheb1, wn_digi_cheb1] = cheb1ord(fdpass, fdstop, rp, rs);
[z_digi_cheb1, p_digi_cheb1, k_digi_cheb1] = cheby1(n_digi_cheb1, rp, wn_digi_cheb1);
[b_digi_cheb1, a_digi_cheb1] = zp2tf(z_digi_cheb1, p_digi_cheb1, k_digi_cheb1);

%% Filter Orders
fprintf('Filter Orders:\n');
fprintf('1. Analog Elliptic: %d (n = %d)\n', 2*n_ana_ellip, n_ana_ellip);
fprintf('2. Analog Chebyshev I: %d (n = %d)\n', 2*n_ana_cheb1, n_ana_cheb1);
fprintf('3. Digital Elliptic: %d (n = %d)\n', 2*n_digi_ellip, n_digi_ellip);
fprintf('4. Digital Chebyshev I: %d (n = %d)\n', 2*n_digi_cheb1, n_digi_cheb1);

%% Pole-Zero Plots
figure;
zplane(z_ana_ellip, p_ana_ellip);
title('Analog Elliptic: Pole-Zero Plot');
grid on;

figure;
zplane(z_ana_cheb1, p_ana_cheb1);
title('Analog Chebyshev I: Pole-Zero Plot');
grid on;

figure;
zplane(z_digi_ellip, p_digi_ellip);
title('Digital Elliptic: Pole-Zero Plot');
grid on;

figure;
zplane(z_digi_cheb1, p_digi_cheb1);
title('Digital Chebyshev I: Pole-Zero Plot');
grid on;

%% Frequency Response Plots
f = linspace(0, 20e6, 1000);  % 0 to Nyquist (20 MHz)

% 1. Analog Elliptic
w_ana = 2 * pi * f;
H_ana_ellip = freqs(b_ana_ellip, a_ana_ellip, w_ana);
Hdb_ana_ellip = 20*log10(abs(H_ana_ellip));
phase_ana_ellip = unwrap(angle(H_ana_ellip)) * 180/pi;

figure;
subplot(2,1,1);
plot(f/1e6, Hdb_ana_ellip);
title('Analog Elliptic: Frequency Response');
ylabel('Magnitude (dB)'); grid on; ylim([-80 5]);
xlim([0 20]);
hold on;
hold off;

subplot(2,1,2);
plot(f/1e6, phase_ana_ellip);
xlabel('Frequency (MHz)'); ylabel('Phase (degrees)');
grid on; xlim([0 20]);

% 2. Analog Chebyshev I
H_ana_cheb1 = freqs(b_ana_cheb1, a_ana_cheb1, w_ana);
Hdb_ana_cheb1 = 20*log10(abs(H_ana_cheb1));
phase_ana_cheb1 = unwrap(angle(H_ana_cheb1)) * 180/pi;

figure;
subplot(2,1,1);
plot(f/1e6, Hdb_ana_cheb1);
title('Analog Chebyshev I: Frequency Response');
ylabel('Magnitude (dB)'); grid on; ylim([-80 5]);
xlim([0 20]);
hold on;
hold off;

subplot(2,1,2);
plot(f/1e6, phase_ana_cheb1);
xlabel('Frequency (MHz)'); ylabel('Phase (degrees)');
grid on; xlim([0 20]);

% 3. Digital Elliptic
w_digi = f / (sample_rate/2) * pi;
H_digi_ellip = freqz(b_digi_ellip, a_digi_ellip, w_digi);
Hdb_digi_ellip = 20*log10(abs(H_digi_ellip));
phase_digi_ellip = unwrap(angle(H_digi_ellip)) * 180/pi;

figure;
subplot(2,1,1);
plot(f/1e6, Hdb_digi_ellip);
title('Digital Elliptic: Frequency Response');
ylabel('Magnitude (dB)'); grid on; ylim([-80 5]);
xlim([0 20]);
hold on;
hold off;

subplot(2,1,2);
plot(f/1e6, phase_digi_ellip);
xlabel('Frequency (MHz)'); ylabel('Phase (degrees)');
grid on; xlim([0 20]);

% 4. Digital Chebyshev I
H_digi_cheb1 = freqz(b_digi_cheb1, a_digi_cheb1, w_digi);
Hdb_digi_cheb1 = 20*log10(abs(H_digi_cheb1));
phase_digi_cheb1 = unwrap(angle(H_digi_cheb1)) * 180/pi;

figure;
subplot(2,1,1);
plot(f/1e6, Hdb_digi_cheb1);
title('Digital Chebyshev I: Frequency Response');
ylabel('Magnitude (dB)'); grid on; ylim([-80 5]);
xlim([0 20]);
hold on;
hold off;

subplot(2,1,2);
plot(f/1e6, phase_digi_cheb1);
xlabel('Frequency (MHz)'); ylabel('Phase (degrees)');
grid on; xlim([0 20]);