function I = trapcomp(a, b, M, f)

% Formula dei trapezi composita

h = (b - a) / M; % Ampiezza dei sottointervalli
x = [a: h : b]; % Estremi dei sottointervalli
y = f(x);

I = h * (0.5 * y(1) + 0.5 * y(end) + sum(y(2 : end - 1)));