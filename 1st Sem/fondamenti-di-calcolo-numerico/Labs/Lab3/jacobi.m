function [x, k] = jacobi(A, b, x0, toll, nmax)

% Medoto di Jacobi

% A: matrice del sistema Ax = b
% b: termine noto
% x0: guess iniziale
% toll: tolleranza sul residuo normalizzato
% nmax: numero massimo di iterazioni

% x: soluzione ottenuta
% k: numero di iterazioni effettuate

% Verifico compatibilita' delle dimensioni di A, B, x0
n = size(b, 1);
if(size(A, 1) ~= n || size(A, 2) ~= n || size(x0, 1) ~= n)
    error("dimensioni incompatibili");
end

% Verifico A non abbia elemnenti nulli sulla diagonale
if(prod(diag(A)) == 0)
    error("matrice con almeno un elemento nullo sulla diagonale");
end

% Definisco matrice di iterazione Bj e vettore colonna g
D = diag(diag(A));
Bj = D \ (D - A);
g = D \ b;

% Inizializzo x a x0, numero di iterazioni k, 
% definisco residuo e residuo normalizzato
x = x0;
k = 0;
res = b - A*x;
res_nor = norm(res)/norm(b);

while(res_nor > toll && k < nmax)
    k = k+1;
    x = Bj*x + g;
    res = b - A*x;
    res_nor = norm(res)/norm(b);
end
