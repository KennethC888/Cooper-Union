% SPDX-License-Identifier: GNU AGPL-3.0-or-later
% Copyright (C) 2025 Kenneth Chan <kenc0728@gmail.com>
% Kenneth Chan

clc;
clear;
close all;
rng(388); 

% Question 2 a) 
HLap = (1/6) * [1, 4, 1; 4, -20, 4; 1, 4 ,1]; % Note that HLap [0][0] corresponds to the -20

hx = fspecial('sobel');
hy = hx';                  

convHx = conv2(hx, hx, 'full');
convHy = conv2(hy, hy, 'full');

% HLapSob = (hx convolve hx) + (hy convolve hy)
HLapSob = convHx + convHy;

fprintf('HLap\n'); 
disp(HLap); 
fprintf('HLapSob\n')
disp(HLapSob);
% HLapSob results in a 5x5 zero phase FIR filter as the coefficients in the matrix are symmetrical   

% Question 2 b) 
[HLap_f, fx, fy ] = freqz2(HLap);
[HLapSob_f, a, b] = freqz2(HLapSob); % a and b are unimportant 

% Remove imaginary terms
HLap_f = real(HLap_f); 
HLapSob_f = real(HLapSob_f); 

% By showing the max value in matrices HLap_f and HLapSob_f is <=0, we satisfy the
% condition of the problem
maxHLap = max(HLap_f, [], 'all');
maxHLapSob = max(HLapSob_f, [], 'all');

fprintf('Max value of HLap_f = %f\n', maxHLap);
fprintf('Max value of HLapSob_f = %f\n', maxHLapSob);
fprintf('Based on results, both HLap_f and HLapSob_f are real for all frequencies.\n');

% Question 2 part c

% Surface plot for HLap
figure;
surf(fx, fy, HLap_f);
shading interp;
title('Surface Plot of HLap');
xlabel('fx');
ylabel('fy');
zlabel('H');
colormap(jet);

% Surface plot for HLapSob_f
figure;
surf(fx, fy, HLapSob_f);
shading interp;
title('Surface Plot of HLapSob');
xlabel('fx');
ylabel('fy');
zlabel('H');
colormap(jet);

% Contour plot for HLap
figure;
contourf(fx, fy, HLap_f, 20);
title('Contour Plot of HLap');
xlabel('Frequency X');
ylabel('Frequency Y');
colormap(jet);

% Contour plot for HLapSob_f
figure;
contourf(fx, fy, HLapSob_f, 20);
title('Contour Plot of HLapSob');
xlabel('Frequency X');
ylabel('Frequency Y');
colormap(jet);

% Question 2 part d
% Load the images
Lily = load('LilyImg.mat');
Rodan = load('Rodanimg.mat');

% Extract the image matrices 
LilyFields = fieldnames(Lily);       
RodanFields = fieldnames(Rodan);  

LilyImg = Lily.(LilyFields{1}); 
RodanImg = Rodan.(RodanFields{1}); 

% Convert to double for filtering
LilyD = double(LilyImg);
RodanD = double(RodanImg);

% Filter images using HLap and HLapSob
Lily_Lap     = filter2(HLap, LilyD);
Lily_LapSob  = filter2(HLapSob, LilyD);
Rodan_Lap    = filter2(HLap, RodanD);
Rodan_LapSob = filter2(HLapSob, RodanD);

% Original images
figure; 
image(uint8(LilyImg)); 
colormap(gray); 
axis image;
title('Lily – Original');

figure; 
image(uint8(RodanImg)); 
colormap(gray); 
axis image;
title('Rodan – Original');

% Display HLAP filtered images
figure; 
imagesc(Lily_Lap); 
colormap(gray); 
axis image;
title('Lily – Laplacian (HLap)');

figure; 
imagesc(Rodan_Lap); 
colormap(gray); 
axis image;
title('Rodan – Laplacian (HLap)');

% Display HLAPSOB filtered images
figure; 
imagesc(Lily_LapSob); 
colormap(gray); 
axis image;
title('Lily – Laplacian Sobel (HLapSob)');

figure; 
imagesc(Rodan_LapSob);
colormap(gray); 
axis image;
title('Rodan – Laplacian Sobel (HLapSob)');
% Comment: HLap acts like a high pass filter and appears 
% relatively isotropic. 
% HLapSob is also like a high pass filter and is not
% isotrophic at higher frequencies 


% Question 3 part b, part a is on the bottom
% Upsample the images (insert zeros between rows and columns)
Lily_up  = upsample(LilyImg);
Rodan_up = upsample(RodanImg);

% Plot the upsampled images
figure; 
imagesc(Lily_up); 
colormap(gray); 
axis image;
title('Lily – Upsampled Image');

figure; 
imagesc(Rodan_up); 
colormap(gray); 
axis image;
title('Rodan – Upsampled Image');

% Check top-left 10x10 block before and after upsampling
fprintf('\nTop-left 10x10 of original Lily image:\n');
disp(LilyImg(1:10,1:10));

fprintf('Top-left 10x10 of upsampled Lily image:\n');
disp(Lily_up(1:10,1:10));

fprintf('\nTop-left 10x10 of original Rodan image:\n');
disp(RodanImg(1:10,1:10));

fprintf('Top-left 10x10 of upsampled Rodan image:\n');
disp(Rodan_up(1:10,1:10));
% Output is correct because the upsampling was successful,
% there are zeros between the rows and columns of the upper
% 10 x 10 matrices between the non-upsampled and upsampled images

% Question 3 part c

% Original Lily, 2D DFT
Lily_fft = fftshift(abs(fft2(double(LilyImg))));
figure; 
imagesc(log(1 + Lily_fft)); colormap(gray); axis image;
title('Lily – Magnitude Spectrum (Original)');

% Lily upsampled, 2D DFT
Lily_fft_up = fftshift(abs(fft2(double(Lily_up))));
figure;
imagesc(log(1 + Lily_fft_up)); colormap(gray); axis image;
title('Lily – Magnitude Spectrum (Upsampled)');

% Original Rodan, 2D DFT
Rodan_fft = fftshift(abs(fft2(double(RodanImg))));
figure; 
imagesc(log(1 + Rodan_fft)); colormap(gray); axis image;
title('Rodan – Magnitude Spectrum (Original)');

% Rodan upsampled, 2D DFT
Rodan_fft_up = fftshift(abs(fft2(double(Rodan_up))));
figure;
imagesc(log(1 + Rodan_fft_up)); colormap(gray); axis image;
title('Rodan – Magnitude Spectrum (Upsampled)');

% Comment:what we observe in the upsampled spectrum would be
% called IMAGING distortion. (this is due to the insertion of zeros)

% Question 3 part a
function v = upsample(u)
v = zeros(2 * size(u, 1), 2 * size(u, 2)); 
v(1:2:end, 1:2:end) = u;
end
