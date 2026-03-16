function [t_h, U, iter_nwt] = eulero_indietro_newton(f, df, t0, T, y0, h);

% Metodo di eulero all'indietro

% f: funzione che descrive il problema di Cauchy, f = f(t, y)
% df: derivata della funzione f
% t0, T: estremi dell'intervallo temporale
% y0: dato iniziale del problema di Cauchy

% t_h: vettore degli istanti in cui calcolo la soluzione discreta
% U: soluzione discreta calcolata nei nodi temporali t_h
% iter_nwt: vettore contenente il numero di iterazioni di Newton 
%           per risolvere l'equazione non lineare ad ogni 
%           istante temporale

t_h = t0:h:T;
N_istanti = length(t_h);
U = zeros(1, N_istanti);

U(1) = y0;

% Parametri del metodo di newton
nmax = 100;
toll = 1e-6;
iter_nwt = zeros(1, N_istanti);

for i = 2:N_istanti
    u_old = U(i - 1);
    t_nwt = t_h(i);

    phi = @(u) u - u_old - h * f(t_nwt, u);
    dphi = @(u) 1 - h * df(t_nwt, u);
    [u_nwt, it_nwt] = newton(u_old, nmax, toll, phi, dphi);
    U(i) = u_nwt(end);
    iter_nwt(i) = it_nwt;
end