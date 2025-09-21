<center><h1 style="color: var(--text-accent)">Applied Statistics Notes</h1></center>
<center><i>Claudio Tessa - 2024/2025</i></center>

# 1 High-Dimensional Data & Principal Component Analysis

The new central issue in multivariate (MV) analysis is the investigation of **dependence**, **correlation** among variables:

![[Pasted image 20250531132201.png|center|400]]

## 1.1 Covariance and correlation

Sample **covariance** between two variables $\boldsymbol{x}_{j}$ and $\boldsymbol{x}_{k}$:
$$
cov_{jk} = s_{jk} = \frac{1}{n-1} \sum_{i = 1}^{n}{(x_{ij} - \bar{x}_{j})(x_{ik} - \bar{x}_{k})}
$$
Sample **correlation coefficient** between two variables $\boldsymbol{x}_{j}$ and $\boldsymbol{x}_{k}$:
$$
corr_{jk} = r_{jk} = \frac{s_{jk}}{\sqrt{ s_{jj} } \sqrt{ s_{kk} }} = \frac{\sum_{i = 1}^{n} { (x_{ij} - \bar{x}_{j})(x_{ik} - \bar{x}_{k})}}{\sqrt{ \sum_{i = 1}^{n}(x_{ij} - \bar{x}_{j})^{2} } \sqrt{ \sum_{i = 1}^{n}(x_{ik} - \bar{x}_{k})^{2} }}
$$
For describing a sample of MV data, we may then use:

- The vector of **sample means**:$$\boldsymbol{\bar{x}} = \begin{bmatrix} \bar{x}_{1}, \dots, \bar{x}_{p} \end{bmatrix}$$
- The **variance-covariance** or **correlation matrix**:$$S = \begin{bmatrix} s_{11} & \dots & s_{1p} \\ \vdots & \ddots & \vdots \\ s_{p1} & \dots & s_{pp} \end{bmatrix} \qquad \qquad R = \begin{bmatrix} 1 & \dots & r_{1p} \\ \vdots & \ddots & \vdots \\ r_{p1} & \dots & 1 \end{bmatrix}$$

the value of $r$ ranges in $[-1, 1]$. It is essentially the covariance divided by the product of the standard deviations. $r$ measures the **strength of the linear association**:

- $r = 0$ implies lack of linear association between the components.
- $r < 0$ implies a tendency for one value in the pair to be larger than its average than its average when the other is smaller than its average.
- $r > 0$ implies a tendency for one value in the pair to be large when the other value is large, and also for both values to be small together.
- $|r| = 1$ implies the two variables are perfectly correlated, negatively or positively.

## 1.2 Dimensionality reduction

Consider the data matrix $X$ of dimensions $n \times p$, being $n$ the **number of statistical units** and $p$ the **dimension of the single unit**, which may be **correlated**.

We would like to **summarize** the data with many $p$ variables by a **smaller** set of $k$ derived variables in a new matrix $M$ of dimensions $n \times k$. We will have **residual**, information in $X$ that is not retained in $M$. It is a **balancing** act between the dimension $k$ and the loss of important information.

## 1.3 Principal Component Analysis

Considering the data matrix $X$ of dimension $n \times p$, being $n$ the **number of statistical units** and $p$ the **dimension of the single unit**, which may be **correlated**.

A **Principal Component Analysis (PCA)** is concerned with **explaining the **variance-covariance structure** of the set of variables contained in $X$ through a **few linear combinations of these variables**.

If we have $p$ variables in our dataset, although $p$ components are required to reproduce the total system variability, often much of **this variability can be accounted for by a smaller number ($k$) of the principal components**, displaying as much as possible of the variation among objects.

PCA then produces a **low-dimensional representation of a dataset**. It needs a sequence of linear combinations of the variables that have maximal variance, and are mutually uncorrelated.

The $k$ components can then replace the original $p$ variables, and the original dataset, consisting of **$n$ measurements of $p$ variables**, is reduced to a dataset consisting of **$n$ measurements on $k$ principal uncorrelated components**. The choice of $k$ is a **tradeoff choice**. The best $k$ is the smallest $k$ capturing "enough" variability of our dataset.

