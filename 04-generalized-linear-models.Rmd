# Generalized Linear Models

## Conceptual Foundations of GLMs

**Motivating Examples in Insurance**

1.  **Binary variables**
    -   **Examples**: yes/no, claim/no claim, alive/dead, solvent/insolvent
    -   **Problem**: Can take only two values, zero (non-event) or one (event)
2.  **Count variables**
    -   **Examples**: No. of claims, accidents, deaths
    -   **Problem**: Can take the value of any non-negative integers
3.  **Positive continuous variables**
    -   **Examples**: Income and claim severity
    -   **Problem**: Takes only positive values and may be highly skewed

**Question**: Generalize a linear model to analyze these variables?

------------------------------------------------------------------------

**GLM Component 1: Target Distributions**

-   **Linear Models (LMs)**: $Y \sim \text{normal}$
-   **Generalized Linear Models (GLMs)**: $Y \sim \text{linear exponential family}$

**A "monster" revisited...**

-   **Probability function**: $$
    f(y; \theta, \phi) = \exp \left( \frac{y \theta - b(\theta)}{\phi} + S(y, \phi) \right)
    $$ *No need to memorize for PA!*

**Things to keep in mind:**

-   A **rich class of distributions** that includes a number of common **discrete** and **continuous** distributions
-   **Examples**: Normal, gamma, inverse Gaussian, Poisson, binomial
-   Provides a **unifying approach** to modeling binary, discrete, and continuous target variables, all within the **same statistical framework**

------------------------------------------------------------------------

**GLM Component 2: Link Functions**

-   **Linear Models (LMs)**: $$
    \mu = \eta = \beta_0 + \beta_1 X_1 + \dots + \beta_p X_p
    $$
-   **Generalized Linear Models (GLMs)**: $$
    g(\mu) = \eta = \beta_0 + \beta_1 X_1 + \dots + \beta_p X_p
    $$

**Link Functions**

-   Equate a **function** of the target mean with the linear predictor.
-   $g$ can be any **monotonic function** (e.g., identity, log, inverse, square root).
-   Allows analysis of situations where the **effects** of the predictors on the target mean are **more complex** than additive.

**Special Case: Linear Models**

-   **Target distribution**: Normal
-   **Link function**: Identity, $g(\mu) = \mu$

------------------------------------------------------------------------

**Warning: GLMs do NOT Transform Target Variables!**

**A common misconception about GLMs:**

> “GLMs transform the (non-normal) target variable so that it can be reasonably described by a linear model.”
>
> **WRONG!!!**

**Truth:**

-   The **link function** $g$ is applied to the **target mean** $\mu$.
-   The **target variable** $Y$ is left **untransformed**.

------------------------------------------------------------------------

**Two Examples with the Log Transformation**

**Model 1 (Transformed target)**

-   **Definition**: $\ln Y = \eta + \epsilon$ or $Y = \exp(\eta + \epsilon)$
-   **What kind of model**: Linear model fitted to $\ln Y$ (i.e., log-transformed)
-   **Behavior of target**: Lognormal; target must be positive

**Model 2 (Transformed mean)**

-   **Definition**:
    1.  $Y \sim \text{normal}$
    2.  $\ln \mu = \eta$ or $\mu = \exp(\eta)$
-   **What kind of model**: GLM with normal target and log link
-   **Behavior of target**: Mean is positive; target can take any real values

------------------------------------------------------------------------

### Selection of Target Distributions and Link Functions

#### From Past PA Exams {.unnumbered}

##### December 7, 2020 Exam, Task 8 {.unnumbered}

-   Your assistant has prepared code to fit two GLMs to the data, using the **Poisson** and **gamma** distributions, each with its **canonical link function**.
-   Explain whether each choice for distribution and link function is **reasonable** for this data and business problem.

##### December 8, 2020 Exam, Task 7 {.unnumbered}

-   Explain why **Poisson** is a **reasonable distribution choice** for this problem.
-   State **two other reasonable choices of distribution**.

##### December 2019 Exam, Task 7 {.unnumbered}

-   Determine a **distribution and link function** to use.
-   Justify your choice of distribution based on the business problem and data.

------------------------------------------------------------------------

#### Target Distribution {.unnumbered}

##### General Principle {.unnumbered}

Choose a distribution from the linear exponential family that **best aligns** with the **characteristics** of the target.

##### Examples {.unnumbered}

1.  **Positive, right-skewed variable:**
    -   Examples: Claim amounts, income
    -   Candidate distributions: **Gamma**, **inverse Gaussian**
