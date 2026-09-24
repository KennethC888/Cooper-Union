% SPDX-License-Identifier: GNU AGPL-3.0-or-later
% Copyright (C) 2025 Kenneth Chan <kenc0728@gmail.com>
% Kenneth Chan

d_min = 1; 

% N is number of dimensions, M is the number of points, constell is input,
% energy_per_bit_in_DB and spectral_efficiency are outputs

function [energy_per_bit_in_DB, spectral_efficiency] = constellation_calculations(constell)
    [N,M] = size(constell);
    symbol_squared = constell.^2; 
    symbol_energies = sum(symbol_squared, 1);
    
    % Energy per symbol is 1/M times sum of s_m
    % Formulas are from FF slides 
    energy_per_symbol = sum(symbol_energies) / M;
    k = log2(M); 
    energy_per_bit = (1/k) * energy_per_symbol; 

    energy_per_bit_in_DB = 10 * log10(energy_per_bit);
    spectral_efficiency = k / N;
end

% Generating 8-PSK, 16-QAM, 4-Orthog
%8-PSK first
M_PSK = 8; 
N_PSK = 2; 
k_PSK = log2(M_PSK); 

radius = 1 / (2 * sin(pi/M_PSK)); % From problem 3 in the homework, gets radius of the circle as a function of M 
angles_PSK = (0:(M_PSK - 1)) * (2 * pi / M_PSK); 
complex_PSK = radius * exp(1i * angles_PSK); 
Eight_PSK = [real(complex_PSK); imag(complex_PSK)];
[Energy_per_bit_eight_psk_dB, spectral_efficiency_eight_psk] = constellation_calculations(Eight_PSK);

% 16-QAM
M_QAM = 16; 
N_QAM = 2; 
k_QAM = log2(M_QAM); 

spacing = d_min / 2; 
points = [-3*spacing, -spacing, spacing, 3*spacing];
[x, y] = meshgrid(points, points);
QAM_symbols = [x(:)'; y(:)'];
constell_sixteen_QAM = QAM_symbols;

[Energy_per_bit_sixteen_qam_dB, spectral_efficiency_sixteen_qam] = constellation_calculations(constell_sixteen_QAM);

% 4-Ortho
% For orthog, M = N 
M_Ortho = 4; 
N_Ortho = 4; 
k_Ortho = log2(M_Ortho); 

% min dist of <1,0,0,0> and <0,1,0,0> is sqrt(2)
min_dist = sqrt(2); 
scaling = 1 / min_dist; 
constell_ortho = eye(N_Ortho) * scaling; 
[Energy_per_bit_four_ortho_dB, spectral_efficiency_four_ortho] = constellation_calculations(constell_ortho);

% Print on a table 
fprintf('Results of Constellation Calculations \n');

fprintf('%-20s %-20s %-15s\n', 'Constellation', 'Energy per bit (dB)', 'Spectral Efficiency (eta)');
fprintf('--------------------------------------------------\n');
fprintf('%-20s %-20.4f %-15.4f\n', '8-PSK', Energy_per_bit_eight_psk_dB, spectral_efficiency_eight_psk);
fprintf('%-20s %-20.4f %-15.4f\n', '16-QAM', Energy_per_bit_sixteen_qam_dB, spectral_efficiency_sixteen_qam);
fprintf('%-20s %-20.4f %-15.4f\n', '4-Orthogonal', Energy_per_bit_four_ortho_dB, spectral_efficiency_four_ortho);
fprintf('16-QAM is the most spectral efficient while 4-Orthogonal is the most power efficient\n'); 
fprintf('The difference in dB/bit of 16-QAM (least power efficient) and 4-Orthogonal (most power efficient) is 3.9794 dB/bit');