The $n$ observations previously represented in $p$ variables system are then projected in the new $k$ principal component analysis. The **data projected** is called **Scores**. The new system of coordinates used to identify the subspace is obtained via linear combination of the original variables. The **weights** given to each original variables to compute the new system of coordinates are called **loadings**.

In matrix notation:

![[Pasted image 20250531141956.png|center|300]]

the two matrices $V$ and $U$ are **orthogonal**:

- The matrix $V$ is called the **loadings matrix**.
- The matrix $U$ is called the **scores matrix**, and contains the original data in a rotated system where the loadings are the weights with whom each original variable contributes to the rotated one

PCA projects data along the directions of maximal variability, to **maximize variance**, and **minimize residuals**.

We can write the original observations in a new reference system as a **linear combination of the original dimensions**:
$$
PC_{j} = \phi_{1j} x_{1} + \phi_{2j} x_{2} + \dots + \phi_{pj} x_{p}
$$
and the single observation (**score $i$**) in the PCA space will be
$$
z_{ij} = \phi_{1j} x_{i 1} + \phi_{2 j} x_{i 2} + \dots + \phi_{pj} x_{ij}
$$
The original variables are linearly combined together weighted according to the loadings to obtain the new system of coordinates.

## 1.4 PCA as optimization problem

Given random variables $X_{1}, \dots, X_{p}$, identify $k$ linear combinations of the variables that maximally represent their variability.

***First Principal Component***

Normalized linear combination that maximized the variance:
$$
z_{1} = \phi_{11} X_{i} + \phi_{21} X_{2} + \dots + \phi_{p 1} X_{p}
$$
With maximum variance, subject to $\sum_{i = 1}^{p}{\phi_{j 1}^{p}} = 1$.

Loading vector (normalized): $\boldsymbol{\phi_{1}} = (\phi_{11}, \dots, \phi_{p_{1}})'$.

We need to solve an optimization problem (we assume we have **0 mean**):

Data: $\mathbb{X} = [x_{ij}]$. Assume $\mathbb{E}[X_{j}] = 0$ (otherwise consider $\tilde{\mathbb{X}} = [\tilde{x}_{ij}], \tilde{x}_{ij} = x_{ij} - \tilde{x}_{j}$).

Linear combination for the $i$-th statistical unit:
$$
z_{i1} = \phi_{11} x_{i 1} + \phi_{21} x_{i 2} + \dots + \phi_{p 1} x_{ip} = \sum_{j = 1}^{p}{\phi_{j 1} x_{ij}}
$$
Problem:
Find $\boldsymbol{\phi_{1}} = (\phi_{11}, \dots, \phi_{p 1})'$ solution to
$$
\max_{\phi_{11}, \dots, \phi_{p 1}}{\left\{  \frac{1}{n} \sum_{i = 1}^{n}{\underbrace{\left( \sum_{j = 1}^{p}{\phi_{j 1} x_{ij}} \right)}_{z_{i 1}^{2}}}^{2}  \right\}} \quad\text{s. t.} \quad \sum_{j = 1}^{p}{\phi_{j1}^{p}} = 1
$$
The vector of loadings related to the first principal component is found as the **first eigenvector** of the sample covariance matrix $\mathbb{S}$, ordering the eigenvalues from latest to smallest.

Note: The sample covariance matrix is symmetric and positive semidefinite, so all its eigenvalues are real and non-negative.

Eigenvector of $\mathbb{S}: \boldsymbol{e}_{1}, \dots, \boldsymbol{e}_{p}$ such that $\mathbb{S} \boldsymbol{e}_{j} = \lambda_{j} \boldsymbol{e}_{j}$, sorting eigenvalues as $\lambda_{1} \geq \lambda_{2} \geq \dots \geq \lambda_{p} \geq 0$.
The first PC is then $\boldsymbol{\phi_{1}} = \boldsymbol{e}_{1}$.

***Second Principal Component***

