% SPDX-License-Identifier: GNU AGPLv3 or later
%
% Assignment 1: Rolling in the Mud (Solving System of Equations)
% Copyright (C) 2025 Kenneth Chan <kenc0728@gmail.com>

clc; 
clear;

u = [11,13,17]; % Row matrix
v = [-1;-1;-1]; % Column matrix

A = [-u; 2 * u; 7 * u]; 
B = [A.', v]; % A.' is transpose of A

c = exp(i * pi / 4); % exp(A) is e^A 
d = sqrt(1 * i); 
l = floor(nthroot(8.4108e6, 2.1)); % Gets the floor of 2.1th root of 8.4108e6 
k = floor(100 * log(2)) + ceil(exp(7.5858)); 


% Creates a matrix, will solve system of equations when in form of AX = b 

A = [
    1, -11, 3
    1,  1,  0
    2,  5,  1
    ];     

b = [
    -37
    -1
    10
    ];

X = mldivide(A,b); % Left divides a matrix, same thing as X = A \ b
