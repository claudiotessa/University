%% ESERCIZIO 3

fun = @(x) x .* sin(x);
a = -2;
b = 6;
x_dis = a:0.01:b;
f_dis = fun(x_dis);

figure(1);
plot(x_dis, f_dis, "r");

PP_dis = [];
err_dis = [];
err_max = [];

for n = 2:2:6
    x_nod = linspace(a, b, n+1);
    f_nod = fun(x_nod);
    P = polyfit(x_nod, f_nod, n);
    poly_dis = polyval(P, x_dis);
    PP_dis = [PP_dis; poly_dis];
    err_dis = [err_dis; abs(f_dis - poly_dis)];
    err_max = [err_max; norm(f_dis - poly_dis, inf)];
end

figure(2);
plot(x_dis, f_dis, "-r", x_dis, PP_dis, "--");
legend("f(x)", "\Pi_2 f(x)", "\Pi_4 f(x)", "Pi_6 f(x)");

% Errori di interpolazione
figure(3);
plot(x_dis, err_dis, "-");
legend("n = 2", "n = 4", "n = 6");