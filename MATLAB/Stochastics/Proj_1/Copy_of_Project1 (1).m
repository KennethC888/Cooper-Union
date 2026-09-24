% SPDX-License-Identifier: GNU AGPL-3.0-or-later
% Copyright (C) 2025 Kenneth Chan <kenc0728@gmail.com>
% Kenneth Chan

% NOTE: Justification for question 1C, the probabilty is so low that it says it takes 1
% trial to get close to the true value and obtains 0 probability. We know
% it isn't 0, but it would require at least 1e13 iterations (which will
% take forever to run and may not produce an output), but I know that the
% theoretical probiablity would have matched the simulation, same goes for
% 1D. It is extremely difficult to match simulation to theoretical when the
% probabilty of the event occuring is so small to begin with. It works
% pretty well for 1A and 1B, getting "close enough" answers, but for 1C and
% 1D (have low probabilities of happening), it is hard to simulate without
% a large time consumption (and I can't see my results when I run the code,
% or I wait a long time). This same issue occurs when printing the pmf for
% question 2F doing part A and B. So there are some printed probabilities
% of 0, but they are not truly 0, it is just that printing more precise
% values and increasing the number of iterations in the simulation 
% result in nothing being printed (too long). 

% Also for the PMF of troll HP and 

clc;
clear;
close all;
rng(388); 
format long e;
% 
%% QUESTION 1

% Question 1A
% I am ASSUMING that within 0.0001 for 1A, probability is close enough
fprintf('Question 1A \n');
theoretical_1A = (1/6) .^3;
close_enough_1A = 0.0001; 
fprintf('The theoretical probability of rolling an 18 from 3d6 is %f\n',theoretical_1A);

% Simulate 
MAX = 1e8;
num_trials = 0;
count = 0; 

for i = 1: MAX
    numRolls = 3; 
    roll = sum(randi(6,1,3)); % Roll the dice
    if roll == 18
        count = count + 1; 
    end
    empirical_1A = count/i; 
    num_trials = num_trials + 1; 
    if empirical_1A >= theoretical_1A - close_enough_1A && empirical_1A <= theoretical_1A + close_enough_1A
        fprintf('It took %d trials to get "close" enough to the true probability\n', num_trials);
        break; 
    end
end
fprintf('The empirical probability of rolling an 18 from 3d6 is %f\n', empirical_1A);

% Question 1B 
% Theoretical
% Close enough is 0.0001
fprintf('\nQuestion 1B \n')
theoretical_1B = 1 -(1 -(1/6)^3)^3; % Theoretical probability for rolling an 18 from 3d6 using fun method
fprintf('The theoretical probability of rolling an 18 from 3d6 with fun method is %f\n', theoretical_1B);
close_enough_1B = 0.0001;

% Simulate 
MAX = 1e8;
num_trials = 0;
count = 0; 

for i = 1: MAX
    roll = zeros(1,3); 
    for j = 1: 3
        roll(j) = sum(randi(6,1,3));
    end
    if max(roll) == 18
        count = count + 1; 
    end
    empirical_1B = count/i; 
    num_trials = num_trials + 1; 
    if empirical_1B >= theoretical_1B - close_enough_1B && empirical_1B <= theoretical_1B + close_enough_1B
        fprintf('It took %d trials to get "close" enough to the true probability\n', num_trials);
        break; 
    end
end
fprintf('The empirical probability of rolling an 18 from 3d6 with fun method is %f\n', empirical_1B);


% Question 1C 
fprintf('\nQuestion 1C \n')
theoretical_1C = theoretical_1B ^6; % Theoretical probability for PROF FONTAINE
fprintf('The theoretical probability of rolling an 18 from 3d6 with fun method is %.15e\n', theoretical_1C);
close_enough_1C = 1e-10;

% Simulate 
MAX = 1e10;
num_trials = 0;
count = 0; 

