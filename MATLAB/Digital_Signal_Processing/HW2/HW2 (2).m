% SPDX-License-Identifier: GNU AGPL-3.0-or-later
% Copyright (C) 2025 Kenneth Chan <kenc0728@gmail.com>
% Kenneth Chan

% To meet specs, max gain should be 0dB, pband should be under 1.5 dB, and
% sband should be under -30 dB 

clc;
clear;
close all;
rng(388); 

% Parameters 
pband_min = 10e6;       % Passband minimum 
pband_max = 11e6;       % Passband maximum
sband_max = 9e6;        % Stopband maximum
sband_min = 12e6;       % Stopband minimum
pband_variation = 1.5;  % Passband ripple 
sband_atten = 30;       % Stopband attenuation 
Fs = 40e6;              % Sampling frequency 

% Convert to rad/s for analog
Wp = [2*pi*pband_min 2*pi*pband_max];
Ws = [2*pi*sband_max 2*pi*sband_min];

% Analog Butterworth TIME! 
[n, Wn] = buttord(Wp, Ws, pband_variation, sband_atten, 's');
[b, a] = butter(n, Wn, 'bandpass', 's');

% Frequency response (analog)
f = linspace(0, 20e6, 1024);
w = 2*pi*f;
H = freqs(b, a, w);

% Plot magnitude and phase
figure;
subplot(2,1,1);
plot(f/1e6, 20*log10(abs(H)));
grid on;
xlabel('Frequency (MHz)');
ylabel('Magnitude (dB)');
title('Analog Butterworth Bandpass Magnitude Response');
ylim([-60 5]);

subplot(2,1,2);
plot(f/1e6, unwrap(angle(H))*180/pi);
grid on;
xlabel('Frequency (MHz)');
ylabel('Phase (degrees)');
title('Analog Butterworth Bandpass Phase Response');

% Pole-zero plot for analog Butterworth
zeros_analog = roots(b);
poles_analog = roots(a);

figure;
plot(real(zeros_analog), imag(zeros_analog), 'o', 'MarkerSize', 8, 'LineWidth', 2);
hold on;
plot(real(poles_analog), imag(poles_analog), 'x', 'MarkerSize', 8, 'LineWidth', 2);
grid on;
xlabel('Real Part');
ylabel('Imaginary Part');
title(['Analog Butterworth Pole-Zero Plot']);
legend('Zeros', 'Poles', 'Location', 'best');
axis equal;

% Display filter order
disp(['Analog Butterworth Filter Order: ', num2str( 2 *n)]);

% Max gain
passband_indices = (w >= 2*pi*pband_min) & (w <= 2*pi*pband_max);
peak_passband_gain = max(abs(H(passband_indices)));
peak_passband_gain_dB = 20 * log10(peak_passband_gain); 
disp(['Peak passband gain in dB: ', num2str(peak_passband_gain_dB)]);


% Find stopband gains
H_9MHz  = interp1(f, H, 9e6, 'linear');
H_12MHz = interp1(f, H, 12e6, 'linear');
gain_9MHz  = abs(H_9MHz);
gain_9MHz_dB = 20 * log10(gain_9MHz);
gain_12MHz = abs(H_12MHz);
gain_12MHz_dB = 20 * log10(gain_12MHz);
% Find passband edge gains
H_10MHz = interp1(f, H, 10e6, 'linear');
H_11MHz = interp1(f, H, 11e6, 'linear');
gain_10MHz = abs(H_10MHz);
gain_10MHz_dB = 20 * log10(gain_10MHz);
gain_11MHz = abs(H_11MHz);
gain_11MHz_dB = 20 * log10(gain_11MHz);
% Display results
disp(['Gain at 9 MHz in dB:   ', num2str(gain_9MHz_dB)]);
disp(['Gain at 10 MHz in dB:  ', num2str(gain_10MHz_dB)]);
disp(['Gain at 11 MHz in dB:  ', num2str(gain_11MHz_dB)]);
disp(['Gain at 12 MHz in dB:  ', num2str(gain_12MHz_dB)]);
disp(['----------------------------------------']);
% Peak passband is very close to 0 dB, meets specs
% Passband gain at 10 and 11 MHz is below 1.5 dB, meets specs
% Magnitude of stopband gain at 12 Mhz and 9 MHz is below 30 dB (at 12 MHz, close enough), meets specs