Normalized linear combination of variables
$$
Z_{2} = \phi_{12} X_{1} + \phi_{22} X_{2} + \dots + \phi_{p 2} X_{p}
$$
which is uncorrelated with $Z_{1}$ and has the maximum variance, such that $\sum_{i = 1}^{p}{\phi_{j 2}^{2}} = 1$.

Loadings vector: $\boldsymbol{\phi}_{2} = (\phi_{1 2}, \dots, \phi_{p 2})'$. We can show that imposing $Cov(Z_{1}, Z_{2}) = 0$ is equivalent to $\boldsymbol{\phi}_{1} \perp \boldsymbol{\phi}_{2}$.

Data: $\mathbb{X} = [x_{ij}]$. Assume $\mathbb{E}[X_{j}] = 0$ (otherwise consider $\tilde{\mathbb{X}} = [\tilde{x}_{ij}], \tilde{x}_{ij} = x_{ij} - \tilde{x}_{j}$).

Linear combination for $i$-th statistical unit:
$$
z_{12} = \phi_{12} x_{i 1} + \phi_{2 2}x _{i 2} + \dots + \phi_{p 2} x_{i p} = \sum_{j = 1}^{p}{\phi_{j 2} x_{i j}}
$$
Optimization problem:
Find $\boldsymbol{\phi}_{2} = (\phi_{12}, \dots, \phi_{p 2})'$ solution to
$$
\max_{\phi_{1 2}, \dots, \phi_{p 2}}{\left\{  \frac{1}{n} \sum_{i = 1}^{n}{\left( \sum_{j = 1}^{p}{\phi_{j 2} x_{i j}} \right)^{2}}  \right\}} \quad \text{subject to} \quad \sum_{j = 1}^{p}{\phi_{j 2}^{2}} = 1, \quad \sum_{j = 1}^{p}{\phi_{j 1}\phi_{j 2}} = 0
$$
Solution: $\boldsymbol{\phi}_{2} = \boldsymbol{e}_{2}$ **second eigenvector** of the sample covariance matrix.

# 2 Clustering Methods

Clustering is a technique used in **unsupervised learning** to group objects into clusters. The grouping has to be such that the **objects in the same group are similar** to each other, while at the same time **different from objects belonging to other groups**.

The goal is to **minimize intra-cluster distances** (the distances between objects within the same cluster) and **maximize inter-cluster distances** (the distances between objects in different groups)

There are two different kinds of clustering:

- **Hierarchical** clustering: a set of nested clusters organized as a hierarchical tree. It can be:
	- Agglomerative
	- Divisive
- **Partitional** clustering: a division of data objects into subsets (clusters) such that each data object is exactly in one subset.

## 2.1 Distances

Given two $p$-dimensional vectors $x = (x_{1}, x_{2}, \dots, x_{p})$ and $y = (y_{1}, y_{2}, \dots, y_{p})$, the **distance** between $x$ and $y$ may be computed in several ways:

- **Euclidian Distance**: $$d_{E}(x, y) = \sqrt{ (x_{1} - y_{1})^{2} + (x_{2} - y_{2})^{2} + \dots + (x_{n} - y_{n})^{2} } = \sqrt{ \sum_{i = 1}^{n} (x_{i} - y_{i})^{2} }$$
- **Squared Euclidian Distance** (gives more emphasis to outliers): $$d_{E^{2}}(x, y) = (x_{1} - y_{1})^{2} + (x_{2} - y_{2})^{2} + \dots + (x_{n} - y_{n})^{2} = \sum_{i = 1}^{n} (x_{i} - y_{i})^{2}$$
- **Standardized Euclidian Distance** (weights dimensions with the inverse of the variability on that dimension):  $$d_{SE}(x, y) = \sqrt{ \dfrac{1}{s_{1}^{2}}(x_{1} - y_{1})^{2} + \dots + \dfrac{1}{s_{n}^{2}} (x_{n} - y_{n})^{2}} = \sqrt{ \sum_{i = 1}^{n} \frac{1}{s_{i}^{2}}(x_{i} - y_{i}) }$$
- **Chebychev Distance** (for each dimension, selects the one for which the distance is grater. Very sensitive to outliers): $$d_{max}(x, y) = \max_{i} |x_{i} - y_{i}|$$
- **Manhattan Distance**: $$d_{M}(x, y) = |x_{1} - y_{1}| + |x_{2} - y_{2}| + \dots + |x_{n} - y_{n}| = \sum_{i = 1}^{n} |x_{i} - y_{i}|$$
- **Correlation-based Distance**: $$d_{R}(x, y) = 1 - r_{xy}$$where $$r_{xy} = \frac{S_{x, y}}{\sqrt{ S_{x} } \sqrt{ S_{y} }} = \frac{\sum_{i = 1}^{n}(x_{i} - \bar{x})(y_{i} - \bar{y})}{\sqrt{ \sum_{i = 1}^{n}(x_{i} - \bar{x})^{2} \sum_{i = 1}^{n}(y_{i} - \bar{y})^{2} }}$$
Choosing the "right" metric is something that depends on the application, based on what kind of similarity we are interested in evaluating.

