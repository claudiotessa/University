function [x, iter, err] = graddyn(A, b, x0, nmax, toll)

% Metodo del gradiente
% A: matrice del sistema lineare Ax = b
% b: termine noto
% x0: guess iniziale
% nmax: numero massimo di iterazioni
% toll: tolleranza sul residuo normalizzato

% x: soluzione ottenuta
% iter: numero di iterazioni effettuate
% err: vettore che contiene residuo normalizzato ad ogni iterazione

% Verifico A quadrata
[n, m] = size(A);
if(n ~= m)
    error("Matrice non quadrata");
end

% Inizializzo x a x0, numero iterazioni, 
% definisco il residuo e residuo normalizzato
x = x0;
iter = 0;
r = b - A * x;
err_k = norm(r) / norm(b);
err = err_k;

while(err_k > toll && iter < nmax)
    iter = iter + 1;
    alpha = (r' * r) / (r' * A * r);
    x = x + alpha*r;
    r = (eye(n) - alpha * A) * r;
    err_k = norm(r) / norm(b);
    err = [err err_k];
end

if(iter == nmax)
    fprintf("Il metodo non converge in %d operazioni\n", iter);
end