%% ESERCIZIO 2

% PUNTO 1)
y_ex = @(t) 2*exp(t) + 2*(t - 1).*exp(2*t);
t0 = 0;
T = 2;
t_plot = t0:0.01:T;
f = @(t, y) y + 2*t.*exp(2*t);
y0 = 0;
h = 0.1;
[EA_t_h, EA_U] = eulero_avanti(f, t0, T, y0, h);
[EI_t_h, EI_U, EI_it_pf] = eulero_indietro(f, t0, T, y0, h);
figure(1);
plot(t_plot, y_ex(t_plot), "-k", ...
    EA_t_h, EA_U, "--r", ...
    EI_t_h, EI_U, "--b");
legend("soluzione analitica", ...
    "sol. EA per h = 0.1", ...
    "sol. EI per h = 0.1");

% PUNTO 2) Verificare ordini di convergenza
H = [0.2, 0.1, 0.05, 0.025, 0.0125];
errore_EA = [];
errore_EI = [];

for h = H
    [EA_t_h, EA_U] = eulero_avanti(f, t0, T, y0, h);
    [EI_t_h, EI_U, EI_it_pf] = eulero_indietro(f, t0, T, y0, h);
    errore_EA = [errore_EA, max(abs(y_ex(EA_t_h) - EA_U))];
    errore_EI = [errore_EI, max(abs(y_ex(EI_t_h) - EI_U))];
end
figure(2);
loglog(H, errore_EA, "-or", ...
    H, errore_EI, "-ob", ...
    H, H, "--k", ...
    H, H.^2, "--m");
legend("errore EA", "errore EI", "ordine 1", "ordine 2");

