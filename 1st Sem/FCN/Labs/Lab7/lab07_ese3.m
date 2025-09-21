%% ESERCIZIO 3

% PUNTO 1
f = @(x) x .* sin(x) ./ (2 * pi);
a = 0;
b = 2 * pi;
x_plot = a:0.01:b;
y_plot = f(x_plot);
figure(1);
plot(x_plot, y_plot);

% PUNTO 2: vedi funzioni

% PUNTO 3
M = [1:20];
n = length(M);
IPMC = zeros(1, n);
ITC = zeros(1, n);
ISC = zeros(1, n);

for i = 1: n
    IPMC(i) = pmedcomp(a, b, M(i), f);
    ITC(i) = trapcomp(a, b, M(i), f);
    ISC(i) = simpcomp(a, b, M(i), f);
end

I_ex = -ones(1, n);
figure(2);
plot(M, I_ex, "-k", M, IPMC, "r--", M, ITC, "b--", M, ISC, "m--");
legend("I ex", "PMC", "TC", "SC");

% PUNTO 4
E_PMC = abs(I_ex - IPMC);
E_TC = abs( I_ex - ITC);
E_SC = abs(I_ex - ISC);
h = (a - b) ./ M;
figure(3);
loglog(h, E_PMC, "r--", h, E_TC, "b--", h, E_SC, "k--", ...
    h, h.^2, "-r", h, h.^4, "-b");
legend("Err PMC", "Err TC", "Err SC", "h^2", "h^4");

% PUNTO 5
d2f = @(x) ( 1/(2*pi) * (2*cos(x) - x.*sin(x)) );
d4f = @(x) ( 1/(2*pi) * (-4*cos(x) + x.*sin(x)) );

d2f_max = max(abs(d2f(x_plot))); % K2
d4f_max = max(abs(d4f(x_plot))); % K4
toll = 1e-5;
M_PMC = sqrt( (b-a)^3 * d2f_max / (24*toll) );
M_TC = sqrt( (b-a)^3 * d2f_max / (12*toll) );
M_SC = ( (b-a)^5 * d4f_max / (2880*toll) )^(1/4);

M_PMCi = ceil(M_PMC)
M_TCi = ceil(M_TC)
M_SC = ceil(M_SC)