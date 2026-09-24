% SPDX-License-Identifier: GNU AGPL-3.0-or-later
% Copyright (C) 2025 Kenneth Chan <kenc0728@gmail.com>
% Kenneth Chan 

clear;
close all;
clc;

% Frequency between 0 and pi 
num_points = 1e4;
w = linspace(0, pi, num_points);  % frequency vector (rad)

N1 = 4; 
N2 = 8; 

wname1 = ['db', num2str(N1)];
[h0_1, h1_1, f0_1, f1_1] = wfilters(wname1);
H1_1 = fliplr(h0_1) .* (-1).^(0:length(h0_1)-1);  
F0_1 = fliplr(h0_1);                            
F1_1 = h0_1 .* (-1).^(0:length(h0_1)-1);


wname2 = ['db', num2str(N2)];
[h0_2, h1_2, f0_2, f1_2] = wfilters(wname2);
H1_2 = fliplr(h0_2) .* (-1).^(0:length(h0_2)-1);  
F0_2 = fliplr(h0_2);                            
F1_2 = h0_2 .* (-1).^(0:length(h0_2)-1);

% part b 2 
H0_w1 = freqz(h0_1,1,w);
H1_w1 = freqz(H1_1,1,w);

H0_w2 = freqz(h0_2,1,w);
H1_w2 = freqz(H1_2,1,w);

figure; 
hold on; 

% Plot db4 responses
plot(w, abs(H0_w1), 'r', 'LineWidth', 1.5);  % H0, db4
plot(w, abs(H1_w1), 'b', 'LineWidth', 1.5);  % H1, db4

% Plot db8 responses
plot(w, abs(H0_w2), 'c', 'LineWidth', 1.5);  % H0, db8
plot(w, abs(H1_w2), 'g', 'LineWidth', 1.5);  % H1, db8

xlabel('Frequency (rad)');
ylabel('Magnitude');
title('Frequency Response of db4 and db8 Wavelets');
legend('H0, db4','H1, db4','H0, db8','H1, db8');
grid on;

hold off; 

% part b 3 
power_sum1 = abs(H0_w1).^2 + abs(H1_w1).^2;
power_sum2 = abs(H0_w2).^2 + abs(H1_w2).^2;

max_diff1 = max(abs(power_sum1 - 2));
max_diff2 = max(abs(power_sum2 - 2));

disp(['db4: Max difference from 2 = ', num2str(max_diff1)]);
disp(['db8: Max difference from 2 = ', num2str(max_diff2)]);
% The difference results are close to 0, like we wanted! 

% b4

E00_H0_4 = h0_1(1:2:end);     % Even H0 samples (db4)
E01_H0_4 = h0_1(2:2:end);     % Odd  H0 samples (db4)
E10_H1_4 = H1_1(1:2:end);     % Even H1 samples (db4)
E11_H1_4 = H1_1(2:2:end);     % Odd  H1 samples (db4)

R00_F0_4 = F0_1(1:2:end);     % Even F0 samples (db4)
R01_F0_4 = F0_1(2:2:end);     % Odd  F0 samples (db4)
R10_F1_4 = F1_1(1:2:end);     % Even F1 samples (db4)
R11_F1_4 = F1_1(2:2:end);     % Odd  F1 samples (db4)

fprintf("\nPolyphase Matrices — db4 \n");
fprintf("E(z)\n");
E_4 = [E00_H0_4; E01_H0_4; E10_H1_4; E11_H1_4];
disp(E_4);

fprintf("R(z)\n");
R_4 = [R00_F0_4; R01_F0_4; R10_F1_4; R11_F1_4];
disp(R_4);


E00_H0_8 = h0_2(1:2:end);     
E01_H0_8 = h0_2(2:2:end);     
E10_H1_8 = H1_2(1:2:end);     
E11_H1_8 = H1_2(2:2:end);     

R00_F0_8 = F0_2(1:2:end);     
R01_F0_8 = F0_2(2:2:end);     
R10_F1_8 = F1_2(1:2:end);     
R11_F1_8 = F1_2(2:2:end);     