for i = 1: MAX
    total = zeros(1,6); 
    for j = 1:6
        rolls = sum(randi(6,3,3), 1); % 3 rolls of 3d6
        total(j) = max(rolls);        % take max = fun method
    end
    if all(total == 18)
        count = count + 1; 
    end
    empirical_1C = count/i; 
    num_trials = num_trials + 1; 
    if empirical_1C >= theoretical_1C - close_enough_1C && empirical_1C <= theoretical_1C + close_enough_1C
        fprintf('It took %d trials to get "close" enough to the true probability\n', num_trials);
        break; 
    end
end
fprintf('The empirical probability of obtaining character FF from 3d6 with fun method is %.15e\n', empirical_1C);


% clear;

% Question 1D 
fprintf('\nQuestion 1D \n');
theoretical_1D = ((81/216)^3-(56/216)^3)^6; % Theoretical probability for Keene
fprintf('The theoretical probability of rolling a 9 from 3d6 with fun method is %.12e\n', theoretical_1D);
close_enough_1D = 1e-8;


% Simulate 
MAX = 1e8;
num_trials = 0;
count = 0; 

for i = 1: MAX
    total = zeros(1,6); 
    for j = 1: 6
        rolls = sum(randi(6,3,3), 1); % 3 rolls of 3d6
        total(j) = max(rolls);        % fun method: max of the three
    end
    if all(total == 9)
        count = count + 1; 
    end
    empirical_1D = count/i; 
    num_trials = num_trials + 1; 
    if empirical_1D >= theoretical_1D - close_enough_1D && empirical_1D <= theoretical_1D + close_enough_1D
        fprintf('It took %d trials to get "close" enough to the true probability\n', num_trials);
        break; 
    end
end
fprintf('The empirical probability of obtaining character Keene from 3d6 with fun method is %.12e\n', empirical_1D);


% Match results disucussion: 


%% Question 2

% Question 2A and 2B
fprintf('\nQuestion 2A and 2B\n');
theoretical_2A = (1+2+3+4)/4; 
fprintf('The theoretical average hit points of a troll is %f\n', theoretical_2A);

% Simulate 
MAX = 1e8; 
count_1 = 0; 
count_2 = 0;
count_3 = 0;
count_4 = 0;
sum = 0;

for i = 1: MAX
    roll = randi([1,4]); % Roll the 1d4 dice
    if roll == 1
        count_1 = count_1 + 1; 
    elseif roll == 2
        count_2 = count_2 + 1; 
    elseif roll == 3
        count_3 = count_3 + 1; 
    elseif roll == 4
        count_4 = count_4 + 1; 
    end

    sum = sum + roll;
    empirical_2A = sum / i; 
end
fprintf('The empirical average hit points of a troll is %f\n', empirical_2A);
fprintf('The theoretical pmf of troll health:\n')
fprintf('P(X=1) = 0.25 \n');
fprintf('P(X=2) = 0.25 \n');
fprintf('P(X=3) = 0.25 \n');
fprintf('P(X=4) = 0.25 \n\n');
fprintf('The empirical pmf of troll health:\n')
fprintf('P(X=1) = %f \n', count_1 / MAX);
fprintf('P(X=2) = %f \n', count_2 / MAX);
fprintf('P(X=3) = %f \n', count_3 / MAX);
fprintf('P(X=4) = %f \n\n', count_4 / MAX);

clear; 

% Question 2A continued
theoretical_2A_fireball = (1+2)/2 + (1+2)/2; 
fprintf('The theoretical average damage of FIREBALL is %f\n', theoretical_2A_fireball);

% Simulate 
MAX = 1e8; 
total = 0;
count2 = 0;
count3 = 0; 
count4 = 0; 

for i = 1: MAX
    roll_2d2 = randi([1,2],1,2); % Roll the 2d2 die also randi([min,max],rows,col)
    sum_of_2d2 = sum(roll_2d2);
    if sum_of_2d2 == 2
        count2 = count2 + 1; 
    elseif sum_of_2d2 == 3 
        count3 = count3 + 1; 
    elseif sum_of_2d2 == 4
        count4 = count4 + 1; 
    end
    total = total + sum_of_2d2;
end
empirical_2A_fireball = total / MAX; 
fprintf('The empirical average damage of FIREBALL is %f\n\n', empirical_2A_fireball);


