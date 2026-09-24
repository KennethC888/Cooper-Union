% SPDX-License-Identifier: GNU AGPL-3.0-or-later
% Copyright (C) 2025 Kenneth Chan <kenc0728@gmail.com>
% Kenneth Chan
clc;
clear;
close all;
rng(388); 
% Note that color_of_ball is 1 for red, 2 for blue
N = 1e5; 

% Vector of cases (b1, r1, b2, r2)
cases = [2 8 2 8;   % Case I
         6 4 2 8;   % Case II
         2 8 6 4;   % Case III
         6 4 6 4];  % Case IV
% Run through each case
for i = 1:size(cases, 1)
    b1 = cases(i, 1);
    r1 = cases(i, 2);
    b2 = cases(i, 3);
    r2 = cases(i, 4);
    fprintf('--- Case %d: (r1=%d, b1=%d), (r2=%d, b2=%d) ---\n', i, r1, b1, r2, b2);
    
    % Run theoretical calculations
    urn_decision_theory(r1, b1, r2, b2);
    
    % Run simulation 
    urn_decision_sim_loop(r1, b1, r2, b2, N);
end


function urn_decision_theory(r1,b1,r2,b2)
    P_Red_URN_I = r1 / (r1 + b1); 
    P_Blue_URN_I = b1/ (r1 + b1); 

    % Likelihoods 
    P_Red_URN_II_given_Red_Urn_I = (r2 + 1) / (r2 + b2 + 1); 
    P_Blue_URN_II_given_Blue_Urn_I = (b2 + 1) / (r2 + b2 + 1); 
    P_Red_URN_II_given_Blue_Urn_I = r2 / (r2 + b2 + 1); 
    P_Blue_URN_II_given_Red_Urn_I = b2 / (r2 + b2 + 1); 

    % Total Probability
    P_Blue_II = (P_Blue_URN_II_given_Red_Urn_I * P_Red_URN_I) + (P_Blue_URN_II_given_Blue_Urn_I * P_Blue_URN_I); 
    P_Red_II = (P_Red_URN_II_given_Red_Urn_I * P_Red_URN_I) + (P_Red_URN_II_given_Blue_Urn_I * P_Blue_URN_I);
    
    % Posterior 
    P_RedI_given_RedII  = (P_Red_URN_II_given_Red_Urn_I  * P_Red_URN_I) / P_Red_II;
    P_BlueI_given_RedII = (P_Red_URN_II_given_Blue_Urn_I * P_Blue_URN_I) / P_Red_II;
    P_RedI_given_BlueII  = (P_Blue_URN_II_given_Red_Urn_I * P_Red_URN_I) / P_Blue_II;
    P_BlueI_given_BlueII = (P_Blue_URN_II_given_Blue_Urn_I * P_Blue_URN_I) / P_Blue_II;
    
    % ML 
    ML_decision_Red_II  = (P_Red_URN_II_given_Red_Urn_I >= P_Red_URN_II_given_Blue_Urn_I) + 1;
    ML_decision_Blue_II = (P_Blue_URN_II_given_Red_Urn_I < P_Blue_URN_II_given_Blue_Urn_I) + 1;
    ML_decision_rule = [ML_decision_Red_II; ML_decision_Blue_II];

    % ML Error
    err_if_RedI_ml  = (ML_decision_rule(1) ~= 1) * P_Red_URN_II_given_Red_Urn_I  + (ML_decision_rule(2) ~= 1) * P_Blue_URN_II_given_Red_Urn_I;
    err_if_BlueI_ml = (ML_decision_rule(1) ~= 2) * P_Red_URN_II_given_Blue_Urn_I + (ML_decision_rule(2) ~= 2) * P_Blue_URN_II_given_Blue_Urn_I;
    Perr_ml = P_Red_URN_I * err_if_RedI_ml + P_Blue_URN_I * err_if_BlueI_ml;

    % MAP
    Map_decision_Red_II  = (P_RedI_given_RedII >= P_BlueI_given_RedII) + 1; % The "+1" is for 1 to be red and 2 to be blue
    Map_decision_Blue_II = (P_RedI_given_BlueII >= P_BlueI_given_BlueII) + 1;
    Map_decision_rule = [Map_decision_Red_II; Map_decision_Blue_II];

    % MAP Error
    err_if_RedI_map  = (Map_decision_rule(1) ~= 1) * P_Red_URN_II_given_Red_Urn_I  + (Map_decision_rule(2) ~= 1) * P_Blue_URN_II_given_Red_Urn_I;
    err_if_BlueI_map = (Map_decision_rule(1) ~= 2) * P_Red_URN_II_given_Blue_Urn_I + (Map_decision_rule(2) ~= 2) * P_Blue_URN_II_given_Blue_Urn_I;
    Perr_map = P_Red_URN_I * err_if_RedI_map + P_Blue_URN_I * err_if_BlueI_map;
    


    % Display results
    fprintf("P(RedI)=%.3f, P(BlueI)=%.3f\n", P_Red_URN_I, P_Blue_URN_I);
    fprintf("Decision rule ML  = [%d (if RedII), %d (if BlueII)]\n", ML_decision_rule);
    fprintf("Decision rule MAP = [%d (if RedII), %d (if BlueII)]\n", Map_decision_rule);
    fprintf("Theoretical Perr ML  = %.4f\n", Perr_ml);
    fprintf("Theoretical Perr MAP = %.4f\n\n", Perr_map);
end

function urn_decision_sim_loop(r1,b1,r2,b2,N)
    errors_ml  = 0;
    errors_map = 0;
    for i = 1:N
        % Draw from Urn I
        color_URN_I = red_or_blue(r1,b1);
        if color_URN_I == 1 % RedI drawn, add 1 red ball to Urn II   
            r2_new = r2 + 1;
            b2_new = b2;
        else % BlueI drawn, add 1 blue ball to Urn II       
            r2_new = r2;
            b2_new = b2 + 1;
        end
        % Take a ball from Urn II
        color_URN_II = red_or_blue(r2_new,b2_new);

        % ML decision
        if color_URN_II==1
            decision_ml = ((r2+1) >= r2) + 1; 
        else
            decision_ml = (b2 >= (b2+1)) + 1;
        end

        % MAP decision
        if color_URN_II==1
            decision_map = (r1*(r2+1) >= b1*r2) + 1;
        else
            decision_map = (r1*b2 >= b1*(b2+1)) + 1;
        end

        % Error Calculation
        errors_ml  = errors_ml  + (decision_ml~=color_URN_I);
        errors_map = errors_map + (decision_map~=color_URN_I);
    end
    fprintf("Actual Perr ML  = %.4f\n", errors_ml/N);
    fprintf("Actual Perr MAP = %.4f\n\n", errors_map/N);
end

function [color_of_ball] = red_or_blue(r,b)
    num_balls = r + b;
    chosen_ball = randi(num_balls); 
    if chosen_ball <= r
        color_of_ball = 1; % red
    else
        color_of_ball = 2; % blue
    end
end

% ML is better than MAP when there is a significant difference between the
% number of blue and red balls in the urns. The smaller the difference
% between the number of red and blue balls in the urn, the more likely MAP
% is better. 