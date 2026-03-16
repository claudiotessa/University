function [t_h,U] = eulero_avanti(f,t0,T,y0,h)

% Metodo di Eulero in avanti

% f: funzione ch edescrive il problema di Cauchy, f = f(t,y)
% t0, T: estremi dell'intervallo temporale
% y0: il dato iniziale del problema di Cauchy
% h: ampiezza del passo di discretizzazione temporale

% t_h: vettore degli istanti in cui calcoliamo la soluzione discreta
% U: soluzione discreta calcolata nei nodi temporali t_h

t_h = t0:h:T;
N_istanti = length(t_h);
U = zeros(1,N_istanti);

U(1) = y0;

for i = 2:N_istanti
    u_old = U(i-1);
    t_old = t_h(i-1);
    U(i) = u_old + h * f(t_old,u_old);
end