## 2.2 Clustering Evaluation

To verify the goodness of a clustering, it is possible to use numerical indices, which are typically grouped into the following three families:

- **External Metrics** - If some external class label is provided:
	- $n$ = number of points
	- $m_{i}$ = points in cluster $i$
	- $c_{j}$ = points in class $j$
	- $m_{ij}$ = points in cluster $i$ coming from class $j$
	- $p_{ij} = \dfrac{m_{ij}}{m_{i}}$ = frequency of elements from class $j$ in class $i$
	- **Entropy**:
		- of a *cluster* $i$: $\displaystyle e_{i} = - \sum_{j =1}^{K} p_{ij} \log p_{ij}$
		- of a *clustering*: $\displaystyle e = \sum_{i = 1}^{K} \frac{m_{i}}{n}e_{i}$
	- **Purity**:
		- of a *cluster* $i$: $\displaystyle p_{i} = \max_{j} p_{ij}$
		- of a *clustering*: $\displaystyle purity = \sum_{i = 1}^{K} \frac{m_{i}}{n}p_{i}$
	- **Precision**:
		- of a *cluster* $i$ with respect to class $j$: $Prec(i, j) = p_{ij}$
		- of a *clustering*: take the maximum
	- **Recall**:
		- of a *cluster* $i$ with respect to class $j$: $\displaystyle Rec(i, j) = \frac{m_{ij}}{c_{j}}$
		- of a *clustering*: take the maximum
	- **F-measure**:
		- *Harmonic mean* of Precision and Recall: $\displaystyle F(i, j) = \frac{2 \cdot Prec(i, j) \cdot Rec(i, j)}{Prec(i, j) + Rec(i, j)}$
- **Internal Metrics** - Used to evaluate the clustering without any reference to external information:
	- **Sum of Squared Errors (SSE)**: sum of the squared distances between all observations in a cluster and the corresponding medoid: $$E(C) = \sum_{i = 1}^{k} \sum_{o \in C} d(o, cen_{i})^{2}$$
	- **Within Clusters Sum of Squares (WCSS)**: $$WCSS = \sum_{P_{i} \text{ in Cluster 1}}{d(P_{i}, C_{2})^{2}} + \sum_{P_{i} \text{ in Cluster 2}}{d(P_{i}, C_{2})^{2}} + \dots$$
	- What is the **correct number of clusters**? Identify the **elbow** of the curve that represents the internal metrics as the number of clusters varies (e.g., 5 in this example):
	  ![[Pasted image 20250603230743.png|center|300]]
- **Relative Metrics**: used to compare different clusterings with each other (e.g., SSE or entropy).

## 2.3 Hierarchical Clustering

With this method, cluster are organized as a hierarchical tree. There are two main types of hierarchical clustering:

- **Agglomerative** - Start with points as individual clusters. At each step, merge the closest pair of clusters until only one cluster (or $k$ clusters) is left.
- **Divisive** - Start with one, all inclusive cluster. At each step, split a cluster until each cluster contains a point (or there are $k$ clusters).

![[Pasted image 20250603231604.png|center|400]]

Hierarchical clustering uses a **Distance Matrix** to implement groupings. The Distance Matrix contains the distance between every pair of observations.

