%% LABORATORIO 5 - ESERCIZIO 1

% PUNTO 1: Visualizzazione grafica di f
x = linspace(-2, 2, 1001);

fun = @(x) exp(x) - x.^2 - sin(x) - 1;
y = fun(x);

% figure(1);
% plot(x, y, "-b");
% hold on;
% grid on;
% plot(x, zeros(length(x), 1), "-r");
% xlabel("x");
% ylabel("y");
% title("y = f(x)");

% Le due radici di f sono x1 = 0 e x2 =  1.28 circa

% PUNTO 2) Proprieta' di convergenza di Newton
dfun = @(x) exp(x) - 2*x - cos(x);
dy = dfun(x);

% figure(2);
% plot(x, dy, "-b");
% hold on;
% grid on;
% plot(x, zeros(length(x), 1), "-r");
% xlabel("x");
% ylabel("y");
% title("y = dfun(x)");
% x1 = 0 annulla sia fun che dfun, 
% mentre x2 = 1.28 annulla fun ma non dfun.

d2fun = @(x) exp(x) - 2 + sin(x);
d2y = d2fun(x);
% figure(3);
% plot(x, d2y, "-b");
% hold on;
% grid on;
% plot(x, zeros(length(x), 1), "-r");
% xlabel("x");
% ylabel("y");
% title("y = d2fun(x)");
% x1 = 0 ha molteplicita' 2, quindi mi aspetto dalla 
% teoria che Newton converga localmente per x1 con ordine 1.
% x2 = 1.28 circa  e' semplice, quindi il metodo di newton 
% converge localmente per x2 con ordine 2.

% PUNTO 3)
x1 = 0;
x0 = 0.1;
nmax = 1000;
toll = 1e-6;
[xvec, it] = newton(x0, nmax, toll, fun, dfun);
[p, c] = stimap(xvec);
% Come mi aspetto dalla teoria, il metodo converge 
% localmente per x1 = 0 con ordine 1.
errore = abs(xvec - x1);
figure(4);
semilogy([1:it+1], errore, "b*");
xlabel("Iterazioni");
ylabel("Errore");
title("Convergenza lineare per Newton per x1 = 0")

x2 = 1.279701331000996;
x0 = 1.2;
[xvec, it] = newton(x0, nmax, toll, fun, dfun);
[p, c] = stimap(xvec);
% Come mi aspetto dalla teoria, il metodo di Newton 
% converge per x2 con ordine 2.
errore = abs(xvec - x2);
figure(5);
semilogy([1:it+1], errore, "b*");
xlabel("Iterazioni");
ylabel("Errore");
title("Convergenza quadratica per Newton per x2 = 1.279...");