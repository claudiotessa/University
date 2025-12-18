![[Pasted image 20250502224702.png]]

> **Leggi di kirkhoff**
>  1. La somma delle correnti che entrano - somma delle correnti che escono = 0
>  2. La somma delle tensioni in una maglia = 0


# DOMANDA 1

1 - Scrivere le leggi di Kirchhoff alle correnti per ogni nodo della rete
1. $i_{in} - i_{1} - i_{3} = 0$

2 - Scrivere la legge di Ohm per ogni corrente di lato, indicando con $G = R^{−1}$ la conduttanza di lato

> **Legge di Ohm**: $i = \frac{V}{R} = VG$

1. $i_{1} = \frac{V_{1}}{R_{1}} =V_{1}G_{1}$

3 - Scrivere la legge di Kirchhoff alla tensione per la maglia di ingresso costituita dal generatore
di tensione $V_{in}$ e le resistenze $R_{in}$, $R_{2}$ e $R_{4}$

$V_{in}  - V_{2} - V_{4} - V_{0} = 0$

4 - Riportare l’elenco delle incognite del problema e verificare che il numero di equazioni e' uguale al numero di incognite. Motivare la risposta.

# PUNTO 2

$V_{in} = 5V$
$R_{in} = 600 \ohm$
$R_{k} = \dfrac{R_{in}}{k}$

1. $i_{1} = \dfrac{v_{1} - v_{2}}{R_{1}}$
2. $i_{2} = \dfrac{v_{2}-v_{3}}{R_{1}}$
3. $i_{3} = \dfrac{v_{1} - v_{4}}{R_{2}}$
4. 

$$
Y
=
\begin{bmatrix}
\frac{1}{R_{2}}+\frac{1}{R_{1}} & -\frac{1}{R_{1}} & 0 & -\frac{1}{R_{2}} & 0 & 0 \\
-\frac{1}{R_{1}} & \frac{2}{R_{1}} + \frac{1}{R_{2}} & -\frac{1}{R_{1}} & 0 & -\frac{1}{R_{2}} & 0 \\
-y_{31} & -y_{32} & Y_{33}
\end{bmatrix}
\qquad
\mathbf{b} = 
\begin{bmatrix}
\frac{V_{in}}{R_{in}} \\
0 \\
0 \\
0 \\
0 \\
0
\end{bmatrix}
$$
$$
Y\mathbf{v} = \mathbf{b}
$$
