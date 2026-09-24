% SPDX-License-Identifier: GNU AGPL-3.0-or-later
%
% Assignment 3 AMONG US and or AMOGUS
% Code inspired by Jacob Koziej 
% Copyright (C) 2025 Kenneth Chan <kenc0728@gmail.com>

% Given 
ITERATIONS = 1e6; 
CREWMATES = 6;    
ROUNDS = 12;  

CREWMATE_SIDES = 4; 
IMPOSTER_ROLLS = 2; 
IMPOSTER_SIDES = 2; 

% Makes a random generator
rng(0x73757300);

crewmates = randi(CREWMATE_SIDES, CREWMATES, ITERATIONS); % randi(A,B,C) does a B x C matrix with elements being random numbers between 1 and A

sus = randi(IMPOSTER_SIDES, IMPOSTER_ROLLS, ITERATIONS); % Makes a matrix with random values for the imposter dies, how many rolls, and iterations
sus = sum(sus); % Sums up the sus of the imposters in the iterations 

targets = randi(CREWMATES, ROUNDS, ITERATIONS); % Creates a target matrix for imposters to attack random crewmates for the rounds, and iterations of the rounds

kills = zeros(size(crewmates)); % Matrix that tracks the dead crewmates 

rows = targets(:); % Places the targets in a row of the matrix 

cols = repmat(1:ITERATIONS, ROUNDS, 1); % Repeats rounds based on iterations (Rounds is a row, iterations is a column) 
cols = cols(:);

ind = sub2ind(size(kills), rows, cols); 
% returns the linear indices corresponding to the row and column subscripts in row and col for the size of kills matrix

kills(ind) = 1; % If a crewmate is dead, then the matrix has a value of 1 in there 

survivors = ~((sus > crewmates) & kills); % Survivors are the ones who did not die and have a greater sus resistance than sus

losses = sum(survivors) <= 1; %1 or fewer survivors is a loss
loss_rate = mean(losses);  % Fraction of iterations resulting in a loss