% Analog Chebyshev Type I 
[n_cheby, Wn_cheby] = cheb1ord(Wp, Ws, pband_variation, sband_atten, 's');
[b_cheby, a_cheby] = cheby1(n_cheby, pband_variation, Wn_cheby, 'bandpass', 's');

% Frequency response (Chebyshev Type I)
H_cheby = freqs(b_cheby, a_cheby, w);

% Plot magnitude and phase for Chebyshev Type I
figure;
subplot(2,1,1);
plot(f/1e6, 20*log10(abs(H_cheby)));
grid on;
xlabel('Frequency (MHz)');
ylabel('Magnitude (dB)');
title('Analog Chebyshev Type I Bandpass Magnitude Response');
ylim([-60 5]);

subplot(2,1,2);
plot(f/1e6, unwrap(angle(H_cheby))*180/pi);
grid on;
xlabel('Frequency (MHz)');
ylabel('Phase (degrees)');
title('Analog Chebyshev Type I Bandpass Phase Response');

% Pole-zero plot for analog Chebyshev Type I
zeros_analog = roots(b_cheby);
poles_analog = roots(a_cheby);

figure;
plot(real(zeros_analog), imag(zeros_analog), 'o', 'MarkerSize', 8, 'LineWidth', 2);
hold on;
plot(real(poles_analog), imag(poles_analog), 'x', 'MarkerSize', 8, 'LineWidth', 2);
grid on;
xlabel('Real Part');
ylabel('Imaginary Part');
title(['Analog Chebyshev Type I Pole-Zero Plot - Order: ']);
legend('Zeros', 'Poles', 'Location', 'best');
axis equal;

% Display filter order
disp(['Analog Chebyshev Type I Filter Order: ', num2str(2 * n_cheby)]);

% Max gain
passband_indices = (w >= 2*pi*pband_min) & (w <= 2*pi*pband_max);
peak_passband_gain = max(abs(H_cheby(passband_indices)));
peak_passband_gain_dB = 20 * log10(peak_passband_gain); 
disp(['Peak passband gain in dB: ', num2str(peak_passband_gain_dB)]);

% Find stopband gains
H_9MHz  = interp1(f, H_cheby, 9e6, 'linear');
H_12MHz = interp1(f, H_cheby, 12e6, 'linear');
gain_9MHz  = abs(H_9MHz);
gain_9MHz_dB = 20 * log10(gain_9MHz);
gain_12MHz = abs(H_12MHz);
gain_12MHz_dB = 20 * log10(gain_12MHz);
% Find passband edge gains
H_10MHz = interp1(f, H_cheby, 10e6, 'linear');
H_11MHz = interp1(f, H_cheby, 11e6, 'linear');
gain_10MHz = abs(H_10MHz);
gain_10MHz_dB = 20 * log10(gain_10MHz);
gain_11MHz = abs(H_11MHz);
gain_11MHz_dB = 20 * log10(gain_11MHz);
% Display results
disp(['Gain at 9 MHz in dB:   ', num2str(gain_9MHz_dB)]);
disp(['Gain at 10 MHz in dB:  ', num2str(gain_10MHz_dB)]);
disp(['Gain at 11 MHz in dB:  ', num2str(gain_11MHz_dB)]);
disp(['Gain at 12 MHz in dB:  ', num2str(gain_12MHz_dB)]);
disp(['----------------------------------------']);
% Peak passband is very close to 0 dB, meets specs
% Passband gain at 10 and 11 MHz is below 1.5 dB (close enough, right?), meets specs
% Magnitude of stopband gain at 12 Mhz and 9 MHz is below 30 dB, meets specs

% Analog Cheb type II 
[n_cheby2, Wn_cheby2] = cheb2ord(Wp, Ws, pband_variation, sband_atten, 's');
[b_cheby2, a_cheby2] = cheby2(n_cheby2, sband_atten, Wn_cheby2, 'bandpass', 's');

% Frequency response (Chebyshev Type II)
H_cheby2 = freqs(b_cheby2, a_cheby2, w);

% Plot magnitude and phase for Chebyshev Type II
figure;
subplot(2,1,1);
plot(f/1e6, 20*log10(abs(H_cheby2)));
grid on;
xlabel('Frequency (MHz)');
ylabel('Magnitude (dB)');
title('Analog Chebyshev Type II Bandpass Magnitude Response');
ylim([-60 5]);

