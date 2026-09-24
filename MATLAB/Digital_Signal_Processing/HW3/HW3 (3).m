% SPDX-License-Identifier: GNU AGPL-3.0-or-later
% Copyright (C) 2025 Kenneth Chan <kenc0728@gmail.com>
% Kenneth Chan

clc;
clear;
close all;
rng(388); 

%% Question 4
fprintf('\n*** THIS IS QUESTION 4!***\n\n');
% Parameters
N = 8; % Filter order
N_bandpass = N/2; 
Rp = 1.5; % ripple passband
Rs = 30; % ripple stopband
Wp = [0.3 0.6]; % passband edges

[z_orig,p_orig,k_orig] = ellip(N_bandpass,Rp,Rs,Wp, 'bandpass'); 
[b_up,a] = zp2tf(z_orig,p_orig,k_orig); 

n = 2048;                   
[H, w] = freqz(b_up, a, n);
magnitude_dB = 20*log10(abs(H)); 
figure;
plot(w/pi, magnitude_dB, 'LineWidth', 1.2);   
grid on;
xlabel('Normalized Frequency (× Nyquist)');
ylabel('Magnitude (dB)');
title('Elliptic bandpass transfer function (dB)');
ylim([-100 10]);

[sos,g]   = zp2sos(z_orig,p_orig,k_orig, 'up','inf'); 
[sos2,g2] = zp2sos(z_orig,p_orig,k_orig, 'down','inf'); 

[H1, w1] = freqz(sos);
[H2, w2] = freqz(sos2);

fprintf('SOS (up) ordering \n');
numStages = size(sos, 1);  

for i = 1:numStages
    % Get numerator (b) and denominator (a) coefficients for this stage
    b_up = sos(i, 1:3);   % Coefficients of zeros
    a_up = sos(i, 4:6);   % Coefficients of poles

    % Find zeros and poles for this section
    z_up = roots(b_up);
    p_up = roots(a_up);

    % Compute magnitudes (distance from origin)
    zeroMag_up = abs(z_up);
    poleMag_up = abs(p_up);

    % Display results
    fprintf('Stage %d:\n', i);
    fprintf('Zero magnitudes: [%.4f, %.4f]\n', zeroMag_up(1), zeroMag_up(2));
    fprintf('Pole magnitudes: [%.4f, %.4f]\n', poleMag_up(1), poleMag_up(2));
end

fprintf('\nSOS (down) ordering\n');
numStages2 = size(sos2, 1);
for i = 1:numStages2
    b_down = sos2(i, 1:3);
    a_down = sos2(i, 4:6);

    z_down = roots(b_down);
    p_down = roots(a_down);

    zeroMag_down = abs(z_down);
    poleMag_down = abs(p_down);

    fprintf('Stage %d:\n', i);
    fprintf('Zero magnitudes: [%.4f, %.4f]\n', zeroMag_down(1), zeroMag_down(2));
    fprintf('Pole magnitudes: [%.4f, %.4f]\n', poleMag_down(1), poleMag_down(2));
end

% part d
numStages = size(sos,1); 
b_cumulative_up = 1; % Numer
a_cumulative_up = 1; % Denom
w = linspace(0,pi, 2048);

figure; 
hold on;

for i = 1:numStages
    b_cumulative_up = conv(b_cumulative_up, sos(i, 1:3));
    a_cumulative_up = conv(a_cumulative_up, sos(i, 4:6));
    
    H_cumulative_up = freqz(b_cumulative_up, a_cumulative_up, w);
    
    % Linf-scaling (normalize so peak gain = 0 dB)
    H_cumulative_up = H_cumulative_up / max(abs(H_cumulative_up));
    
    plot(w/pi, 20*log10(abs(H_cumulative_up)), 'DisplayName', sprintf('UP: Stage %d', i), 'LineWidth', 1.2);
end

grid on;
xlabel('Normalized Frequency (× Nyquist)');
ylabel('Magnitude (dB)');
title('Successive Cumulative Transfer Functions (UP ordering)');
legend show;
ylim([-100 5]);
hold off;

%DOWN
b_cumulative_down = 1;
a_cumulative_down = 1;
figure; 
hold on;

