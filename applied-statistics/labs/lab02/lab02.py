"""
Applied statistics lab2
"""

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.decomposition import PCA
from sklearn.preprocessing import StandardScaler
from mpl_toolkits.mplot3d import Axes3D
import time
from tqdm.notebook import tqdm

plt.rcParams["figure.figsize"] = (8, 8)

### PCA Tourist dataset

tourists = pd.read_csv("datasets/tourists.txt", sep=" ")
print(tourists.head())

tourists_data = tourists.iloc[:, 2:]
tourists_label = tourists.iloc[:, :2]
n_tour, p_tour = tourists_data.shape
print("Tourists dataset shape:", tourists_data.shape)

# boxplot of original data
plt.figure()
tourists_data.boxplot(rot=90, grid=False)
plt.title("Tourists Data (Original)")
plt.show()

# pca is not about the mean, it is about variability
tourists_centered = tourists_data - tourists_data.mean()

ax = tourists_centered.boxplot(rot=90, grid=False)
plt.title("Centered Tourists Data")
plt.show()

## PCA on original data
pca_tourists = PCA()
tourists_scores = pca_tourists.fit_transform(tourists_data)
print(
    "Tourists PCA explained variance ratio:\n", pca_tourists.explained_variance_ratio_
)
print()

pc_sd = np.sqrt(pca_tourists.explained_variance_)
print("Standard deviation of the components:")
print(pc_sd)
print()

# Cumulative proportion of explained variance:
cumulative_explained_variance = np.cumsum(pca_tourists.explained_variance_ratio_)
print("Cumulative proportion of explained variance:")
print(cumulative_explained_variance)
print()

# loadings (compositions o principal components)
load_tour = pca_tourists.components_.T
print(load_tour)

fig, axes = plt.subplots(3, 1, figsize=(8, 12))

for i, ax in enumerate(axes):
    ax.bar(tourists_data.columns, load_tour[:, i])
    ax.set_xticklabels(tourists_data.columns, rotation=90)
    ax.set_ylabel(f"PC{i+1} Loading")
    ax.set_title(f"Loadings for PC{i+1}")

plt.tight_layout()
plt.show()


fig, axs = plt.subplots(1, 3, figsize=(15, 5))
axs[0].plot(np.arange(1, p_tour + 1), pca_tourists.explained_variance_, marker="o")
axs[0].set_title("PC Variances (Scree plot)")
orig_variances = tourists_data.var(ddof=1)
axs[1].bar(tourists_data.columns, orig_variances)
axs[1].tick_params(axis="x", rotation=45)
plt.setp(axs[1].get_xticklabels(), rotation=45, ha="right")
axs[1].set_title("Original Variables Variance")
cum_explained = np.cumsum(pca_tourists.explained_variance_ratio_)
axs[2].plot(np.arange(1, p_tour + 1), cum_explained, marker="o")
axs[2].axhline(1, color="blue")
axs[2].axhline(0.8, color="blue", linestyle="--")
axs[2].set_xlabel("Number of components")
axs[2].set_ylabel("Cumulative explained variance")
axs[2].set_ylim(0, 1)
plt.tight_layout()
plt.show()

# the first PC explains more than 98% of the total variability
