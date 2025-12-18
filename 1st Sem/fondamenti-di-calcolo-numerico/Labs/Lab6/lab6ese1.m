%% LABORATORIO 6 - ESERCIZIO 1

fun = @(x) 1 ./ (1 + x.^2);
a = -5;
b = 5;
x_dis = a:0.01:b;
f_dis = fun(x_dis);

% Grado del polinomio interpolante n = 5
n = 5;
x_nod = linspace(a, b, n + 1);
f_nod = fun(x_nod);
P = polyfit(x_nod, f_nod, n);
poly_dis = polyval(P, x_dis);

figure(1);
plot(x_dis, f_dis, "-r", x_dis, poly_dis, "--b");
title("Interpolazione su nodi equispaziati");
legend("f(x)", "\Pi_5 f(x)");
% Errore di interpolazione
err = abs(f_dis - poly_dis);
figure(2);
plot(x_dis, err, "r");
title("Errore di interpolazione n = 5");

% Grado del polinomio interpolante n = 10
n = 10;
x_nod1 = linspace(a, b, n+1);
f_nod1 = fun(x_nod1);
P1 = polyfit(x_nod1, f_nod1, n);
poly_dis1 = polyval(P1, x_dis);

% Confronto
figure(3);
plot(x_dis, f_dis, "-r", x_dis, poly_dis, "--b", ...
    x_dis, poly_dis1, "--m");
legend("f(x)", "\Pi_5 f(x)", "\Pi_{10} f(x)");

err1 = abs(f_dis - poly_dis1);

% Confronto degli errori di interpolazione
figure(4);
plot(x_dis, err, "r", x_dis, err1, "b");
title("Errori di interpolazione per nodi equispaziati");
legend("n = 5", "n = 10");
