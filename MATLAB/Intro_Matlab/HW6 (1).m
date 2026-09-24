% SPDX-License-Identifier: GNU AGPL-3.0-or-later
% Copyright (C) 2025 Kenneth Chan <kenc0728@gmail.com>
% Kenneth Chan

clear all;
close all;
clc;

% Initializing variables
C = 10e-9;
R = 1000;
K_max = 4; 
K_0 = 4 - 2*sqrt(2);
K_1 = K_0;
K_2 = (0.5 * K_0) + (0.5 * K_max); 
K_3 = (0.2 * K_0) + (0.8 * K_max); 
N = 10e4; 
f = linspace(0,1e6,N);
f2 = logspace(3,6,N);

radian_f = 2 * pi * f; 
radian_f2 = 2 * pi * f2; 

wn = sqrt(2)/(R *C); 

% K_1
K = K_1;

% Transfer function coefficients
num = [0, 0, K];
den = [(R *C)^2, (4 - K)*R *C, 2];

% Frequency response linspace
[H_lin, ~] = freqs(num, den, radian_f);
magnitude_lin = 20*log10(abs(H_lin));
phase_lin = unwrap(angle(H_lin)) * 180/pi;

% Frequency response logspace 
[H_log, ~] = freqs(num, den, radian_f2);
magnitude_log = 20*log10(abs(H_log));
phase_log = unwrap(angle(H_log)) * 180/pi;

% Plot of magnitude, phase, and freq
figure;
subplot(2,1,1);
plot(f/1e3, magnitude_lin);
title(['K = K_0']);
ylabel('Magnitude (dB)');
ylim([min(magnitude_lin(end-10:end)), max(magnitude_lin) + 3]);
grid on;

subplot(2,1,2);
plot(f/1e3, phase_lin);
ylabel('Phase (degrees)');
xlabel('Frequency (kHz)');
grid on;

% Bode plot
figure;
subplot(2,1,1);
semilogx(f2/1e3, magnitude_log);
title(['Bode Plot: K = K_0']);
ylabel('Magnitude (dB)');
grid on;

subplot(2,1,2);
semilogx(f2/1e3, phase_log);
ylabel('Phase (degrees)');
xlabel('Frequency (kHz)');
grid on;

Q1 = sqrt(2) / (4 - K_1);

% K_2
K = K_2;

% Transfer function coefficients
num = [0, 0, K];
den = [(R *C)^2, (4 - K)*R *C, 2];

% Frequency response (linear scale)
[H_lin, ~] = freqs(num, den, radian_f);
magnitude_lin = 20*log10(abs(H_lin));
phase_lin = unwrap(angle(H_lin)) * 180/pi;

% Frequency response (log scale)
[H_log, ~] = freqs(num, den, radian_f2);
magnitude_log = 20*log10(abs(H_log));
phase_log = unwrap(angle(H_log)) * 180/pi;

% Plotting (linear scale)
figure;
subplot(2,1,1);
plot(f/1e3, magnitude_lin);
title(['K = (0.5 * K_0) + (0.5 * K_max)']);
ylabel('Magnitude (dB)');
ylim([min(magnitude_lin(end-10:end)), max(magnitude_lin) + 3]);
grid on;

subplot(2,1,2);
plot(f/1e3, phase_lin);
ylabel('Phase (degrees)');
xlabel('Frequency (kHz)');
grid on;

% Plotting (Bode plot)
figure;
subplot(2,1,1);
semilogx(f2/1e3, magnitude_log);
title(['Bode Plot: K = (0.5 * K_0) + (0.5 * K_max)']);
ylabel('Magnitude (dB)');
grid on;

subplot(2,1,2);
semilogx(f2/1e3, phase_log);
ylabel('Phase (degrees)');
xlabel('Frequency (kHz)');
grid on;

Q1 = sqrt(2) / (4 - K_2);


% K_3
K = K_3;

% Transfer function coefficients
num = [0, 0, K];
den = [(R *C)^2, (4 - K)*R *C, 2];

% Frequency response (linear scale)
[H_lin, ~] = freqs(num, den, radian_f);
magnitude_lin = 20*log10(abs(H_lin));
phase_lin = unwrap(angle(H_lin)) * 180/pi;

% Frequency response (log scale)
[H_log, ~] = freqs(num, den, radian_f2);
magnitude_log = 20*log10(abs(H_log));
phase_log = unwrap(angle(H_log)) * 180/pi;

% Plotting (linear scale)
figure;
subplot(2,1,1);
plot(f/1e3, magnitude_lin);
title(['K =(0.2 * K_0) + (0.8 * K_max']);
ylabel('Magnitude (dB)');
ylim([min(magnitude_lin(end-10:end)), max(magnitude_lin) + 3]);
grid on;

subplot(2,1,2);
plot(f/1e3, phase_lin);
ylabel('Phase (degrees)');
xlabel('Frequency (kHz)');
grid on;

% Plotting (Bode plot)
figure;
subplot(2,1,1);
semilogx(f2/1e3, magnitude_log);
title(['Bode Plot: K = (0.2 * K_0) + (0.8 * K_max)']);
ylabel('Magnitude (dB)');
grid on;

subplot(2,1,2);
semilogx(f2/1e3, phase_log);
ylabel('Phase (degrees)');
xlabel('Frequency (kHz)');
grid on;

Q1 = sqrt(2) / (4 - K_3);

fprintf('Natural Frequency: ωn = %.2f rad/s (%.2f kHz)\n', wn, wn/(2*pi*1e3));
fprintf('Q values:\nK1: Q = %.3f\nK2: Q = %.3f\nK3: Q = %.3f\n', Q1, sqrt(2)/(4-K_2), sqrt(2)/(4-K_3));

