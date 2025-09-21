function [t_h, U, iter_pf] = eulero_indietro(f, t0, T, y0, h)

% Metodo di Eulero all'indietro

% f: funzione che descrive il problema di Cauchy, f = f(t, y)
% t0, T: estremi dell'intervallo temporale
% y0: dato iniziale del problema di Cauchy
% h: ampiezza del passo di discretizzazione temporale

% t_h: vettore degli istanti in cui calcolo la soluzione discreta
% U: soluzione discreta calcolata nei nodi temporali t_h
% iter_pf: vettore contenente il numero di iterazioni di punto 
%          fisso utilizzate per risolvere l'equazione non lineare 
%          ad ogni istante di tempo

t_h = t0:h:T;
N_istanti = length(t_h);
U = zeros(1, N_istanti);

U(1) = y0;

% Parametri delle iterazioni di punto fisso

nmax = 100;
toll = 1e-5;
iter_pf = zeros(1, N_istanti);

for i = 2:N_istanti
    u_old = U(i - 1);
    t_pf = t_h(i);
    phi = @(u) u_old + h * f(t_pf, u);
    [u_pf, it_pf] = ptofis(u_old, nmax, toll, phi);
    U(i) = u_pf(end);
    iter_pf(i) = it_pf;
end