subplot(2,1,2);
plot(f/1e6, unwrap(angle(H_cheby2))*180/pi);
grid on;
xlabel('Frequency (MHz)');
ylabel('Phase (degrees)');
title('Analog Chebyshev Type II Bandpass Phase Response');

% Pole-zero plot for analog Chebyshev Type II
zeros_analog = roots(b_cheby2);
poles_analog = roots(a_cheby2);

figure;
plot(real(zeros_analog), imag(zeros_analog), 'o', 'MarkerSize', 8, 'LineWidth', 2);
hold on;
plot(real(poles_analog), imag(poles_analog), 'x', 'MarkerSize', 8, 'LineWidth', 2);
grid on;
xlabel('Real Part');
ylabel('Imaginary Part');
title(['Analog Chebyshev Type II Pole-Zero Plot - Order: ', num2str(n_cheby2)]);
legend('Zeros', 'Poles', 'Location', 'best');
axis equal;

disp(['Analog Chebyshev Type II Filter Order: ', num2str(2 * n_cheby2)]);

% Max gain
passband_indices = (w >= 2*pi*pband_min) & (w <= 2*pi*pband_max);
peak_passband_gain = max(abs(H_cheby2(passband_indices)));
peak_passband_gain_dB = 20 * log10(peak_passband_gain); 
disp(['Peak passband gain in dB: ', num2str(peak_passband_gain_dB)]);

% Find stopband gains
H_9MHz  = interp1(f, H_cheby2, 9e6, 'linear');
H_12MHz = interp1(f, H_cheby2, 12e6, 'linear');
gain_9MHz  = abs(H_9MHz);
gain_9MHz_dB = 20 * log10(gain_9MHz);
gain_12MHz = abs(H_12MHz);
gain_12MHz_dB = 20 * log10(gain_12MHz);
% Find passband edge gains
H_10MHz = interp1(f, H_cheby2, 10e6, 'linear');
H_11MHz = interp1(f, H_cheby2, 11e6, 'linear');
gain_10MHz = abs(H_10MHz);
gain_10MHz_dB = 20 * log10(gain_10MHz);
gain_11MHz = abs(H_11MHz);
gain_11MHz_dB = 20 * log10(gain_11MHz);
% Display results
disp(['Gain at 9 MHz in dB:   ', num2str(gain_9MHz_dB)]);
disp(['Gain at 10 MHz in dB:  ', num2str(gain_10MHz_dB)]);
disp(['Gain at 11 MHz in dB:  ', num2str(gain_11MHz_dB)]);
disp(['Gain at 12 MHz in dB:  ', num2str(gain_12MHz_dB)]);
disp(['----------------------------------------']);
% Peak passband is very close to 0 dB, meets specs
% Passband gain at 10 and 11 MHz is below 1.5 dB (close enough, right?), meets specs
% Magnitude of stopband gain at 9 MHz is below 30 dB, at 12 MHz it meets specs, as it is
% below 30 dB, but it is quite large and a slight overdesign (-52dB is a
% lot larger attenuation than needed)

% Analog Elliptic 
[n_elliptic, Wn_elliptic] = ellipord(Wp, Ws, pband_variation, sband_atten, 's'); % order and cutoff freq
[b_elliptic, a_elliptic] = ellip(n_elliptic, pband_variation, sband_atten, Wn_elliptic, 'bandpass', 's');

% Frequency response (Elliptic)
H_elliptic = freqs(b_elliptic, a_elliptic, w);
% Plot magnitude and phase for Elliptic
figure;
subplot(2,1,1);
plot(f/1e6, 20*log10(abs(H_elliptic)));
grid on;
xlabel('Frequency (MHz)');
ylabel('Magnitude (dB)');
title('Analog Elliptic Bandpass Magnitude Response');
ylim([-60 5]);
subplot(2,1,2);
plot(f/1e6, unwrap(angle(H_elliptic))*180/pi);
grid on;
xlabel('Frequency (MHz)');
ylabel('Phase (degrees)');
title('Analog Elliptic Bandpass Phase Response');

% Pole-zero plot for analog Elliptic
zeros_analog = roots(b_elliptic);
poles_analog = roots(a_elliptic);

