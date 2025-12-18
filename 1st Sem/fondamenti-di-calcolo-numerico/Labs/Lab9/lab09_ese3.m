%% ESERCIZIO 3

% PUNTO 1
u_ex = @(t) 10*exp(-3*t + 1./(2*t + 1));
t = 0;
T = 10;
t_dis = linspace(t0, T, 1000);
figure(1);
plot(t_dis, u_ex(t_dis));
title("sol analitica");

% PUNTO 2)
f = @(t, y) -y*(3 + 2./(2*t + 1).^2);
h = 1;
y0 = 10*exp(1);
[t_h, U] = eulero_avanti(f, t0, T, y0, h);
U(5)
U(9)
figure(2);
plot(t_dis, u_ex(t_dis), "-k", t_h, U, "--r");
legend("sol analitica", "EA per h = 1");

% PUNTO 3)
H = [0.1, 0.05, 0.025, 0.0125];
Err = [];

for h = H
    [t_h, U] = eulero_avanti(f, t0, T, y0, h);
    Err = [Err, max(abs(u_ex(t_h) - U))];
end
loglog(H, Err, "ro-", H, H, "--k", H, H.^2, "--b");
legend("Err EA", "h", "h^2");
