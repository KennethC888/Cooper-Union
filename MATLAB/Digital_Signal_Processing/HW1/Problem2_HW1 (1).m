% SPDX-License-Identifier: GNU AGPL-3.0-or-later
% Copyright (C) 2025 Kenneth Chan <kenc0728@gmail.com>
% Kenneth Chan

clc;
clear;
close all;
rng(388); 

% rectangular
num_points = 1000; 
length_rect = 30; 
w_rect = rectwin(length_rect);
w_rect = w_rect / sum(w_rect); % Normalize for 0dB peak
[h_rect, w] = freqz(w_rect, num_points);

% chebyshev
length_cheb = 50; 
peak_sidelobe = 30; 
w_cheb = chebwin(length_cheb, peak_sidelobe);
w_cheb = w_cheb / sum(w_cheb); % Normalize for 0dB peak
h_cheb = freqz(w_cheb, num_points);


% Kaiser
length_kaiser = length_cheb; 
beta = 3; % guessing the parameter beta used for the Kaiser window
w_kaiser = kaiser(length_kaiser, beta);
w_kaiser = w_kaiser / sum(w_kaiser); % Normalize for 0dB peak
h_kaiser = freqz(w_kaiser, num_points);

% Plot rectangular window
figure;
plot(w, 20*log10(abs(h_rect)));
grid on;
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Magnitude (dB)');
title('Frequency Response of Rectangular Window');

% Plot Chebyshev window
hold on; % Retain current plot
[h_cheb, w] = freqz(w_cheb, num_points);
plot(w, 20*log10(abs(h_cheb)));
legend('Rectangular Window', 'Chebyshev Window');

% Plot Kaiser window
plot(w, 20*log10(abs(h_kaiser)));
legend('Rectangular Window', 'Chebyshev Window', 'Kaiser Window');
hold off; % Release the plot hold


