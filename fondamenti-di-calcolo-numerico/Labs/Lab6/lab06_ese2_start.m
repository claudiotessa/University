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

