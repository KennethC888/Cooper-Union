% SPDX-License-Identifier: GNU AGPL-3.0-or-later
% Copyright (C) 2025 Kenneth Chan <kenc0728@gmail.com>
% Kenneth Chan

clear all;
close all;
clc;

% Initialize all variables 
M = 100; 
K = 20; 
N = 200; 
L = 3; 
PdB = [0; -2; -4]; 
PndB = -10; 

[A, S, B, V, R] = signal_generation(M, N, K, PdB, PndB);


function [A, S, B, V, R] = signal_generation(M, N, K, PdB, PndB)
    L = 3; 
    
    S = zeros(M,L); 
    for i = 1:L
        indices = randperm(M, K);
        S(indices, i) = 1/sqrt(K); 
    end
    
    sigma_squared = 10.^(PdB/10); 
    B = diag(10.^(PdB/20)) * randn(L,N);
    
    % Gaussian Noise Matrix
    V = 10^(PndB/20) * randn(M,N);
    
    % Composite Data Matrix 
    A = (S*B) + (1/sqrt(M))*V; 
    % Correlation Matrix
    R = (A*A')/N; 
end

[U, sval_matrix, V] = svd(A);
sval = diag(sval_matrix); 

% Perform eigendecomposition of R and sort
[eigvec, eigval_matrix] = eig(R);
eigval = diag(eigval_matrix);
[eigval, idx] = sort(eigval, 'descend');
eigvec = eigvec(:,idx);

figure;
subplot(2,1,1);
stem(sval, 'filled', 'LineWidth', 1.5);
title('Singular Values of A');
xlabel('Index'); ylabel('Value');
grid on;

subplot(2,1,2);
stem(eigval, 'filled', 'LineWidth', 1.5);
title('Sorted Eigenvalues of R');
xlabel('Index'); ylabel('Value');
grid on;

ratio_sval = sval(3)/sval(4);
ratio_eigval = eigval(3)/eigval(4);
fprintf('3rd/4th singular value ratio: %.4f\n', ratio_sval);
fprintf('3rd/4th eigenvalue ratio: %.4f\n', ratio_eigval);

UL = U(:,1:3);
PN = eye(M) - UL*UL'; % eye is I matrix
R_inv = inv(R);

fprintf('\nSMUSIC and SMVDR for True Sources\n');
for i = 1:3
    s_true = S(:, i);           
    SMUSIC_true = 1 / (s_true' * PN * s_true);
    SMVDR_true = 1 / (s_true' * R_inv * s_true);
    fprintf('Source %d (%.0f dB): SMUSIC = %.2e, SMVDR = %.2e\n', ...
            i, PdB(i), SMUSIC_true, SMVDR_true);
end

test_vectors = 20;
SMUSIC_test = zeros(test_vectors, 1);
SMVDR_test = zeros(test_vectors, 1);

fprintf('\nSMUSIC and SMVDR for Random Vectors\n');
for i = 1:test_vectors
    s_test = zeros(M, 1);
    s_test(randperm(M, K)) = 1/sqrt(K); 
    SMUSIC_test(i) = 1 / (s_test' * PN * s_test);
    SMVDR_test(i) = 1 / (s_test' * R_inv * s_test);
end


fprintf('SMUSIC (random): Max = %.2e, Mean = %.2e, Median = %.2e\n', ...
        max(SMUSIC_test), mean(SMUSIC_test), median(SMUSIC_test));
fprintf('SMVDR (random):  Max = %.2e, Mean = %.2e, Median = %.2e\n', ...
        max(SMVDR_test), mean(SMVDR_test), median(SMVDR_test));

% Average
SMUSIC_ratio = mean([1/(S(:,1)'*PN*S(:,1)), ...  
                 1/(S(:,2)'*PN*S(:,2)), ...
                 1/(S(:,3)'*PN*S(:,3))]) / mean(SMUSIC_test);

SMVDR_ratio = mean([1/(S(:,1)'*R_inv*S(:,1)), ... % Avg of true sources
                1/(S(:,2)'*R_inv*S(:,2)), ...
                1/(S(:,3)'*R_inv*S(:,3))]) / mean(SMVDR_test);

fprintf('\nPerformance Comparison\n');
fprintf('SMUSIC (True/Random ratio): %.2f\n', SMUSIC_ratio);
fprintf('SMVDR (True/Random ratio):  %.2f\n', SMVDR_ratio);

if SMUSIC_ratio > SMVDR_ratio
    fprintf('\nMUSIC performs better at identifying true sources.\n');
else
    fprintf('\nMVDR performs better at identifying true sources.\n');
end

% TRY AGAIN
N = 50;
[A, S, B, V, R] = signal_generation(M, N, K, PdB, PndB);

[U, sval_matrix, V] = svd(A);
sval = diag(sval_matrix);


figure;
stem(sval, 'filled', 'LineWidth', 1.5);
title('Singular Values of A (N = 50)');
xlabel('Index'); ylabel('Value');
grid on;


ratio_sval = sval(3)/sval(4);
fprintf('3rd/4th singular value ratio: %.4f\n', ratio_sval);


UL = U(:,1:3);  
PN = eye(M) - UL*UL';  


fprintf('\nMUSIC Spectrum for True Sources (N = 50)\n');
for i = 1:3
    s_true = S(:, i);
    SMUSIC_true = 1 / (s_true' * PN * s_true);
    fprintf('Source %d (%.0f dB): MUSIC = %.2e\n', i, PdB(i), SMUSIC_true);
end


test_vectors = 20;
SMUSIC_test = zeros(test_vectors, 1);
for i = 1:test_vectors
    s_test = zeros(M, 1);
    s_test(randperm(M, K)) = 1/sqrt(K);
    SMUSIC_test(i) = 1 / (s_test' * PN * s_test);
end

fprintf('\nMUSIC (random): Max = %.2e, Mean = %.2e, Median = %.2e\n', ...
        max(SMUSIC_test), mean(SMUSIC_test), median(SMUSIC_test));


MUSIC_ratio = mean([1/(S(:,1)'*PN*S(:,1)), ...
                    1/(S(:,2)'*PN*S(:,2)), ...
                    1/(S(:,3)'*PN*S(:,3))]) / mean(SMUSIC_test);
fprintf('\nMUSIC (True/Random ratio): %.2f\n', MUSIC_ratio);
fprintf('MUSIC algorithm still works, but the performance is quite noticeably worse\n');


% ONE LAST THING

S_new = S'*S; 
disp(S_new); 
fprintf('This results in a 3x3 matrix which is the inner products of all source vectors'); 