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