% Question 2B
fprintf('The theoretical pmf of FIREBALL:\n')
fprintf('P(X=2) = 0.25 \n');
fprintf('P(X=3) = 0.50 \n');
fprintf('P(X=4) = 0.25 \n\n');
fprintf('The empirical pmf of FIREBALL:\n');
% Calculate empirical pmf for FIREBALL
fprintf('P(X=2) = %f \n', count2 / MAX);
fprintf('P(X=3) = %f \n', count3 / MAX);
fprintf('P(X=4) = %f \n', count4 / MAX);

% Simulate 
MAX = 1e8; 
total = 0;

for i = 1: MAX
    roll_2d2 = randi([1,2],1,2); % Roll the 2d2 die also randi([min,max],rows,col)
    sum_of_2d2 = sum(roll_2d2);
    total = total + sum_of_2d2;
end

% Question 2C 
fprintf('\nQuestion 2C \n');
num_trolls = 6;
kill_all = 0; 
% Use Law of total probability: P(all trolls die) = sum from Keene's roll
% from d=2 to d=4 of P(all trolls die| Keene's fireball damage is d) * P(Keene's fireball damage is d)
theoretical_2C = 0.25*(0.5)^6 + 0.5*(0.75)^6 + 0.25*(1)^6;
fprintf('The theoretical probability of all 6 trolls dying is %f\n', theoretical_2C);

MAX = 1e7; 

for i = 1: MAX
    troll_health = randi([1,4],1,6);
    roll_2d2 = randi([1,2],1,2); % Roll the 2d2 die also randi([min,max],rows,col)
    sum_of_2d2 = sum(roll_2d2);
    if sum_of_2d2 >= max(troll_health)
        kill_all = kill_all + 1; 
    end
end
empirical_2C = kill_all / MAX; 
fprintf('The empirical probability of all 6 trolls dying is %f\n', empirical_2C);

% Question 2D 
fprintf('\nQuestion 2D \n');
% Note: If Keene = 2, then troll must be 3 or 4 HP, so probability of survival
% is 1/4 * (1/4+1/4) = 1/8; if Keene = 3, then troll must be 4 HP,
% probability of survival is (1/2) * (1/4) = 1/8, add the two to get the
% denominator, 1/4. 

% If Keene = 2, Get expected value in numerator: 3 (the HP) * 1/4 (troll getting 3 HP) * 1/4 (Keene getting a 2) + 
% 4 (the HP) * 1/4 (probability of troll getting 4 HP) *1/4 (Keene getting 2)
% If Keene = 3, then 4 (the HP) * 1/4 (probability of troll getting 4 HP) * 1/2 (Keene getting 3),
% add the two to get the numerator, 15/16.
theoretical_2D = (15/16) / (1/4); 
fprintf('The theoretical HP of the one surviving troll is %f\n', theoretical_2D);

MAX = 5e6; 
count = 0; % number of times exactly 5 trolls die
surviving_HP_total = 0; % sum of HPs of surviving trolls

for i = 1:MAX
    troll_health = randi([1,4],1,6);       % 6 trolls' HP
    roll_2d2 = randi([1,2],1,2);           % 2d2 FIREBALL
    sum_of_2d2 = sum(roll_2d2);            % total damage
    
    % Count how many trolls die
    num_dead = sum(troll_health <= sum_of_2d2);
    
    if num_dead == 5
        % Find the surviving troll
        surviving_troll = troll_health(troll_health > sum_of_2d2);
        surviving_HP_total = surviving_HP_total + surviving_troll; % add HP
        count = count + 1; % increment counter
    end
end

% Expected HP of the surviving troll
expected_HP = surviving_HP_total / count;
fprintf('Expected HP of the one surviving troll: %f\n', expected_HP);

