%% ESERCIZIO 3

% PUNTO 1) Interpolatore di Lagrange con n = 3
f = @(x) atan(x) ./ (7 + sin(7*x));
xdis = linspace(0, pi, 1000);
xL = linspace(0, pi, 4);
yL = f(xL);
PL = polyfit(xL, yL, 3);
ydis = polyval(PL, xdis);
figure(1);
plot(xL, yL, "ko", xdis, ydis, "-r");
title("Interpolatore di Lagrange per n = 3");

% PUNTO 2) Retta di regressione lineare
xMQ = linspace(0, pi, 100);
yMQ = f(xMQ);
PMQ = polyfit(xMQ, yMQ, 1);
ydis = polyval(PMQ, xdis);
figure(2);
plot(xdis, f(xdis), "ko", xdis, ydis, "-r");
title("Retta di regressione lineare");

