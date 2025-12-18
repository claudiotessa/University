%% LABORATORIO 5 - ESERCIZIO 2

phi1 = @(x) cos(x);
a = 0; b = 1.5;
x0 = 0.3;
nit = 6; % Numero di iterazioni
% xn = ptofis_visual(a, b, x0, nit, phi1);
% Come mi aspetto dalla teoria, il metodo converge 
% al punto fisso

phi2 = @(x) x.^2 + x - 1;
a = -1.3; b = 1.1;
x0 = 0.98;
nit = 30; % Numero di iterazioni
xn = ptofis_visual(a, b, x0, nit, phi2);
% Come mi aspetto dalla teoria, la convergenza del metodo 
% non e' garantita per entrambi i punti. Per x2 = -1 il metodo 
% sembra convergere molto lentamente

phi3 = @(x) x - cos(x);
nmax = 1000;
toll = 1e-6;
x0 = 0.3;
[xvec, it] = ptofis(x0, nmax, toll, phi3);