for i = 1:numStages2
    b_cumulative_down = conv(b_cumulative_down, sos2(i,1:3));
    a_cumulative_down = conv(a_cumulative_down, sos2(i,4:6));
    
    H_cumulative_down = freqz(b_cumulative_down, a_cumulative_down, w);
    
    % Scaling
    H_cumulative_down = H_cumulative_down / max(abs(H_cumulative_down));
    
    plot(w/pi, 20*log10(abs(H_cumulative_down)), 'DisplayName', sprintf('Down: Stage %d', i), 'LineWidth', 1.2);
end

grid on;
xlabel('Normalized Frequency (× Nyquist)');
ylabel('Magnitude (dB)');
title('Successive Cumulative Transfer Functions (DOWN ordering)');
legend show;
ylim([-100 5]);
hold off;

fprintf('\n*** Comparing Up and Down Realizations ***\n');

numStages = size(sos, 1);
max_difference = 1e-6;  % if difference is below this, then we're good! 

for i = 1:numStages
    up_idx = i; % up index
    down_idx = numStages - i + 1;  % reverse order 
    
    % Extract numerator and denominator coefficients
    B_up = sos(up_idx, 1:3);
    A_up = sos(up_idx, 4:6);
    
    B_down = sos2(down_idx, 1:3);
    A_down = sos2(down_idx, 4:6);
    
    % Normalize both so that leading denominator coefficient = 1
    A_up = A_up / A_up(1);
    A_down = A_down / A_down(1);
    
    % Compute scaling factor between numerators
    scale_factor = B_up(1) / B_down(1);
    
    % Compare denominators
    denom_match = max(abs(A_up - A_down)) < max_difference;
    
    % Compare numerators (after adjusting for scaling)
    num_match = max(abs(B_up - scale_factor * B_down)) < max_difference;
    
    fprintf('Stage %d (UP) vs Stage %d (DOWN):\n', up_idx, down_idx);
    fprintf('Denominator reversed match: %s\n', string(denom_match));
    fprintf('Numerator match (up to scaling): %s\n', string(num_match));
    fprintf('Scaling factor ≈ %.4f\n\n', scale_factor);
end




%% Question 5 
fprintf('\n*** THIS IS QUESTION 5!***\n\n');
order = 3;
Wp_lowpass = 0.3; % passband edge for lowpass filter
Rp_lowpass = 0.92; % in dB
Rs_lowpass = 20; % in dB

original_numer = [0.1336, 0.0563, 0.0563, 0.1336];
original_denom = [1, -1.5055, 1.2630, -0.3778]; 

allpass1_numer = [-0.4954, 1];
allpass1_denom = [1, -0.4954]; 
allpass2_numer = [0.7626, -1.0101, 1];
allpass2_denom = [1, -1.0101, 0.7626];
allpass_combined_denom = conv(allpass1_denom, allpass2_denom);

a1 = conv(allpass1_numer, allpass2_denom);
a2 = conv(allpass2_numer, allpass1_denom); 
new_numer = 1/2 * (a1 + a2);

num = 2000;
w = linspace(0, pi, num); 
H_original = freqz(original_numer, original_denom, w);
H_allpass = freqz(new_numer, allpass_combined_denom,w);

% Freq error
max_freqz_error = max(abs(H_original - H_allpass));
fprintf('The max frequency error is %.5f. ', max_freqz_error); 

% Pole/zero errors
original_poles = roots(original_denom);
original_zeros = roots(original_numer);
allpass_poles = roots(allpass_combined_denom);
allpass_zeros = roots(new_numer); 

max_pole_error = max(abs((original_poles) - (allpass_poles)));
max_zero_error = max(abs((original_zeros) - (allpass_zeros)));

fprintf('\nThe max pole error is %.5f ', max_pole_error);
fprintf('\nThe max zero error is %.5f ', max_zero_error); 

% part b
fprintf('\n\n*** Coefficients of original transfer function (quantized) ***');
bits = 4; 
y = fi(original_numer, 1, bits, 3);
y2 = fi(original_denom, 1, bits, 3); 

% HQ(z) quantized
HQz_numer = y.data; 
HQz_denom = y2.data; 

