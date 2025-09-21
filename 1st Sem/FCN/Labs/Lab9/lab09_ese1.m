%% LABORATORIO 9 - ESERCIZIO 1

% PUNTO 1)
t0 = 0;
T = 6;
u_ex = @(t) 0.5 * asin((exp(4*t) - 1) ./ (exp(4*t) + 1));
t_dis = linspace(t0, T, 1000);
figure(1);
plot(t_dis, u_ex(t_dis));
title("Soluzione analitica");

% PUNTO 2) Vedi funzioni

% PUNTO 3)
f = @(t, y) cos(2*y);
df = @(t, y) -2*sin(2*y);
h = 0.5;
y0 = 0;
[t1, U1] = eulero_avanti(f, t0, T, y0, h);
[t2, U2, it_newt2] = eulero_indietro_newton(f, df, t0, T, y0, h);
[t3, U3, it_newt3] = crank_nicolson(f, df, t0, T, y0, h);
figure(2);
plot(t_dis, u_ex(t_dis), "-k", ...
    t1, U1, "--r", ...
    t2, U2, "--b", ...
    t3, U3, "--m");
legend("sol. analitica", "EA per h = 0.5", ...
    "EI per h = 0.5", "CN per h = 0.5");

% PUNTI 4 e 5)
H = [0.4, 0.2, 0.1, 0.05, 0.025, 0.0125];
E1 = [];
E2 = [];
E3 = [];

for h = H
    [t1, U1] = eulero_avanti(f, t0, T, y0, h);
    [t2, U2, it_newt2] = eulero_indietro_newton(f, df, t0, T, y0, h);
    [t3, U3, it_newt3] = crank_nicolson(f, df, t0, T, y0, h);

    E1 = [E1, max(abs(u_ex(t1) - U1))];
    E2 = [E2, max(abs(u_ex(t2) - U2))];
    E3 = [E3, max(abs(u_ex(t3) - U3))];
end

figure(3);
loglog(H, E1, "ro-", H, E2, "bo-", H, E3, "go-", ...
    H, H, "--k", H, H.^2, "--m");
legend("err EA", "err EI", "err CN", "h", "h^2");