%% ESERCIZIO 2

% PUNTO 1)

n = 100;
R1 = ones(n);
R2 = 2 * ones(n);
A = diag(-R2) + diag(R1(1:n-1), -1);
A(1,:) = 1;
nnz_elem = nnz(A);

Bin = [R1, -R2];
d = [-1. 0];
Asp = spdiags(Bin, d, n, n);
Asp(1, :) = 1;

