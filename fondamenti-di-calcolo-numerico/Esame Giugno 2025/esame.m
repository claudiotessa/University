% ES 1

% a)
n = 10;
A = diag(3*ones(n, 1)) + ...
    diag(-2 * ones(n - 1, 1), 1) + ...
    diag(-1*ones(n-1, 1), -1);

x_star = [1:n]';

b = A * x_star;

% b)
[L, U, P] = lu(A);
%figure;
%spy(L);
%figure;
%spy(U);

% c)
y = fwsub(L, P*b);
x = bksub(U, y);

% d)
B = A * A';
[Lb, Ub, Pb] = lu(B);
yb = Lb \ (Pb * b);
xb = Ub \ yb;


% f)
cb = cond(B);

% ES 2

% a)
f = @(x) (x - 2) .* exp(x - 1);
alpha = 2;

% b)
xx = [1:0.01:3];
figure;
plot(xx, f(xx), "-b", [alpha], f(alpha), "or");

% c)
phi = @(x) x - ( (x-2).*exp(x-2) ) ./ (2*exp(1) - 1);
figure;
plot(xx, f(xx), "-b", xx, phi(xx) - xx, "-r");

% d)
phi(alpha)

% e)
x0 = 1.5;
toll = 1e-4;
nmax = 1000;
[xvect, it] = ptofis(x0, nmax, toll, phi);
it
xvect(2)
xvect(3)
abs(xvect(it) - xvect(it - 1))

% f)
[p, c] = stimap(xvect);

dphi = @(x) (exp(x - 2) + (x-2)*exp(x-2)*(2*exp(1) - 1)) / (2*exp(1) - 1)^2;

% ESE 3

% b)
a = 0;
b = 1;
f = @(x) (1 - 2*x) .* exp(-2*x);
If = quadcomp(a, b, 1, f);

% c)
pi = @(x, i) x^i;
E = [];
for i = 0:4
    I = b^(i+1)/(i+1) - a^(i+1)/(i+1);
    Ei = abs( I - quadcomp(a, b, 1, @(x) x^i) );
    E = [E, Ei];
end

% d)
N = [5, 10, 20, 40];
En = [];
for n = N
    In = quadcomp(a, b, n, f);
    En = [En, abs(exp(-2) - In)];
end

% e)
hh = [1/5, 1/10, 1/20, 1/40];
loglog(hh, En, "-b", hh, hh, "-r", hh, hh.^2, "-k" );
legend("En", "h", "h^2");