%% ESERCIZIO 2

A = [2 -2 0; -1 2 0; 0 -1 3];
b = A * [1 1 1]';

x0 = [0 0 0]';
nmax = 100;
toll = 1e-4;
[xJ, itJ] = jacobi(A, b, x0, toll, nmax);   % 26 iterazioni
[xGS, itGS] = gs(A, b, x0, toll, nmax);     % 14 iterazioni

% A e' una matrice tridiagonale 
% => Jacobi e GS convergono/non-converono entrambi
% se convergono, GS e' piu' veloce di Jacobi