fprintf("\nPolyphase Matrices — db8 \n");
fprintf("E(z)\n");
E_8 = [E00_H0_8; E01_H0_8; E10_H1_8; E11_H1_8];
disp(E_8);

fprintf("R(z)\n"); 
R_8 = [R00_F0_8; R01_F0_8; R10_F1_8; R11_F1_8];
disp(R_8);


% b5 
% Convolution of polyphase components for db4
P00_4 = conv(R00_F0_4, E00_H0_4) + conv(R10_F1_4, E10_H1_4);

% Find peak to determine c and n0
[~, idx_peak] = max(abs(P00_4));  % index of maximum magnitude
c_4 = P00_4(idx_peak);            % scaling factor
n0_4 = idx_peak - 1;              % delay in samples

fprintf('db4: Computed c = %.4f, n0 = %d\n', c_4, n0_4);

% Convolution of polyphase components for db8
P00_8 = conv(R00_F0_8, E00_H0_8) + conv(R10_F1_8, E10_H1_8);

% Find peak to determine c and n0
[~, idx_peak] = max(abs(P00_8));  % index of maximum magnitude
c_8 = P00_8(idx_peak);            % scaling factor
n0_8 = idx_peak - 1;              % delay in samples

fprintf('db8: Computed c = %.4f, n0 = %d\n', c_8, n0_8);

% b 6 
fprintf('\nPart 6\n');

% --- db4 ---
% Polyphase multiplication (2x2)
P00_4 = conv(R00_F0_4, E00_H0_4) + conv(R10_F1_4, E10_H1_4);
P01_4 = conv(R00_F0_4, E01_H0_4) + conv(R10_F1_4, E11_H1_4);
P10_4 = conv(R01_F0_4, E00_H0_4) + conv(R11_F1_4, E10_H1_4);
P11_4 = conv(R01_F0_4, E01_H0_4) + conv(R11_F1_4, E11_H1_4);

% Peak magnitude and delay for diagonal (d and n0)
[~, idx_peak] = max(abs(P00_4));
d_4 = P00_4(idx_peak);       % scaling factor
n0_4 = idx_peak - 1;         % delay (samples)

% Maximal numerical error using ideal delta function
len_4 = length(P00_4);
ideal_diag = zeros(1,len_4);
ideal_diag(n0_4+1) = d_4;    % MATLAB indexing

max_err_4 = max([abs(P00_4 - ideal_diag), abs(P11_4 - ideal_diag), abs(P01_4), abs(P10_4)]);

fprintf('db4: d = %.4f, n0 = %d, maximal numerical error = %.4e\n', d_4, n0_4, max_err_4);

% --- db8 ---
P00_8 = conv(R00_F0_8, E00_H0_8) + conv(R10_F1_8, E10_H1_8);
P01_8 = conv(R00_F0_8, E01_H0_8) + conv(R10_F1_8, E11_H1_8);
P10_8 = conv(R01_F0_8, E00_H0_8) + conv(R11_F1_8, E10_H1_8);
P11_8 = conv(R01_F0_8, E01_H0_8) + conv(R11_F1_8, E11_H1_8);

[~, idx_peak] = max(abs(P00_8));
d_8 = P00_8(idx_peak);
n0_8 = idx_peak - 1;

len_8 = length(P00_8);
ideal_diag_8 = zeros(1,len_8);
ideal_diag_8(n0_8+1) = d_8;

max_err_8 = max([abs(P00_8 - ideal_diag_8), abs(P11_8 - ideal_diag_8), abs(P01_8), abs(P10_8)]);

fprintf('db8: d = %.4f, n0 = %d, maximal numerical error = %.4e\n', d_8, n0_8, max_err_8);

% b7 

fprintf('\nPart 7\n');
% H0, H1, F0, F1 are already defined for db4 and db8
filters = {'db4', h0_1, H1_1, F0_1, F1_1; 
           'db8', h0_2, H1_2, F0_2, F1_2};

