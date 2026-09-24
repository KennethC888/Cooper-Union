% SPDX-License-Identifier: GNU AGPL-3.0-or-later
% Copyright (C) 2025 Kenneth Chan <kenc0728@gmail.com>
% Kenneth Chan 

clear;
close all;
clc;

%% Problem 1

SNR = 4; % dB/bit
SNR_linear = 10^(SNR / 10);
Eb = 1;             
N0 = Eb / SNR_linear;

p = -0.217; 

y = qfunc(sqrt((1-p)*SNR_linear)); 

p = 0; 
y2 = qfunc(sqrt((1-p)*SNR_linear)); 
%disp(y); % Correlation Case 
%disp(y2); % Orthogonal Case 

% Noncoherent. Looked at the graph and ESTIMATING HERE, for p = 0, (orthogonal case), the probability of error 
% was relatively closer to 10^-2. For noncoherent correlation case, the probability of error was roughly between 0.1
% and 0.01.

fprintf('BER of coherent orthogonal %.4f\n', y);
fprintf('BER of coherent PSK %.4f\n', y2);

%% Problem 2 
x = 1; 
% Distance counts (each pair counted twice) (kl)
k1 = 20;    
k2 = 12;    
k3 = 8;     
k4 = 8;     
k5 = 4;     
k6 = 4;  


% Verify that total number of ordered pairs is 8*7 = 56
total_pairs = k1 + k2 + k3 + k4 + k5 + k6;
fprintf("\nTotal number of pairs = %d (expected 56)\n\n", total_pairs);

a1 = k1/8.0;    
a2 = k2/8.0;    
a3 = k3/8.0;   
a4 = k4/8.0;   
a5 = k5/8.0;  
a6 = k6/8.0;

d1 = 2 * sqrt(x); 
d2 = 2 * sqrt(2*x); 
d3 = 4 * sqrt(x); 
d4 = 2 * sqrt(5 *x);
d5 = 6 * sqrt(x); 
d6 = 2 * sqrt(10 *x); 

b1 = (d1 * d1) / (4 * x); 
b2 = (d2 * d2) / (4 * x); 
b3 = (d3 * d3) / (4 * x); 
b4 = (d4 * d4) / (4 * x); 
b5 = (d5 * d5) / (4 * x); 
b6 = (d6 * d6) / (4 * x);

fprintf("Distance parameters (a_k and b_k):\n");
fprintf("  a1 = %.2f,   b1 = %.1f\n", a1, b1);
fprintf("  a2 = %.2f,   b2 = %.1f\n", a2, b2);
fprintf("  a3 = %.2f,   b3 = %.1f\n", a3, b3);
fprintf("  a4 = %.2f,   b4 = %.1f\n", a4, b4);
fprintf("  a5 = %.2f,   b5 = %.1f\n", a5, b5);
fprintf("  a6 = %.2f,   b6 = %.1f\n\n", a6, b6);

% Put ak and bk in arrays for convenience
a = [a1 a2 a3 a4 a5 a6];
b = [b1 b2 b3 b4 b5 b6];

% Full union bound function
Pe_full = @(beta_lin) sum(a .* qfunc(sqrt(b .* beta_lin)));

% Nearest-neighbor (simplified) union bound
Pe_simplified = @(beta_lin) a1 * qfunc(sqrt(b1 * beta_lin));

% Sweep over beta in dB
beta_dB = 0:0.2:20;       % adjust as needed
beta_lin = 10.^(beta_dB/10);

Pe_full_vals = arrayfun(Pe_full, beta_lin);
Pe_simple_vals = arrayfun(Pe_simplified, beta_lin);

% Plot
figure; 
semilogy(beta_dB, Pe_full_vals, 'LineWidth', 2); hold on;
semilogy(beta_dB, Pe_simple_vals, '--', 'LineWidth', 2);

grid on;
xlabel('\beta = E_b/N_0 (dB)');
ylabel('P_e (log scale)');
title('Union Bound vs Simplified Bound for 8-Point Constellation');

