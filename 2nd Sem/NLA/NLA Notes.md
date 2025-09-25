<center><h1 style="color: var(--text-accent)">NUMERICAL LINEAR ALGEBRA</h1></center>
<center><i>Claudio Tessa - 2025/2026</i></center>

# 1  Introduction

## 1.1  Basic matrix decomposition

### 1.1.1  LU factorization with (partial) pivoting

If $A \in \mathbb{R}^{n\times n}$ is nonsingular (invertible), then
$$
PA = LU
$$
- $P$ is a permutation matrix
- $L$ is unit lower matrix
- $U$ is upper triangular

***Linear system solution***:
$$
A \mathbf{x} = \mathbf{b}
$$
1. Factor $PA = LU$ (expensive, $O(n^{3})$)
2. Solve $L\mathbf{y} = P \mathbf{b}$ (lower triangular system, $O(n^{2})$)
3. Solve $U\mathbf{x} = \mathbf{y}$ (upper triangular system, $O(n^{2})$)

### 1.1.2  Cholesky decomposition

If $A \in \mathbb{R}^{n \times n}$ is symmetric ($A^{T} = A$) and positive definite ($\mathbf{z}^{T}A \mathbf{z} > 0$ for all $\mathbf{z} \neq \mathbf{0}$), then
$$
A = L^{T}L
$$
where $L$ is lower triangular (with positive entries on the diagonal).

***Linear system solution***:
$$A \mathbf{x} = \mathbf{b}$$
1. Factor $A = L^{T} L$ (expensive, $O(N^{3})$)
2. Solve $L^{T}\mathbf{y} = \mathbf{b}$ (lower triangular system, $O(n^{2})$)
3. Solve $L \mathbf{x} = \mathbf{y}$ (upper triangular system, $O(n^{2})$)

### 1.1.3  QR decomposition

If $A \in \mathbb{R}^{n \times n}$ is nonsingular (invertible), then
$$
A = QR
$$
- $Q$ is an orthogonal
- $R$ is upper triangular

***Linear System Solution***:
$$A\mathbf{x} = \mathbf{b}$$
1. Factor $A = QR$ (expensive, $O(n^{3})$)
2. Multiply $\mathbf{c} = Q^{T}\mathbf{b}$ ($O(n^{2})$)
3. Solve $R\mathbf{x} = \mathbf{c}$ (lower triangular system, $O(n^{2})$)

## 1.2  Sparse matrices

A sparse matrix is a matrix in which most elements are zero. Roughly speaking, given $A \in \mathbb{R}^{n\times n}$, the number of non-zero entries of $A$, called $\mathrm{nnz}(A)$, is $O(n)$.

Many matrices arising from real applications are sparse. If we need to store $A$, we can exploit the sparse structure using different **storage schemes**:


| Name             | Easy insertion | Fast $A \mathbf{x}$ |
| ---------------- | -------------- | ------------------- |
| Coordinate (COO) | Yes            | No                  |
| CSR              | No             | Yes                 |

### 1.2.1  Coordinate format (COO)

The data structure consists of three arrays of length $\mathrm{nnz(A)}$:

- `AA`: all the values of the nonzero elements of $A$ *in any order*
- `JR`: integer array containing their row indices
- `JC` integer array containing their column indices

---

***Example***

$$
\begin{matrix}
A = \begin{bmatrix}
1 & 0 & 0 & 2 & 0 \\
3 & 4 & 0 & 5 & 0 \\
6 & 0 & 7 & 8 & 9 \\
0 & 0 & 10 & 11 & 0 \\
0 & 0 & 0 & 0 & 12
\end{bmatrix} 

& & & 

\begin{array}{l}
\texttt{AA} \quad \boxed{\begin{matrix}
12 & 9 & 7 & 5 & 1 & 2 & 11 & 3 & 6 & 4 & 8 & 10
\end{matrix}}  \\

\texttt{JR} \quad \boxed{\begin{matrix}
5 & 3 & 3 & 2 & 1 & 1 & 4 & 2 & 3 & 2 & 3 & 4
\end{matrix}}   \\

\texttt{JC} \quad \boxed{\begin{matrix}
5 & 5 & 3 & 4 & 1 & 4 & 4 & 1 & 1 & 2 & 4 & 3
\end{matrix}}  
\end{array}  