for k = 1:2
    name = filters{k,1};
    H0 = filters{k,2};
    H1 = filters{k,3};
    F0 = filters{k,4};
    F1 = filters{k,5};
    
    % --- Compute T(z) ---
    T = conv(H0, F0) + conv(H1, F1);
    
    % --- Compute A(z) ---
    H0_neg = H0 .* (-1).^(0:length(H0)-1);  % H0(-z)
    H1_neg = H1 .* (-1).^(0:length(H1)-1);  % H1(-z)
    A = conv(H0_neg, F0) + conv(H1_neg, F1);
    
    % Ideal T vector: single nonzero coefficient = 2 at index 2N
    N = length(H0)/2;       % dbN
    T_ideal = zeros(1,length(T));
    T_ideal(2*N) = 2;       % MATLAB indexing
    
    % Compute errors
    max_err_T = max(abs(T - T_ideal));
    max_err_A = max(abs(A));
    
    fprintf('%s:\n', name);
    fprintf('Max absolute error for T(z) = %.4e\n', max_err_T);
    fprintf('Max absolute error for A(z) = %.4e \n\n', max_err_A);
end

% --- b8: derivatives of |H0(w)|^2 ---

% Compute |H0(w)|^2 for db4 and db8
H0_sq_4 = abs(H0_w1).^2;
H0_sq_8 = abs(H0_w2).^2;

% First derivative (numerical)
dH0_sq_4 = diff(H0_sq_4) / (w(2) - w(1));
dH0_sq_8 = diff(H0_sq_8) / (w(2) - w(1));

% Second derivative (numerical)
ddH0_sq_4 = diff(dH0_sq_4) / (w(2) - w(1));
ddH0_sq_8 = diff(dH0_sq_8) / (w(2) - w(1));

% Adjust frequency vectors due to diff shortening the arrays
w_d1_4 = w(1:end-1);
w_d1_8 = w(1:end-1);
w_d2_4 = w(1:end-2);
w_d2_8 = w(1:end-2);

% Plot first derivative
figure;
subplot(2,1,1);
plot(w_d1_4, dH0_sq_4, 'r', 'LineWidth', 1.5); hold on;
plot(w_d1_8, dH0_sq_8, 'b', 'LineWidth', 1.5);
xlabel('\omega (rad)');
ylabel('d|Ho|^2 / dw');
title('First Derivative of |H0(w)|^2');
legend('db4','db8');
grid on;

% Plot second derivative
subplot(2,1,2);
plot(w_d2_4, ddH0_sq_4, 'r', 'LineWidth', 1.5); hold on;
plot(w_d2_8, ddH0_sq_8, 'b', 'LineWidth', 1.5);
xlabel('\omega (rad)');
ylabel('d^2|Ho|^2 / dw^2');
title('Second Derivative of |H0(w)|^2');
legend('db4','db8');
grid on;

% Verify values at omega = 0 and pi
fprintf('db4: First derivative at w=0 = %.4e, w=pi = %.4e\n', dH0_sq_4(1), dH0_sq_4(end));
fprintf('db4: Second derivative at w=0 = %.4e, w=pi = %.4e\n', ddH0_sq_4(1), ddH0_sq_4(end));

fprintf('db8: First derivative at w=0 = %.4e, w=pi = %.4e\n', dH0_sq_8(1), dH0_sq_8(end));
fprintf('db8: Second derivative at w=0 = %.4e, w=pi = %.4e\n', ddH0_sq_8(1), ddH0_sq_8(end));

% part 9 
% For N = 4 
fprintf('\n Part 9\n'); 

h0 = h0_1;
h1 = H1_1;
w = linspace(0, pi, 1000);

% Level 2 filters
G0 = conv(upsample(h0, 2), h0);
G1 = conv(upsample(h0, 2), h1);
G2 = conv(upsample(h1, 2), h0);
G3 = conv(upsample(h1, 2), h1);

% Level 3 filters
G4 = conv(upsample(G0, 2), h0);
G5 = conv(upsample(G0, 2), h1);
G6 = conv(upsample(G1, 2), h0);
G7 = conv(upsample(G1, 2), h1);
G8 = conv(upsample(G2, 2), h0);
G9 = conv(upsample(G2, 2), h1);
G10 = conv(upsample(G3, 2), h0);
G11 = conv(upsample(G3, 2), h1);

