# Progetto 3 - Domanda 1

**Claudio Tessa**

Sistema di tre equazioni nelle tre incognite $v_{s}, y, x$:

- Legge di Kirchhoff alle tensioni maglia 1, 2, terra: $$v_{s} - x - y = 0$$
- Legge di Kirchhoff alle correnti nodo 1:$$i_{s} - \dfrac{v_{s}}{R} - \dfrac{y}{R} = 0$$
- Legge di Kirchhoff alle correnti nodo 2: $$\frac{y}{R} - i_{sat}\left( \exp\left( \frac{x}{V_{th}} \right)  - 1\right) - \frac{x}{R} = 0$$

**Eliminando le incognite $v_{s}$ e $y$ in funzione di $x$:**

Dall'eq. 1 abbiamo:
$$
v_{s} = x + y
$$
Sostituendo $v_{s}$ in eq. 2:
$$
i_{s} = \frac{x + y}{R} + \frac{y}{R} \implies y = \frac{Ri_{s} - x}{2}
$$
Sostituendo $y$ in eq. 3:
$$
\begin{align}
\frac{Ri_{s} - x}{2R} &= i_{sat}\left( \exp\left( \dfrac{x}{V_{th}} \right) - 1 \right) + \frac{x}{R} \\[1em]
\iff\frac{i_{s}}{2} - \frac{x}{2R} & = i_{sat} \exp\left( \frac{x}{V_{th}} \right) - i_{sat} + \frac{x}{R}\\[1em]
\iff R i_{s} - x &= 2R i_{sat} \exp\left( \frac{x}{V_{_{th}}}\right) - 2R i_{sat} + 2x \\[1em]
\iff 0 &= x + \underbrace{\frac{2}{3} R i_{sat}}_{A} \exp\left( \frac{x}{V_{th}} \right) - \underbrace{\left( \frac{2}{3}R i_{sat} + \frac{1}{3} R i_{s} \right)}_{B}
\end{align}
$$
otteniamo quindi $g(x) = x + A \exp\left( \dfrac{x}{V_{th}} \right) - B = 0$
