%% 2 Febbraio 2024

% 1.1

n = 6;
A = hilb(n);

[R, flag] = chol(A);
if(flag == 0)
    disp("Simmetrica e definita positiva");
else
    disp("NON simmetrica e definita positiva");
end

determinanti = zeros(1, n);
for i = 1:n
    A_i = A(1:i, 1:i);
    det_i = det(A_i);
    determinanti(i) = det_i;
end
disp(all(determinanti ~= 0));

% 1.2
n = 10
A = hilb(n) + 10 * eye(n);

x = ones(n, 1);
b = A * x;