Hierarchical clustering does not require the number of groups to be defined a priori, but it does require a stopping criterion.

## 2.4 K-means

In the K-means method, the goal is to find a partition of the observation in a given number $K$ of groups. **Each observation is assigned to one and only one group.**

Each cluster is associated with a **centroid** (central point). Each point is then assigned to the cluster with the **nearest centroid**. The number of clusters $K$ must be specified a priori.

The algorithm objective is to minimize the sum of the distances of the points from their respective centroids.

Let $C_{1}, \dots, C_{k}$ the index sets of each cluster. They form a partition:

- $C_{1} \cup C_{2} \cup \dots \cup C_{k} = \{ 1, 2, \dots, n \}$: each observation belongs to at least one cluster
- $C_{i} \cap C_{j} = \emptyset$: each observation belongs to only one cluster.

$\implies i\in C_{k}$ if the $i$-th observation belongs to the $k$-th cluster.

### 2.4.1 K-Means as an Optimization Problem

Given a st $\mathbf{X}$ of $n$ points in a $d$-dimensional space and an integer $K$, group the points into $K$ clusters $C = \{ C_{1}, C_{2}, \dots, C_{k} \}$ such that
$$
Cost(C) = \sum_{i = 1}^{k} \sum_{x \in C_{i}} dist^{2}(x, c_{i})
$$
is **minimized**, where $c_{i}$ is the centroid of the points in cluster $C_{i}$.

A **good clustering** is one such that **within cluster variability** is as small as possible:
$$
W(C_{k}) = \frac{1}{|C_{k}|} \sum_{i, i' \in C_{k}} d^{2}(\mathbf{x}_{i}, \mathbf{x}_{i'}) = \frac{1}{|C_{k}|} \sum_{i, i' \in C_{k}} \sum_{j} (x_{ij} - x_{i', j})^{2}
$$
Find $C_{1}, \dots, C_{k}$
$$
\min_{C_{1}, \dots, C_{k}} \sum_{k = 1}^{K} W(C_{k})
$$

### 2.4.2 K-means: Algorithm

1. **Initialization** - Assign each observation randomly to a cluster
2. **Iteration** - Repeat until convergence:
	- *Identification of the centroids*: for $k = 1, \dots, K$ $$\bar{x}_{k} = \frac{1}{|C_{k}| } \sum_{i \in C_{k}} x_{i}$$
	- *Assignment*: assign $x_{i}$ to cluster $C_{k}$ with closest centroid.

K-means always converges, but not necessarily to the global optimum (heavily dependent on the initialization). Typically, K-means is repeated several times with different initializations:

- Select original set of points by methods at **random**
- Select original set of points **other than at random**: e.g., pick the most distant from each other.

Contrarily to hierarchical clustering, here we must fix $k$. Moreover, K-means struggles when clusters have different sizes, or densities.

![[Pasted image 20250608160814.png|center|200]]

The use of Euclidean distance makes the algorithm sensitive to outliers. We can use **medoids** (median points) instead of centroids (this is called K-medoids algorithm).

![[Pasted image 20250608160941.png|center|150]]

## 2.5 Gaussian Mixture Model (GMM)

Used to represent a population composed of multiple subpopulations, each modeled by a Gaussian distribution.
$$
X_{1}, \dots X_{n} \sim^{iid} p(x) = \sum_{k = 1}^{K} w_{k} \mathcal N(x | \mu_{k}, \Sigma_{k})
$$
where $w_{k} \geq0$ and $\sum_{k = 1}^{K} w_{k} = 1$

Introduce $z_{1}, \dots, z_{n}$, $z_{i}\in \{ 0, 1 \}^{k}$ with $z_{i}[j] = 1 \iff X_{i} \in Cluster_{j}$

**Joint low** 
$$p(X, Z) = \left[ \prod_{i = 1}^{n} \prod_{k = 1}^{K} \mathcal N(x_{i} | \mu_{k}, \Sigma_{k}) w_{k} \right]^{z_{i}[k]}$$
depends on unknown parameters $\underline{\mu} = (\mu_{1}, \dots, \mu_{k})$, $\underline{\Sigma} = (\Sigma_{1}, \dots, \Sigma_{k})$, $\underline{w} = (w_{1}, \dots, w_{k})$.

