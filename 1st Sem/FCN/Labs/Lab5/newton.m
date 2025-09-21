function [xvec, it] = newton(x0, nmax, toll, fun, dfun)

% Metodo di newton per la ricerca di radici della funzione fun

% x0: punto di partenza
% nmax: numero massimo di iterazioni
% toll: tolleranza sul test d'arresto
% fun: funzione (function handle)
% dfun: derivata della funzione (function handle)

% xvec: vettore contenente le soluzioni ad ogni iterazione 
%       (l'ultima componente e' la soluzione)
% it: numero di iterazioni effettuate

% Inizializzazione
it = 0;
incr = toll + 1;
xvec = [x0];

while(it < nmax && incr >= toll)
    xv = xvec(end);
    if(dfun(xv) == 0)
        disp("Arresto per annullamento di dfun");
    else
        xn = xv - fun(xv)/dfun(xv);
        incr = abs(xn - xv);
        xvec = [xvec; xn];
        it = it + 1;
    end
end

fprintf("Numero di iterazioni: %d\n", it);
fprintf("Zero calcolato: %12.13f\n", xvec(end));