figure;
plot(real(zeros_analog), imag(zeros_analog), 'o', 'MarkerSize', 8, 'LineWidth', 2);
hold on;
plot(real(poles_analog), imag(poles_analog), 'x', 'MarkerSize', 8, 'LineWidth', 2);
grid on;
xlabel('Real Part');
ylabel('Imaginary Part');
title(['Analog Elliptic Pole-Zero Plot - Order: ', num2str(n_elliptic)]);
legend('Zeros', 'Poles', 'Location', 'best');
axis equal;

disp(['Analog Elliptic Filter Order: ', num2str(2 * n_elliptic)]);

% Max gain
passband_indices = (w >= 2*pi*pband_min) & (w <= 2*pi*pband_max);
peak_passband_gain = max(abs(H_elliptic(passband_indices)));
peak_passband_gain_dB = 20 * log10(peak_passband_gain); 
disp(['Peak passband gain in dB: ', num2str(peak_passband_gain_dB)]);

% Find stopband gains
H_9MHz  = interp1(f, H_elliptic, 9e6, 'linear');
H_12MHz = interp1(f, H_elliptic, 12e6, 'linear');
gain_9MHz  = abs(H_9MHz);
gain_9MHz_dB = 20 * log10(gain_9MHz);
gain_12MHz = abs(H_12MHz);
gain_12MHz_dB = 20 * log10(gain_12MHz);
% Find passband edge gains
H_10MHz = interp1(f, H_elliptic, 10e6, 'linear');
H_11MHz = interp1(f, H_elliptic, 11e6, 'linear');
gain_10MHz = abs(H_10MHz);
gain_10MHz_dB = 20 * log10(gain_10MHz);
gain_11MHz = abs(H_11MHz);
gain_11MHz_dB = 20 * log10(gain_11MHz);
% Display results
disp(['Gain at 9 MHz in dB:   ', num2str(gain_9MHz_dB)]);
disp(['Gain at 10 MHz in dB:  ', num2str(gain_10MHz_dB)]);
disp(['Gain at 11 MHz in dB:  ', num2str(gain_11MHz_dB)]);
disp(['Gain at 12 MHz in dB:  ', num2str(gain_12MHz_dB)]);
disp(['----------------------------------------']);
% Peak passband is very close to 0 dB, meets specs
% Passband gain at 10 and 11 MHz is below 1.5 dB (close enough), meets specs
% Magnitude of stopband gain at 12 Mhz and 9 MHz is below 30 dB, meets specs

% Digital Buttersworth! 
Wp_d = [pband_min pband_max] / (Fs/2);   % normalized passband (digital)
Ws_d = [sband_max sband_min] / (Fs/2);   % normalized stopband (digital)

% Butterworth digital
[n_dig_butter, Wn_dig_butter] = buttord(Wp_d, Ws_d, pband_variation, sband_atten);
[b_dig_butter, a_dig_butter] = butter(n_dig_butter, Wn_dig_butter, 'bandpass');

% Frequency response
[H_dig_butter, f_dig] = freqz(b_dig_butter, a_dig_butter, 1024, Fs);

% Plot magnitude and phase for digital Butterworth
figure;
subplot(2,1,1);
plot(f_dig/1e6, 20*log10(abs(H_dig_butter)));
grid on;
xlabel('Frequency (MHz)');
ylabel('Magnitude (dB)');
title('Digital Butterworth Bandpass Magnitude Response');
ylim([-60 5]);

order_dig_butter = length(a_dig_butter) - 1;
disp(['Butterworth digital filter order: ', num2str(order_dig_butter)]);

% Pole-zero plot for digital Butterworth
figure;
zplane(b_dig_butter, a_dig_butter);
title(['Digital Butterworth Pole-Zero Plot - Order: ']);

% Max gain
passband_indices = (w >= 2*pi*pband_min) & (w <= 2*pi*pband_max);
peak_passband_gain = max(abs(H_dig_butter(passband_indices)));
peak_passband_gain_dB = 20 * log10(peak_passband_gain); 
disp(['Peak passband gain in dB: ', num2str(peak_passband_gain_dB)]);