fprintf('\nHQ Numerator:  '); fprintf('%.4f ', HQz_numer);
fprintf('\nHQ Denominator: '); fprintf('%.4f ', HQz_denom);
fprintf('\n');

fprintf('\n*** Coefficients of composite transfer function (quantized) ***');
y3 = fi(allpass1_numer, 1, bits, 3);
y4 = fi(allpass1_denom, 1, bits, 3); 
y5 = fi(allpass2_numer, 1, bits, 3);
y6 = fi(allpass2_denom, 1, bits, 3); 

% HAQ(z) quantized
HAQz1_numer = y3.data; 
HAQz1_denom = y4.data; 
HAQz2_numer = y5.data;
HAQz2_denom = y6.data; 

HAQz_denom = conv(HAQz2_denom, HAQz1_denom);
HAQz1_combined_num1 = conv(HAQz1_numer, HAQz2_denom); 
HAQz1_combined_num2 = conv(HAQz2_numer, HAQz1_denom); 
HAQz_numer = 0.5 * (HAQz1_combined_num1 + HAQz1_combined_num2);

fprintf('\nHAQ(z) Numerator:  '); fprintf('%.4f ', HAQz_numer);
fprintf('\nHAQ(z) Denominator: '); fprintf('%.4f ', HAQz_denom);
fprintf('\n');

% part c 
% could not get zplane to change colors for zeros and poles
[z, p]    = tf2zp(original_numer, original_denom);     
[zq, pq]  = tf2zp(HQz_numer, HQz_denom);            
[zaq, paq] = tf2zp(HAQz_numer, HAQz_denom);       

figure; 
hold on; 
grid on;

% Plot the unit circle
theta = linspace(0, 2*pi, 400);
plot(cos(theta), sin(theta), 'k--', 'LineWidth', 1);

% Original H(z)
plot(real(z),  imag(z),  'bo', 'MarkerSize',8, 'DisplayName','Zeros H');
plot(real(p),  imag(p),  'bx', 'MarkerSize',8, 'DisplayName','Poles H');

% HQ quantized
plot(real(zq), imag(zq), 'ro', 'MarkerSize',8, 'DisplayName','Zeros HQ');
plot(real(pq), imag(pq), 'rx', 'MarkerSize',8, 'DisplayName','Poles HQ');

% HAQ quantized
plot(real(zaq), imag(zaq),'go', 'MarkerSize',8, 'DisplayName','Zeros HAQ');
plot(real(paq), imag(paq),'gx', 'MarkerSize',8, 'DisplayName','Poles HAQ');

axis equal; axis([-1.2 1.2 -1.2 1.2]);
xlabel('Real'); ylabel('Imag');
title('Pole-Zero Plot: Original vs Quantized (HQ, HAQ)');
legend('','Zeros H','Poles H', 'Zeros HQ', 'Poles HQ', 'Zeros HAQ', 'Poles HAQ');

p_sorted = sort(p); 
pq_sorted = sort(pq);
paq_sorted = sort(paq);
z_sorted = sort(z); 
zq_sorted = sort(zq);
zpaq_sorted = sort(zaq);

error_p_pq = abs(p_sorted - pq_sorted);
max_error_p_pq = max(error_p_pq); 
error_p_paq = abs(p_sorted - paq_sorted);
max_error_p_paq = max(error_p_paq); 

error_z_pq = abs(z_sorted - zq_sorted);
max_error_z_pq = max(error_z_pq); 
error_z_paq = abs(z_sorted - zpaq_sorted);
max_error_z_paq = max(error_z_paq); 

fprintf('\n\nMax absolute error of original poles and HQ poles is %.4f', max_error_p_pq); 
fprintf('\nMax absolute error of original poles and HAQ poles is %.4f', max_error_p_paq); 
fprintf('\nMax absolute error of original zeros and HQ zeros is %.4f', max_error_z_pq); 
fprintf('\nMax absolute error of original zeros and HAQ zeros is %.4f', max_error_z_paq); 

% Part d
w = [0, pi]; 
fprintf('\n\nIdeal (theoretical) gain at w = 0 is 1 (0 dB)\n');
fprintf('Ideal (theoretical) gain at w = pi is 0 (-infinity dB)\n');

