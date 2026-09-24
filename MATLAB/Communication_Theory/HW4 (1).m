% SPDX-License-Identifier: GNU AGPL-3.0-or-later
% Copyright (C) 2025 Kenneth Chan <kenc0728@gmail.com>
% Kenneth Chan 

clear;
close all;
clc;

% PARAMS
Ac = 2;            
fc = 10;           
fm = 2;           
ka = 2;           
fs = 100;         
N = 2000;          
t = (0:N-1)/fs;    

Am_values = [0.4, 0.45, 0.6];

for k = 1:length(Am_values)
    Am = Am_values(k);

    % Message and AM signal
    m = Am * sin(2*pi*fm*t);
    sigma_part_e = Ac * (1 + ka*m) .* cos(2*pi*fc*t);

    % Envelope
    envelope = Ac * (1 + ka*m);

    % Modulation index, if it is greater than 100%, than it is
    % overmodulated
    mu = ka * Am;

    % Display results
    fprintf('Am = %.2f Modulation index = %.2f%%\n', Am, mu*100);

    
    % Plotting envelope
    figure;
    plot(t(1:fs), sigma_part_e(1:fs), 'b', 'LineWidth', 1.2); hold on;
    plot(t(1:fs), envelope(1:fs), 'r--', 'LineWidth', 1);
    plot(t(1:fs), -envelope(1:fs), 'r--', 'LineWidth', 1);
    title_str = sprintf('AM Signal: Am = %.2f', Am);
    ylim([-5 5]);               
    yticks(-5:0.5:5);           
    title(title_str);
    xlabel('Time (s)');
    ylabel('Amplitude (V)');
    legend('AM signal','Envelope','-Envelope');
    grid on;
end

%% Question 4
sigma_squared = 1; 
sigma = sqrt(sigma_squared); 
N = 1e6; 
% Rayleigh dist 
nI = sqrt(sigma_squared) * randn(N,1);
nQ = sqrt(sigma_squared) * randn(N,1);
R = sqrt(nI.^2 + nQ.^2);  
desired_prob = 1e-3; 

rho = sigma * sqrt(-2 * log(desired_prob));  % from P(R>rho)=exp(-rho^2/(2σ^2))

% PLOTTING TIME
figure;

% Make histogram of simulated data
histogram(R, 100, 'Normalization', 'pdf');   
hold on;                                      

r = 0:0.01:max(R);                            

% Theoretical Rayleigh pdf and plotting it
pdf_theory = (r / sigma_squared) .* exp(-r.^2 / (2 * sigma_squared));
plot(r, pdf_theory, 'r', 'LineWidth', 1.5);  

% Threshold line
xline(rho, 'k', 'LineWidth', 2);        

% Add labels and title
title('PDF of R with threshold');
xlabel('R');
ylabel('p(R)');
legend('Simulated data', 'Theory', 'Threshold');
grid on;

frac_exceed = mean(R > rho);
fprintf('Simulated fraction above rho = %.4e, Theoretical = %.4e\n', frac_exceed, desired_prob);

% part e, decrease sigma squared by 1dB
sigma_squared_part_e = sigma_squared * 10^(-1/10); 
sigma_part_e = sqrt(sigma_squared_part_e); 

% Generate new Rayleigh distributed random variables with decreased sigma
nI_part_e = sqrt(sigma_squared_part_e) * randn(N, 1);
nQ_part_e = sqrt(sigma_squared_part_e) * randn(N, 1);
R_part_e = sqrt(nI_part_e.^2 + nQ_part_e.^2);  

% Make histogram of new simulated data
figure;
histogram(R_part_e, 100, 'Normalization', 'pdf');   
hold on;                                      

% Theoretical Rayleigh pdf for decreased sigma and plotting it
pdf_theory_part_e = (r / sigma_squared_part_e) .* exp(-r.^2 / (2 * sigma_squared_part_e));
plot(r, pdf_theory_part_e, 'r', 'LineWidth', 1.5);  

xline(rho, 'k', 'LineWidth', 2);        
title('PDF of R with decreased sigma threshold');
xlabel('R');
ylabel('p(R)');
legend('Simulated data', 'Theory', 'Threshold');
grid on;

frac_exceed_part_e = mean(R_part_e > rho);
fprintf('Simulated fraction above rho (decreased sigma) = %.4e\n', frac_exceed_part_e);

% part f, increase sigma squared by 1 dB 
sigma_squared_part_f = sigma_squared * 10^(1/10); 
sigma_part_f = sqrt(sigma_squared_part_f); 

nI_part_f = sqrt(sigma_squared_part_f) * randn(N, 1);
nQ_part_f = sqrt(sigma_squared_part_f) * randn(N, 1);
R_part_f = sqrt(nI_part_f.^2 + nQ_part_f.^2);  

% Make histogram of new simulated data for increased sigma
figure;
histogram(R_part_f, 100, 'Normalization', 'pdf');   
hold on;                                      

% Theoretical Rayleigh pdf for increased sigma and plotting it
pdf_theory_part_f = (r / sigma_squared_part_f) .* exp(-r.^2 / (2 * sigma_squared_part_f));
plot(r, pdf_theory_part_f, 'r', 'LineWidth', 1.5);  

xline(rho, 'k', 'LineWidth', 2);        
title('PDF of R with increased sigma threshold');
xlabel('R');
ylabel('p(R)');
legend('Simulated data', 'Theory', 'Threshold');
grid on;

frac_exceed_part_f = mean(R_part_f > rho);
fprintf('Simulated fraction above rho (increased sigma) = %.4e\n', frac_exceed_part_f);

% part g 
% Theoretical probabilities
P_theory_0dB = exp(-rho^2 / (2 * sigma_squared));
P_theory_neg_dB = exp(-rho^2 / (2 * sigma_squared_part_e));
P_theory_one_dB = exp(-rho^2 / (2 * sigma_squared_part_f));
fprintf('At -1 dB: %2.e\n', P_theory_neg_dB); 
fprintf('At 0 dB: %2.e \n', P_theory_0dB);
fprintf('At 1 dB: %2.e \n', P_theory_one_dB); 

fprintf('Ratio of probability -1dB/1dB:%2.e \n', P_theory_neg_dB/P_theory_one_dB); 
% This seems to imply that changing sigma_squared by 1dB 
% changes the probability by 4%. 

% Part h 
desired_prob_2 = 1e-4;
rho_2 = sigma * sqrt(-2 * log(desired_prob_2));

P_low2 = exp(-rho_2^2 / (2 * sigma_squared_part_e));
P_high2 = exp(-rho_2^2 / (2 * sigma_squared_part_f));

fprintf('\nFor probability P = 10^-4:\n');
fprintf('At -1dB: Theoretical = %.4e\n', P_low2);
fprintf('At 0dB:  Theoretical = %.4e\n', desired_prob_2);
fprintf('At 1dB : Theoretical = %.4e\n', P_high2);
fprintf('Ratio between -1dB and +1dB ≈ %.1e\n', P_low2 / P_high2);
% The ratio between -1dB and 1dB for the probability = 10^-4 is
% about 3 times less then the ratio between -1dB and 1dB 
% for the probabilty 10^-3
% The smaller the probability, the smaller the probability found in the
% tail, which will decrease the ratio between -1dB and 1dB 