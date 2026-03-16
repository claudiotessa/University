function I = simpcomp(a, b, M, f)

% Formula di Simpson composita

h = (b - a) / M; % Ampiezza sottointervalli
xestr = [a : h : b]; % Estremi dei sottointervalli
xmed = [a + h/2 : h : b - h/2]; % Punti medi dei sottointervalli

yestr = f(xestr);
ymed = f(xmed);
I = (h/6) * ( yestr(1) + yestr(end) + 2*sum(yestr(2:end-1)) + 4*sum(ymed));
