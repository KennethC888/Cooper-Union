% SPDX-License-Identifier: GNU AGPL-3.0-or-later
% Func off
% Copyright (C) 2025 Kenneth Chan <kenc0728@gmail.com>
% Kenneth Chan

ip = @(u,v) sum(u.' * v); 
ip_norm = @(u) sqrt(ip(u,u)); 

% Given matrix
A = [1, 2+3i, -1+7i; 
     1i, 3i, 6+10i; 
     2-1i, 1-1i, 11-4i; 
     -1, 2i, 3+4i];

% Taken from MIT's Gram Schmidt in Matlab
function Q = gram_schmidt(B) % input is a matrix and output is Q 
    [m, n] = size(B); Q = zeros(m, n); 
    for i = 1:n
        v = B(:, i); % Take the i-th column
        for j = 1:i-1
            v = v - (Q(:, j)' * B(:, i)) * Q(:, j); 
        end 
        Q(:, i) = v / norm(v); % Normalize
    end
end

U = gram_schmidt(A); 

function bool = is_orthogonal(u, v, inner_product)

   ip = inner_product(u,v); 

   if (eps(abs(ip)) > 0) 
       bool == false; 
   else
       bool == true; 
   end

end