2.  **Binary variable:**
    -   Example: Indicator (0/1)
    -   Distribution: **Binomial (Bernoulli)**
3.  **Count variable:**
    -   Examples: No. of claims, accidents, etc.
    -   Candidate distribution: **Poisson**

------------------------------------------------------------------------

#### Link Function: Important Considerations {.unnumbered}

##### Consideration 1: Appropriateness of predictions {.unnumbered}

Make sure model predictions **match** the range of values of the target mean: $$
g(\mu) = \eta \quad \Rightarrow \quad \mu = g^{-1}(\eta) \quad \Rightarrow \quad \hat{\mu} = g^{-1}(\hat{\eta}) \quad \text{(prediction)}
$$

###### Example 1: Positive, unbounded target mean {.unnumbered}

-   **Good link:** Log link $g(\mu) = \ln \mu \Rightarrow \hat{\mu} = e^{\hat{\eta}} \geq 0$
-   **Bad link:** Identity link $g(\mu) = \mu \Rightarrow \hat{\mu} = \hat{\eta} \in \mathbb{R}$

###### Example 2: Unit-valued target mean (= probability) {.unnumbered}

-   **Logit link:** $g(\mu) = \ln \left( \frac{\mu}{1 - \mu} \right) \Rightarrow \hat{\mu} = \frac{e^{\hat{\eta}}}{1 + e^{\hat{\eta}}} \in [0, 1]$

##### Consideration 2: Interpretability {.unnumbered}

Choose the link function such that the GLM is **easy to interpret** (= interpretable), making it straightforward to describe the **effects of predictors** on the target mean.

###### Example statement {.unnumbered}

If a continuous predictor $X$ increases by 1 unit, by how much will the target mean change?

------------------------------------------------------------------------

##### Consideration 3: Canonical Link Function {.unnumbered}

| Target Distribution | Canonical Link  | Mathematical Form             |
|---------------------|-----------------|-------------------------------|
| Normal              | Identity        | $g(\mu) = \mu$                |
| Binomial            | Logit           | $g(\pi) = \ln[\pi/(1 - \pi)]$ |
| Poisson             | Log             | $g(\mu) = \ln \mu$            |
| Gamma               | Inverse         | $g(\mu) = 1/\mu$              |
| Inverse Gaussian    | Squared inverse | $g(\mu) = 1/\mu^2$            |

*Motivation:* To facilitate convergence.

Using the canonical Link function will tend to make convergence faster, and more likely to occur.

However, just because the link function is the canonical link, doesn't mean we should always use that link function. In practice, there are much more important considerations to keep in mind, like whether the predictors are appropriate, and whether the resulting glm is easy to interpret.

###### Example: Gamma GLM {.unnumbered}

Because we know that for Gamma, the mean is always positive: - The **Inverse Link** doesn't always ensure positive predictions. - The **Log Link** is much more commonly used, because it ensure positive predictions, and makes the GLM easier to interpret.

------------------------------------------------------------------------

#### Tweedie Distribution for Aggregate Loss {.unnumbered}

A random variable $S$ follows the **Tweedie distribution** if $$
S = \sum_{i=1}^{N} X_i = X_1 + \dots + X_N,
$$ where: - $N$ is a Poisson random variable (**claim counts**) - The $X_i$'s are i.i.d. gamma random variables independent of $N$ (**claim sizes**)

##### Distributional Characteristics {.unnumbered}

**Mixed nature**: - A discrete **probability mass** at zero corresponding to $N = 0$ - A **probability density function** on the positive real line corresponding to $N = 1, 2, \dots$

##### Importance in Exam PA {.unnumbered}

-   Mentioned in **one and only one slide** of PA modules.
-   **Package** designed specifically for Tweedie will **not be available** on the exam.
-   If there are exam questions on Tweedie, expect **conceptual** ones testing what Tweedie is and how it serves as an alternative model for loss modeling.

------------------------------------------------------------------------

#### Interpretation of GLM Coefficients {.unnumbered}

##### Example 1: Log Link {.unnumbered}

$$
\ln \mu = \eta \quad \Rightarrow \quad \mu = e^{\eta} = e^{\beta_0} \times e^{\beta_1 X_1} \times \dots \times e^{\beta_j X_j} \times \dots \times e^{\beta_p X_p}
$$

