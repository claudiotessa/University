function I = pmedcomp(a, b, M, f)

% Formula del punto medio composita

% a, b: estremi di integrazione
% M: numero dei sottointervalli
% f: funzione

% I: valore dell'integrale calcolato

h = (b - a) / M; % Ampiezza dei sottointervalli
x = [a + h/2 : h : b - h/2]; % Punti medi dei sottointervalli

I = h * sum(f(x));