legend('Full Union Bound', 'Nearest-Neighbor Approx.');
ylim([1e-6 1e-2]);

%% Question 6 
% Part d 
Rs = 48000; % Hz 
rolloff = 0.2;  
samp_per_sym = 16; 
bandwidth = 28800; % Hz 
dig_samp_rate = Rs * samp_per_sym; 
bps = 2 * Rs;  % QPSK = 2 bits/sym

% Directions say 3 symbols
b = rcosdesign(rolloff, 3, samp_per_sym, "sqrt"); 
b2 = b;  

figure;
stem(b, 'filled');
grid on;
title('Transmit pRC Pulse Shape');
xlabel('Sample index');
ylabel('Amplitude');

% Matched-filter pulse = convolution of b with itself
c = conv(b, b2);
figure;
stem(c, 'filled');
grid on;
title('Pulse Shape at Output of Matched Filter');
xlabel('Sample index');
ylabel('Amplitude');

% Find main peak
[peak_val, n0] = max(abs(c));

ISI_power = 0;
k = 1;

while true
    idx_plus  = n0 + k*samp_per_sym;
    idx_minus = n0 - k*samp_per_sym;

    if idx_plus > length(c) && idx_minus < 1
        break;
    end

    if idx_plus <= length(c)
        ISI_power = ISI_power + c(idx_plus)^2;
    end

    if idx_minus >= 1
        ISI_power = ISI_power + c(idx_minus)^2;
    end

    k = k + 1;
end

signal_power = peak_val^2;

SIR0 = signal_power / ISI_power;
SIR0_dB = 10*log10(SIR0);

fprintf("\n*** Part (e) Results ***\n");
fprintf("Main peak index = %d\n", n0);
fprintf("Signal power = %.6f\n", signal_power);
fprintf("ISI power = %.6f\n", ISI_power);
fprintf("SIR0 = %.3f (linear)\n", SIR0);
fprintf("SIR0 = %.3f dB\n", SIR0_dB);

SNIR_target_dB = SIR0_dB - 5;
SIR0_lin = 10^(SIR0_dB/10);
SNIR_target_lin = 10^(SNIR_target_dB/10);

% 1/SNIR = 1/SIR + 1/SNR  Linear
SNR_lin = 1 / ( (1 / SNIR_target_lin) - (1 / SIR0_lin) );
SNR_dB = 10 * log10(SNR_lin);

fprintf("\n*** Part (f) Results ***\n");
fprintf("Target SNIR = SIR0 - 5 dB = %.3f dB\n", SNIR_target_dB);
fprintf("Required SNR = %.3f dB\n", SNR_dB);



%% Question 7

rng(388);

num_bits = 1e5;
bits = randi([0 1], num_bits, 1);

MSB = bits(1:2:end);
LSB = bits(2:2:end);

I = 1 - 2*MSB;
Q = 1 - 2*LSB;

symbols = (I + 1i*Q) / sqrt(2);

y = upsample(symbols, samp_per_sym);
tx_waveform = conv(y, b);
env_tx = abs(tx_waveform);

figure;
plot(env_tx(1:500));
grid on;
title('Transmit Waveform Envelope (QPSK with pRC)');
xlabel('Sample index');
ylabel('Amplitude');

c = conv(b,b);
[peak_val, n0] = max(abs(c));

signal_power = peak_val^2;
ISI_power = 0;

k = 1;
while true
    idx1 = n0 + k*samp_per_sym;
    idx2 = n0 - k*samp_per_sym;
    if idx1 > length(c) && idx2 < 1
        break;
    end
    if idx1 <= length(c)
        ISI_power = ISI_power + abs(c(idx1))^2;
    end
    if idx2 >= 1
        ISI_power = ISI_power + abs(c(idx2))^2;
    end
    k = k + 1;
end

SIR_linear = signal_power / ISI_power;

fprintf("Average SIR = %.3f (linear)\n", SIR_linear);
fprintf("Average SIR = %.2f dB\n", 10*log10(SIR_linear));

% part b

