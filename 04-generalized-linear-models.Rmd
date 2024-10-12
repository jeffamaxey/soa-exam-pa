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

---

### Selection of Target Distributions and Link Functions

#### From Past PA Exams {-}

##### December 7, 2020 Exam, Task 8 {-}
- Your assistant has prepared code to fit two GLMs to the data, using the **Poisson** and **gamma** distributions, each with its **canonical link function**.
- Explain whether each choice for distribution and link function is **reasonable** for this data and business problem.

##### December 8, 2020 Exam, Task 7 {-}
- Explain why **Poisson** is a **reasonable distribution choice** for this problem.
- State **two other reasonable choices of distribution**.

##### December 2019 Exam, Task 7 {-}
- Determine a **distribution and link function** to use.
- Justify your choice of distribution based on the business problem and data.

---

#### Target Distribution {-}

##### General Principle {-}
Choose a distribution from the linear exponential family that **best aligns** with the **characteristics** of the target.

##### Examples {-}

1. **Positive, right-skewed variable:**
   - Examples: Claim amounts, income
   - Candidate distributions: **Gamma**, **inverse Gaussian**

2. **Binary variable:**
   - Example: Indicator (0/1)
   - Distribution: **Binomial (Bernoulli)**

3. **Count variable:**
   - Examples: No. of claims, accidents, etc.
   - Candidate distribution: **Poisson**


---

#### Link Function: Important Considerations {-}

##### Consideration 1: Appropriateness of  predictions {-}
Make sure model predictions **match** the range of values of the target mean:
\[
g(\mu) = \eta \quad \Rightarrow \quad \mu = g^{-1}(\eta) \quad \Rightarrow \quad \hat{\mu} = g^{-1}(\hat{\eta}) \quad \text{(prediction)}
\]

###### Example 1: Positive, unbounded target mean {-}
- **Good link:** Log link \( g(\mu) = \ln \mu \Rightarrow \hat{\mu} = e^{\hat{\eta}} \geq 0 \)
- **Bad link:** Identity link \( g(\mu) = \mu \Rightarrow \hat{\mu} = \hat{\eta} \in \mathbb{R} \)

###### Example 2: Unit-valued target mean (= probability) {-}
- **Logit link:** \( g(\mu) = \ln \left( \frac{\mu}{1 - \mu} \right) \Rightarrow \hat{\mu} = \frac{e^{\hat{\eta}}}{1 + e^{\hat{\eta}}} \in [0, 1] \)


##### Consideration 2: Interpretability {-}
Choose the link function such that the GLM is **easy to interpret** (= interpretable), making it straightforward to describe the **effects of predictors** on the target mean.

###### Example statement {-}
If a continuous predictor \( X \) increases by 1 unit, by how much will the target mean change?

---

##### Consideration 3: Canonical Link Function {-}

| Target Distribution  | Canonical Link    | Mathematical Form                       |
|----------------------|-------------------|-----------------------------------------|
| Normal               | Identity          | \( g(\mu) = \mu \)                      |
| Binomial             | Logit             | \( g(\pi) = \ln[\pi/(1 - \pi)] \)       |
| Poisson              | Log               | \( g(\mu) = \ln \mu \)                  |
| Gamma                | Inverse           | \( g(\mu) = 1/\mu \)                    |
| Inverse Gaussian     | Squared inverse   | \( g(\mu) = 1/\mu^2 \)                  |

*Motivation:* To facilitate convergence.

Using the canonical Link function will tend to make convergence faster, and more likely to occur. 

However, just because the link function is the canonical link, doesn't mean we should always use that link function. In practice, there are much more important considerations to keep in mind, like whether the predictors are appropriate, and whether the resulting glm is easy to interpret.

###### Example: Gamma GLM {-}
Because we know that for Gamma, the mean is always positive:
-  The **Inverse Link** doesn't always ensure positive predictions.
-  The **Log Link** is much more commonly used, because it ensure positive predictions, and makes the GLM easier to interpret.


---



### Weights and Offsets
### Fitting and Assessing the Performance of a GLM
### Performance Metrics for Classifiers

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

