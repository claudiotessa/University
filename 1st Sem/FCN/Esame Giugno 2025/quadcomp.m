function I=quadcomp(a,b,M,f)
%
% I = quadcomp( a, b, M, f )
%
% Formula di integrazione composita: 
% Inputs:
%    a,b: estremi di integrazione,
%    M: numero di sottointervalli (m=1 formula di integrazione semplice)
%    f: funzione
% Output:
%    I: integrale calcolato

H=(b-a)/M;
x=a:H:b; % vettore degli estremi dei sottointervalli

% metodo di Gauss a due nodi
I=0;
for j=1:M
    % i nodi sono le radici del polinomio di Legendre di grado 2
    p_gplus=x(j)+(1+1/sqrt(3))*H/2;
    p_gminus=x(j)+(1-1/sqrt(3))*H/2;
    I=I+H/2*(f(p_gplus)+f(p_gminus));
end