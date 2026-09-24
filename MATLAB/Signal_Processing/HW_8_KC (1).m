% SPDX-License-Identifier: GNU AGPL-3.0-or-later
% MUST BE EASY
% Copyright (C) 2025 Kenneth Chan <kenc0728@gmail.com>
% Kenneth Chan

clc;
clear;
close all;

syms A_E I_C I_S q D_n n_i N_B W_B V_BE V_T

% BJT equations
I_S_eq = (A_E * q * D_n * n_i^2) / (N_B * W_B);
I_C_eq = I_S * exp(V_BE / V_T);


z = subs(I_C_eq == I_C, I_S, I_S_eq);
A_E_solution = solve(z, A_E);

disp('A_E in terms of I_C:');
disp(A_E_solution);

% Solve for RC differential equation
syms V_s(t) R C V_c(t)
Voltage = dsolve(V_s(t) == R * C * diff(V_c(t), t) + V_c(t));

mu_o = vpa(sym(4 * 10^-7) * pi, floor(1000 * pi)); 
disp(mu_o); 