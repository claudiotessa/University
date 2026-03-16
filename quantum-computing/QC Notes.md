---
number headings: first-level 1, max 6, 1.1
---
<center><h1 style="color: var(--text-accent)">Quantum Computing</h1></center>
<center><i>Claudio Tessa - 2024/2025</i></center>

# 1 Introduction

## 1.1 Complex Numbers

In the realm of complex numbers, a number $z$ can be expressed in different forms: 
$$
z = x + iy = r(\cos \varphi + i \sin \varphi) = re^{i\varphi}
$$
where
- $x$ is the real part
- $y$ is the imaginary part
- $r$ is the length of the vector
- $\varphi$ is the radius between the vector and the real axis

A complex number can be **rotated by an angle $\psi$** by multiplying it with $e^{i\psi}$, which geometrically corresponds to rotating $z$ by an angle $\psi$ within the complex plane. 

We define the **conjugate** of a complex number $z$ as
$$
\bar{z} = x - iy = re^{-i\varphi}
$$
that is, changing the sign of the imaginary part.

We can now define the **Hermitian** of a vector of complex number $z = \begin{bmatrix} a \\ b\end{bmatrix}$, where $a$ and $b$ are complex. From here, the **conjugate transpose** of $z$ is the vector $z^{H} = \begin{bmatrix}\bar{a} & \bar{b}\end{bmatrix}$.

## 1.2 Dirac's notation

Dirac notation (also knows as **bra-ket** notation), provides a way to represent quantum states. A central element of this notation is the **ket**, denoted as $\ket{v} = \vec{v}$, which corresponds to a **unitary column vector**.

The ket is used to represents a quantum state, characterized as a complex unit vector (i.e., with a length of one). Kets are used in conjunction with **bras**, which are row vectors denoted by $\bra{v} = \vec{v}^{H}$. The bra $\bra{v}$ represents the conjugate transpose of the ket $\ket{v}$.

On kets and bras we can perform multiplications:

- The scalar product between two kets $\ket{x}$ and $\ket{y}$ (that is, between two vectors $\vec{x}^{H}$ and $\vec{y}$) is represented as $\braket{ x | y } = \vec{x}^{H} \cdot \vec{y}$.
- We often need to multiply a ket $\vec{v}$ (a column vector) with a matrix $M$. This is denoted as $M\ket{v} = M \cdot \vec{v}$.
- We can also concatenate multiplications, for example $\braket{ x | M | y } = \vec{x}^{H} \cdot M \cdot \vec{y}$.

# 2 Qubits

Quantum bits (or **qubits**) are the fundamental units in quantum information processing, in the same way that  bits are the fundamental units of information for classical processing. Just like classical bits, there are several ways to realize quantum bits physically. A qubit, however, has infinite possible values, differently from classical bits that can be either 0 or 1.

A qubit state is represented by a unit vector $|v\rangle$ of two complex numbers $a$ and $b$:
$$
\ket{v} = \begin{pmatrix}
a \\ b
\end{pmatrix}
=
a \ket{0} + b \ket{1}
$$
where $\ket{0} = \begin{pmatrix} 1 \\ 0 \end{pmatrix}$ and $\ket{1} = \begin{pmatrix}0 \\ 1\end{pmatrix}$. These two vectors are called the **standard basis**, while the complex numbers $a$ and $b$ are called the **amplitudes**. When $a$ and $b$ are both non-zero, $\ket{v}$ is said to be a **superposition**.

When describing the state qubit, it is possible to use any pair of **orthonormal basis** $\ket{u}$ and $\ket{u^{\perp}}$:
$$
\ket{v} = a\ket{u} + b \ket{u^{\perp}}
$$
Remember that two vectors $\ket{u}$ and $\ket{u^{\perp}}$ are orthonormal if they are orthogonal and both unitary. 

The most used basis, however, are the standard basis. Another set of useful basis are the Hadamard basis, denoted with labels $\ket{+}$ and $\ket{-}$:
$$
\ket{+} = \frac{1}{\sqrt{ 2 }}\begin{pmatrix}
1 \\ 1
\end{pmatrix}
\qquad \qquad
\ket{-} =  \frac{1}{\sqrt{ 2 }}\begin{pmatrix}
1 \\ -1
\end{pmatrix}
$$

## 2.1 Single-Qubit Measurements

Any device that measures a qubit must have two preferred states whose representative vectors $\ket{u}$ and $\ket{u^{\perp}}$ form an orthonormal basis (we will generally assume $\ket{u} = \ket{0}$ and $\ket{u^{\perp}} = \ket{1}$). The measurement outcome is always one of the two basis vectors $\ket{u}$ or $\ket{u^{\perp}}$. This behavior of measurement is an **axiom** of quantum mechanics.

Consider the qubit $\ket{v} = a \ket{u} + b \ket{u^{\perp}}$. The probability that the state of the qubit is measured as $\ket{u}$ is $|a|^{2}$. Similarly, The probability that the state is measured as $\ket{u^{\perp}}$ is $|b|^{2}$.

Measurement of a qubit changes its state. If a qubit $\ket{v} = a\ket{u} + b \ket{u^{\perp}}$ is measured as $\ket{u}$, then the state changes to $\ket{v} = 1\ket{u} + 0 \ket{u^{\perp}} = \ket{u}$. A second measurement with respect to the same basis will return $\ket{u}$ with probability 1.

While the mathematics of measuring a qubit in the superposition state $a\ket{0} + b \ket{1}$ with respect to the standard basis is clear, measurement brings up questions as to the meaning of a superposition. Superposition is basis dependent: all states are in superpositions with respect to some basis and not with respect to others

Because the result of measuring a superposition is probabilistic, some people are tempted to think of the state $\ket{v} = a \ket{0} + b \ket{1}$ as a probabilistic mixture of $\ket{0}$ and $\ket{1}$. **It is not**. In particular, it is not true that the state is either $\ket{0}$ or $\ket{1}$ and that we just do not happen to know which. Rather, $\ket{v}$ is a definite state, which, when measured in certain bases, gives deterministic results, while in others it gives random results.

Given that qubits can take one of infinitely many states, one might hope that a single qubit could store lots of classical information. However, information about a qubit can be obtained only by measurement, and any measurement result in one of only two states. Thus, a single measurement yields at most a single classical bit of information. Because the measurement changes the state, one cannot make two measurements on the original state of a qubit.

> Note that if you have a qubit in state $\ket{v} = a \ket{0} + b \ket{1}$ with $a$ and $b$ unknown, **is is impossible to measure $a$ and $b$**. Furthermore, a quantum state cannot be cloned. It is not possible to measure a qubit's state twice, even indirectly by copying the qubit's state and measuring the copy

## 2.2 Global Phase of a Qubit

