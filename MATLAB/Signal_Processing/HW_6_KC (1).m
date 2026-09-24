% Four-year transform 
% Kenneth Chan

frequency_sample = 96000; 
num_samples = 192000; 
db2mag = @(dB) 10.^(dB / 20); 

period = 1/frequency_sample; 
t = (0:num_samples - 1) * period;    % Time vector

freq_matrix = [-20.48e3; -360; 996; 19.84e3];
db_matrix = db2mag([14; -10; 0; 2]); 

% DFT
dft = sum(db_matrix .* exp(1j * 2 * pi * freq_matrix .* t)); % Want magnitude, so positive exponential... 
dft = dft + db2mag(-10) + randn(size(dft));  
S = fftshift(fft(dft));

figure; 
plot(frequency_sample / num_samples * (-num_samples / 2:num_samples / 2 - 1), 20 * log10(abs(S))); % Magnitude formula is = 20*log(dB) 
title('DFT'); 
ylabel('Magnitude [dB]');
xlabel('Frequency [Hz]');
xlim([-frequency_sample / 2, frequency_sample / 2]); % The NYquist frequency states that only up to frequency_sample/2  is used

c = 0.53;

n = [0.76 + 0.64j, 0.76 - 0.64j, 0.69 + 0.71j, 0.69 - 0.71j, 0.82 + 0.57j, 0.82 - 0.57j];
d = [0.57 + 1j*0.78, 0.57 - 1j*0.78, 0.85 + 1j*0.48, 0.85 - 1j*0.48, 0.24, 0.64];

numerator_coefficients = poly(n);    % Numerator coefficients
denominator_coefficients = poly(d);  % Denominator coefficients

numerator_coefficients = c * numerator_coefficients; 

figure;
zplane(numerator_coefficients, denominator_coefficients);
title('Pole-Zero Plot');


% Compute and plot frequency response using freqz
% Compute the frequency response
[H, w] = freqz(numerator_coefficients, denominator_coefficients);
H_dB = 20 * log10(abs(H));
H_ph = rad2deg(unwrap(angle(H)));

% Convert angular frequency to physical frequency
frequencies = w / (2 * pi);

% Magnitude response
figure;
sgtitle('Response');

subplot(2,1,1);
plot(frequencies, H_dB);
title('Magnitude Response (dB)');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');

% Phase response
subplot(2,1,2);
plot(frequencies, H_ph);
title('Phase Response');
xlabel('Frequency (Hz)');
ylabel('Phase (degrees)');
