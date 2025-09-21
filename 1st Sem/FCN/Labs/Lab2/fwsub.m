function x = fwsub(A, b)

% Metodo di sostituzione in avanti per la risoluzione di un
% sistema lineare Ax = b

% A: matrice quadrata triangolare inferiore
% b: termine noto
% x: soluzione

% Verifico che A sia quadrata e con dimensioni coerenti a quelle di b
n = length(b);
if(size(A, 1) ~= n || size(A, 2) ~= n)
    error("Dimensioni incompatibili")
end

% Verifico che A sia triangolare inferiore
if(~isequal(A, tril(A)))
    error("Matrice non triangolare inferiore")
end

% Verifico che la matrice non sia singolare (det != 0)
% Essendo A triangolare, tutti gli elementi sulla diagonale
% principale corrispondono agli autovalori
if(prod(diag(A)) == 0)
    error("Matrice singolare")
end

x = zeros(n, 1);

x(1) = b(1) / A(1, 1);
for i = 2:n
    % * fa il prodotto scalare
    x(i) = (b(i) - A(i, 1:i-1) * x(1:i-1)) / A(i, i);
end