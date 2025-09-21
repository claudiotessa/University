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

A sparse matrix is a matrix in which most elements are zero. Roughly speaking, given $A \in \mathbb{R}^{n\times n}$, the number of non-zero entries of $A$ i

