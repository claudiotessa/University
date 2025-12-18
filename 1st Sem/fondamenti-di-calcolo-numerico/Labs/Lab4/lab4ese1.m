%% ESERCIZIO 1
% PUNTO 1) Definisco A e b
n = 7;
A = diag(9*ones(n, 1)) - diag(3*ones(n-1, 1), 1) - ...
    diag(3*ones(n - 1, 1), -1) + diag(ones(n-2, 1), 2) + ...
    diag(ones(n-2, 1), -2);
b = [7 4 5 5 5 4 7]';

% PUNTO 2)
lambda_max = max(eig(A));
lambda_min = min(eig(A));
lim = 2 / lambda_max;
alpha_opt = 2 / (lambda_min + lambda_max);

% PUNTO 3) Richardson

% PUNTO 4) Risolvo Ax = b con Richardson
x0 = zeros(n, 1);
toll = 1e-6;
nmax = 1000;

alpha1 = 2;
[xR1, kR1] = richardson(A, b, x0, alpha1, toll, nmax)
% Essendo alpha1 > lim, 
% come mi aspetto dalla teoria il metodo diverge.

alpha2 = 0.11;
[xR2, kR2] = richardson(A, b, x0, alpha2, toll, nmax)
% Essendo alpha2 < lim, 
% come mi aspetto dalla teoria il metodo converge (45 iter.).

[xR3, kR3] = richardson(A, b, x0, alpha_opt, toll, nmax)
% Per alpha_opt ottengo convergenza in 22 iterazioni 
% (massima velocita' di convergenza).