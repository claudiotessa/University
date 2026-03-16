"""
Applied statistics lab1
"""

import pandas as pd

pd.options.display.float_format = "{:.2f}".format

import matplotlib.pyplot as plt
import seaborn as sns

PATH = ""
df = pd.read_csv("datasets/heart_failure_clinical_records_dataset_smhd.csv")

"""
print(type(df))
print(df)  # prints full table
print(df.shape)  # prints (rows, columns) of the table
print(df.info()) # prints column name, non-null count, data type 
"""

cat_vars = [
    "anaemia",
    "diabetes",
    "high_blood_pressure",
    "sex",
    "smoking",
    "DEATH_EVENT",
]
num_vars = [
    "age",
    "creatinine_phosphokinase",
    "ejection_fraction",
    "platelets",
    "serum_creatinine",
    "serum_sodium",
    "bmi",
    "time",
]

### Categorical variables

print("Absolute frequency:")  # just counts per category
print(df["diabetes"].value_counts())

print("------------------------------------")

print("Relative frequency:")  # percentage per category
print(df["diabetes"].value_counts(normalize=True))

print("------------------------------------")

print(df["anaemia"].unique())  # prints all unique categories
print(df["anaemia"].nunique())  # counts the unique categories

print("\n\n")

### Barplots

colors = ["#baddf5", "#cc2b2b"]

ax = sns.countplot(data=df, x="anaemia", palette=colors, hue="anaemia", legend=False)
ax.set_title("Barplot anaemia")
# plt.show()  # program PAUSES until you close the window

## A grid of barplots for all categorical variables

fig, ax = plt.subplots(nrows=2, ncols=3, figsize=(13, 10))

ax = ax.flatten()

for i in range(len(cat_vars)):
    sns.countplot(
        data=df, x=cat_vars[i], palette=colors, hue=cat_vars[i], legend=False, ax=ax[i]
    )
    title = cat_vars[i]
    ax[i].set_title(title)
plt.tight_layout()  # avoid overlap among subplots
# plt.show()

# Numerical variables

print(df[num_vars].describe())  # prints count, percentiles, min-max, ...

# IQR interQuantile Range: 75% - 25%
iqr = df["ejection_fraction"].quantile(0.75) - df["ejection_fraction"].quantile(0.25)
print("IQR:", iqr)

#### Histograms

## Note: barplots for categorical, histograms for numerical variables

nrows = 4
ncols = 2

fig, ax = plt.subplots(nrows=nrows, ncols=ncols, figsize=(10, 25))
for i in range(len(num_vars)):
    plt.subplot(nrows, ncols, i + 1)
    # sns.distplot(df[num_vars[i]]) # deprecated function
    sns.histplot(
        data=df,
        x=num_vars[i],
        kde=True,
        alpha=0.4,
        edgecolor=(1, 1, 1),  # , ax=ax[i // ncols, i % ncols]
    )
    title = "Distribution : " + num_vars[i]
    plt.title(title)
# plt.show()

### Kurtosis and skeweness
# skeweness is a measure of the asymmetry of a distribution
# skeweness = 3 * [(mean - median) / (std)]
# kurtosis is a measure of the tailedness of a districution (how often outliers occur)

from scipy.stats import kurtosis, skew

# Create a list (of dictionaries) to store the results
results = []

for n in num_vars:
    k = kurtosis(df[n])
    s = skew(df[n])
    results.append({"variable": n, "kurtosis": k, "skewness": s})

# Convert the results list to a DataFrame
ks_df = pd.DataFrame(results)

print(ks_df)


### Boxplots
# to visualize the distribution of a numerical variable, highlighting its main statistics (min, max, mean, median)

fig, ax = plt.subplots(nrows=4, ncols=2, figsize=(10, 25))
for i in range(len(num_vars)):
    plt.subplot(4, 2, i + 1)
    sns.boxplot(data=df, y=num_vars[i])
    title = "Distribution : " + num_vars[i]
    plt.title(title)
plt.show()

### Bivariate and multivariate statistics

# Histograms grouped by a categorical variable
sns.histplot(
    data=df,
    x="ejection_fraction",
    kde=True,
    alpha=0.4,
    edgecolor=(1, 1, 1, 0.4),
    hue="DEATH_EVENT",
)

# Boxplot grouped by a categorical variable
sns.boxplot(x="DEATH_EVENT", y="serum_creatinine", data=df, hue="DEATH_EVENT")

### Covariance matrix (see covariance matrix formula)
# positive covariance = the variables increase together
# negative covariance = the variables decrease together
cov_matrix = df[num_vars].cov()

# Plot the covariance matrix as a heatmap
plt.figure(figsize=(12, 9))
sns.heatmap(cov_matrix, annot=True, cmap="Blues")

plt.title("Covariance Matrix Heatmap")
plt.show()

### Correlation matrix (see formula): bounded in [-1, 1]
corrmat = df[num_vars].corr()
plt.figure(figsize=(12, 9))
sns.heatmap(corrmat, cmap="Blues", annot=True)
plt.title("Correlation Matrix Heatmap")
plt.show()

### Scatterplot
sns.scatterplot(data=df, x="bmi", y="ejection_fraction", hue="DEATH_EVENT")

# scatterplot with multiple variables
vars_to_plot = ["serum_sodium", "bmi", "ejection_fraction", "age", "serum_creatinine"]
sns.pairplot(
    df, x_vars=vars_to_plot, y_vars=vars_to_plot, hue="DEATH_EVENT", height=5
).add_legend()