**Condition low** $p(Z|X) \to$ soft cluster assignments
$$
P(Z_{i} = [0, \dots, \underset{i}{1}, \dots, 0] \ | \ X) \quad \propto \quad \bar{u}_{j} \ \mathcal N(X_{i} | \mu_{j}, \Sigma_{i})
$$
We want to estimate those parameters:

- **Maximum (log) likelihood** $$\ln p(\underline{X} | \underline{w}, \underline{\mu}, \underline{\Sigma}) = \sum_{i = 1}^{n} \ln\left( \sum_{k = 1}^{K} w_{k } \ \mathcal N (x_{i} | \mu_{k}, \Sigma_{k}) \right)$$take $\mu_{1} = x_{1}$, $\Sigma_{1} = \sigma^{2} I$, then $\ln\left( \sum_{k = 1}^{K} w_{k} \ \mathcal N(X_{1}| \mu_{k}, \Sigma_{k}) \right) \xrightarrow{z^{2} \to 0} +\infty$
- **Expectation maximization**
  $\theta$ all the parameters $$p(X | \theta) \text{ is the likelihood for the data}$$$Z$ latent variables$$p(X, Z|\theta) \text{ is the joint model}$$ $$\underbrace{\ln p(X|\theta)}_{\text{log likelihood}} = \underbrace{\ln \left( \sum_{z} p(X, z|\theta) \right)}_{\text{bad object}}$$
### 2.5.1 Expectation Maximization Algorithm

1. Evaluate $p(Z|X, \theta)$
2. $\theta^{new}$ optimizes $$\arg\max_{\theta} \ \sum_{z} p(z| X, \underbrace{\theta^{old}}_{\text{fixed}}) \ \underbrace{\ln p(X, z | \theta)}_{\begin{matrix} \text{log of joint} \\ \text{distribution,} \\ \text{better than} \\ \ln p(X |\theta) \end{matrix}}$$
Iterate step 1. and 2. until we reach some convergence.

For a GMM:
- Step 1$$
p(Z, X, \theta^{old}) = \prod_{i = 1}^{n}  \left\{  \prod_{k = 1}^{K} \underbrace{\left( \frac{\pi_{k} \mathcal N(x_{i}|\mu_{k}^{old}, \Sigma_{k}^{old})}{\sum_{j = 1}^{K} \pi_{j}^{old} \mathcal N(x_{i} | \mu_{j}^{old}, \Sigma_{i}^{old})} \right)^{z_{i}[k]}}_{\gamma_{i, k}}  \right\}
$$
- Step 2 $$\mu_{k}^{new} = \frac{1}{\sum_{i = 1}^{n}\gamma_{i,k}} \sum_{i 1}^{n} \gamma_{i,k} x_{i}$$ K-means $\gamma_{i, k}$ is the cluster allocation $\displaystyle \mu_{k}^{new} = \frac{1}{M_{k}} \sum_{i \in C_{k}} x_{i}$.

$$
\Sigma_{k}^{new} = \frac{1}{\Sigma \gamma_{i, k}} \sum_{i = 1}^{n} \gamma_{i,k} (x_{i} - \mu_{k}^{new})(x_{i} - \mu_{k}^{new})^{T}
$$
$$
\pi_{k}^{new} = \frac{\sum_{i = 1}^{n} \gamma_{i, k}}{n}
$$

# 3 Supervised Learning

We have a set of **features** $\mathbb{X} = \begin{bmatrix}\underline{x}_{1}' \\ \vdots \\ \underline{x}_{n}' \end{bmatrix}$, and **target** $Y = \begin{bmatrix}y_{1} \\ \vdots \\ y_{n}\end{bmatrix}$

The **goal** is to learn a function
$$
f : X \to Y
$$
where:

- $X$ the space where the features live
- $Y$ the space where the target lives

