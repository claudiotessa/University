%% ESERCIZIO 2

% PUNTO 1) Definisco A e b, verifico che A sdp, 
% e calcolo K (senza cond())
n = 50;
A = diag(4*ones(n, 1)) -...
    diag(ones(n - 1, 1), 1) - diag(ones(n-1, 1), -1) -...
    diag(ones(n-2, 1), 2) - diag(ones(n-2, 1), -2);
b = 0.2*ones(n, 1);

if(isequal(A, A'))
    if(min(eig(A)) > 0)
        disp("matrice simmetrica e definita positiva");
    else
        disp("matrice simmetrica ma non definita positiva");
    end
else
    disp("matrice non simmetrica");
end

lambda_max = max(eig(A));
lambda_min = min(eig(A));
K = lambda_max / lambda_min;

% PUNTO 2) Funzione graddyn()

% PUNTO 3)
x0 = zeros(n, 1);
toll = 1e-5;
nmax = 10000;
[xG, iterG, errG] = graddyn(A, b, x0, nmax, toll);

% PUNTO 4) Funzione gradprec()
P = diag(2 * ones(n, 1)) -...
    diag(ones(n - 1, 1), 1) - diag(ones(n - 1, 1), -1);
[xGP, iterGP, errGP] = gradprec(A, b, P, x0, nmax, toll);

% PUNTO 5)
figure
semilogy([0:iterG], errG, '-r', [0:iterGP], errGP, '-b');
axis([0 200 0 4]);
xlabel("numero iterazioni");
ylabel("residuo normalizzato");
legend("gradiente", "gradiente precondizionato");