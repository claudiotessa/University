%% LABORATORIO 10 - ESERCIZIO 1

% PUNTO a)
f = @(x) x - atan(exp(x)- 1);
x = linspace(-1, 2, 1000);
y = f(x);

figure(1);
plot(x, y, "-b");
grid on;

% PUNTO b)
tol = 1e-6;
nmax = 100;
df = @(x) 1 - exp(x) ./ (1 + (exp(x) - 1).^2);
% Considero la radice alpha > 1
xalpha_0 = 3;
[xvect_alpha, it_alpha] = newton(xalpha_0, nmax, tol, f, df);
% Considero la radice beta = 0
xbeta_0 = 0.2;
[xvect_beta, it_beta] = newton(xbeta_0, nmax, tol, f, df);
% Stima dell'ordine di convergenza del metodo in entrambi i casi
[palpha, calpha] = stimap(xvect_alpha); % ordine 2
[pbeta, cbeta] = stimap(xvect_beta); % ordine 1

% Round-off
df = @(x) 1 - exp(x) .* (1 ./ ( 1 + (exp(x) - 1).^2) );
[xvect_alpha, it_alpha] = newton(xalpha_0, nmax, tol, f, df);
[xvect_beta, it_beta] = newton(xbeta_0, nmax, tol, f, df);
[palpha, calpha] = stimap(xvect_alpha); % ordine 2
[pbeta, cbeta] = stimap(xvect_beta); % ordine 2 ??? Se scelgo toll = 1e-6 
% evito di fare calcoli con quantita' molto piccole, e ottengo 
% ordine 1 per beta = 0