-   **Case 1**: If $X_j$ is numeric and $X_j$ increases by 1:
    -   **Multiplicative change**: The target mean is multiplied by a factor of $e^{\beta_j}$.
    -   This means: $$
        \text{new } \mu = e^{\beta_j} \times \text{old } \mu
        $$
    -   **% change**: $$
        \% \text{ change in } \mu = \frac{\text{algebraic change in } \mu}{\text{old } \mu} = \frac{(e^{\beta_j} - 1) \mu}{\mu} = e^{\beta_j} - 1
        $$
-   **Note**:
    -   If $e^{\beta_j} > 1$, the mean is **scaled up** (when $\beta_j > 0$).
    -   If $e^{\beta_j} < 1$, the mean is **scaled down** (when $\beta_j < 0$).
-   **Case 2**: If $X_j$ is the dummy variable for a non-baseline level:
    -   **Multiplicative change**: Target mean multiplied by a factor of $e^{\beta_j}$: $$
        \mu_{\text{non-baseline level}} = e^{\beta_j} \times \mu_{\text{baseline level}}
        $$
    -   **% change**: $e^{\beta_j} - 1$ from baseline to non-baseline level.

------------------------------------------------------------------------

##### Example 2: Logit Link {.unnumbered}

*Just another form of log link!*

$$
\ln(\text{odds}) = \eta \quad \Leftrightarrow \quad \text{odds} = e^{\eta} = e^{\beta_0} \times e^{\beta_1 X_1} \times \dots \times e^{\beta_j X_j} \times \dots \times e^{\beta_p X_p}
$$

-   **Example**: If $X_j$ is numeric and $X_j \uparrow 1$:
    -   **Multiplicative change**: $$
        \text{new odds} = e^{\beta_j} \times \text{old odds}
        $$
    -   **% change**: $$
        \% \text{ change in odds} = e^{\beta_j} - 1
        $$

------------------------------------------------------------------------

### Weights and Offsets

So far, we have studied the two components of a GLM, the **Target Distribution** and the **Link Function**.

In this subsection, we are going to look at two concepts that arise frequently when we apply generalized linear models (GLMs) in the actuarial context. The concepts are **Weights** and **Offsets**.

Both concepts are related to **incorporating a measure of exposure** in the GLM to **improve the model fit**. We will look at the mechanics and mathematics

------------------------------------------------------------------------

#### Weights {.unnumbered}

To understand how weights come up in a GLM setting lets consider the following generic dataset.

There is a target variable, and some predictors, Variable 1, Variable 2, and so on. And we have an exposure variable $E_n$.

##### Grouped Data Structure {.unnumbered}

| Target Variable | Exposure $E$ | Variable 1 | Variable 2 | $\dots$  |
|-----------------|--------------|------------|------------|----------|
| $y_1$           | $E_1$        | $x_{11}$   | $x_{12}$   | $\dots$  |
| $y_2$           | $E_2$        | $x_{21}$   | $x_{22}$   | $\dots$  |
| $\vdots$        | $\vdots$     | $\vdots$   | $\vdots$   | $\vdots$ |
| $\vdots$        | $\vdots$     | $\vdots$   | $\vdots$   | $\vdots$ |

**Characteristic**:\
Each $y$ value is an outcome **averaged** by the corresponding $E$ value.

**Example**:\
$$
y = \text{average } \#\text{ of claims for a group} = \frac{\text{total } \#\text{ claims}}{E}
$$ with $E = \#\text{policyholders in a group}$.

##### Motivation {.unnumbered}

-   **Larger exposure** $\Rightarrow$ less variance, more precision
-   Recall: $\text{Var}(\bar{X}) = \frac{\text{Var}(X_1)}{n}$ if i.i.d.

##### Suggested Approach {.unnumbered}

-   Attach a **higher weight** to observations with a **larger exposure** $\Rightarrow$ Improve the reliability of fitting procedure.

------------------------------------------------------------------------

#### Offsets {.unnumbered}

##### Grouped Data Structure {.unnumbered}

| Target Variable | Exposure $E$ | Variable 1 | Variable 2 | $\dots$  |
|-----------------|--------------|------------|------------|----------|
| $y_1$           | $E_1$        | $x_{11}$   | $x_{12}$   | $\dots$  |
| $y_2$           | $E_2$        | $x_{21}$   | $x_{22}$   | $\dots$  |
| $\vdots$        | $\vdots$     | $\vdots$   | $\vdots$   | $\vdots$ |
| $\vdots$        | $\vdots$     | $\vdots$   | $\vdots$   | $\vdots$ |

