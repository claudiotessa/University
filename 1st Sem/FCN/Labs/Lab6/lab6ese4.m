%% ESERCIZIO 4

fun = @(x) 1 ./ (1 + x.^2);
a = -5;
b = 5;
x_dis = a:0.01:b;
f_dis = fun(x_dis);

n = 5;
x_hat = -cos(pi*(0:n)/n); % per l'intervallo [-1, 1]
x_nod = (a + b)/2 + ((b - a)/2)*x_hat;
f_nod = fun(x_nod);
P = polyfit(x_nod, f_nod, n);
poly_dis = polyval(P, x_dis);
figure(1);
plot(x_dis, f_dis, "-r", x_dis, poly_dis, "--b");
legend("f(x)", "\Pi^C_5 f(x)");
err = abs(f_dis - poly_dis);

n = 10;
x_hat1 = -cos(pi*(0:n)/n);
x_nod1 = (a+b)/2 + ((b-a)/2)*x_hat1;
f_nod1 = fun(x_nod1);
P1 = polyfit(x_nod1, f_nod1, n);
poly_dis1 = polyval(P1, x_dis);
err1 = abs(f_dis - poly_dis1);

% Confronto
figure(2);
plot(x_dis, f_dis, "-r", x_dis, poly_dis, "--b", ...
    x_dis, poly_dis1, "--m");
legend("f(x)", "\Pi_5^C f(x)", "\Pi_{10}^C f(x)");

% Errori di interpolazione
figure(3);
plot(x_dis, err, "r", x_dis, err1, "b");
legend("n = 5", "n = 10");