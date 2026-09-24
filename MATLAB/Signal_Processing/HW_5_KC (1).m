% SPDX-License-Identifier: GNU AGPL-3.0-or-later
% Plotting, scheming even... 
% Copyright (C) 2025 Kenneth Chan <kenc0728@gmail.com>
% Kenneth Chan

clc; 
clear;
close all; 

% Taken from HW 2
t = linspace(-pi, pi, 1000);
n = 0:50; 
a_n = 2*n + 1; 
s = (sin(a_n' * t) ./ a_n'); % ./ is element-wise division
square_wave = sum(s);

figure; % Makes a figure
hold on; % This allows graphs to overlay (have two functions on one graph)
plot(t, s);
plot(t, square_wave);
title('Fourier Series Square Wave Approximation'); 
xlabel('t'); % x-axis label
xlim([t(1), t(end)]); % x bounds from lowest to highest
xticklabels({'-\pi', '-\pi/2', '0', '\pi/2', '\pi'}); % tick labels on x-axis
xticks([-pi, -pi/2, 0, pi/2, pi]); % Place ticks at these values
ylim([-1,1]); % Limits graph/figure to only show y-values from -1 to 1


% NOTE: subplot (x, y, z): this allows several different graphs to take up
% the screen in different areas 
% x: Number of rows to split the graphs displayed
% y: Number of columns to split the graphs displayed
% z: The position of the active subplot 
% The intention of the following is that so the approximation is on the top
% half of the screen and the components are in the bottom half of the
% screen

figure; 
sgtitle('Fourier Series Square Wave Approximation'); % Places an overall title for the two (now separate) graphs

subplot(2, 1, 1);
plot(t,square_wave); 
title('Approximation of Square Wave'); 
xlabel('t'); % x-axis label
xlim([t(1), t(end)]); % x bounds from lowest to highest
xticklabels({'-\pi', '-\pi/2', '0', '\pi/2', '\pi'});% tick labels on x-axis
xticks([-pi, -pi/2, 0, pi/2, pi]); % Place ticks at these values
ylim([-1,1]); % Limits graph/figure to only show y-values from -1 to 1


subplot(2, 1, 2);
plot(t,s); 
title('Components of Square Wave'); 
xlabel('t'); % x-axis label
xlim([t(1), t(end)]); % x bounds from lowest to highest
xticklabels({'-\pi', '-\pi/2', '0', '\pi/2', '\pi'}); % tick labels on x-axis
xticks([-pi, -pi/2, 0, pi/2, pi]); % Place ticks at these values
ylim([-1,1]); % Limits graph/figure to only show y-values from -1 to 1

% Mesh grid graphing
x = linspace(-2 *pi, 2 *pi, 100);
y = linspace(-2 *pi, 2 *pi, 100);

[X, Y] = meshgrid(x, y);
Z = ((X .* sin(X)) - (Y .*cos(Y))); 

figure;
surf(X, Y, Z); % Plots the function

% publish('myfile.m','pdf')