H_orig = freqz(original_numer, original_denom, w);
H_HQ = freqz(HQz_numer, HQz_denom, w);
H_HAQ = freqz(HAQz_numer, HAQz_denom, w);

fprintf('\nIdeal gain for H at w = 0 and w = pi, respectively. %d %d', H_orig(1), H_orig(2)); 
fprintf('\nIdeal gain for HQ at w = 0 and w = pi, respectively. %d %d', H_HQ(1), H_HQ(2)); 
fprintf('\nIdeal gain for HAQ at w = 0 and w = pi, respectively. %d %d', H_HAQ(1), H_HAQ(2)); 

gain_H_orig = 20 * log10(abs(H_orig));
gain_H_HQ = 20 * log10(abs(H_HQ));
gain_H_HAQ = 20 * log10(abs(H_HAQ));

error_gain_H_HQ = abs(gain_H_HQ - gain_H_orig); 
error_gain_H_HAQ = abs(gain_H_HAQ - gain_H_orig); 

fprintf('\n\nGain comparison at ω = 0 (z = 1):\n');
fprintf('Original gain: %.4f dB\n', gain_H_orig(1));
fprintf('HQ gain:       %.4f dB (error = %6.4f dB)\n', gain_H_HQ(1),  error_gain_H_HQ(1));
fprintf('HAQ gain:      %.4f dB (error = %6.4f dB)\n', gain_H_HAQ(1), error_gain_H_HAQ(1));

fprintf('\nGain comparison at ω = π (z = -1):\n');
fprintf('Original gain: %.4f dB\n', gain_H_orig(2));
fprintf('HQ gain:       %.4f dB (error = %6.4f dB)\n', gain_H_HQ(2),  error_gain_H_HQ(2));
fprintf('HAQ gain:      %.4f dB (error = %6.4f dB)\n', gain_H_HAQ(2), error_gain_H_HAQ(2));
fprintf('These results satisfy the requirements');

% Part e 
num_points = 10^4; 

frequencies = linspace(0, pi, num_points);
HW = freqz(original_numer, original_denom, frequencies);
HQW = freqz(HQz_numer, HQz_denom, frequencies);
HAQ = freqz(HAQz_numer, HAQz_denom, frequencies);

mag_err_HQ_and_HW  = abs(abs(HW) - abs(HQW));
mag_err_HAQ_and_HW = abs(abs(HW) - abs(HAQ));

max_err_HQ  = max(mag_err_HQ_and_HW);
max_err_HAQ = max(mag_err_HAQ_and_HW);

fprintf('\n\n*** Frequency Response Magnitude Error ***\n');
fprintf('Max error between H(W) and HQ(W) = %.4e\n', max_err_HQ);
fprintf('Max error between H(W) and HAQ(W) = %.4e\n', max_err_HAQ);

% part f
mag_HW  = 20*log10(abs(HW));
mag_HQW = 20*log10(abs(HQW));
mag_HAQ = 20*log10(abs(HAQ));

% Plot the magnitude response of the quantized systems
figure;
hold on;
plot(frequencies, 20*log10(abs(HW)), 'b', 'DisplayName', 'Original');
plot(frequencies, 20*log10(abs(HQW)), 'r', 'DisplayName', 'HQ');
plot(frequencies, 20*log10(abs(HAQ)), 'g', 'DisplayName', 'HAQ');
grid on;
xlabel('Frequency (rad/sample)');
ylabel('Gain (dB)');
ylim([-40 10]); 
title('Frequency Response of Original and Quantized Systems');
legend('show');
hold off;

figure;
plot(frequencies, unwrap(angle(HW)) * 180/pi, 'b', 'DisplayName', 'Original');
hold on;
plot(frequencies, unwrap(angle(HQW)) * 180/pi, 'r', 'DisplayName', 'HQ');
plot(frequencies, unwrap(angle(HAQ)) * 180/pi, 'g', 'DisplayName', 'HAQ');
grid on;
xlabel('Frequency (rad/sample)');
ylabel('Phase (degrees)');
title('Phase Response of Original and Quantized Systems');
legend('show');
hold off;