\end{matrix}
$$

---

### 1.2.2  Coordinate Compressed Sparse Row format (CSR)

If the elements of $A$ are listed by row, the array `JC` might be replaced by an array that points to the beginning of each row.

- `AA`: all the values of the nonzero elements of $A$, *stored row by row* from $1, \dots, n$
- `JA`: contains the column indices
- `IA`: contains the pointers to the beginning of each row in the arrays `AA` and `JA`. Thus $IA(i)$ contains the position in the arrays `AA` and `JA` where the $i$-th row starts. The length of `IA` is $n + 1$

---

***Example***

$$
\begin{matrix}
A = \begin{bmatrix}
1 & 0 & 0 & 2 & 0 \\
3 & 4 & 0 & 5 & 0 \\
6 & 0 & 7 & 8 & 9 \\
0 & 0 & 10 & 11 & 0 \\
0 & 0 & 0 & 0 & 12
\end{bmatrix} 

& & & 

\begin{array}{l}
\texttt{AA} \quad \boxed{\begin{matrix}
1 & 2 & 3 & 4 & 5 & 6 & 7 & 8 & 9 & 10 & 11 & 12
\end{matrix}}  \\

\texttt{JA} \quad \boxed{\begin{matrix}
1 & 4 & 1 & 2 & 4 & 1 & 3 & 4 & 5 & 3 & 4 & 5
\end{matrix}}   \\

\texttt{IA} \quad \boxed{\begin{matrix}
1 & 3 & 6 & 10 & 12 & 13
\end{matrix}}  
\end{array}  

\end{matrix}
$$

---

# 2  Iterative methods for large and sparse linear systems

Let's consider the following linear system of equations
$$A \mathbf{x} = \mathbf{b}$$
where:

- $A \in \mathbb{R}^{n \times n}$
- $\mathbf{b} \in \mathbb{R}^{n}$
- $\mathbf{x} \in \mathbb{R}^{n}$
- $\det(A) \neq 0$

In general, direct methods (i.e., methods based on a *manipulation* of $A$) are not suitable whenever $n$ is large, or $A$ is sparse. The average cost of direct methods scales as $n^{3}$. Therefore, we use iterative methods.

We introduce a sequence $\mathbf{x}^{(k)}$ of vectors determined by a recursive relation that identifies the method. In order to initialize the iterative process, it is necessary to provide an initial vector $\mathbf{x}^{(0)}$. 

For the method to make sense, it must satisfy the **convergence property**
$$
\lim_{ k \to +\infty } \mathbf{x}^{(k)} = \mathbf{x} 
$$
Convergence must not depend on the choice of $\mathbf{x}^{(0)}$.

Since the convergence is only guaranteed after an infinite number of iterations, from a practical point of view we will have to stop the iterative process after a finite number of iterations, when we believe we have arrived *sufficiently close* to the solution. For this, we use specific **stopping criteria**.

Note that, even in exact arithmetic, an iterative method will inevitably be affected by a **numerical error**.

## 2.1  The Jacobi method

Starting from the $i$-th line of the linear system:
$$
\sum_{j = 1}^{n} a_{ij} x_{j} = b_{i} \quad \implies \quad a_{i 1} x_{1} + a_{i 2} x_{2} + \dots + a_{i n} x_{n} = b_{i}
$$
Formally, the solution $x_{i}$ for each $i$ is given by
$$
x_{i} = \frac{b_{i} - \sum_{j \neq i} a_{ij} x_{j}}{a_{ii}}
$$
Obviously we cannot use it because we do not know $x_{j}$ for $j \neq i$. We can introduce an iterative method that updates $x_{i}^{(k+1)}$ using the others $x_{j}^{(k)}$ obtained in the previous step $k$
$$
x_{i}^{(k+1)} = \frac{b_{i} - \sum_{j\neq i} a_{ij} x_{j}^{(k)}}{a_{ii}} \qquad \forall i = 1, \dots, n
$$
In general, each iteration costs $\sim n^{2}$ operations, so the Jacobi method is competitive if the number of iterations is less that $n$. If $A$ is a sparse matrix, then the cost is only $\sim n$ per iteration.