Let's consider two qubits:
$$
\ket{v} = a \ket{0} + b \ket{1}
\qquad \qquad
\ket{v'} = e^{i\varphi} \ket{v}
$$
where $e^{i\varphi}$ is a unitary complex number (of length 1). Therefore, the amplitudes of $v'$ and $v$ have the same "lengths". Then, the two vectors $\ket{v}$ and $\ket{v'}$ describe **the same qubit**. To denote this, we write
$$
\ket{v} = \ket{v'}
$$
$\ket{v}$ and $\ket{v'}$ differ only from a rotation $\varphi$ which is called **global phase** and has no physical meaning.

Apparently, there are four degrees of freedom (independent parameters needed to fully describe the state) in a qubit $\ket{v} = a \ket{0} + b \ket{1}$, as $a$ and $b$ are complex numbers (and therefore made up of 2 parameters each). However, one degree of freedom is removed by the **normalization constraint** $|a|^{2} + |b|^{2} = 1$.

We can therefore rewrite the qubit as
$$
\ket{v} = e^{i\alpha}\cos{\left(\frac{\theta}{2}\right)}\ket{0} + e^{i\beta}\sin{\left(\frac{\theta}{2}\right)}\ket{1}
$$
then, multiplying by $e^{-i\alpha}$ (the **global phase** has no consequences) and setting $\varphi = \beta - \alpha$, we can rewrite $\ket{v}$ in **spherical coordinates** (Bloch sphere):
$$
\ket{v} = \cos{\left( \frac{\theta}{2} \right)} \ket{0} + e^{i\varphi} \sin{\left( \frac{\theta}{2} \right)} \ket{1}
$$
$\varphi = \beta - \alpha$ is called **relative phase** and it is physically meaningful. It is a measure of the angle in the complex plane between the two complex numbers $a$ and $b$.

# 3 Single-Qubit Gates

Quantum logic gates are the fundamental components of quantum circuits, analogous to classical logic gates. These gates operate on single or multiple qubits, manipulating their quantum states and, in the case of multi-qubit gates, creating entanglement. A key characteristic of quantum logic gates is their reversibility, meaning the input state can always be recovered from the output state.

Mathematically, while qubits are vectors, gates are matrices. The action of the gare on the qubit is found by multiplying vector $\ket{v}$, which represents the state of the qubit, by matrix $U$, representing the gate. The result is a qubit in a new state:
$$
\ket{v'} = U\ket{v}
$$

In particular, a gate is a 2x2 **unitary** matrix $U$. Unitary, in the case of a matrix, means that 
$$
U^{H}U = UU^{H} = UU^{-1} = I
$$
The matrix is unitary because it must satisfy some principles of quantum mechanic:

- **No-cloning**: qubits cannot be copied.
- **No-delete**: state transformation of a qubit is reversible, $\ket{v} = U^{H}\ket{v'}$

There exist many types of quantum gates. However, it is possible to identify the minimum number of gates such that, combining them, one can obtain all other gates. These make up the **universal set** of gates. Any quantum computer has to at least implement the universal set of gates.

All quantum gates are equivalent to rotations, since all qubits are on the Bloch sphere, and a gate is transforming a qubit into another qubit (therefore into another point on the sphere).

## 3.1 Identity gate

![[Pasted image 20250423182528.png | center | 100]]

$$
I = \begin{bmatrix}
1 & 0 \\
0 & 1
\end{bmatrix}
$$
$$
\ket{v} = I\ket{v}
$$

Apparently useless, but it is not. It is useful with multiple qubits circuits.

## 3.2 Pauli-X gate (Not)

![[Pasted image 20250423182620.png | center | 100]]

$$
X = \begin{bmatrix}
0 & 1 \\
1 & 0
\end{bmatrix}
$$

Amplitudes $a$ and $b$ are **exchanged**. If $\ket{v} = a \ket{0} + b \ket{1}$ we have
$$
X\ket{v} = b \ket{0} + a \ket{1}
$$
It is equivalent to a **rotation around the *x*-axis by $\pi$ radians**. This rotation requires $\theta \to\pi - \theta$ and $\varphi = -\varphi$. Therefore, with $\ket{v} = \cos{\left( \dfrac{\theta}{2} \right)}\ket{0} + e^{i\varphi}\sin{\dfrac{\theta}{2}}\ket{1}$ we obtain
$$
\ket{v'} = \sin{\left( \frac{\theta}{2} \right)} \ket{0} + e^{-i\varphi}\cos{\left( \frac{\theta}{2} \right)}\ket{1}
$$
then, if we multiply $\ket{v'}$ by $e^{i\varphi}$ (unit vector, same qubit), we can see that $\ket{v'}$ is the same as $\ket{v}$ with $a$ and $b$ swapped:
$$
\ket{v'} = e^{i\varphi}\sin{\left( \frac{\theta}{2} \right)} \ket{0} + \cos{\left( \frac{\theta}{2} \right)}\ket{1}
$$

## 3.3 Pauli-Z gate (Phase Flip)

![[Pasted image 20250423182650.png | center | 100]]

$$
Z = \begin{bmatrix}
1 & 0 \\
0 & -1
\end{bmatrix}
$$

Changes the sign of $b$. If $\ket{v} = a \ket{0} + b \ket{1}$ we have
$$
Z\ket{v} = a \ket{0} - b \ket{1}
$$
It is equivalent to a **rotation around the *z*-axis by $\pi$ radians**. This rotation requires $\varphi \to \varphi + \pi$ ($e^{i(\varphi+\pi)} = -e^{i\varphi}$). Therefore, with $\ket{v} = \cos{\left( \dfrac{\theta}{2} \right)}\ket{0} + e^{i\varphi}\sin{\dfrac{\theta}{2}}\ket{1}$ we obtain
$$
\ket{v'} = \cos{\left( \frac{\theta}{2} \right)}\ket{0} - e^{i\varphi}\sin{\left( \frac{\theta}{2} \right)}\ket{1}
$$
We can see that  $\ket{v'}$ is the same as $\ket{v}$ with $b$ negative:

## 3.4 Pauli-Y gate

![[Pasted image 20250423182638.png | center | 100]]

$$
Y = \begin{bmatrix}
0 & -i \\
i & 0
\end{bmatrix}
$$
It is equivalent to a **rotation around the *y*-axis by $\pi$ radians**. Moreover, $Y = iXZ$ ($i$ is a global phase and can be neglected). $X$ and $Z$ are two $\pi$ rotations around the *x*-axis and the *z*-axis, which is equivalent to a $\pi$ rotation around the *y*-axis.

$$
XZ = \begin{bmatrix}
1 & 0 \\
0 & -1
\end{bmatrix}
\begin{bmatrix}
0 & 1 \\
1 & 0
\end{bmatrix}
=
\begin{bmatrix}
0 & 1 \\
-1 & 0
\end{bmatrix}
$$
$$
\implies Y = \begin{bmatrix}
0 & -1 \\
i & 0
\end{bmatrix}
=
-i \begin{bmatrix}
0 & 1 \\
-1 & 0
\end{bmatrix}
=
iXZ
$$

## 3.5 Phase gate

![[Pasted image 20250423182707.png | center | 100]]

$$
S = \begin{bmatrix}
1 & 0 \\
0 & i
\end{bmatrix}
$$

It is equivalent to a **rotation around the *z*-axis by $\frac{\pi}{2}$ radians**. If you perform two consecutive rotations with gate $S$, it is equivalent to one rotation with gate $Z$:
$$
S\cdot S - \begin{bmatrix}
1 & 0 \\ 0 & i
\end{bmatrix}
\begin{bmatrix}
1 & 0 \\ 0 & i
\end{bmatrix}
=
\begin{bmatrix}
1 & 0 \\ 0 & -1
\end{bmatrix}
= Z
$$

## 3.6 Hadamard gate

![[Pasted image 20250423182724.png | center | 100]]

$$
H = \frac{1}{\sqrt{ 2 }}\begin{bmatrix}
1 & 1 \\ 1 & -1
\end{bmatrix}
$$

It is equivalent to a **rotation around the *y*-axis by $\frac{\pi}{2}$ radians, followed by a rotation around the *x*-axis by $\pi$ radians**. Note that:

- $H \ket{0} = \dfrac{1}{\sqrt{ 2 }}\begin{bmatrix} 1 & 1 \\ 1 & -1\end{bmatrix} \begin{bmatrix} 1 \\ 0 \end{bmatrix} = \dfrac{1}{\sqrt{ 2 }}\begin{bmatrix}1 \\ 1\end{bmatrix} = \ket{+}$
- $H \ket{1} = \dfrac{1}{\sqrt{ 2 }}\begin{bmatrix} 1 & 1 \\ 1 & -1\end{bmatrix} \begin{bmatrix} 0 \\ 1 \end{bmatrix} = \dfrac{1}{\sqrt{ 2 }}\begin{bmatrix}1 \\ -1\end{bmatrix} = \ket{-}$

$\ket{+}$ and $\ket{-}$ are relevant states (Hadamard states), since for both of them $|a|^{2} = |b|^{2} = \frac{1}{2}$. This gives the qubit equal probability of being measured as $\ket{0}$ or $\ket{1}$ (**maximum superposition**). It is often used to prepare qubits in superposition states.

Note that all quantum gates are equivalent to rotations on the Bloch sphere. If you apply twice the same Pauli gate you go back to the initial qubit:
$$
X^{2} = Y^{2} = Z^{2} = I
$$
Moreover, for a gate to create a superposition from a base state, all elements of the gate must be different from zero.

# 4 Single-Qubit quantum circuits

Quantum circuits are a model for quantum computation. They are a sequence of initializations of qubits to known values, gates, measurements, and possibly other actions.

![[Pasted image 20250429195544.png |center|300]]

Here, lines define the sequence of events. Horizontal lines are qubits, while the objects connected by lines are operations (gates, measurements) performed on qubits. Double lines represent classical bits instead. Note that **lines are not physical connections**.

## 4.1 Serial gates

Consider the following quantum circuit.

![[Pasted image 20250429195807.png|center|300]]

with gates $B$ directly after gate $A$. Then, the effect of the two gates can be described as a single gate $C = BA$:

![[Pasted image 20250429195948.png|center|300]]

Note that the multiplication is **from right to left** with respect to the order in which gates appear in the circuit:
$$
\ket{v_{\mathrm{out}}} = C \ket{v_{\mathrm{in}}} = BA \ket{v_{\mathrm{in}}}
$$

## 4.2 Bra-ket notation: outer product of kets

The **outer product** between kets $\ket{a} = \begin{bmatrix} a_{1} \\ a_{2} \end{bmatrix}$ and $\ket{b} = \begin{bmatrix}b_{1} \\ b_{2}\end{bmatrix}$ is a $2 \times 2$ matrix represented with the notation $\ket{a}\bra{b}$ and defined as:
$$
\ket{a}\bra{b} = \vec{a} \otimes \vec{b}^{H} = \begin{bmatrix}
a_{1} \\ a_{2}
\end{bmatrix} \otimes \begin{bmatrix}
\bar{b}_{1} & \bar{b_{2}}
\end{bmatrix} = \begin{bmatrix}
a_{1} \bar{b}_{1}  & a_{1} \bar{b}_{2} \\
a_{2} \bar{b}_{1}  & a_{2}\bar{b_{2}}
\end{bmatrix}
$$
The outer product is an element-by-element product between the first vector and the Hermitian of the second vector. $\otimes$ is the **tensor product** operator.

The outer and scalar product have this useful property:
$$
(\ket{a} \bra{b} )\ket{c} = \ket{a}\braket{ b | c }  = \braket{ b | c } \ket{a}
$$
Remember that $\ket{a} \bra{b}$ is a matrix, and $\braket{ b | c }$ is a scalar.

***Proof***

We want to prove that $(\ket{a} \bra{b} )\ket{c} = \ket{a}\braket{ b | c }  = \braket{ b | c } \ket{a}$, where $\ket{a} = \begin{bmatrix}a_{1}\\ a_{2}\end{bmatrix}$, $\ket{b} = \begin{bmatrix}b_{1} \\ b_{2}\end{bmatrix}$, and $\ket{c} = \begin{bmatrix}c_{1} \\ c_{2}\end{bmatrix}$.

Use the definition of outer product and apply the inner product:
$$
(\ket{a} \bra{b} )\ket{c} = \begin{bmatrix}
a_{1}\bar{b}_{1} & a_{1}\bar{b}_{2} \\ a_{2}\bar{b}_{1} & a_{2}\bar{b}_{2}
\end{bmatrix}
\begin{bmatrix}
c_{1} \\ c_{2}
\end{bmatrix}
=
\begin{bmatrix}
a_{1}\bar{b}_{1}c_{1} + a_{1}\bar{b}_{2}c_{2} \\
a_{2}\bar{b}_{1}c_{1} + a_{2}\bar{b}_{2}c_{2}
\end{bmatrix}
$$
observe that $\begin{bmatrix} a_{1}\bar{b}_{1}c_{1} + a_{1}\bar{b}_{2}c_{2} \\ a_{2}\bar{b}_{1}c_{1} + a_{2}\bar{b}_{2}c_{2} \end{bmatrix} = \begin{bmatrix} a_{1}(\bar{b}_{1}c_{1} + \bar{b}_{2}c_{2}) \\ a_{2}(\bar{b}_{1}c_{1} + \bar{b}_{2}c_{2}) \end{bmatrix}$, and $(\bar{b}c_{1} + \bar{b}c_{2})$ is the inner product $\braket{ b | c }$. Therefore, we can rewrite the result as
$$
(\ket{a} \bra{b} )\ket{c} = \begin{bmatrix}
a_{1} \\ a_{2}
\end{bmatrix}
\braket{ b | c } 
= \ket{a} \braket{ b | c } 
$$

## 4.3 Measurement of a Qubit

The **measurement** (or **projection**) operator is a special **non-unary** (and **non-invertible**) $2 \times 2$ matric $M_{k}$ such that
$$
M_{k} = \ket{k} \bra{k} 
$$
which projects a qubit $\ket{v}$ along a vector $\ket{k}$.

![[Pasted image 20250429202454.png|center|200]]![[Pasted image 20250429202626.png|center|180]]

After the projection, the resulting state **could be** (probabilistic)
$$
\ket{v}_{k} = \frac{M_{k} \ket{v}}{\braket{ v | M_{k} | v } }
$$
which does **not** correspond to a rotation.

The **probability** of the measurement to be $\ket{v_{k}}$ is
$$p_{k} = \braket{ v | M_{k} | v }$$
in the standard basis $M_{0} = \ket{0} \bra{0} = \begin{bmatrix}1 & 0 \\ 0 & 0\end{bmatrix}$ and $M_{1} = \ket{1} \bra{1} = \begin{bmatrix}0 & 0\\ 0 & 1\end{bmatrix}$.

### 4.3.1 Property of the Measurement Operator

Once applied, $M_{k}$ does not change the vector anymore, if it is applied twice:
$$
M_{k}^{2} = M_{k}M_{k} = M_{k}
$$
***Proof 1***

Define $\ket{k} = \begin{bmatrix}a \\ b\end{bmatrix}$. Now compute:

- $M_{k} = \ket{k} \bra{k} = \begin{bmatrix}a \\ b\end{bmatrix} \otimes \begin{bmatrix}\bar{a} & \bar{b}\end{bmatrix} = \begin{bmatrix}a^{2} & a\bar{b} \\ b\bar{a} & b^{2}\end{bmatrix}$
- $M_{k}^{2} = \begin{bmatrix}a^{2} & a\bar{b} \\ b\bar{a} & b^{2}\end{bmatrix} \begin{bmatrix}a^{2} & a\bar{b} \\ b\bar{a} & b^{2}\end{bmatrix} = \begin{bmatrix}a^{4}+a^{2}b^{2} & a^{3}\bar{b}+a\bar{b}b^{2} \\ b\bar{a}a^{2} + b^{3}\bar{a} & b^{4}+a^{2}b^{2}\end{bmatrix} = \begin{bmatrix}a^{2}\cancel{(a^{2} + b^{2})} & a\bar{b}\cancel{(a^{2} + b^{2})} \\ b\bar{a}\cancel{(a^{2} + b^{2})} & b^{2}\cancel{(a^{2} + b^{2})}\end{bmatrix}$

Remembering that $a^{2} + b^{2} = 1$, thus
$$M_{k}^{2} = \begin{bmatrix}a^{2} & a\bar{b} \\ b\bar{a} & b^{2}\end{bmatrix} = M_{k}$$

***Proof 2***

We want to prove that the application of $M_{k}$ to ket $\ket{v}$ projects $\ket{v}$ on vector $\ket{k}$.

From the definition of $M_{k} = \ket{k} \bra{k}$, apply $M_{k}$ to $\ket{v}$:
$$
M_{k}\ket{v} = \ket{k} \bra{k} \ket{v} = \braket{ k | v } \ket{k}
$$
remember that $\braket{ k | v }$ is the cosine of the angle between $\ket{k}$ and $\ket{v}$. Therefore, the resulting vector has the same direction of $\ket{k}$, scaled by $\braket{ k | v }$.

# 5 Multiple-Qubits States

Given two qubits
$$
\ket{v_{A}} = a_{0}\ket{0} + a_{1}\ket{1},
\qquad
\ket{v_{B}} = b_{0}\ket{0} + b_{1} \ket{1}
$$
we with to know their combined state. In other words, we want to know the probability for the two qubits to be

- both in state $\ket{0}$; or
- the first one in state $\ket{0}$ and the second one in state $\ket{1}$; or
- the first one in state $\ket{1}$ and the second one in state $\ket{0}$; or
- both in state $\ket{1}$.

The two qubits do not necessarily interact with each other.

The state of the two qubits $\ket{v_{A}}$ and $\ket{v_{B}}$ is described with their **tensor product**
$$
\ket{v_{A}} \otimes \ket{v_{B}} = \begin{bmatrix}
a_{0} \\ a_{1}
\end{bmatrix} \otimes \begin{bmatrix}
b_{0} \\ b_{1}
\end{bmatrix}
= \begin{bmatrix}
a_{0}b_{0} \\ a_{0}b_{1} \\ a_{1}b_{0} \\ a_{1}b_{1}
\end{bmatrix}
$$
for this, we can introduce a new compact notation:
$$
\ket{v_{A}v_{B}} = \ket{v_{A}} \otimes \ket{v_{B}}
$$
Note that the opposite is not always true. A vector of 4 element cannot always be decomposed into the tensor product of 2 qubits.

We can rewrite $\ket{v_{A}v_{B}}$ as
$$
\begin{align}
\ket{v_{A}v_{B}} &= a_{0}b_{0}\underbrace{(\ket{0}\otimes \ket{0})}_{\ket{00}} + a_{0}b_{1} \underbrace{(\ket{0}\otimes \ket{1})}_{\ket{01}} + a_{1}b_{0} \underbrace{(\ket{1} \otimes \ket{0})}_{\ket{10}} + a_{1}b_{1} \underbrace{(\ket{1} \otimes \ket{1})}_{\ket{11}} \\
&= a_{0}b_{0}\ket{00} + a_{0}b_{1}\ket{01} + a_{1}b_{0}\ket{10} + a_{1}b_{1}\ket{11}

\end{align}
$$
So we have:

- $(a_{0}b_{0})^{2}$ probability of being in state $\ket{00}$
- $(a_{0}b_{1})^{2}$ probability of being in state $\ket{01}$
- $(a_{1}b_{0})^{2}$ probability of being in state $\ket{10}$
- $(a_{1}b_{1})$ probability of being in state $\ket{11}$

Moreover, the combined amplitudes also normalize to 1. In fact, we can rewrite the sum of the square of the amplitudes as
$$
a_{0}^{2}b_{0}^{2} + a_{0}^{2}b_{1}^{2} + a_{1}^{2}b_{0}^{2} + a_{1}^{2}b_{1}^{2} = a_{0}^{2}\underbrace{(b_{0}^{2}+b_{1}^{2})}_{1} + a_{1}^{2}\underbrace{(b_{0}^{2} + b_{1}^{2})}_{1} = a_{0}^{2} + a_{1}^{2} = 1
$$

## 5.1 Multiple-Qubits Circuits (Parallel Gates)

Applying single gates to two independent qubits, corresponds to

Applying single gates $A$ and $B$ to two independent qubits, initially in states $\ket{v_{A}}$ and $\ket{v_{B}}$ respectively, corresponds to applying the tensor product of those gates, $A\otimes B$, to the combined state of the two qubits, $\ket{v_{A}} \otimes \ket{v_{B}}$. The resulting state is $(A \otimes B)(\ket{v_{A} \otimes \ket{v_{B}}})$, which is equivalent to the tensor product of the individual resulting states, $(A \ket{v_{A}}) \otimes (B \ket{v_{B}})$:

![[Pasted image 20250502173248.png|center|300]]

This is represented as a single composite gate $A \otimes B$:

![[Pasted image 20250502173348.png|center|250]]

### 5.1.1 The $H^{\otimes n}$ Hadamard Transform

A particular case is the one with the Hadamard gate:

![[Pasted image 20250502173643.png|center|250]]

this case is so common that we define a particular notation for this **Hadamard transform**:
$$H^{\otimes n}$$
is the Hadamard transform of $n$ qubits. The example in the previous figure shows the $H^{\otimes 2}$, Hadamard transform of 2 qubits.

The Hadamard transform places the state in a **uniform** superposition (equal probability of being in any state).

# 6 Multiple-Qubits Gates

There are quantum gates which apply **only to multiple qubits**.

## 6.1 Controlled NOT (CNOT)

![[Pasted image 20250517175737.png|center|200]]
$$
CNOT = \begin{bmatrix}
1 & 0 & 0 & 0 \\
0 & 1 & 0 & 0 \\
0 & 0 & 0 & 1 \\
0 & 0 & 1 & 0
\end{bmatrix}
$$
where $\oplus$ is the XOR operator.

If the control qubit $\ket{v_{A}}$ is $\ket{1}$, then the target qubit $v_{B}$ is flipped. In other words, if we apply the CNOT gate to $\ket{v_{A}} = a_{0} \ket{0} + a_{1} \ket{ 1}$ and $\ket{v_{B}} = b_{0} \ket{0} + b_{1} \ket{1}$, that is
$$
\ket{v_{A} v_{B}} = a_{0}b_{0} \ket{00} + a_{0} b_{1} \ket{01} + a_{1} b_{0} \ket{10} + a_{1} b_{1} \ket{11}
$$
we invert the last two amplitudes:
$$
CNOT \ket{v_{A}b_{A}} 
= 
\begin{bmatrix}
1 & 0 & 0 & 0 \\
0 & 1 & 0 & 0 \\
0 & 0 & 0 & 1 \\
0 & 0 & 1 & 0
\end{bmatrix}
\begin{bmatrix}
a_{0} b_{0} \\
a_{0} b_{1} \\
a_{1}\textcolor{orange}{b_{0}} \\
a_{1}\textcolor{green}{b_{1}}
\end{bmatrix}
=
\begin{bmatrix}
a_{0} b_{0} \\
a_{0} b_{1} \\
a_{1}\textcolor{green}{b_{1}} \\
a_{1}\textcolor{orange}{b_{0}}
\end{bmatrix}
$$
More **in general**, if we apply the CNOT gate to
$$\ket{v_{C}} = c_{0} \ket{00} + c_{1} \ket{01} + c_{2} \ket{10} + c_{3} \ket{11}$$
we invert the two amplitudes $c_{2}$ and $c_{3}$
$$
CNOT \ket{v_{C}} 
= 
\begin{bmatrix}
1 & 0 & 0 & 0 \\
0 & 1 & 0 & 0 \\
0 & 0 & 0 & 1 \\
0 & 0 & 1 & 0
\end{bmatrix}
\begin{bmatrix}
c_{0} \\
c_{1} \\
\textcolor{orange}{c_{2}} \\
\textcolor{green}{c_{3}}
\end{bmatrix}
=
\begin{bmatrix}
c_{0} \\
c_{1} \\
\textcolor{green}{c_{3}} \\
\textcolor{orange}{c_{2}}
\end{bmatrix}
$$

## 6.2 Generic Controlled Gate

![[Pasted image 20250517181215.png|center|150]]
$$C_{U} = \begin{bmatrix}
I & 0 \\ 0 & U
\end{bmatrix}$$
If control qubit $\ket{v_{A}}$ is $\ket{1}$, then target gate $U$ is applied to qubit $\ket{v_{B}}$. In other words, if we apply the generic controlled gate $C_{U}$ to $\ket{v_{A}} = a_{0} \ket{0} + a_{1} \ket{1}$ and $\ket{v_{B}} = b_{0} \ket{0} + b_{1} \ket{1}$ we obtain
$$
C_{U} \ket{v_{A}v_{B}} = \begin{bmatrix}
I & 0 \\
0 & U
\end{bmatrix}
\begin{bmatrix}
a_{0}b_{0} \\
a_{0}b_{1} \\
a_{1} b_{0} \\
a_{1} b_{1}
\end{bmatrix}
$$
Note that $\begin{bmatrix}I & 0 \\ 0 & U\end{bmatrix}$ is **not equivalent** to $I \otimes U$.

## 6.3 SWAP

![[Pasted image 20250517181810.png|center|200]]
$$SWAP = \begin{bmatrix}
1 & 0 & 0 & 0 \\
0 & 0 & 1 & 0 \\
0 & 1 & 0 & 0 \\
0 & 0 & 0 & 1
\end{bmatrix}$$
The state of $\ket{v_{A}} = a_{0} \ket{0} + a_{1} \ket{1}$ and $\ket{v_{B}} = b_{0} \ket{0} + b_{1} \ket{1}$, described with their tensor product
$$
\ket{v_{A}v_{B}} = a_{0}b_{0} \ket{00} + \textcolor{teal}{a_{0}b_{1}} \ket{01} + \textcolor{green}{a_{1} b_{0}} \ket{10} + a_{1} b_{1} \ket{11}
$$
is swapped after we apply the SWAP gate:
$$
SWAP \ket{v_{A}v_{B}}
=
\ket{v_{A}v_{B}} = a_{0}b_{0} \ket{00} +  \textcolor{green}{a_{1} b_{0}}\ket{01} + \textcolor{teal}{a_{0}b_{1}} \ket{10} + a_{1} b_{1} \ket{11}
$$
which is identical to the tensor product $\ket{v_{B}v_{A}}$.

## 6.4 CCNOT (or Toffoli)

![[Pasted image 20250517182727.png|center|250]]
$$
CCNOT = 
\begin{bmatrix}
1 & 0 & 0 & 0 & 0 & 0 & 0 & 0 \\
0 & 1 & 0 & 0 & 0 & 0 & 0 & 0 \\
0 & 0 & 1 & 0 & 0 & 0 & 0 & 0 \\
0 & 0 & 0 & 1 & 0 & 0 & 0 & 0 \\
0 & 0 & 0 & 0 & 1 & 0 & 0 & 0 \\
0 & 0 & 0 & 0 & 0 & 1 & 0 & 0 \\
0 & 0 & 0 & 0 & 0 & 0 & 0 & 1 \\
0 & 0 & 0 & 0 & 0 & 0 & 1 & 0 \\
\end{bmatrix}
$$
Is a CNOT gate with 2 control bits instead of 1. The target qubit $\ket{v_{2}}$ is inverted when **both** control qubits are $\ket{1}$.

## 6.5 Quantum Circuit

We can express a quantum circuit as one matrix. We must follow three rules:

- Composition across wired is achieved by **tensor product**.
- Composition along (sets of) wires is achieved by **matrix product**, but **right to left**.
- Composition across wires requires to use the identity matrix for qubits without gates.

---
***Example***

![[Pasted image 20250517183400.png|center|200]]

$$
\underbrace{(H \otimes I \otimes I)}_{4^{\text{th}}} 
\cdot 
\underbrace{(I \otimes CNOT)}_{3^{\text{rd}}} 
\cdot 
\underbrace{(X \otimes I \otimes H)}_{2^{\text{nd}}}
\cdot
\underbrace{(CNOT \otimes I)}_{1^{\text{st}}}
$$
---

## 6.6 Entanglement

It takes $2^{n}$ real numbers to describe the state of an $n$-qubits system. This is because the state of $n$-qubits are described by their tensor product, which leads to $2^{n}$ coefficients (although one degree of freedom is removed by the normalization, and another one is removed because the global phase is meaningless).

However, it takes $2n$ real numbers to describe $n$ individual single-qubits states. Since $2^{n} \gg 2n$, this means that most $n$-qubits states **cannot** be described in terms of $n$ separate qubits.

Multiple-qubits states that cannot be written as the tensor product of $n$ single-qubits are called **entangled states**. Thus, the vast majority of quantum states are entangled.

Multiple-qubits states that can be written as a tensor product from the constituent subsystems are called **separable states**.

---
***Example***

The elements of the **Bell states** are entangled.

Consider the Bell state $\ket{\Phi^{+}} = \frac{1}{\sqrt{ 2 }}(\ket{00} + \ket{11})$, it cannot be described in terms of the state of each of its component qubits separately.

If we have two qubits $\ket{v_{A}} = a_{0} \ket{0} + a_{1} \ket{1}$ and $\ket{v_{B}} = b_{0} \ket{0} + b_{1} \ket{1}$, it is impossible to find $a_{0}, a_{1}, b_{0}, b_{1}$ such that
$$
\ket{v_{A} v_{B}} = a_{0} b_{0} \ket{00} + \underbrace{a_{0} b_{1}}_{0} \ket{01} + \underbrace{a_{1} b_{0}}_{0} \ket{10} + a_{1} b_{1} \ket{11}
=
\frac{1}{\sqrt{ 2 }} (\ket{00} + \ket{11})
$$
since $a_{0}b_{1} = 0$ implies that either $a_{0}b_{0} = 0$ or $a_{1}b_{1} = 0$, none of which is true.

---

Entanglement is **not basis dependent** (only the notion of superposition is basis dependent).

Moreover, Entanglement is not an absolute property of a quantum state. It depends on the particular decomposition of the system into subsystems under consideration. States entangled with respect to one decomposition may be unentangled with respect to other decompositions. When we say that a state in **entangled**, we mean that it is entangled with respect to his decomposition into **individual qubits**.

### 6.6.1 Entangling gates

Not all 2-qubits gates can be written as the tensor product of single qubits gates. A generic 2-qubits gate has 16 complex values, while two single-qubit gates have 4 + 4 = 8 total complex values.

A gate that cannot be written as the tensor product of single-qubit gates is called **entangling gate**. One example of an entangling gate is the CNOT gate

If we have a set of $N$ qubits that are entangled and wish to apply a quantum gate on $M < N$ qubits in the set, we will have to extend the gate to take $N$ qubits. This can be done by combining the gate with an identity matrix such that their tensor product becomes a gate that act on $N$ qubits (it is difficult to simulate large entangled quantum systems using classical computers, as the state vector of a quantum register with $n$ qubits is $2^{n}$ complex entries).

### 6.6.2 Bell states

This four entangled states are called **Bell states**:

- $\ket{\Phi^{+}} = \frac{1}{\sqrt{ 2 }} (\ket{00} + \ket{11})$
- $\ket{\Phi^{-}} = \frac{1}{\sqrt{ 2 }} (\ket{00} - \ket{11})$
- $\ket{\Psi^{+}} = \frac{1}{\sqrt{ 2 }} (\ket{01} + \ket{10})$
- $\ket{\Psi^{-}} = (\ket{01} - \ket{10})$

These states are **maximally entangled**, in the sense that, when looked at separately, the state of each qubit is as uncertain as possible. Contrarily, **unentangled states** are the least entangled states possible in the sense that, when looked at separately, the state of each qubit is as certain as possible.

The following quantum circuit produces Bell states:

![[Pasted image 20250517193028.png|center|250]]

## 6.7 Multi-qubits measurement

What happens when measuring one qubit in a two-qubits system? Suppose we have
$$
\ket{v_{C}} = \ket{v_{A}v_{B}} = c_{0} \ket{00} + c_{1} \ket{01} + c_{2} \ket{ 10} + c_{3} \ket{11}
$$
The state of the system can always be described as
$$
\ket{v} = c_{01} \ket{0} \otimes \frac{c_{0}\ket{0} + c_{1} \ket{1}}{c_{01}} + c_{23} \ket{1} \otimes \frac{c_{2} \ket{ 0} + c_{3} \ket{1}}{c_{23}}
$$
with $c_{01} = \sqrt{ c_{0}^{2} + c_{1}^{2} }$ and $c_{23} = \sqrt{ c_{2}^{2}  + c_{3}^{2}}$.

If qubit $\ket{v_{A}}$ is measured as $\ket{0}$, then $c_{2} = 0$ and $c_{3} = 0$.

The state of qubit $\ket{v_{B}}$ becomes
$$
\ket{v_{B}} = \frac{c_{0} \ket{0} + c_{1}\ket{1}}{c_{01}}
$$
which is a valid qubit normalized to 1.

## 6.8 Limits of Quantum Information

### 6.8.1 No-cloning principle

The **no-cloning principle** is a fundamental rule saying you cannot make a copy of an unknown qubit's state. Cloning violates quantum mechanic principles.

This principle is crucial because if we could perfectly clone qubits, it would potentially allow information to be transmitted faster than light, and it would also allow extracting an infinite amount of classical information from a single qubit's state.

In quantum computing, the inability to copy a qubit **makes quantum error correction harder**.

Specifically, there does not exist a gate $U$ such that $U({\ket{x}\ket{0}}) = \ket{x}\ket{x}$.

### 6.8.2 No-deleting principle

The **no-deleting principle** states that there does not exist a gate $U$ that can delete one of two copies of a qubit.

Specifically, there does not exist a gate $U$ such that $U(\ket{x}\ket{x}) = \ket{0}\ket{x}$.

### 6.8.3 No-signaling principle

The **no-signaling principle** states that information cannot be transmitted faster than the speed of light. 

It means that performing a measurement or operation on one part of an entangled system should not instantaneously influence the _probabilities_ of outcomes of measurements performed by someone far away on another part of the system in a way that could be used to send a signal. While quantum entanglement shows non-local correlations, these correlations cannot be exploited on their own to send classical information faster than light.

Suppose *Alice* and *Bob* are at a different ends of the universe, but each have one qubit of a Bell pair $\ket{\Phi^{+}} = \dfrac{\ket{00} + \ket{11}}{\sqrt{ 2 }}$. Alice can measure her qubit $\ket{a}$ whenever she wants, and this will collapse Bob's qubit $\ket{b}$ to the same state. **We are interested in whether Bob can infer whether Alice has measured her qubit or not**.

If he can, then Alice can transfer information to Bob instantaneously. For example, Alice can measure her qubit $\ket{a}$ when some event occurs, thus signaling this information to Bob.

# 7 Quantum Transpiling

A qubit is affected by external noise. Each qubit has a **decoherence time**, the maximum time a qubit can keep its superposition state (typically, in the order of hundreds of $\mu \text{s}$). Moreover, gate operations are affected by **errors**, the quality of gates is measured by **fidelity**.

## 7.1 Fidelity

The fidelity of is measured with the following metrics:

- $T_{dec}$: decoherence time of a qubit.
- $t_{\text{gate}}$: processing time of a gate, with $t_{\text{gate}} \ll T_{\text{dec}}$.
- $p_{\text{gate}} \approx \dfrac{t_{\text{gate}}}{T_{\text{dec}}}$: error probability of a gate.
- $\text{Quality ratio} = \dfrac{T_{\text{dec}}}{t_{\text{gate}}}$ (The target is $10^{3}$ or $10^{4}$).
- $F_{\text{gate}} \approx 1 - p_{\text{gate}} \approx 1 - \dfrac{t_{\text{gate}}}{T_{\text{dec}}}$: fidelity of a quantum gate.

***Threshold Theorem (Quantum Fault Tolerance)*** - If quantum gate fidelity id above a certain threshold value, then it is possible to perform arbitrarily long quantum computations reliably, by using quantum error correction and fault tolerant protocols.

We can now define:

- Fidelity of a real gate $E$ with respect to the ideal gate $U$ when applied to qubit $\ket{x}$$$F(E, U, x) = (\braket{ x | U^{H}E | x } )^{2}$$
- Average fidelity of a real gate $E$ with respect to the ideal gate $U$ $$F(E, U) = \int{(\braket{ x | U^{H}E | x} )^{2} \ dx}$$

## 7.2 Quantum Error Correction Codes (QECC)

The correction process is carried on **after each operation**. Redundancy is employed to correct errors, a lot of redundancy is necessary, since qubits are continuous (not discrete) and the error rate is high.

Each qubit becomes a **logical qubit**, which is encoded in $n$ physical qubits: **data** and **ancilla** qubits.

Error correction is the main responsible for the blowup of qubits required for quantum algorithms. $N$ logical qubits require 100 times the amount of physical qubits (data, ancilla, wiring), plus many more for other architecture details.

![[Pasted image 20250521131815.png|center]]

To then perform quantum operation on logical qubits, each fundamental gate needs to be defined on logical qubits. The way the logical operation is performed depends on the logical qubit implementation.

Each logical operation is represented by a **logical gate**.

## 7.3 Quantum Compilation

In quantum computation, we can distinguish the following concepts

- **Quantum Processor** - A chip with $n$ logical qubits.
- **Quantum Language Programming** - Language to describe a circuit using gate-level instructions or other functions.
- **Quantum Algorithm** - The quantum circuit to be executed.
- **Quantum compilation (transpiling)** - Made up of the following phases:
	- **Optimization**: use heuristics to merge gates or rearrange operations.
	- **Placement**: initial mapping of the circuit qubits to the on-chip logical qubits.
	- **Scheduling**: schedule gates execution.
	- **Routing**: move qubits to execute operations on multiple qubits.
- **Quantum execution** - Translation of gate-level instructions to signals sent to the processor.

Let's focus on quantum compilation.

### 7.3.1 Placement

The main issue to be addressed is that, for example, 2 qubits of a multi-qubits gate (e.g., CNOT) need to be adjacent to compute the gate (either on the same row or same column). If they are not adjacent, they need to be moved (routing process).

**Placement** maps the qubits on the chip, deriving the initial configuration of the processor, placing as close as possible qubits that will be processed by a 2-qubits gate, minimizing Manhattan distances (i.e., minimize the routing cost). In this example, the distance between $\ket{v_{4}}$ and $\ket{v_{4}}$ is 4:

![[Pasted image 20250521133122.png|center|175]]

The **target** is to find the placement that minimized the sum of Manhattan distances over all pairs involved in multiple bits gates.

### 7.3.2 Scheduling

Gates can theoretically be all executed simultaneously, but there are scheduling issues: data dependencies, and the fact that out-of-order execution must preserve the correctness of the computation.

There are two different scheduling policies:

- **As Soon As Possible (ASAP)** - An operation is performed as soon as the input data are available.
- **As Late As Possible (ALAP)** - It mitigates the decoherence time constraints, minimizing the time between a gate writing a qubit and the next gate reading it. It reduces the time interval during which a quantum state needs to be preserved.

### 7.3.3 Routing

Multi-qubit gates require qubits to be adjacent. If they are not, we need to move them using the **Swap Gate**.

# 8 Quantum Annealing

**Quantum annealing** is a technique designed primarily to solve **optimization problems**, especially those that can be mapped to an Ising model or a QUBO formulation.

## 8.1 Hamiltonian

The Hamiltonian (denoted as $H$), is defined as a specific type of **operator**. Its primary role is to describe how a quantum state evolves over time. In practice, the Hamiltonian describes the total energy of a quantum system.

Mathematically, it is an object that acts on a function to transform it into another (for instance, a derivative is a common example of an operator).

The Hamiltonian possesses unique and crucial properties that make it fundamental in quantum mechanics:

- **It is Hermitian:** A Hermitian operator is one that is equal to its own conjugate transpose. This means that its **eigenvalues** are always real numbers. Since energy is a real, measurable quantity, it's essential for the Hamiltonian to be Hermitian.
- **Its eigenvalues represent possible energy values:** When you measure the energy of a quantum system, the only possible outcomes are the eigenvalues of its Hamiltonian operator.
- **Its eigenvectors are stationary quantum states:** The eigenvectors of the Hamiltonian are special quantum states that, when measured for energy, will always yield one of the Hamiltonian's eigenvalues. If a system is in one of these "eigenstates" of the Hamiltonian, its probability distribution (and thus its observable properties) does not change over time; only its overall phase changes, making them "stationary" states.

## 8.2 The Ising model

**Ising** is a mathematical formulation used to describe the energy of a quantum system as a function of its qubits states. In the ising model, qubits are represented (referred to) as **spins**, that can be either $\pm 1$.

The energy is given by the Hamiltonian:
$$
H_{\text{ising}} = \sum_{i}{h_{i}s_{i}} + \sum_{i > j}{J_{ij}s_{i}s_{j}}
$$
where:
- $J_{ij}$ is the symmetric interaction between spin $i$ and $j$
- $h_{i}$ is the external magnetic field on spin $i$
- $s_{i}$ is the state of spin $i$ ($\pm_{1}$)

## 8.3 QUBO Problems

**QUBO** (Quadratic Unconstrained Binary Optimization) is a formulation of **optimization problems** equivalent to the Hamiltonian of a system. In a QUBO problem, the variables are binary (0 or 1), and the objective function to be minimized is a quadratic polynomial.

The mathematical form of a QUBO problem is typically expressed as:
$$
y = \sum_{i}{a_{i}x_{i}} + \sum_{i > j}{q_{ij}x_{i}x_{j}}
$$
or equivalently in matric form:
$$
\mathrm{argmin} \ y = xQx^{T} 
$$
where:
- $y$ is the value of the objective function to be minimized.
- $x \in \{ 0, 1 \}^{n}$ are the binary variables, connected to the ising formulation with $s = 2x-1$.
- $n$ is the problem size.
- $Q\in \mathbb{R}^{n \times n}$ is the matrix representing the loss function with $q_{ii} = a_{i}$.

Note that $x_{i}^{2} = x_{i}$.

## The transverse field Ising model

The transverse field Ising model is a quantum version of the Ising model. It describes the interactions between quantum particles.

The energy of this system is given by the Hamiltonian:
$$
\hat{H}_{\text{ising}} = \sum_{i}{h_{i}Z_{i}} + \sum_{i > j}{J_{ij}Z_{i}Z_{j}}
$$
where:

- $Z_{i}$ is the Pauli-Z gate on spin $i$.

Note that "energy" $\hat{H}$ is an **operator** (a matrix) applied to state $\ket{v}$.

## The Eigenspectrum

Remember the definition of **eigenvector** and **eigenvalue**: for an operator $A$, if it acts on a vector $x$ and simply scales $x$ by a scalar factor $\lambda$, then $x$ is called an *eigenvector* of $A$, and $\lambda$ is its corresponding *eigenvalue*.
$$
Ax = \lambda x
$$
Consider now the **time-dependent Schrödinger equation**:
$$
\hat{H} \ket{v} = E \ket{v}
$$
where:

- $\hat{H}$ is the Hamiltonian operator of the system
- $\ket{v}$ is the quantum state
- $E$ is the energy of state $\psi$

We have that the product of the Hamiltonian for a state $\ket{v}$ is equal to an energy times the same state. This is **only true if $E$ is an eigenvalue of $\hat{H}$**. This result is important, because it tells us that there are **stationarity states** where the system will remain as time passes.

The **eigenspectrum** refers to the entire set of possible eigenvalues (energy levels) for a given Hamiltonian.

## Adiabatic Quantum Computing (AQC)

Instead of building a circuit to do what we want, one operation at a time, we leverage the natural tendency of a physical system to evolve towards (and remain into) a state of minimal energy.

An **adiabatic process** is a process occurring very slowly, without transferring energy or mass with the system's surroundings. 

The **adiabatic theorem for the evolution of a quantum system** states that:

> If there is an energy gap between the ground state and other states, ***and*** if the evolution of the system in time is sufficiently slow, ***then*** the system remains in a state of minimal energy (ground state).

The idea is that we have a problem to solve which we can represent as the energy of a quantum system called Hamiltonian. The minimum energy state (**ground state**) corresponds to the **solution** we want, it is however difficult to find. We can evolve a quantum system maintaining it in a minimum energy state (adiabatic).

The procedure is the following:

- Start from a **superposition** configuration in which the system can easily find the ground state.
- **Slowly** alter the system to include the problem we want to solve while reducing the weight of the initial configuration.
- Once the initial configuration weight goes to zero, the system only depends on the problem we want to solve, and it remains in the ground state.
- Read the state of the system to get the solution.

AQC changes the energy landscape to drive the system into the energy minimum with the highest possible probability

## Time-dependent Hamiltonian

The energy of a quantum system can be represented by a time-dependent Hamiltonian, which is composed by two terms:
$$
H(t) = A(t)H_{A} + B(t)H_{B}
$$
where:

- $H_{A}$ represents the Hamiltonian for the initial state
- $H_{B}$ represents the Hamiltonian for the problem that we want to solve
- $A(t)$ and $B(t)$ control the weight of the two Hamiltonians over time

The initial Hamiltonian should enable convenient preparation of the quantum state from which the computation begin. A frequently used Hamiltonian is in the form
$$
H_{A} = - \sum_{i}^{n}{X_{i}}
$$
where each term $X_{i}$ represents the $n$-fold tensor product of identity operators $I$ and the $X$ operator for the $i$-th qubit ($X_{i}$ is the Pauli-X matrix acting on qubit $i$).

Energy eigenstates and eigenvalues for this Hamiltonian can be easily constructed. Its ground state is a perfect superposition of all qubits.

## Ising model and QUBO problems

Currently available QA hardware relies Hamiltonian that describes an Ising model. The Ising model describe he interactions between particles $\hat{\sigma}$.
$$
H_{\text{ising}} = \underbrace{A(t)H_{A}}_{\text{Initial Hamiltonian}} + \underbrace{B(t)\left( \sum_{i}{h_{i}s_{i}} + \sum_{i > j}{J_{ij}s_{i}s_{j}} \right)}_{\text{Problem Hamiltonian}}
$$
A problem can be described by setting the values of $h_{i}$ and $J_{ij}$. The Ising Hamiltonian describes a Quadratic Unconstrained Binary Optimization problem (**QUBO**).

## Adiabatic Quantum Computation VS Quantum Annealing VS Gate Model

In the gate model we directly manipulate the quantum state using gates. This is very powerful computationally (*universal*), but also difficult to do in practice. 

AQC is equivalent to the gate model. In the AQC paradigm we build a representation of do problem, but we do not have control on the quantum states during the adiabatic process. Building an adiabatic computer may be easier, but the current ones are not universal quantum computers, they are **quantum annealers**.

AQC leverages quantum tunneling, just as Quantum Annealing, and in general has a wider computational power. Adiabatic convergence is stricter than QA, so the first implies the latter (AQC is a specific type of QA, which is also *universal*). Quantum Annealing evolves the same Hamiltonian but relaxes on some of the stringent requirements of the adiabatic theorem.

## Quantum Annealing and D-Wave

Adiabatic Quantum Computing is theoretically equivalent to the quantum circuit model. However, AQC must search for the ground state of a **non-stoquastic** Hamiltonian in order to be *universal*.

D-Wave QPU (Quantum Processing Units, a quantum computer chip) samples from the ground state of an Ising Hamiltonian (which is stoquastic and not universal).This means they are particularly well-suited for optimization problems that can be formulated in the Ising model.

D-Wave QPU has a spare structure/architecture. This refers to the physical connectivity between qubits. It is impractical to directly couple every bit to every other qubit in a large-scale quantum chip To overcome this limitation, it entangles multiple qubits to represent virtual qubits with higher connections.


## Sampling 

One of the most immediate consequences it that we cannot rely on a single measurement, but we need to run the experiment multiple times to account for the impact of both the noise and the limited evolution schedule.

We use QA to do sampling from a certain energy distribution.

## Final Overview

![[Pasted image 20250524134644.png|center|400]]

# Variational Quantum Algorithms (VQAs)

Today's quantum computers are too small and noisy to natively run most quantum algorithms, they are called NISQ (Noisy Intermediate Scale Quantum).

The idea is to use a **hybrid quantum-classical approach** where QC is used for a specific part of the computation, while classical methods wrap this quantum subroutine optimizing it for the specific objective function of interest.

A hybrid quantum-classical algorithm (VQA) is characterized by:

- **Parametric quantum circuit** (ansatz), the gates applied are known but some have parameters that can be changed
- **Classical optimizer** to find the optimal gate parameters
- **Iterative** execution of the quantum circuit

## Parametric Quantum Circuit (ansatz)

Some quantum gates have parameters that affect their behavior. All rotation gates $R_{x}, R_{y}, R_{z}$ have as parameter the angle of magnitude. 

For example, the Hadamard gate is a special rotation that can be expressed as a 90° rotation around the Y-axis, followed by a 180° rotation around the X-axis (causing a global phase):
$$
H = R_{x}(\pi)R_{y}\left( \frac{\pi}{2} \right) = -iH
$$
Different circuits have been proposed, with different gate structures and degrees of freedom. It is best for an ansatz to be shallow and use gates that are available on the hardware.

They are relatively problem-agnostic, however they exhibit different complexity which may make them more or less expensive. The Ansatz must be able to reach the solution of the problem with the right parameters.

The **Hardware Efficient Ansatz** is one of many possible ansatz, it consists of a succession of rotation gates and "entangling" 2-qubit gates repeated a certain number of times $D$

![[Pasted image 20250603183853.png|center|400]]

## Classical Optimizer

The goal of the classical optimizer is to find which are the parameters of the quantum circuit that optimize the desired **objective function** computed on the outcome of the measurement.

The choice of optimizer is relatively free and different ones will perform in different ways.

## Iterative Process

1. Initialize parameters
2. Run the quantum circuit
3. Measure the result
4. Compute the objective function
5. Feed the explored parameter values to the classical optimizer
6. Pick the next parameters and repeat from 1. until a termination condition is reached

The circuit is run (if necessary) to compute the solution of the problem.

![[Pasted image 20250603184444.png|center]]

## Strengths and Weaknesses of Variational Algorithms

VQAs are the most promising algorithms for **NISQ devices**:

- Shallow circuits are more resilient to noise
- Repeated sampling and optimization makes them robust to errors
- Ample flexibility

However, they have some drawbacks:

- Approximate methods
- The iterative process makes them slow and resource intensive, which makes unlikely to observe any quantum advantage
- Difficult to obtain formal guarantees on their effectiveness
- Classical optimizer may not find good parameters

Mostly, we use them because they are the only ones we can run on NISQ devices.

## Barren Plateaus

**Barren Plateaus** is a significant challenge encountered in Variational Quantum Algorithms (VQAs). In barren plateaus the magnitude of the **gradient of the cost function exponentially vanishes** with the same size.

Finding good parameters becomes impossibly difficult as the problem size increases. The optimizer is **not able to find the global optimum**.

To mitigate the issue of barren plateaus, strategies include:

- parameter initialization
- suitable ansatz
- efficient optimizer

## Variational Quantum Eigensolver (VQE)

The **Variational Quantum Eigensolver (VQE)**, together with the **Quantum Approximate Optimization Algorithm (QAOA)** are the most largely adopted Variational Quantum Algorithms.

The VQE can be used to find the ground state of a molecule, which is useful to understand behavior of atoms in chemical reactions. In VQE, the energy landscape of a molecule is represented in terms of a matrix $H$, called Hamiltonian, which represents all kinetic and potential energies of the particles in the molecule.

We know the Hamiltonian is an *operator*, it **maps quantum states into quantum states**:
$$H \ket{\psi} = \ket{\varphi}$$
Intuitively, if I know how the energies of the particles relate to each other I can look for states in which the molecule is **stable**:
$$
H \ket{\psi_{i}} = \lambda_{i} \ket{\psi_{i}}
$$
In this case $\ket{\psi_{i}}$ is an eigenstate of $H$ and $\lambda_{i}$ the corresponding eigenvalue. $H$ describes the energy of a system, its eigenvalues $\lambda_{i}$ are all the possible **energy levels**.

The VQE allows to find the **minimum eigenvalue $\lambda_{\min}$** of a Hamiltonian and its associated eigenstate $\ket{\psi_{\min}}$, known as the ground state.

### Expectation Value

We use the notation $\braket{ A }$ to denote the expectation value of a matrix $A$.

Intuitively, it is the "average" value of all the measurements of a certain experiment. However, it may not correspond to any single measurement.

**In classical theory**: Suppose we compute the expectation of measuring a dice $\braket{ D }$. This corresponds to the "value" associated to the measurement (1...6), times the probability of measuring that value:
$$
\braket{ D }  = \frac{1}{6}(1 + 2 + 3 + 4 + 5 + 6) = \frac{21}{6} = 3.5
$$
In a **quantum** system the possible measurements correspond to all possible eigenstate-eigenvalues couples. The expectation value of a state $\ket{\psi}$ depends on an operator $O$ (in the classical example: "look at the upper side of the dice"), which is what we use to make the measurement. In a quantum system it can be computed as
$$
\braket{ O }  = \braket{ \psi | O | \psi }
$$
We always measured along the Pauli-z axis: $\ket{0}, \ket{1}$, hence $O = \sigma_{z}$.

If you change the operator, you can can get different expectations for the same state.

---

***Example***

Say that we want to compute the expectation value of a $\ket{+}$ state:

- **Measurement operator Pauli-z**, we associate value 0 to $\ket{0}$ and 1 to $\ket{1}$:$$\braket{ \sigma_{z} }  = \braket{ + | \sigma_{z} | + } = \frac{1}{2} \cdot 0 + \frac{1}{2} \cdot 1 = \frac{1}{2}$$
- **Measurement operator Pauli-x**, we associate value 0 to $\ket{-}$ and 1 to $\ket{+}$:$$\braket{ \sigma_{x} } = \braket{ + | \sigma_{x} | + } = 0 \cdot 0 + 1 \cdot 1 = 1$$
---

### Variational Principle for VQE

The algorithm is based on the **Rayleigh-Ritz Variational Principle**, according to which:
$$
\braket{ \psi | H | \psi } \geq \lambda_{\min},\qquad\forall\psi\in \mathbb{C}^{N}, \quad N = 2^{n}
$$
In particular, **this lower bound is obtained for $\ket{\psi}= \ket{\psi_{\min}}$**
$$
\braket{ \psi_{\min} | H |\psi_{\min} } = \lambda_{\min}
$$
Therefore, if the ground state $\ket{\psi_{\min}}$ **is one of the possible outcomes** of the parametric circuit, minimizing the expectation is equivalent to finding the minimum eigenvalue of the Hamiltonian $H$.


### VQE Objective Function

The **objective function** considered by the VQE is in the form of
$$
\underset{\theta}{\mathrm{argmin}} \ C(\theta) = \braket{ \psi(\theta) | H | \psi(\theta) } 
$$
where $\ket{\psi(\theta)}$ is the final state prepared by the ansatz, and $\theta$ the parameters of the gates. We want to minimize the expectation with respect to the Hamiltonian of the molecule.

The expectation measured with H can be decompressed based on its constituent Pauli matrices and then measured with $(\sigma_{x}, \sigma_{y}, \sigma_{z})$.

### VQE Iteration in Practice

1. The ansatz is used to generate a quantum state $\ket{\psi(\theta)}$, based on the parameters $\theta$ of the gates.
2. A second stage of the quantum circuit computes $\braket{ \psi(\theta) | H | \psi(\theta) }$.
3. Estimate $C(\theta)$ by running the circuit multiple times to measure first with $\sigma_{x}$, then $\sigma_{y}$, and finally $\sigma_{z}$.
4. Send the objective function value to the classical optimizer

## Quantum Approximate Optimization Algorithm (QAOA)

QAOA is a Variational Algorithm to solve **combinatorial optimization problems** on NISQ devices and is a special case of VQE. 

In practice, industry needs algorithms that work well off-the-shelf and that can be easily adapted to a variety of needs and problems. An algorithm that requires a dedicated team of experts to be adapted to a different problem is likely going to be more efficient but also much more expensive to use.

We would like a method to solve a very large class of problems, this is what QAOA does. Given an optimization problem, QAOA needs it represented with a rather generic formulation, as Hamiltonian $H_{c}$.

The advantage is that all combinatorial optimization problems can be represented in a single formulation. However, we lose the knowledge of the specific problem structure, which is usually what is leveraged by efficient classical solvers.

We have:

- The **Cost Hamiltonian**: its ground state should be the solution of the problem we want to solve.
- The **Mixer Hamiltonian**: its purpose is to explore the space of possible quantum space (i.e., other possible solutions to the problem)

The optimization goal is the same as VQE: optimize $\arg\min \braket{ \psi(\theta) | H | \psi(\theta) }$.

### Unitaries from Hamiltonians

A unitary $U$ can be represented as the exponential of a Hamiltonian $H$. In fact, any quantum gate can be seen as an evolution from the initial state to another with a lower energy:
$$
U = e^{-i\alpha H}
$$
Where $\alpha$ is a scalar value. For example, the $R_{z}$ gate can be represented as
$$
R_{z}(\theta) = e^{-i \frac{\theta}{2}\begin{bmatrix}
1 & 0 \\ 0 & -1
\end{bmatrix}}
$$

### Structure of the QAOA Ansatz

The QAOA ansatz consists of a layer of Hadamard gates used to create a superposition, followed by $p$ **layers** of:

1. **Cost Hamiltonian** $H_{c}$: encodes the problem we want to solve$$U_{c} (\gamma_{i}) = e^{-\gamma_{i} H_{c}}, \qquad \gamma_{i} \in \mathbb{R}, \quad \forall i = 1, \dots, p$$
2. **Mixer Hamiltonian** (fixed): explores the space of quantum states $$\begin{matrix} H_{M} = \sum_{j} \sigma_{X}^{j} \\[1em] U_{M}(\beta_{i}) = e^{-i \beta_{i} H_{M}}, \qquad b_{i} \in \mathbb{R}, \quad \forall i = 1, \dots, p \end{matrix}$$where $\sigma_{X}^{j} = I \otimes \dots \otimes I \otimes \sigma_{X} \otimes I \otimes \dots \otimes I$, hence $\sigma_{X}$ is the $j$-th term of $n$ tensor products with the 2-by-2 identity matrix.

### Implementing the Cost Operator

The **implementation of the cost operator** $U_{c}(\gamma_{i}) = e^{-i \gamma_{i} H_{c}}$ with suitable gates is a non trivial step in the realization of the QAOA circuit.

The most common strategy for realizing the cost operator is to write $H_{c}$ as a **sum of tensor products of Pauli operators (i.e., $\sigma_{X}$, $\sigma_{Y}$, $\sigma_{Z}$)**. In this way, $U_{c}(\gamma_{i})$ can be implemented using **rotation gates**.

### QUBO Problems

A family of problems that is well suited to the QAOA formulation is **Quadratic Unconstrained Binary Optimization (QUBO)** problems.

The most general QUBO formulation is: find
$$
\min_{x \in \{ 0, 1 \}^{n}} x^{T}Qx
$$
where:

- $x \in \{ 0, 1 \}^{n}$ is a vector of $n$ binary variables
- $Q$ is a $n \times n$ matrix, either symmetric or upper-triangular

Suppose now that we have a problem in QUBO formulation and would like to compute its corresponding Hamiltonian to then derive the cost unitary:

1. Convert the QUBO problem from binary variables into spin variables $s \in \{ -1, +1 \}$ with a simple equivalence: $s = 2x - 1$.
2. Compute the cost Hamiltonian:$$H_{c} = \sum_{i} S_{i,i} \sigma_{Z}^{i} + \sum_{j > i} S_{i, j} \sigma_{Z}^{i} \sigma_{Z}^{j}$$where $S_{i,j}$ are coefficients from the QUBO problem with spin variables. Note that $S$ is $n \times n$ while $H_{c}$ is $2^{n} \times 2^{n}$.

### Implementing the Cost Unitary in Practice

In practice, the circuit for the cost Hamiltonian is built in this way:

- A layer of $R_{z}$ rotations on all qubits, corresponding to the $\sigma_{Z}^{i}$ in the Cost Hamiltonian.
- For all the variables-qubit that have coefficients $S_{i,j} \neq 0$ in the QUBO model with spin variables, add the following circuit ($\gamma$ is a parameter): 
  ![[Pasted image 20250606152128.png|center|300]]
- A layer of $R_{x}(\beta)$ on all qubits with the same angle.

---

***Example***

If we have 3 variables all interacting with each other, a QAOA circuit with only 1 layer of Cost Hamiltonian and Mixer Hamiltonian is as follows:

![[Pasted image 20250606152335.png|center]]

with:

- $S_{i, j}$ the coefficient of the quadratic term of $i, j$ in spin variables
- $\gamma_{1}, \beta_{1}$ the ansatz parameter for layer 1.