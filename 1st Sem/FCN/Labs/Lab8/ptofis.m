function [xvect, it] = ptofis(x0, nmax, toll, phi)
%
% [xvect, it] = ptofis(x0, nmax, toll, phi)
%
% Metodo di punto fisso x = phi(x) 
%
% Parametri di ingresso:
%
% x0      Punto di partenza
% nmax    Numero massimo di iterazioni
% toll    Tolleranza sul test d'arresto
% phi     Funzione di iterazione
%
% Parametri di uscita:
%
% xvect   Vett. contenente tutte le iterate calcolate
%         (l'ultima componente e' la soluzione)
% it      Iterazioni effettuate

incr   = toll + 1;
it    = 0;
xvect = x0;
xv    = x0;

while (it < nmax && incr > toll)
   xn    = phi(xv);
   incr   = abs (xn - xv);
   xvect = [xvect ; xn];
   it    = it + 1;
   xv    = xn;
end

fprintf(' Numero di Iterazioni    : %d \n', it);
fprintf(' Punto fisso calcolato   : %12.13f \n', xvect(end));
return
