% SPDX-License-Identifier: GNU AGPL-3.0-or-later
% Copyright (C) 2025 Kenneth Chan <kenc0728@gmail.com>
% Kenneth Chan

clc;
clear;
close all;
rng(388); 

% Given parameters, PART A
Fs = 44100;
bin_spacing = 2; 
bpm = 100; 
tones = [392,440 ,587.33]; 

% Time calculations
quarter_note_in_sec = 60 / bpm; % Duration in seconds
samples_per_note = round(quarter_note_in_sec * Fs);

% pwelch parameters PART B 
N0 = Fs/bin_spacing;     % Hamming window with bin space about 2Hz
nfft = 2^nextpow2(N0);   % DFT size (next power of 2)
win = hamming(N0);       % Hamming window TIME
noverlap_pwelch = floor(N0 * 0.5); % 50% overlap for pwelch

num_blocks = 100;
num_samples = (num_blocks - 1) * (N0 - noverlap_pwelch) + N0;
num_notes = ceil(num_samples/ samples_per_note);

% Generate signal
total_samples = num_notes * samples_per_note;
x = zeros(1, total_samples); %signal vector preallocated with zeros
t_base = (0:samples_per_note-1) / Fs; %time vector for one note

for i = 1:num_notes

    omit_index = randi(3);   % Randomly pick 1, 2, or 3 and omit it

    if omit_index == 1
        tones_to_use = [tones(2), tones(3)];
    elseif omit_index == 2
        tones_to_use = [tones(1), tones(3)];
    else 
        tones_to_use = [tones(1), tones(2)];
    end
    
    % Create the note
    note = sin(2*pi*tones_to_use(1)*t_base) + sin(2*pi*tones_to_use(2)*t_base);
    
    % Add to the signal vector
    start_idx = (i-1)*samples_per_note + 1;
    end_idx = i*samples_per_note;
    x(start_idx:end_idx) = note;
end

% Add Noise 
SNR = 40; % Desired Signal to noise ratio of 40dB
signal_power = var(x);
noise_power = signal_power / 10^(SNR/10); 
noise = sqrt(noise_power) * randn(1, total_samples);
x = x + noise;

% Calculate the Power Spectral Density using pwelch
[pxx, f] = pwelch(x, win, noverlap_pwelch, nfft, Fs);

figure;
subplot(2,1,1);
plot(f, 10*log10(pxx));
grid on;
title('Periodogram of the Synthesized Signal');
xlabel('Frequency (Hz)');
ylabel('Power/Frequency (dB/Hz)');
xlim([0 Fs/2]);

subplot(2,1,2);
plot(f, 10*log10(pxx));
grid on;
title('Zoom-in on Tones (300-600 Hz)');
xlabel('Frequency (Hz)');
ylabel('Power/Frequency (dB/Hz)');
xlim([300 600]);

% Spectrogram parameters
M = round(samples_per_note / 2); % Step size = eighth note
noverlap_spec = N0 - M; % Overlap for spectrogram

figure;
spectrogram(x, win, noverlap_spec, nfft, Fs, 'yaxis');
title('Spectrogram of the Synthesized Signal');
ylim([0.3 0.6]); % Zoom in frequency axis to 300-600 Hz