% Find stopband gains
H_9MHz  = interp1(f, H_dig_butter, 9e6, 'linear');
H_12MHz = interp1(f, H_dig_butter, 12e6, 'linear');
gain_9MHz  = abs(H_9MHz);
gain_9MHz_dB = 20 * log10(gain_9MHz);
gain_12MHz = abs(H_12MHz);
gain_12MHz_dB = 20 * log10(gain_12MHz);
% Find passband edge gains
H_10MHz = interp1(f, H_dig_butter, 10e6, 'linear');
H_11MHz = interp1(f, H_dig_butter, 11e6, 'linear');
gain_10MHz = abs(H_10MHz);
gain_10MHz_dB = 20 * log10(gain_10MHz);
gain_11MHz = abs(H_11MHz);
gain_11MHz_dB = 20 * log10(gain_11MHz);
% Display results
disp(['Gain at 9 MHz in dB:   ', num2str(gain_9MHz_dB)]);
disp(['Gain at 10 MHz in dB:  ', num2str(gain_10MHz_dB)]);
disp(['Gain at 11 MHz in dB:  ', num2str(gain_11MHz_dB)]);
disp(['Gain at 12 MHz in dB:  ', num2str(gain_12MHz_dB)]);
disp(['----------------------------------------']);
% Peak passband is very close to 0 dB, meets specs
% Passband gain at 10 MHz and 11 MHz is below 1.5 dB (close enough, right?), meets specs
% Magnitude of stopband gain at 12 Mhz and 9 MHz is below 30 dB, meets specs


% Digital Cheb I 
[n_cheby_dig, Wn_cheby_dig] = cheb1ord(Wp_d, Ws_d, pband_variation, sband_atten);
[b_cheby_dig, a_cheby_dig] = cheby1(n_cheby_dig, pband_variation, Wn_cheby_dig, 'bandpass');

% Freq response 
[H_cheby_dig, f_cheby_dig] = freqz(b_cheby_dig, a_cheby_dig, 1024, Fs);

% Plotting time! 
figure;
subplot(2,1,1);
plot(f_cheby_dig/1e6, 20*log10(abs(H_cheby_dig)));
grid on;
xlabel('Frequency (MHz)');
ylabel('Magnitude (dB)');
title('Digital Chebyshev Type I Bandpass Magnitude Response');
ylim([-60 5]);

% Pole-zero plot for digital Chebyshev Type I
figure;
zplane(b_cheby_dig, a_cheby_dig);
title(['Digital Chebyshev Type I Pole-Zero Plot']);

% Get actual Chebyshev Type I filter order
order_cheby_dig = length(a_cheby_dig) - 1;
disp(['Chebyshev Type I digital filter order: ', num2str(order_cheby_dig)]);
% Max gain
passband_indices = (w >= 2*pi*pband_min) & (w <= 2*pi*pband_max);
peak_passband_gain = max(abs(H_cheby_dig(passband_indices)));
peak_passband_gain_dB = 20 * log10(peak_passband_gain); 
disp(['Peak passband gain in dB: ', num2str(peak_passband_gain_dB)]);

% Find stopband gains
H_9MHz  = interp1(f, H_cheby_dig, 9e6, 'linear');
H_12MHz = interp1(f, H_cheby_dig, 12e6, 'linear');
gain_9MHz  = abs(H_9MHz);
gain_9MHz_dB = 20 * log10(gain_9MHz);
gain_12MHz = abs(H_12MHz);
gain_12MHz_dB = 20 * log10(gain_12MHz);
% Find passband edge gains
H_10MHz = interp1(f, H_cheby_dig, 10e6, 'linear');
H_11MHz = interp1(f, H_cheby_dig, 11e6, 'linear');
gain_10MHz = abs(H_10MHz);
gain_10MHz_dB = 20 * log10(gain_10MHz);
gain_11MHz = abs(H_11MHz);
gain_11MHz_dB = 20 * log10(gain_11MHz);
% Display results
disp(['Gain at 9 MHz in dB:   ', num2str(gain_9MHz_dB)]);
disp(['Gain at 10 MHz in dB:  ', num2str(gain_10MHz_dB)]);
disp(['Gain at 11 MHz in dB:  ', num2str(gain_11MHz_dB)]);
disp(['Gain at 12 MHz in dB:  ', num2str(gain_12MHz_dB)]);
disp(['----------------------------------------']);
% Peak passband is very close to 0 dB, meets specs
% Passband gain at 10 MHz (a little above 1.5 dB, so it fails the ripple requirement) and 11 MHz does meet specs since
% it is below 1.5 dB
% Magnitude of stopband gain at 12 Mhz and 9 MHz is below 30 dB, meets specs

