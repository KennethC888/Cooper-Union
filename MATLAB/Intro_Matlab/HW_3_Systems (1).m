% SPDX-License-Identifier: GNU AGPLv3 or later
%
% Assignment 3 Systems
% Copyright (C) 2025 Kenneth Chan <kenc0728@gmail.com>

    % Initializing h and x 
    h = [2, 1, 4, 5, 2];
    h_begin = -2; 

    x = [4, 2, 3, 2, 1];
    x_begin = -1;

    % y = h * x (convolution of h and x)
    % y = h * x (convolution of h and x)
    % --- Logic from 'convolve_signals' function is now here ---
    y = conv(h, x); 
    y_begin = x_begin + h_begin; 
    
    
    % Initializing plots x, h, and y
    figure; 

    subplot(3,1,1); 
    stem_plot(x, x_begin);
    title('Stem Plot of x'); 

    subplot(3,1,2); 
    stem_plot(h, h_begin);
    title('Stem Plot of h'); 

    subplot(3,1,3); 
    stem_plot(y, y_begin);
    title('Stem Plot of y'); 

    function stem_plot(input_signal, start_time)
        extend_points = 2; 
        signal_extended = [zeros(1, extend_points), input_signal, zeros(1, extend_points)];
        t = (start_time - extend_points) : (start_time + length(input_signal) - 1 + extend_points); 
        stem(t, signal_extended,"filled","LineWidth", 1.0); 
        xlabel('n');
        ylabel('Amplitude');
    end
    
