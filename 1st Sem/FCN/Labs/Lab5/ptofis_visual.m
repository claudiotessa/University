%
% xn = ptofis_visual(a, b, x0, nit, phi)
%
% Fornisce un'interpretazione geometrica delle iterazioni di punto fisso di phi(x)
%
% Parametri di ingresso:
%
% a, b    Estremi dell'intervallo su cui viene visualizzata la funzione, 
%         b deve essere maggiore di a
% x0      Dato iniziale, appartenente ad [a, b]
% nit     Numero di iterazioni
% phi     Funzione di punto fisso
%
% Parametri di uscita:
%
% xn      Ultima iterata
%


function xn = ptofis_visual (a, b, x0, nit, phi, f)

if (a >= b)
    disp('Errore:');
    disp('     b deve essere maggiore di a')
    xn = x0;
    return
elseif ( x0 > b || x0 < a )
    disp('Errore:');
    disp('     x0 deve appartenere ad [a, b]')
    xn = x0;
    return
elseif (nit <= 0)
    disp('Errore:');
    disp('     nit deve essere positivo')
    xn = x0;
    return
end
xs = linspace(a, b, 1000);
y = xs;
if (~exist('f', 'var'))
    f = @(x) 0;
end
ff = xs;
for i=1:length(xs)
    x = xs(i);
    y(i) = phi(x);
    ff(i) = f(x);
end
figure;
plot(xs, xs, 'r', ...
    xs, y, ...
    xs, ff, 'k--', ...
    xs, zeros(size(xs)));
xlabel('x');
ylabel('y');
title('iterazioni di punto fisso, x = phi(x)');
legend('y = x', 'y = phi(x)')
hold on;
x = x0;
yn = phi(x);
plot([x, x], [0, yn], ':', x, 0, 'o','HandleVisibility','off');
xn = x0;
home;
disp ('Premere invio per continuare')
pause
for i=1:nit
    xv = xn;
    yv = yn;
    xn = yv;
    x = yv;
    yn = phi(x);
    if(xn > b)
        n = floor((xn-b)/(b-a)*1000);
        xs = linspace(b, xn, n);
        y = xs;
        for j=1:length(xs)
            x = xs(j);
            y(j) = phi(x);
        end
        plot(xs, xs, 'r', xs, y, xs, zeros(size(xs)),'HandleVisibility','off');
        b = xn;
    elseif (xn < a)
        n = floor((a - xn)/(b-a)*1000);
        xs = linspace(xn, a, n);
        y = xs;
        for j=1:length(xs)
            x = xs(j);
            y(j) = phi(x);
        end
        plot(xs, xs, 'r', xs, y, xs, zeros(size(xs)),'HandleVisibility','off');
        a = xn;
    end
    plot([xv, xn], [yv, yv], ':','HandleVisibility','off');
    pause
    home;
    fprintf ('Iterata corrente: x = %f\n', xn);
    if (yv*yn > 0)
        if(abs(yv) > abs(yn))
            plot([xn, xn], [yv, 0], ':','HandleVisibility','off');
        else
            plot([xn, xn], [yn, 0], ':','HandleVisibility','off');
        end
    else
        plot([xn, xn], [yn, yv], ':','HandleVisibility','off');
    end
    plot(xn, 0, 'go','HandleVisibility','off');
    disp('Premere Invio per continuare');
    pause
end
hold off;