% Digital Cheb II 
[n_cheby_dig_II, Wn_cheby_dig_II] = cheb2ord(Wp_d, Ws_d, pband_variation, sband_atten);
[b_cheby_dig_II, a_cheby_dig_II] = cheby2(n_cheby_dig_II, sband_atten, Wn_cheby_dig_II, 'bandpass');

% Freq response
[H_cheby_dig_II, f_cheby_dig_II] = freqz(b_cheby_dig_II, a_cheby_dig_II, 1024, Fs);

% Plotting time! 
figure; 
subplot(2,1,1); 
plot(f_cheby_dig_II/1e6, 20 *log10(abs(H_cheby_dig_II)));
grid on; 
xlabel('Frequency (MHz)'); 
ylabel('Magnitude (dB)');
title('Digital Chebyshev Type II Bandpass Magnitude Response');
ylim([-60 5]); 

% Pole-zero plot for digital Chebyshev Type II
figure;
zplane(b_cheby_dig_II, a_cheby_dig_II);
title(['Digital Chebyshev Type II Pole-Zero Plot']);

order_cheby_dig_II = length(a_cheby_dig_II) - 1;
disp(['Chebyshev Type II digital filter order: ', num2str(order_cheby_dig_II)]);

% Max gain
passband_indices = (w >= 2*pi*pband_min) & (w <= 2*pi*pband_max);
peak_passband_gain = max(abs(H_cheby_dig_II(passband_indices)));
peak_passband_gain_dB = 20 * log10(peak_passband_gain); 
disp(['Peak passband gain in dB: ', num2str(peak_passband_gain_dB)]);

% Find stopband gains
H_9MHz  = interp1(f, H_cheby_dig_II, 9e6, 'linear');
H_12MHz = interp1(f, H_cheby_dig_II, 12e6, 'linear');
gain_9MHz  = abs(H_9MHz);
gain_9MHz_dB = 20 * log10(gain_9MHz);
gain_12MHz = abs(H_12MHz);
gain_12MHz_dB = 20 * log10(gain_12MHz);
% Find passband edge gains
H_10MHz = interp1(f, H_cheby_dig_II, 10e6, 'linear');
H_11MHz = interp1(f, H_cheby_dig_II, 11e6, 'linear');
gain_10MHz = abs(H_10MHz);
gain_10MHz_dB = 20 * log10(gain_10MHz);
gain_11MHz = abs(H_11MHz);
gain_11MHz_dB = 20 * log10(gain_11MHz);
% Display results
disp(['Gain at 9 MHz in dB:   ', num2str(gain_9MHz_dB)]);
disp(['Gain at 10 MHz in dB:  ', num2str(gain_10MHz_dB)]);
disp(['Gain at 11 MHz in dB:  ', num2str(gain_11MHz_dB)]);
disp(['Gain at 12 MHz in dB:  ', num2str(gain_12MHz_dB)]);
disp(['----------------------------------------']);
% Peak passband is very close to 0 dB, meets specs
% Passband gain at 10 and 11 MHz is below 1.5 dB, meets specs
% Magnitude of stopband gain at 12 Mhz and 9 MHz is below 30 dB, meets specs


% Digital Elliptic 
[n_elliptic_dig, Wn_elliptic_dig] = ellipord(Wp_d, Ws_d, pband_variation, sband_atten); 
[b_elliptic_dig, a_elliptic_dig] = ellip(n_elliptic_dig, pband_variation, sband_atten, Wn_elliptic_dig, 'bandpass');

[H_elliptic_dig, f_elliptic_dig] = freqz(b_elliptic_dig, a_elliptic_dig, 1024, Fs);

% Plot magnitude and phase for digital elliptic
figure;
subplot(2,1,1);
plot(f_elliptic_dig/1e6, 20*log10(abs(H_elliptic_dig)));
grid on;
xlabel('Frequency (MHz)');
ylabel('Magnitude (dB)');
title('Digital Elliptic Bandpass Magnitude Response');
ylim([-60 5]);

% Pole-zero plot for digital Elliptic
figure;
zplane(b_elliptic_dig, a_elliptic_dig);
title(['Digital Elliptic Pole-Zero Plot']);