It should be noted that the solutions $x_{i}^{(k+1)}$ can be computed fully in parallel, which is very competitive for large scale systems.

## 2.2  The Gauss Seidel method

Let's start from Jacobi's method: $x_{i}^{(k+1)} = \dfrac{b_{i} - \sum_{j \neq i} a_{ij} x_{j}^{(k)}}{a_{ii}}$

At iteration $(k + 1)$, let's consider the computation of $x_{i}^{(k+1)}$. We observe that, for $j < i$ (for $i > 2$), $x_{j}^{(k + 1)}$ is known (we have already calculated it). We can therefore think of using the quantities at step $(k + 1)$ if $j < i$ and (as in the Jacobi method) those at the previous step $k$ if $j > i$.
$$
x_{i}^{(k+1)} = \frac{b_{i} - \sum_{j<i}a_{i j} x_{j}^{(k+1)} - \sum_{j > i}a_{ij} x_{j}^{(k)}}{a_{ii}}
$$
The computational costs are comparable to those of the Jacobi method. However, unlike the Jacobi, GS is not fully parallelizable.

## 2.3  Linear iterative methods

In general, we consider linear iterative methods of the following form:
$$
\mathbf{x}^{(k + 1)} = B \mathbf{x}^{(k)} + \mathbf{f} \qquad k \geq 0
$$
where $B \in \mathbb{R}^{n \times n}$, $\mathbf{f} \in \mathbb{R}^{n}$

$B$ is called iteration matrix. Its choice, together with $\mathbf{f}$, uniquely identify the method. So how to choose $B$ and $\mathbf{f}$?

1. **Consistency** - If $\mathbf{x}^{(k)}$ is the exact solution $\mathbf{x}$, then $\mathbf{x}^{(k+1)}$ is again equal to $\mathbf{x}$ $$\mathbf{x} = B\mathbf{x} + \mathbf{f} \quad \implies \quad \mathbf{f} = (I - B) \mathbf{x} = (I - B)A^{-1} \mathbf{b}$$The former identity gives a relationship between $B$ and $\mathbf{f}$ as a function of the data.
2. **Convergence** - Let's introduce the error at step $(k+1)$: $\mathbf{e}^{(k+1)} = \mathbf{x} - \mathbf{x}^{(k+1)}$ and a suitable vector norm $\lVert \cdot \rVert$ (for example, the Euclidian norm). Then we have:$$ \begin{align} \lVert \mathbf{e}^{(k+1)} \rVert &= \lVert \mathbf{x} - \mathbf{x}^{(k+1)} \rVert = \lVert \mathbf{x} - B \mathbf{x}^{(k)} - \mathbf{f} \rVert   = \qquad \gets \text{consistency} \\[1em] &= \lVert \mathbf{x} - B \mathbf{x}^{(k)} - (I - B)\mathbf{x} \rVert = \lVert B \mathbf{e}^{(k)} \rVert \\[1em] &\leq \lVert B \rVert \lVert \mathbf{e}^{(k)} \rVert \end{align}$$By recursion we obtain $$\begin{align} \lVert  \mathbf{e}^{(k-1)} \rVert &\leq \lVert B \rVert \ \lVert B \rVert \ \lVert e^{(k+1)} \rVert \\[1em] &\leq \lVert B \rVert \ \lVert B \rVert \ \lVert B \rVert  \ \lVert \mathbf{e}^{(k-2)} \rVert \leq \dots \leq \lVert B \rVert ^{k+1} \lVert \mathbf{e}^{(0)} \rVert \end{align}$$ $$\implies \lim_{ k \to \infty } \lVert \mathbf{e}^{(k+1)} \rVert \leq \left(\lim_{ k \to \infty } \lVert B \rVert ^{k+1} \right) \lVert \mathbf{e}^{(0)} \rVert $$If $\displaystyle \lVert B \rVert < 1 \implies \lim_{ k \to \infty } \lVert \mathbf{e}^{(k+1)} \rVert = 0$. Therefore, $\lVert B \rVert < 1$ is a **sufficient condition for convergence**.
   
### 2.3.1  Necessary and sufficient condition for convergence

