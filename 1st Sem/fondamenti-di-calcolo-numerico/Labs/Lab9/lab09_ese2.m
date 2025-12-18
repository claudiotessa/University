%% ESERCIZIO 2

y0 = 1;
L = -2'
t0 = 0;
T = 10;
u_ex = @(t) y0*exp(L*t);
t_dis = linspace(t0, T, 1000);
f = @(t, y) L*y;
df = @(t, y) L;
h = 1.1;
[t1, U1] = eulero_avanti(f, t0, T, y0, h);
[t2, U2, it_newt2] = eulero_indietro_newton(f, df, t0, T, y0, h);

figure(1);
plot(t_dis, u_ex(t_dis), "-k", t1, U1, "--r", t2, U2, "--b");
legend("sol analitica", "EA", "EI");