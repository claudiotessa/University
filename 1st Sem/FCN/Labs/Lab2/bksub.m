function x = bksub(A, b)

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
if(~isequal(A, triu(A)))
    error("Matrice non triangolare superiore")
end

% Verifico che la matrice non sia singolare (det != 0)
% Essendo A triangolare, tutti gli elementi sulla diagonale
% principale corrispondono agli autovalori
if(prod(diag(A)) == 0)
    error("Matrice singolare")
end

x = zeros(n, 1);

x(n) = b(n) / A(n, n);
for i = n-1:-1:1
    % * fa il prodotto scalare
    x(i) = (b(i) - A(i, i+1:n) * x(i+1:n)) / A(i, i);
end