**Characteristic**:\
Each $y$ value is an outcome **summed (aggregated)** over $E$ units.

**Example**:\
For a group, $$
y = \text{total } \#\text{claims for a group}
$$ where $E = \#\text{policyholders in a group}$.

##### Motivation {.unnumbered}

-   **Larger exposure** $\Rightarrow$ larger $y$

##### Mathematics {.unnumbered}

Consider the following log-link Generalized Linear Model (GLM) with an offset:

$$
\ln \mu = \ln E_{\text{offset}} + \eta = \ln E + \left( \beta_0 + \beta_1 X_1 + \dots + \beta_p X_p \right)
$$

###### About the Offset {.unnumbered}

-   A special predictor whose regression coefficient is known to be one.

-   Model equation equivalent to: $$
    \mu = E \exp(\eta)
    $$

    i.e., $\mu$ and $E$ are in **direct proportion**.

------------------------------------------------------------------------

##### Example: Specifying an Appropriate Offset {.unnumbered}

-   **NumClaims**: Number of claims of a policyholder over a time period
-   **Time**: The length of time (in years) a policyholder is observed
-   **Age**: Age of a policyholder
-   **Gender**: Gender of a policyholder
-   **RiskCat**: Risk category to which a policyholder belongs

Use these variables to set up a GLM for **NumClaims** with an appropriate offset.

###### Offset {.unnumbered}

Expect **NumClaims** to be proportional to **Time**.

###### Solution {.unnumbered}

-   **Target distribution**: Poisson
-   **Predictors**: Age, Gender, RiskCat
-   **Link**: Log
-   **Offset**: $\ln(\text{Time})$ (Note: Use $\ln(\text{Time})$, not Time itself)

For the target distribution, we choose the Poisson distribution, because the target variable is `NumClaims` which takes only non-negative integers.

The predictors are `Age`, `Gender` and `RiskCat`.

For the link function, we choose the **Log Link**, because it ensures positive values, is easy to interpret and is the canonical link function of the Poisson distribution.

The Offset should be on the same scale as the transformed target mean (e.g., Log Link Function), therefore the offset should be $ln(Time)$. We use this offset to capture the proportional relationship between the number of claims and time.

------------------------------------------------------------------------

#### Weights vs. Offsets {.unnumbered}

##### Similarities {.unnumbered}

**Same Purpose:** Incorporate a measure of *exposure*

##### Differences {.unnumbered}

|   | **Weights** | **Offsets** |
|--------------------|---------------------------|-------------------------|
| **Nature of target variable** | Average | Aggregate |
| **Role of exposure** | Affect *variance* | Affect *mean* |
|  | Larger weight, lower *variance* | Larger offset, larger *mean* |

##### Interesting Special Case: Log-link Poisson GLM {.unnumbered}

1.  **Model 1:** A Poisson GLM for $Y$ (claim count) using $\ln E$ as the *offset*
2.  **Model 2:** A Poisson GLM for $\frac{Y}{E}$ (claim frequency) using $E$ as the *weight*

------------------------------------------------------------------------

### Fitting and Assessing the Performance of a GLM

#### Coefficient Estimates {.unnumbered}

**Method**\
Least squares estimation $\rightarrow$ Maximum likelihood estimation\
(for linear models)      (for GLMs)

##### MLE: How it works conceptually {.unnumbered}