We define $\rho(B) = \max_{j} \lvert \lambda_{j}(B) \rvert$, where $\lambda_{j}(B)$ are the eigenvalues of $B$. $\rho(B)$ is called **spectral radius** of $B$. Remember that if $B$ is SPD, then $\rho(B) = \lVert B \rVert$.

***Theorem***

A consistent iterative method with iteration matrix $B$ converges **if and only if** $\rho(B) < 1$.

### 2.3.2  Convergence of Jacobi (J) and Gauss-Seidel (GS) methods

Let
$$
A = \begin{bmatrix}
\ddots & & -F \\
& D & \\
-E & & \ddots
\end{bmatrix}
$$

- $D$: diagonal part of $A$
- $-E$: lower triangular part of $A$
- $-F$: upper triangular part of $A$

The Jacobi method can be rewritten as
$$
D \mathbf{x}^{(k+1)} = (E+F)\mathbf{x}^{(k)} + \mathbf{b}
$$
its iteration matrix is given by
$$
B_{J} = D^{-1}(E+F) = F^{-1}(D - A) = I - D^{-1}A
$$

For the Gauss-Seidel method we have
$$
(D - E)\mathbf{x}^{(k+1)} = F \mathbf{x}^{(k)} + \mathbf{b}
$$
The iteration matrix is given by
$$
B_{GS} = (D - E)^{-1}F
$$

Both methods are consistent.

- If $A$ is strictly diagonally dominant by rows/columns, then J and GS converge.
- If $A$ is SPD then the GS method is convergent
- If $A$ is tridiagonal, it can be shown that $\rho^{2}(B_{J}) = \rho(B_{GS})$. Therefore both methods converge or fail to converge at the same time. If they converge, GS is faster than J.

## 2.4  Stopping criteria

A practical test is needed to determine when to stop the iteration. The idea is to terminate the iterations when $\dfrac{\lVert \mathbf{x} - \mathbf{x}^{k} \rVert}{\lVert \mathbf{x}^{k} \rVert} \leq \varepsilon$, where $\varepsilon$ is a user-defined tolerance. Unfortunately, the error is not known. We can use two criterion:

1. **Residual-based stopping criterion**.$$\frac{\lVert \mathbf{x} - \mathbf{x}^{(k)} \rVert }{\lVert \mathbf{x} \rVert } \leq K(A) \frac{\lVert \mathbf{r}^{(k)} \rVert }{\lVert \mathbf{b} \rVert } \quad \implies \quad \boxed{\frac{\left\lVert  \mathbf{r}^{k} \right\rVert }{\lVert \mathbf{b} \rVert } \leq \varepsilon} $$This is a good stopping criterion whenever $K(A)$ is "small".
2. **Distance between consecutive iterates**. Define the relative residual $\boldsymbol{\delta}^{(k)} = \mathbf{x}^{(k+1)} - \mathbf{x}^{(k)}$ $$\boxed{\lVert \boldsymbol{\delta}^{(k)} \rVert \leq \varepsilon} $$It can be shown that the relation between the true error and $\boldsymbol{\delta}^{(k)}$ is$$\lVert \mathbf{e}^{(k)} \rVert \leq \frac{1}{1 - \rho(B)} \lVert \boldsymbol{\delta}^{(k)} \rVert $$This is a good stopping criterion only if $\rho(B) \ll 1$.

## 2.5  The stationary Richardson method

Given $\mathbf{x}^{(0)}$, $\alpha \in \mathbb{R}$:
$$
\mathbf{x}^{(k+1)} = \mathbf{x}^{(k)} + \alpha \underbrace{(\mathbf{b} - A \mathbf{x}^{(k)})}_{\text{residual }\mathbf{r}^{(k)}}
$$
The idea is to update the numerical solution by adding a quantity proportional to the residual (e.g., if the residual is large, the solution at step $k$ should be corrected a lot).

The stationary Richardson method is characterized by
$$
B_{\alpha} = I - \alpha A \qquad \qquad \mathbf{f} = \alpha \mathbf{b}
$$

### 2.5.1  Convergence of the stationary Richardson method

Let $A$ be symmetric and positive definite matrix (*spd*), then the stationary Richardson method is convergent if and only if 
$$
0 < \alpha < \frac{2}{}
$$

