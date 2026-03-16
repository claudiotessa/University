%% ESERCIZIO 1

% PUNTO 1) Definisco A
n = 7;
A = diag(9*ones(n, 1)) + ...
    - diag(3*ones(n - 1, 1), -1) + ...
    - diag(3*ones(n - 1, 1), 1) + ...
    + diag(ones(n - 2, 1), -2) + ...
    + diag(ones(n - 2, 1), 2);

% Calcolo elementi non nulli di A
nnz_elem = nnz(A);

% A e' a dominanza diagonale per righe?
if(2*abs(diag(A)) - sum(abs(A), 2) > 0)
    disp("La matrice e' a dominanza diagonale per righe");
end

% A e' simmetrica e definita positiva
if(isequal(A, A'))
    if(min(eig(A)) > 0)
        disp("La matrice e' simmetrica e definita positiva");
    end
end

% PUNTO 2)
D = diag(diag(A));
E = -tril(A, -1);
F = -triu(A, 1);
Bj = inv(D) * (D - A); % oppure D \ (D - A)
Bgs = inv(D - E) * F; % oppure (D - E) \ F
rho_j = max(abs(eig(Bj)));
rho_gs = max(abs(eig(Bgs)));

% Commento: essendo entrambi i raggi spettrali < 1,
% la condizione necessaria e sufficiente per la
% convergenza e' rispettata.
% Il raggio spettrale di GS < J.

% PUNTO 3) Funzioni J/GS

% PUNTO 5)
b = [7 4 5 5 5 4 7]';
x0 = zeros(n, 1);
toll = 1e-6;
nmax = 1000;

[xJ, kJ] = jacobi(A, b, x0, toll, nmax)
[xGS, kGS] = gs(A, b, x0, toll, nmax)

% Commento: GS converge alla soluzione esatta 
% piu' velocemente rispetto a J. Coerrente con quanto 
% ottenuto in termini di raggi spettrali GS < J