% Question 2E 
fprintf('\nQuestion 2E \n');
% Expected = Expected(Tuition) + Expected(Denial)
% Note that rolling 11 or higher is a 50% chance. 
% Note that expected value of a 2d6 is (2*((1+2+3+4+5+6/6)) = 7 and expected
% value of 1d4 is (1+2+3+4)/4 = 2.5, note that the hammer relies on the
% sword success, so 1/2 * 1/2
% This is 1/2 * 7 + (1/2 *1/2) * 2.5
% Calculate expected value for Question 2E
theoretical_2E = 0.5 * 7 + 0.25 * 2.5; 
fprintf('Theoretical Expected value of damage is %f\n', theoretical_2E);

MAX = 5e6; 
count = 0; % number of times exactly 5 trolls die
total_damage = 0; 

for i = 1:MAX
    damage = 0; 
    use_sword = randi([1,20]); 
    if use_sword >= 11
        sword_damage = randi([1,6],1,2); 
        total_damage = sum(sword_damage) + total_damage; 
        use_hammer = randi([1,20]); 
        if use_hammer >=11
            hammer_damage = randi([1,4],1,1); 
            total_damage = total_damage + sum(hammer_damage);
        end
    end
end

empirical_2E = total_damage / MAX; 
fprintf('Empirical Expected value of damage is %f\n', empirical_2E);


% QUESTION 2F 
fprintf('\nQUESTION 2F A & B\n');

MAX = 1e8;

fprintf('\nQuestion 2FA (Troll HP)\n');

troll_min = 8;
troll_max = 80;

troll_counts = zeros(1, troll_max);
total_troll_hp = 0;

for i = 1:MAX
    troll_hp = sum(randi([1,10],1,8));   % 8d10
    troll_counts(troll_hp) = troll_counts(troll_hp) + 1;
    total_troll_hp = total_troll_hp + troll_hp;
end

empirical_2FA_troll_hp = total_troll_hp / MAX;
fprintf('Empirical average troll HP is %f\n', empirical_2FA_troll_hp);

fprintf('\nEmpirical PMF of troll HP:\n');
for k = troll_min:troll_max
    fprintf('P(X=%d) = %f\n', k, troll_counts(k) / MAX);
end

fprintf('\nQuestion 2FB (FIREBALL Damage)\n');

fireball_min = 8;
fireball_max = 48;

fireball_counts = zeros(1, fireball_max);
total_fireball_damage = 0;

for i = 1:MAX
    fireball_damage = sum(randi([1,6],1,8)); % 8d6
    fireball_counts(fireball_damage) = fireball_counts(fireball_damage) + 1;
    total_fireball_damage = total_fireball_damage + fireball_damage;
end

empirical_2FB_fireball = total_fireball_damage / MAX;
fprintf('Empirical average FIREBALL damage is %f\n', empirical_2FB_fireball);

fprintf('\nEmpirical PMF of FIREBALL damage:\n');
for k = fireball_min:fireball_max
    fprintf('P(X=%d) = %f\n', k, fireball_counts(k) / MAX);
end

% Question 2F C
fprintf('\nQuestion 2FC \n');

num_trolls = 6;
kill_all = 0;

MAX = 1e8;

for i = 1:MAX
    troll_health = zeros(1,6);
    
    for j = 1:6
        troll_health(j) = sum(randi([1,10],1,8)); % each troll is 8d10
    end
    
    fireball_damage = sum(randi([1,6],1,8)); % FIREBALL is 8d6
    
    if fireball_damage >= max(troll_health)
        kill_all = kill_all + 1;
    end
end

empirical_2FC = kill_all / MAX;
fprintf('Empirical probability all 6 trolls die is %f\n', empirical_2FC);

% Question 2F D
fprintf('\nQuestion 2FD \n');

MAX = 1e8;
count = 0;                 % number of times exactly 5 trolls die
surviving_HP_total = 0;    % sum of HPs of surviving trolls

for i = 1:MAX
    troll_health = zeros(1,6);
    
    for j = 1:6
        troll_health(j) = sum(randi([1,10],1,8)); % 8d10 HP
    end
    
    fireball_damage = sum(randi([1,6],1,8)); % 8d6 FIREBALL
    
    % Count how many trolls die
    num_dead = sum(troll_health <= fireball_damage);
    
    if num_dead == 5
        surviving_troll = troll_health(troll_health > fireball_damage);
        surviving_HP_total = surviving_HP_total + surviving_troll;
        count = count + 1;
    end
end

empirical_2FD = surviving_HP_total / count;
fprintf('Empirical expected HP of the one surviving troll is %f\n', empirical_2FD);