avg_sample_power = mean(abs(tx_waveform).^2);
SNR_lin = 10^(SNR_dB/10);

noise_var_complex = avg_sample_power / SNR_lin;
sigma = sqrt(noise_var_complex/2);

noise = sigma*(randn(size(tx_waveform)) + 1i*randn(size(tx_waveform)));
tx_noisy = tx_waveform + noise;

mf_clean = conv(tx_waveform, b);
mf_noisy = conv(tx_noisy, b);

figure;
t_idx = 1:min(1000, length(mf_noisy));
plot(abs(mf_noisy(t_idx)));
grid on;
title('Envelope of Matched-Filter Output (noisy)');
xlabel('Sample index');
ylabel('Amplitude');

mf_sample_idx = n0 : samp_per_sym : n0 + (length(symbols)-1)*samp_per_sym;
mf_sample_idx = mf_sample_idx(mf_sample_idx <= length(mf_noisy));
Nsample = length(mf_sample_idx);

sig_samples = mf_clean(mf_sample_idx);
signal_power_mf = mean(abs(sig_samples).^2);

ISI_power_mf = 0;
neighbor_offsets = -8:8;
for ii = 1:Nsample
    center = mf_sample_idx(ii);
    neighbors = center + neighbor_offsets*samp_per_sym;
    neighbors = unique(neighbors);
    neighbors(neighbors==center) = [];
    neighbors = neighbors(neighbors >= 1 & neighbors <= length(mf_clean));
    ISI_power_mf = ISI_power_mf + sum(abs(mf_clean(neighbors)).^2);
end
ISI_power_mf = ISI_power_mf / Nsample;

noise_at_samples = mf_noisy(mf_sample_idx) - mf_clean(mf_sample_idx);
noise_power_mf = mean(abs(noise_at_samples).^2);

SNIR_empirical = signal_power_mf / (ISI_power_mf + noise_power_mf);

fprintf('Matched-filter output (empirical): signal = %.5e, ISI = %.5e, noise = %.5e\n', signal_power_mf, ISI_power_mf, noise_power_mf);
fprintf('Empirical SNIR = %.3f (%.2f dB)\n', SNIR_empirical, 10*log10(SNIR_empirical));

% part c 

mf_samples = mf_noisy(mf_sample_idx);

MSB_hat = double(real(mf_samples) < 0);
LSB_hat = double(imag(mf_samples) < 0);

bits_hat = zeros(2*Nsample,1);
bits_hat(1:2:end) = MSB_hat;
bits_hat(2:2:end) = LSB_hat;

bits_true = bits(1:2*Nsample);

bit_errors = sum(bits_true ~= bits_hat);
BER_empirical = bit_errors / length(bits_true);

sym_hat = (1 - 2*MSB_hat) + 1i*(1 - 2*LSB_hat);
sym_hat = sym_hat / sqrt(2);
sym_true = symbols(1:Nsample);

symbol_errors = sum(abs(sym_hat - sym_true) > 1e-6);
SER_emp = symbol_errors / Nsample;

fprintf('Symbol errors = %d / %d  (SER = %.3e)\n', symbol_errors, Nsample, SER_emp);
fprintf('Bit errors = %d / %d  (BER = %.3e)\n', bit_errors, length(bits_true), BER_empirical);

one_bit_errors = 0;
two_bit_errors = 0;
for k = 1:Nsample
    btrue = bits_true(2*k-1:2*k);
    bhat  = bits_hat(2*k-1:2*k);
    diffs = sum(btrue ~= bhat);
    if diffs == 1
        one_bit_errors = one_bit_errors + 1;
    elseif diffs == 2
        two_bit_errors = two_bit_errors + 1;
    end
end
fprintf('Of the symbol errors: 1-bit errors = %d, 2-bit errors = %d\n', one_bit_errors, two_bit_errors);

figure;
subplot(2,1,1); plot(real(mf_samples(1:200))); grid on; title('Real part of first 200 MF samples');
subplot(2,1,2); plot(imag(mf_samples(1:200))); grid on; title('Imag part of first 200 MF samples');

