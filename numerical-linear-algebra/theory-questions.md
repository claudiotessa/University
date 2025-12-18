# Theoretical questions from previous exams

## 08/11/2025

Consider the linear system $A \mathbf x = \mathbf b$, where $A \in \mathbb R^{n \times n}$ is an invertible matrix:

1. Describe the gradient method for the numerical solution of the above linear system. Describe the applicability conditions, the algorithm and the interpretation of the scheme as a minimization problem. **Define the notation employed**.

2. State the main theoretical result for the Gradient Method. **Define the notation employed**.

3. Describe the Conjugate Gradient (CG) method. Recall the interpretation of the scheme as a Krylov subspace method and state the main theoretical result. **Define the notation employed**.

4. Comment on the main differences between the Gradient and the Conjugate Gradient methods.

5. Describe the main changes you have to introduce if you want to use the preconditioned Gradient and Conjugate Gradient methods and state the main conditions the preconditioner $P$ has to satisfy. **Introduce the notation employed**

---

Consider the rectangular linear system $A \mathbf x = \mathbf b$, where $A \in \mathbb R^{m \times n}, m \geq n$:

1. Provide the definition of the solution in the least-square sense and state under which condition the problem is well posed. **Introduce the notattion employed**.

2. Describe the QR factorization of the matrix $A$ and discuss how it can be employed to solve the above linear system in the least square sense. **Introduce all the notation employed**.

3. Define the SVD factorization of $A$. **Introduce the notation employed**.

4. Discuss under which condition and how the SVD factorization can be employed to solve the above linear system in the least square sense. **Introduce all the notation employed**.

## 27/10/2022

1. Consider the following problem: find $\mathbf x \in \mathbb R^n, A \mathbf x = \mathbf b$, where $A \in \mathbb R^{n \times n}$ and $b \in \mathbb R^n$ are given. State under which conditions the mathematical problem is well posed.

2. Describe the Gradient method. Introduce the notation, the algorithm, the interpretation of the scheme as a minimization problem. Recall the main theoretical results.

3. Describe the Conjugate Gradient method. Introduce the notation, the algorithm, the interpretation of the scheme as a minimization problem. Recall the main theoretical results.

4. Comment on the main differences between Gradient and Conjugate Gradient methods.

5. Describe the preconditioned Gradient and Conjugate gradient methods and state the main conditions the preconditioner $P$ has to satisfy.

---

1. Consider the following eigenvalue problem: $A \mathbf x = \lambda \mathbf x$, where $A \in \mathbb R^{n \times n}$ is given. Describe the power method for the numerical approximation of the largest in modulus eigenvalue of $A$. Introduce the notation, the algorithm, and the applicability conditions.

2. State the main theoretical result.

3. Discuss how the power method can be suitably modified in order to approximate the smallest in modulus eigenvalue of $A$ and comment on computation cost.

## 13/01/2023

1. Consider the following problem: find $\mathbf x \in \mathbb R^n, A \mathbf x = \mathbf b$, where $A \in \mathbb R^{n \times n}$ and $\mathbf b \in \mathbb R^n$ are given. State under which conditions the mathematical problem is well posed.

2. Describe the general form of a linear iterative method for the approximate solution of $A \mathbf x = \mathbf b$ and describe the stopping criteria.

3. State the necessary and sufficient condition for convergence.

4. State and prove the sufficient condition for convergence.

5. Describe the Generalized Minimal Residual Method (GMRES). Recall the interpretation of the scheme as a Krylov subspace method and the main theoretical results.

---

1. Consider the rectangular linear system $A \mathbf x = \mathbf b$, where $A$ is an $m \times n$ matrix, $m \geq n$. Provide the definition of the solution in the least-square sense and state under which condition the problem is well posed.

2. Describe the QR factorization of the rectangular matrix $A$.

3. Discuss how the QR factorization can be employed to solve the above linear system in the least-square sense.

4. What can be done if $A$ does not have full rank?

## 27/01/2023

Consider the problem: find $\mathbf x \in \mathbb R^n$ such that $A \mathbf x = \mathbf b$, where $A \in \mathbb R^{n \times n}$ and $\mathbf b \in \mathbb R^n$ are given.

1. Describe the LU factorization of $A$. Introduce the employed notation.

2. State the necessary and sufficient conditions for the existence and uniqueness of the LU factorization.

3. Describe how the LU factorization is used to compute the approximate solution of $A \mathbf x = \mathbf b$.

4. State the computational costs and prove the results.

5. Describe how the incomplete LU factorization can be used as preconditioner to accelerate the convergence of a linear iterative method. Introduce the employed notation.

---

1. Consider the following eigenvalue problem: $A \mathbf x = \lambda \mathbf x$, where $A \in \mathbb R^{n \times n}$ is given. Describe the power method for the numerical approximation of the largest in modulus eigenvalue of $A$. Introduce the notation, describe the algorithm, and state the applicability conditions.

2. Prove that, under the conditions stated above, the power method converges.

3. Describe the inverse power method for the numerical approximation of the smallest in modulus eigenvalue of $A$. Introduce the notation, describe the algorithm, and state the applicability conditions.

4. Discuss the computational costs of both the power and inverse power methods.

5. Describe the deflation technique. Present the algorithm and the applicability conditions.

## 12/06/2023

1. Consider the following problem: find $\mathbf x \in \mathbb R^n, A \mathbf x = \mathbf b$, where $A \in \mathbb R^{n \times n}$ and $\mathbf b \in \mathbb R^n$ are given. State under which conditions the mathematical problem is well posed.

2. Describe the Conjugate Gradient method. Introduce the notation, the algorithm, the interpretation of the scheme as a minimization problem. Recall the main theoretical results.

3. Describe the preconditioned Gradient method (PCG) and state the main conditions the preconditioner $P$ has to satisfy, and the main convergence result.

4. Describe the algebraic multigrid method as a preconditioning strategy to accelerate the convergence of the PCG method.

---

1. Consider the following eigenvalue problem: $A \mathbf x = \lambda \mathbf x$, where $A \in \mathbb R^{n \times n}$ is given. Describe the power method for the numerical approximation of the largest in modulus eigenvalue of $A$. Introduce the notation, the algorithm, and the applicability conditions.

2. State the main theoretical results.

3. Comment on the computational costs.

## 04/09/2023

2. Describe the general form of a linear iterative method for the approximate solution of $A \mathbf x = \mathbf b$ and describe the stopping criteria.

3. State the necessary and sufficient condition for convergence.

4. Describe the Generalized Minimal Residual method (GMRES). Recall the interpretation of the scheme as a Kryllov subspace method and the main theoretical results.

## 23/01/2024

2. Describe the LU factorization and its use to approximately solve the linear system $A \mathbf x = \mathbf b$.

3. State the necessary and sufficient condition that guarantees existence and uniqueness of the LU factorization. For what classes of matrices the LU factorization exists and is unique?

4. Describe the main pivoting techniques and comment on the computational costs.

---

1. Consider the following eigenvalue problem: $A \mathbf x = \lambda \mathbf x$, where $A \in \mathbb R^{n \times n}$ is given. Describe the inverse power method for the numerical approximation of the smallest in modulus eigenvalue of $A$. Introduce the notation and discuss the applicability conditions.

2. Write the (pseudo) algorithm.

3. State the main theoretical result.
