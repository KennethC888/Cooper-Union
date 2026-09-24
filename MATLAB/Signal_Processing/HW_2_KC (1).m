% SPDX-License-Identifier: GNU AGPLv3 or later
%
% Assignment 2: "A New Way of Thinking" (Using matrix functions in MatLab)
% Copyright (C) 2025 Kenneth Chan <kenc0728@gmail.com>


u = -4:2:4;  % Start, Step, End
v = pi/4:pi/4:pi;

x = 1:10; 
p = prod(x,"all"); % Computes 10! by having a vector array x with values 1 through 10 and multiplying all values in the array

a = zeros(2,4); 
a(1,1) = 1; 
a(2,3) = 1; 

y = reshape(1:16, 2, []); % Reshapes into 2 rows and 8 columns of numbers 1 through 16
z = y.'; % Transpose
B = reshape(z,4,[]); % Put it back into a 4 row (and consequently, 4 columns) matrix

t = linspace(-pi, pi, 1000);
n = 0:50; % A 1 x 50 array is made
a_n = 2*n + 1; 
% Note that transposes are used for proper matrix multiplication
% summation of sin(a_n *t / a_n)
s = sum(sin(a_n' * t) ./ a_n'); % ./ is element-wise division
plot(t, s);