If $Y = \mathbb{R}$ (continuous target) $\implies$ regression problem. While if $Y$ is a finite set $Y = \{ \ell_{1}, \dots, \ell_{g} \} \implies$ classification problem.

How do we learn such function? Recall that in GMM $z_{i}$ are latent cluster assignments.
Imagine you have:
$$
\begin{array}{ccc|ccc} 
 X_{1} & \dots & X_{n} & X_{n+1} & X_{n+2} & \dots \\ \hline
y_{1} & \dots & y_{n} & y_{n+1} & y_{n+2} & \dots \\
\Big\updownarrow & \dots & \Big\updownarrow & \Big\updownarrow & \Big\updownarrow & \dots \\
z_{1} & \dots & z_{n} & z_{n+1} & z_{n+2} & \dots
 \end{array}
$$

Where $X_{1}, \dots, X_{n}$ is the observed data, and $X_{N+1}, X_{n+2}, \dots$ is the unobserved future data.

Use $(X_{1} \  \dots \ X_{n}, \  y_{1} \ \dots \ y_{n})$ to learn the distribution data in each class/group. Since $z_{i}$ is known for $i = 1, \dots, n$, we optimize:
$$
p((X_{i} : y_{i} = \ell_{k}) \ | \ \theta_{k})
$$
where $\theta_{k}$ are the class-specific parameters $[\mu_{k}, \Sigma_{k}]$

$\implies$ data in class $k$ follow the distribution $p(x | \hat{\theta}_{k})$.

Once you have $\hat{\theta}_{1}, \dots, \hat{\theta}_{g}$, observe $X_{n+1}$ but not $y_{n+1}$.
$$
\begin{matrix}
p(y_{n+1} = \ell_{d} \ | \ \hat{\theta}_{1}, \dots, \hat{\theta}_{d}) 
 & \underset{\begin{matrix} \text{first step} \\ \text{of GMM}\end{matrix}}{=} &
\displaystyle \frac{p(x_{n+1} \ | \ \hat{\theta}_{j}) \pi_{j}}{\sum_{k = 1}^{g} p(x_{n+1} | \hat{\theta}_{k}) \pi_{k}} \\
\Big\updownarrow & & \\
z_{n+1} = [0, \dots, \underset{\begin{matrix}\downarrow \\ d\end{matrix}}{1}, \dots 0]
\end{matrix}
$$
where $\pi_{j} = \dfrac{\text{\# obs in class } j}{n}$.

## 3.1 Formalization as a decision theory problem

$$g = 2$$
Find a **decision rule** $f : X \to \{ 1, 2 \}$ that minimizes the cost of this decision (expected loss).

We need a cost function

- $c_{2, 1} \to$ cost/loss of saying class 2 when in reality it was class 1
- $c_{1, 2} \to$ vice-versa

Expected cost $\displaystyle EC(f) = \int_{R_{2}} c_{2,1} p_{1}(\underline{x}) \pi_{1} \ dx + \int_{R_{1}} c_{1,2} p_{2}(\underline{x}) \pi_{2} \ dx$.
$$
X = R_{1} \cup R_{2} \qquad R_{j} : \{ x : f(x) = j \}
$$

![[Pasted image 20250621151212.png|center|250]]

Optimize $EC(f)$ with respect to $f$:

1. Optimize with respect to $R_{1}$ and $R_{2}$. It is possible to show that the optimal $R_{1}$ is $$\begin{matrix} \{ x \in X : c_{0, 2} p_{2}(x) \pi \leq c_{2,1} p_{1}(x)\pi_{2} \} \\[1em] R_{2} = X \setminus R_{1} \end{matrix}$$
2. $f^{optimized}(x) = \begin{cases} 1 & \text{if } x \in R_{1} \\ 2 & \text{if } x \in R_{2} \end{cases}$

If we assume that $p_{i} (x) = \mathcal N(x | \mu_{i}, \Sigma_{i})$ and $c_{2,1} = c_{1, 2}$, we get what we saw before:
$$
f(\underline{x}) = \arg\max_{j} \pi_{j} \mathcal N(\underline{x} | \mu_{i}, \Sigma_{i})
$$
This is called **quadratic discriminant analysis**.