% Plot 2-level bank
figure;
G2_mag = abs(freqz(G0, 1, w));
plot(w, G2_mag, 'r-', 'LineWidth', 2); hold on;
G2_mag = abs(freqz(G1, 1, w));
plot(w, G2_mag, 'b-', 'LineWidth', 2);
G2_mag = abs(freqz(G2, 1, w));
plot(w, G2_mag, 'g-', 'LineWidth', 2);
G2_mag = abs(freqz(G3, 1, w));
plot(w, G2_mag, 'm-', 'LineWidth', 2);
xlabel('\omega (rad)'); ylabel('Magnitude');
title('2-Level Tree Filter Bank (db4)');
legend('G0','G1','G2','G3', 'Location','best'); grid on;

% Plot 3-level bank 
figure;
G3_mag = abs(freqz(G4, 1, w));
plot(w, G3_mag, 'r-', 'LineWidth', 2); hold on;
G3_mag = abs(freqz(G5, 1, w));
plot(w, G3_mag, 'b-', 'LineWidth', 2);
G3_mag = abs(freqz(G6, 1, w));
plot(w, G3_mag, 'g-', 'LineWidth', 2);
G3_mag = abs(freqz(G7, 1, w));
plot(w, G3_mag, 'm-', 'LineWidth', 2);
G3_mag = abs(freqz(G8, 1, w));
plot(w, G3_mag, 'c-', 'LineWidth', 2);
G3_mag = abs(freqz(G9, 1, w));
plot(w, G3_mag, 'k-', 'LineWidth', 2);
G3_mag = abs(freqz(G10, 1, w));
plot(w, G3_mag, 'r--', 'LineWidth', 2);
G3_mag = abs(freqz(G11, 1, w));
plot(w, G3_mag, 'b--', 'LineWidth', 2);
xlabel('\omega (rad)'); ylabel('Magnitude');
title('3-Level Tree Filter Bank (db4)');
legend('G0','G1','G2','G3','G4','G5','G6','G7', 'Location','best'); grid on;

fprintf('3-level filter bank completed successfully.\n');

% For N=8

h0 = h0_2;
h1 = H1_2;
w = linspace(0, pi, 1000);

% Level 2 filters
G0 = conv(upsample(h0, 2), h0);
G1 = conv(upsample(h0, 2), h1);
G2 = conv(upsample(h1, 2), h0);
G3 = conv(upsample(h1, 2), h1);

% Level 3 filters
G4 = conv(upsample(G0, 2), h0);
G5 = conv(upsample(G0, 2), h1);
G6 = conv(upsample(G1, 2), h0);
G7 = conv(upsample(G1, 2), h1);
G8 = conv(upsample(G2, 2), h0);
G9 = conv(upsample(G2, 2), h1);
G10 = conv(upsample(G3, 2), h0);
G11 = conv(upsample(G3, 2), h1);

% Plot 2-level bank
figure;
G2_mag = abs(freqz(G0, 1, w));
plot(w, G2_mag, 'r-', 'LineWidth', 2); hold on;
G2_mag = abs(freqz(G1, 1, w));
plot(w, G2_mag, 'b-', 'LineWidth', 2);
G2_mag = abs(freqz(G2, 1, w));
plot(w, G2_mag, 'g-', 'LineWidth', 2);
G2_mag = abs(freqz(G3, 1, w));
plot(w, G2_mag, 'm-', 'LineWidth', 2);
xlabel('\omega (rad)'); ylabel('Magnitude');
title('2-Level Tree Filter Bank (db8)');
legend('G0','G1','G2','G3', 'Location','best'); grid on;

% Plot 3-level bank 
figure;
colors = {'r','b','g','m','c','k','r--','b--'};
G3_filters = {G4,G5,G6,G7,G8,G9,G10,G11};
for i = 1:8
    G3_mag = abs(freqz(G3_filters{i}, 1, w));
    plot(w, G3_mag, colors{i}, 'LineWidth', 2); hold on;
end
xlabel('\omega (rad)'); ylabel('Magnitude');
title('3-Level Tree Filter Bank (db8)');
legend('G0','G1','G2','G3','G4','G5','G6','G7', 'Location','best'); grid on;

fprintf('db8 3-level filter bank completed successfully.\n');