order_elliptic_dig = length(a_elliptic_dig) - 1;
disp(['Elliptic digital filter order: ', num2str(order_elliptic_dig)]);

% Max gain
passband_indices = (w >= 2*pi*pband_min) & (w <= 2*pi*pband_max);
peak_passband_gain = max(abs(H_elliptic_dig(passband_indices)));
peak_passband_gain_dB = 20 * log10(peak_passband_gain); 
disp(['Peak passband gain in dB: ', num2str(peak_passband_gain_dB)]);

% Find stopband gains
H_9MHz  = interp1(f, H_elliptic_dig, 9e6, 'linear');
H_12MHz = interp1(f, H_elliptic_dig, 12e6, 'linear');
gain_9MHz  = abs(H_9MHz);
gain_9MHz_dB = 20 * log10(gain_9MHz);
gain_12MHz = abs(H_12MHz);
gain_12MHz_dB = 20 * log10(gain_12MHz);
% Find passband edge gains
H_10MHz = interp1(f, H_elliptic_dig, 10e6, 'linear');
H_11MHz = interp1(f, H_elliptic_dig, 11e6, 'linear');
gain_10MHz = abs(H_10MHz);
gain_10MHz_dB = 20 * log10(gain_10MHz);
gain_11MHz = abs(H_11MHz);
gain_11MHz_dB = 20 * log10(gain_11MHz);
% Display results
disp(['Gain at 9 MHz in dB:   ', num2str(gain_9MHz_dB)]);
disp(['Gain at 10 MHz in dB:  ', num2str(gain_10MHz_dB)]);
disp(['Gain at 11 MHz in dB:  ', num2str(gain_11MHz_dB)]);
disp(['Gain at 12 MHz in dB:  ', num2str(gain_12MHz_dB)]);
% Peak passband is very close to 0 dB, meets specs
% Passband gain at 10 MHz (a little above 1.5 dB) fails the ripple
% requirement but 11 MHz meets specs since it is below 1.5 dB 
% Magnitude of stopband gain at 12 Mhz and 9 MHz is below 30 dB, meets specs


%% Question 2
% Kaiser Window FIR Filter

% Define frequency and amplitude specs
frequencies = [sband_max pband_min pband_max sband_min];
amplitudes = [0 1 0];
dev = [10^(-sband_atten/20), (10^(pband_variation/20)-1)/(10^(pband_variation/20)+1), 10^(-sband_atten/20)];

% Estimate Kaiser order and parameters
[N_kaiser, Wn_kaiser, beta, ftype] = kaiserord(frequencies, amplitudes, dev, Fs);
N_kaiser = N_kaiser + rem(N_kaiser, 2); % Make order even

% Design FIR using Kaiser window
bandpass_kaiser = fir1(N_kaiser, Wn_kaiser/(Fs/2), 'bandpass', kaiser(N_kaiser+1, beta));

% Frequency response
[Hk, fk] = freqz(bandpass_kaiser, 1, 2048, Fs);
magnitude_Kaiser = 20*log10(abs(Hk));
phase_Kaiser = unwrap(angle(Hk))*180/pi;
freq_Kaiser = fk/1e6;

% Plot magnitude and phase
figure;
subplot(2,1,1);
plot(freq_Kaiser, magnitude_Kaiser);
title('Kaiser Window FIR Bandpass');
xlabel('Frequency (MHz)');
ylabel('Magnitude (dB)');
grid on;
ylim([-60 5]);
xlim([0 20]);

subplot(2,1,2);
plot(freq_Kaiser, phase_Kaiser);
xlabel('Frequency (MHz)');
ylabel('Phase (degrees)');
grid on;
xlim([0 20]);

% Plot coefficients
figure;
stem(bandpass_kaiser);
title('Kaiser FIR Coefficients');
xlabel('Coefficient Index');
ylabel('Amplitude');
grid on;

% Pole-zero plot
figure;
zplane(bandpass_kaiser, 1);
title('Kaiser FIR Pole-Zero Plot');


% Equiripple (Parks–McClellan) FIR Filter
% Normalized frequency edges
f_normalized = [sband_max pband_min pband_max sband_min] / (Fs/2);

% Estimate order and weights
[N_pm, fo, ao, w] = firpmord(f_normalized, [0 1 0], dev);

