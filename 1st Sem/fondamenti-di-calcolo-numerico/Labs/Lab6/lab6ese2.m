% ESERCIZIO 2

clear all
close all
clc

%% PUNTO 1

% Dati sperimentali
sigma = [0 0.06 0.14 0.25 0.31 0.47 0.60 0.70];
epsilon = [0 0.08 0.14 0.20 0.23 0.25 0.28 0.29];

figure(1)
axes('FontSize',12)
plot(sigma, epsilon, 'ko', 'linewidth', 2)
title('Dati sperimentali')
xlabel('Sforzo')
ylabel('Deformazione')


% Interpolazione di Lagrange (IL)
sigma_dis  = linspace(min(sigma), max(sigma), 1000);
grado      = length(sigma) - 1;
PL         = polyfit(sigma, epsilon, grado); 
epsilon_IL = polyval(PL, sigma_dis);

figure(2)
axes('FontSize',12)
plot(sigma, epsilon, 'ko', sigma_dis, epsilon_IL, 'r', 'linewidth', 2)
xlabel('Sforzo')
ylabel('Deformazione')
title('Dati sperimentali & Interp. Pol. Lagrange')

% Interpolazione Composita Lineare (ICL)
epsilon_ICL = interp1(sigma, epsilon, sigma_dis);
figure(3);
plot(sigma, epsilon, "ko", sigma_dis, epsilon_ICL, "r");
legend("Dati sperimentali", "Interp. Comp. Lineare");

% Confronto
figure(4);
plot(sigma, epsilon, "ko", sigma_dis, epsilon_IL, "--b", ...
    sigma_dis, epsilon_ICL, "--m");
legend("Dati sperimentali", "Inter. Lagrange", "Int. Comp. Lineare");

sigma_v = [0.40, 0.75];
epsilon_IL_v = polyval(PL, sigma_v);
epsilon_ICL_v = interp1(sigma, epsilon, sigma_v);
fprintf("Sigma: %f %f\n", sigma_v);
fprintf("Epsilon IL: %f %f", epsilon_IL_v);
fprintf("Epsilon ICL: %f %f\n", epsilon_ICL_v);