-   Form the (log)likelihood function:\
    $L(\beta_0, \ldots, \beta_p) = \ldots$\
    and $l = \ln L$\
    (in terms of $\beta$'s)
-   Choose the $\beta$'s to maximize $l(\beta_0, \ldots, \beta_p)$

**Warning**\
Algorithm may **not converge** $\Rightarrow$ no estimates found

##### Predictions {.unnumbered}

$$
g(\mu_i) = \beta_0 + \beta_1 X_{i1} + \ldots + \beta_p X_{ip}
$$

$$
\mu_i = g^{-1}(\beta_0 + \beta_1 X_{i1} + \ldots + \beta_p X_{ip})
$$

Then we replace the $\beta$'s with $\hat{\beta}$ to replace the coefficients with the coefficient estimates:

$$
g(\mu_i) = \beta_0 + \beta_1 X_{i1} + \ldots + \beta_p X_{ip}
$$

$$
\mu_i = g^{-1}(\beta_0 + \beta_1 X_{i1} + \ldots + \beta_p X_{ip})
$$

That's how we get the predicted target mean.

------------------------------------------------------------------------

##### Global Goodness-of-fit Measure: Deviance {.unnumbered}

After fitting a GLM, how do we quantify the goodness of fit to the training data?

For linear models, we used the RSS or $R^2$, however the $R^2$ is no longer a good measure, because it is no longer between 0 and 1. Therefore, we need more general goodness-of-fit measures for GLMs.

That brings us to the concept of **Deviance**.

**Measure**\
RSS or $R^2$ $\rightarrow$ Deviance\
(for linear models)      (for GLMs)

###### Deviance {.unnumbered}

-   **Idea**: Compare fitted GLM with saturated GLM (perfect fit) with respect to goodness of fit.
-   **Definition**:\
    $$
    \text{Deviance} = 2(l_{\text{SAT}} - l) \geq 0,
    $$ where:
    -   $l_{\text{SAT}}$ = maximized log-likelihood of the saturated GLM\
    -   $l$ = maximized loglikelihood of the fitted GLM
-   **Criterion**: The lower, the better the fit to training data

**Warning**\
Deviance depends on the target distribution! We cannot say that one GLM is better than another GLM if the target distribution is different, even if it has a lower deviance: - Deviance of a Poisson GLM: 100 (better fit? No!) - Deviance of a gamma GLM: 200

------------------------------------------------------------------------

##### Local Goodness-of-fit Measure: Deviance Residuals {.unnumbered}

**Residuals**\
Raw residual $e_i = y_i - \hat{\mu}_i$ $\rightarrow$ Deviance residual $d_i$\
(for linear models)      (for GLMs)

###### Definition {.unnumbered}

-   **Signed square root** of the $i$th term in the deviance formula.
-   Positive if $y_i > \hat{\mu}_i$ and negative if $y_i < \hat{\mu}_i$.

###### Example {.unnumbered}

-   Deviance formula for a Poisson GLM:\
    $$
    D = 2 \sum_{i=1}^n \left[ y_i \ln \frac{y_i}{\hat{\mu}_i} - (y_i - \hat{\mu}_i) \right]
    $$
-   $y_i = 59$ and $\hat{\mu}_i = 71$ for the $i$th training observation.
-   $d_i = \text{sign}(y_i - \hat{\mu}_i) \sqrt{2 \left[ y_i \ln \frac{y_i}{\hat{\mu}_i} - (y_i - \hat{\mu}_i) \right]} = - \sqrt{2 \left[ 59 \ln \frac{59}{71} - (59 - 71) \right]} = -1.47$

##### Deviance Residuals as Diagnostic Tools {.unnumbered}

If the fitted GLM is “good,” then the deviance residuals should:

-   Be approximately **normally distributed** for most target distributions in the linear exponential family (Exception: **Binomial**).
-   Have **no systematic patterns** when considered on their own and with respect to the predictors.
-   Have approximately **constant variance** upon standardization (i.e., **homoscedastic**).

###### Q-Q plot for deviance residuals {.unnumbered}

-   Model is adequate $\checkmark \Rightarrow$ Points **fall closely on a straight line**
-   Points deviate substantially from a straight line $\Rightarrow$ Model is inadequate $\times$

**Note**: For this method to work, the target distribution **need not be normal**.

------------------------------------------------------------------------

##### Penalized Likelihood Measures: AIC and BIC {.unnumbered}

-   **Deviance**: Goodness of fit on training data
-   **AIC/BIC**: Goodness of fit on training data + model complexity

###### Definition of AIC and BIC {.unnumbered}

-   $\text{AIC} = -2l + 2p$
    -   where $l$ represents goodness of fit
    -   and $p$ represents complexity
-   $\text{BIC} = -2l + p \ln(n_{\text{tr}})$
    -   where $n_{\text{tr}}$ is the number of training observations

Perform stepwise selection using forward/backward selection and **AIC/BIC**.

###### Regularization {.unnumbered}

-   Find estimates by minimizing **deviance** (goodness of fit) + **regularization penalty** (complexity).
-   Same ideas in Chapter 3 apply.

------------------------------------------------------------------------

### Performance Metrics for Classifiers

------------------------------------------------------------------------

## Case Study 1: GLMs for Continuous Target Variables

### Data Preparation

### Model Construction and Evaluation

### Model Validation and Interpretation

## Case Study 2: GLMs for Binary Target Variables

### Data Exploration and Preparation

### Model Construction and Selection

### Interpretation of Model Results

## Case Study 3: GLMs for Count and Aggregate Loss Variables

### Data Exploration and Preparation

### Model Construction and Evaluation

### Predictions