% Design FIR using Parks–McClellan algorithm
bandpass_pm = firpm(N_pm, fo, ao, w);

% Frequency response
[Hpm, fpm] = freqz(bandpass_pm, 1, 2048, Fs);
magnitude_PM = 20*log10(abs(Hpm));
phasePM = unwrap(angle(Hpm))*180/pi;
freq_PM = fpm/1e6;

% Plot magnitude and phase
figure;
subplot(2,1,1);
plot(freq_PM, magnitude_PM);
title('Equiripple (Parks–McClellan) FIR Bandpass');
xlabel('Frequency (MHz)');
ylabel('Magnitude (dB)');
grid on;
ylim([-60 5]);
xlim([0 20]);

subplot(2,1,2);
plot(freq_PM, phasePM);
xlabel('Frequency (MHz)');
ylabel('Phase (degrees)');
grid on;
xlim([0 20]);

% Plot coefficients
figure;
stem(bandpass_pm);
title('Equiripple FIR Coefficients');
xlabel('Coefficient Index');
ylabel('Amplitude');
grid on;

% Pole-zero plot
figure;
zplane(bandpass_pm, 1);
title('Equiripple FIR Pole-Zero Plot');


% (a) Filter lengths
L_kaiser = length(bandpass_kaiser);
L_pm     = length(bandpass_pm);

fprintf('Kaiser: order N = %d, length = %d\n', N_kaiser, L_kaiser);
fprintf('Parks-McClellan: order N = %d, length = %d\n', N_pm, L_pm);

% (b) Weights vs tolerances (linear)
stop_tol = dev(1);   % linear tolerance for stop (same for both stops)
pass_tol = dev(2);   % linear passband tolerance
fprintf('\nLinear tolerances: stop = %.3e, pass = %.3e\n', stop_tol, pass_tol);

% Interpret firpm weights 'w' returned earlier: w corresponds to bands [stop pass stop]
if exist('w','var')
    w_stop1 = w(1);
    w_pass  = w(2);
    w_stop2 = w(3);
    % average stop weight (if symmetric)
    w_stop_avg = mean([w_stop1, w_stop2]);
    fprintf('firpm weights: stop1 = %.3f, pass = %.3f, stop2 = %.3f, stop_avg = %.3f\n', w_stop1, w_pass, w_stop2, w_stop_avg);

    % expected weight ratio from theory: w_pass/w_stop ≈ delta_stop/delta_pass
    expected_ratio = stop_tol / pass_tol;
    actual_ratio   = w_pass / w_stop_avg;
    fprintf('Expected weight ratio (delta_stop/delta_pass) = %.3f\n', expected_ratio);
    fprintf('Actual weight ratio (w_pass / w_stop_avg) = %.3f\n', actual_ratio);
    fprintf('(They should be approximately equal since weights ~ 1/delta.)\n\n');
else
    warning('firpm weights ''w'' not present in workspace.');
end

% Convenience: function to test a given freq response
check_response = @(H, f, label) deal(20*log10(abs(H)), f);

% Convert freq arrays back to Hz for comparisons
fk_Hz  = fk;      
fpm_Hz = fpm;     

%Max gain
pmin = pband_min; 
pmax = pband_max;  

% Kaiser
pass_idx_k = (fk_Hz >= pmin) & (fk_Hz <= pmax);
max_k = max(magnitude_Kaiser(pass_idx_k));
min_k = min(magnitude_Kaiser(pass_idx_k));
delta_k = max_k - min_k;
fprintf('Kaiser passband max = %.3f dB, min = %.3f dB, diff = %.3f dB\n', max_k, min_k, delta_k);

% Parks-McClellan
pass_idx_pm = (fpm_Hz >= pmin) & (fpm_Hz <= pmax);
max_pm = max(magnitude_PM(pass_idx_pm));
min_pm = min(magnitude_PM(pass_idx_pm));
delta_pm = max_pm - min_pm;
fprintf('Parks-McClellan passband max = %.3f dB, min = %.3f dB, diff = %.3f dB\n', max_pm, min_pm, delta_pm);

% Check passband ripple requirement (compare to 1.5 dB target)
fprintf('(Target passband ripple difference = 1.5 dB). Kaiser diff = %.3f, PM diff = %.3f\n\n', delta_k, delta_pm);
