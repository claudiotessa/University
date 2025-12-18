% PUNTO 1) Definisco A e b

n = 20;

R = ones(n, 1);
A = -diag(R) + diag(R(1:n-1), -1);
A(1,:) = 1;

b = zeros(n, 1);
b(1) = 2;

% PUNTO 2) Fattorizzazione lu con il comando lu().
% Il comando restituisce una 1a matrice L triangolare inferiore
% una 2a matrice U triangolare superiore
% una 3a matrice P di permutazione

[L, U, P] = lu(A);

% Verifico che non sia effettuato pivoting
if(isequal(P, eye(n)))
    disp("Pivoting non effettuato")
else
    disp("Pivoting effettuato")
end

% PUNTO 3) implementare fwsub e bksub

% PUNTO 4) Fattorizzazione LU e sostituzione avanti/indietro
% Primo step: risolvo Ly = Pb con sostituzione in avanti
y = fwsub(L, P * b);
% Secondo step: risolvo il sistema Ux = y con sostituzione all'indietro
x = bksub(U, y);

% PUNTO 5) Calcolare errore relativo, residuo normalizzato, 
% e numero di condizionamento della matrice

x_ex = (2/n) * ones(n, 1); % soluzione esatta

err_rel = norm(x - x_ex) / norm(x_ex);
res_nor = norm(b - A*x)/norm(b);

K = cond(A);

% PUNTO 6)
N = [10 20 40 80 160]
K = [];
err_rel = [];
res_nor = [];

for n = N
    R = ones(n, 1);
    A = -diag(R) + diag(R(1:n-1), -1);
    A(1, :) = 1;

    b = zeros(n, 1);
    b(1) = 2
    
    [L, U, P] = lu(A);
    y = fwsub(L, P * b);
    x = bksub(U, y);

    x_ex = (2/n) * ones(n, 1);
    err_rel = [err_rel; norm(x - x_ex) / norm(x_ex)];
    res_nor = [res_nor; norm(b - A*x)/norm(b)];
    K = [K; cond(A)];
end

semilogy(N, err_rel, "-s", N, res_nor, "-o", N, K, "-x");
legend("errore rel", "residuo norm", "numero di cond");
xlabel("dimensione n");
ylabel("err, res, cond");
grid on;