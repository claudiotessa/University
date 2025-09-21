% ESERCIZIO 2

n = 5;
H = hilb(n);
x_ex = ones(n, 1);
b = H*x_ex;

R = chol(H); % R e' matrice triangolare superiore

y = fwsub(R', b);
x = bksub(R, y);

err_rel = norm(x_ex - x)/norm(x_ex);

[L, U, P] = lu(H);
y = fwsub(L, P*b);
x = bksub(U, y);

err_rel = norm(x - x_ex)/norm(x_ex)
err_nor = norm(b - H*x)/norm(b);
K = cond(H);