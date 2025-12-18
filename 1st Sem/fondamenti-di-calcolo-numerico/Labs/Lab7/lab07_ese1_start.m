% ESERCIZIO 1

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
   
% Interpolazione composita lineare  (ICL)
epsilon_ICL = interp1(sigma, epsilon, sigma_dis);

figure(3)
axes('FontSize',12)
plot(sigma, epsilon, 'ko', sigma_dis, epsilon_ICL, 'r', 'linewidth', 2)
xlabel('Sforzo')
ylabel('Deformazione')
title('Dati sperimentali & Interp. Comp. Lineare')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  DA COMPLETARE  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Dato P = polyfit(x_d, y_d, n), con n numero naturale:
%   se n = length(x_d)-1 ==> P = Interp. Polinom. di Lagrange
%   se n < length(x_d)-1 ==> P = Appross. Minimi Quadrati
%   se n > length(x_d)-1 ==> Interpolante non unico!

% Interpolazione nel senso dei minimi quadrati di grado 1, 2 e 4 (IMQ)

epsilon_IMQ(1, :) = polyval(polyfit(sigma, epsilon, 1), sigma_dis);
epsilon_IMQ(2, :) = polyval(polyfit(sigma, epsilon, 2), sigma_dis);
epsilon_IMQ(3, :) = polyval(polyfit(sigma, epsilon, 3), sigma_dis);

figure(4)
axes('FontSize',12)
plot(sigma, epsilon, "ko", sigma_dis, epsilon_IMQ, "-");
title("Dati sperimentali & Inter. ai Minimi Quadrati");
xlabel("Sforzo");
ylabel("Deformazione")
legend("Dati sperimentali", "Minimi Quadrati: 1", ...
    "Minimi Quadrati: 2", "Minimi Quadrati: 4");
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% PUNTO 2
figure(5)
axes('FontSize',12)
plot(sigma,     epsilon,          'ko', ... 
     sigma_dis, epsilon_IL,       'g',  ...
     sigma_dis, epsilon_ICL,      'm', ...
     sigma_dis, epsilon_IMQ(3, :), "c", ...                                         % DA COMPLETARE
     'linewidth', 2)

xlabel('Sforzo')
ylabel('Deformazione')
title('Dati sperimentali & Confronti')
legend('Dati Sp.', ... 
       'I. Lagrange', ...
       'I. Composita Lin.', ...
       "Int. ai Minimi Quadrati: 4",  ...                                      % DA COMPLETARE
       'Location', 'southeast')
   
%% PUNTO 3

sigma_v        = [0.4 0.75];
epsilon_IL_v   = polyval(PL, sigma_v);
epsilon_ICL_v  = interp1(sigma, epsilon, sigma_v);
epsilon_IMQ4_v = polyval(polyfit(sigma, epsilon, 4), sigma_v);                             % DA COMPLETARE

% Print
fprintf('Sigma:         %f   %f\n', sigma_v)
fprintf('Epsilon IL:    %f   %f\n', epsilon_IL_v)
fprintf('Epsilon ICL:   %f   %f\n', epsilon_ICL_v)
fprintf('Epsilon IMQ4:   %f   %f\n', epsilon_IMQ4_v)

