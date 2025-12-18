%% ESERCIZIO 4

f = @(x) exp(sin(x)) .* cos(x);
a = 0;
b = pi/2;

M = [1:20];
n = length(M);
IPMC = zeros(1, n);
ISC = zeros(1, n);

for i = 1:n
    IPMC(i) = pmedcomp(a, b, M(i), f);
    ISC(i) = simpcomp(a, b, M(i), f);
end

I_ex = (exp(1) - 1) * ones(1, n);
figure(1);
plot(M, I_ex, "-k", M, IPMC, "r--", M, ISC, "b--");
legend("I ex", "PMC", "SC");

% PUNTO 2
E_PMC = abs(I_ex - IPMC);
E_SC = abs(I_ex - ISC);
h = (b-a)./M;
figure(2);
loglog(h, E_PMC, "r--", h, E_SC, "b--", h, h.^2, "r-", h, h.^4, "b-");
legend("Err PMC", "Err SC", "h^2", "h^4");