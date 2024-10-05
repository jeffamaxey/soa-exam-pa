# (PART) A Crash Course in R {-}

# Basics of R Programming



## Data Types in R

### Exercise 1.2.2 - Calculating least squares estimates by matrix manipulation

You are fitting a multiple linear regression model:


$$
\begin{equation} 
\widehat{Y} = \beta_{0} + \beta_{1}X_{1} + \beta_{2}X_{2} + \epsilon
\end{equation} 
$$ 

to the following dataset:

| i   | $Y_{i}$ | $X_{i1}$ | $$X_{i2}$$ |
|-----|---------|----------|------------|
| 1   | 14      | 2        | 4          |
| 2   | 11      | 3        | 2          |
| 3   | 14      | 0        | 6          |
| 4   | 18      | 8        | 4          |
| 5   | 12      | 4        | 3          |
| 6   | 9       | 1        | 2          |

Perform the following two tasks in R:

**(a)** In matrix form, the model is

  $$
  \begin{equation} 
  Y = X\beta + \epsilon
  \end{equation}
  $$ 

Set up the response vector **Y** and design matrix **X** corresponding to the dataset above.

**(b)** Use the matrix formula $$\widehat{\beta} = (X^TX)^{-1}X^TY$$ from Exam SRM to calculate the least squares estimates of $\beta_{0}$, $\beta_{1}$, $\beta_{2}$.

**Solution:** The R commands are collected below. Let's look at the code line by line.

**(a)** The response vector can be created by the following command:


``` r
Y <- c(14, 11, 14, 18, 12, 9)
```

To setup the design matrix, we first create the three columns:


``` r
x0 <- rep(1, 6) # same as c(1, 1, 1, 1, 1, 1)
x1 <- c(2, 3, 0, 8, 4, 1)
x2 <-  c(4, 2, 6, 4, 3, 2)
```

The first column is a vectorof 1's corresponding to the intercept of the model. It is created by the `rep(x, n)` function, which, in its simplest form, repeats or replicates the x vector n times.

The other two columns represent the values of $X_{1}$ and $X_{2}$.

Now we combine these three vectors via c(x0, x1, x2) and use the `matrix()` function to produce the design matrix.


``` r
X <- matrix(c(x0, x1, x2), nrow=6)
X
#>      [,1] [,2] [,3]
#> [1,]    1    2    4
#> [2,]    1    3    2
#> [3,]    1    0    6
#> [4,]    1    8    4
#> [5,]    1    4    3
#> [6,]    1    1    2
```

**(b)** Using the matrix formula $\widehat{\beta} = (X^TX)^{-1}X^TY$, we can calculate the least squares estimates of $\beta_{0}$, $\beta_{1}$, $\beta_{2}$.


``` r
B <- solve(t(X) %*% X) %*% t(X) %*% Y
B
#>        [,1]
#> [1,] 5.2506
#> [2,] 0.8137
#> [3,] 1.5166
```

Then $\widehat{\beta}_{0}$ = 5.2505543, $\widehat{\beta}_{1}$ = 0.8137472, and $\widehat{\beta}_{2}$ = 1.5166297.

*Remark:* In Chapter 3, we will learn how to use the `lm()` function to fit a linear model and the `coef()` function to extract the least squares estimates.

### Data Frames

**Importance of Data Frames:** In Exam PA (and predictive modeling in general), data frames are **useful** mainly for two reasons:

1.  ***(Data frames = datasets)*** From a statistical point of view, eac column of a data frame can be interpreted as observed values of the same variable (that's why each column must have the same type of data) and each row represents the set of measurements taken for the same observations (e.g., record, case, instance) corresponding to these variables, very much like an Excel Spreadsheet. The variables across different columns are allowed to be of different types and capture different kinds of information.

2.  ***(Structure vs. Unstructured Data)*** From a data management prespective, data frames are efficient storage devices for ***structrued data***, or data that fit into a tabular arrangement. The row-by-column configuration of structured data makes it easy to search for, extract, and compare information across rows, but there is a limit to the scope of information that can be expressed by structured data. It does not lend itself to information that does not naturally fit into a tabular arrangement. Such information, such as texts, images, audio, and videos, is known as ***unstructured data***. Although unstructured data are more flexible and potentially useful, they are harder to access and have to be carefully pre-processed (or manipulated) before they can serve as useful inputs to a predictive model.

### Exercise 1.2.3 - Listing the components of a list

In Exercise 1.2.2, we considered a multiple linear regression model for Y on two predictors $X_{1}$ and $X_{2}$. As we will learn in Chapter 3, we can easily fit such a model by the following commands involving the `lm()` function:


``` r
Y <- c(14, 11, 14, 18, 12, 9)
X1 <- c(2, 3, 0, 8, 4, 1)
X2 <- c(4, 2, 6, 4, 3, 2)
m <- lm(Y ~ X1 + X2)
```

The resulting object, named `m`, is a list with various components.

List the components of `m` and choose the components that apears to contain the least squares coefficient estimates. Check your answers against the code.

***Solution:*** We can see a list of components of `m` by typing the command `m$`. Then RSudio will show a prompt listing all of the components of `m`.

Alternatively and more formally, we can apply the `names()` function to `m`.


``` r
names(m)
#>  [1] "coefficients"  "residuals"     "effects"      
#>  [4] "rank"          "fitted.values" "assign"       
#>  [7] "qr"            "df.residual"   "xlevels"      
#> [10] "call"          "terms"         "model"
```

Out of the 12 components, the `coefficients` component appears the most relevant. Accessing this component indeed produces the least squares coefficient estimates:


``` r
m$coefficients
#> (Intercept)          X1          X2 
#>      5.2506      0.8137      1.5166
```

### Functions

The basic structure of a function in R:

```         
FUNCTION_NAME <- function(ARGUMENT_1, ARGUMENT_2,...) {
  STATEMENT_1
  STATEMENT_2
  ...
  return(VALUE)
}
```

Example of a function:


``` r
sumDiff <- function(x, y) {
  s <- x + y
  d <- x - y
  return(list(sum=s, diff=d))
}

sumDiff(1, 2)$sum
#> [1] 3
sumDiff(1, 2)$diff
#> [1] -1
sumDiff(1:3, 1:3)
#> $sum
#> [1] 2 4 6
#> 
#> $diff
#> [1] 0 0 0
```

## Basic Data Management

Now that we have a basic undertanding of common data types and structures in R, we are ready to look at some elementary data management problems commonly encountered in Exam PA (you will see more complicated ones in ATPA). Even after we have imported the data into R in the usual observation-by-variable format, there are often data management issues that should be resolved before a predictive model can be constructed meaningfully. To illustrate these data mangement issues, we will focus on a small-scale dataset involving eight actuaries in a hypothetical company set up in the code below:


``` r
x <- 1:8
name <- c("Embryo Luo", "", "Peter Smith", NA, "Angela Peterson", "Emily Johnston", "Barbara Scott", "Benjamin Eng")
gender <- c("M", "F", "M", "F", "F", "F", "?", "M")
age <- c(-1, 25, 22, 50, 30, 42, 29, 36)
exams <- c(10, 3, 0, 4, 6, 7, 5, 9)
Q1 <- c(10, NA, 4, 7, 8, 9, 8, 7)
Q2 <- c(9, 9, 5, 7, 8, 10, 9, 8)
Q3 <- c(9 ,7, 5, 8, 10, 10, 7, 8)
salary <- c(300000, NA, 80000, NA, NA, NA, NA, NA)
actuary <- data.frame(x, name, gender, age, exams, Q1, Q2, Q3, salary)
actuary
#>   x            name gender age exams Q1 Q2 Q3 salary
#> 1 1      Embryo Luo      M  -1    10 10  9  9  3e+05
#> 2 2                      F  25     3 NA  9  7     NA
#> 3 3     Peter Smith      M  22     0  4  5  5  8e+04
#> 4 4            <NA>      F  50     4  7  7  8     NA
#> 5 5 Angela Peterson      F  30     6  8  8 10     NA
#> 6 6  Emily Johnston      F  42     7  9 10 10     NA
#> 7 7   Barbara Scott      ?  29     5  8  9  7     NA
#> 8 8    Benjamin Eng      M  36     9  7  8  8     NA
```

Each row of the dataset, called `actuary`, has information about an actuary's name, gender, age, number of exams passed, three evaluation ratings on a scale from 1 to 10 assigned by their supervisors according to three performance measures, and their salary.

Although the dataset you will encounter in real life is likely to have hundreds and thousands of observations, for demonstration pruposes I have deliberately chosen a toy dataset like `actuary` so that you can appreciate the changes you have made to the dataset by visual inspection (the small size of the dataset makes this possible). The data management techniques we are going to illustrate, however, are so general and efficient that they apply equally well to large datasets.

Using this toy dataset, we will demonstrate how to accomplish the following data management tasks in R:

1.  **(Deletion):** How to delete the variable x, which is simply a column of row numbers and not useful for most predictive purposes?

2.  **(Missing/abnormal values):** Some entries in the dataset are missing or do not make sense. How to deal with these missing or abnormal entries?

3.  **(Creation + Sorting):** How to create a new numeric variable that averages the three evaluation ratings and provides an overall performance measure for each actuary? Based on the overall performance measure, which actuary has the best performance?

4.  **(Identification):** How to identify Associates (those who have passed 7 to 9 exams) and Fellows (those who have passed 10 exams)? More generally, how to create a new categorical variables that represents whether an actuary is an Associate, Fellow, or pre-ASA student?

5.  **(Merge):** How to add new observations and variables to an existing dataset?

6.  **(Compound):** How to create a compound variable that represents both the gender and smoking status of an actuary?

### Task 1: Removing Unimportant Variables

In the course of a data analysis, we may want to remove variables which turn out to be redundant or add little value to our analysis. In the `actuary` data, the `x` variable is a vector of row numbers that do not provide any useful information for understanding the eight actuaries.

To **delete** a variable in a data frame, we can use the `$` notation we learned to access the variable and assign it to the special symbol `NULL`.


``` r
actuary$x <- NULL
actuary
#>              name gender age exams Q1 Q2 Q3 salary
#> 1      Embryo Luo      M  -1    10 10  9  9  3e+05
#> 2                      F  25     3 NA  9  7     NA
#> 3     Peter Smith      M  22     0  4  5  5  8e+04
#> 4            <NA>      F  50     4  7  7  8     NA
#> 5 Angela Peterson      F  30     6  8  8 10     NA
#> 6  Emily Johnston      F  42     7  9 10 10     NA
#> 7   Barbara Scott      ?  29     5  8  9  7     NA
#> 8    Benjamin Eng      M  36     9  7  8  8     NA
```

### Task 2: Missing Values

In data analysis, we say that there is a *missing value* when a value is not available (hence missing) for a particular entry in a dataset for whatever reason.

In R, **missing values** are denoted by the special symbol **`NA`**, which stands for not available.

We can see that the actuary dataset has quite a few missing values:

| Variable | Missing Value(s)                    |     |     |
|----------|-------------------------------------|-----|-----|
| `name`   | 2nd and 4th observation             |     |     |
| `gender` | 7th observation                     |     |     |
| `Q1`     | 2nd observation                     |     |     |
| `salary` | All but the 1st and 3rd observation |     |     |

*Note that although the name of the second observation is left blank (indicated by the empty character string "") and the missing value of gender is coded as "?", they are not treated technically in R as missing values. We will need to identify these entries manually.*

Missing values are problmeatic in data analsis because many functions in R will return a missing value if some of its arguments contain missing values. There are many methods for dealing with missing values, some simple and some more sophisticated (the more sophisticated ones will e introduced in ATPA). In most cases, more than one method can apply. Here are some simple guidelines:

-   ***Removing observations:*** If the missing observations for a variable are only a very small part of the data, as in the case of Q1, then deleting the missing observation results in virtually no loss of information and is a sensible move.
-   ***Removing variables:*** If the majority of the observation for a variable are missing ,as in the case of `salary`, then the variable contributes little information to help us understand the data and it makes sense to remove the entire variable.

While removing observations nd/or variables is simple, doing so relies on the assumption that the missing values are randomly (rather than systematically) generated, so their removal is unlikely to introduce bias or impair the effectiveness of the predictive model we build.

For the sake of demonstration, here we will handle the missing values in the `actuary` dataset as follows:

-   Removing the `salary` variable.
-   Removing the second and fourth rows.
-   Treating `gender` as a factor with three levels, `"M", "F", and "?"`. (This requires no adjustment. If you like, you can rename the "?" level as \`"Unknown".)

The removal of `salary` should be straight forward and we can do it in exactly the same way as in Task 1.


``` r
actuary$salary <- NULL
actuary
#>              name gender age exams Q1 Q2 Q3
#> 1      Embryo Luo      M  -1    10 10  9  9
#> 2                      F  25     3 NA  9  7
#> 3     Peter Smith      M  22     0  4  5  5
#> 4            <NA>      F  50     4  7  7  8
#> 5 Angela Peterson      F  30     6  8  8 10
#> 6  Emily Johnston      F  42     7  9 10 10
#> 7   Barbara Scott      ?  29     5  8  9  7
#> 8    Benjamin Eng      M  36     9  7  8  8
```

Now lets proceed to remove the second and fourth observations (rows). Here are two commond methods, both of which rely on logical subsetting:

1.  *Using the `is.na()` function*: The `is.na()` function returns an object of the same size as its argument. The elements of this object are equal to `TRUE` if the corresponding elements of the original object are equal to NA and equal to `FALSE` otherwise. Effectively, it answers the question of hether each element of the function's argument is `NA` or not.


``` r
is.na(actuary$Q1)
#> [1] FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE
actuary.1 <- actuary[!is.na(actuary$Q1),]
actuary.1
#>              name gender age exams Q1 Q2 Q3
#> 1      Embryo Luo      M  -1    10 10  9  9
#> 3     Peter Smith      M  22     0  4  5  5
#> 4            <NA>      F  50     4  7  7  8
#> 5 Angela Peterson      F  30     6  8  8 10
#> 6  Emily Johnston      F  42     7  9 10 10
#> 7   Barbara Scott      ?  29     5  8  9  7
#> 8    Benjamin Eng      M  36     9  7  8  8
```

2.  *Using the `complete.cases()` or `na.omit()` functions*: These two functions are more global than `is.na()` and remove all rows containing missing values.


``` r
cc <- complete.cases(actuary)
actuary.2 <- actuary[cc, ]
actuary.2
#>              name gender age exams Q1 Q2 Q3
#> 1      Embryo Luo      M  -1    10 10  9  9
#> 3     Peter Smith      M  22     0  4  5  5
#> 5 Angela Peterson      F  30     6  8  8 10
#> 6  Emily Johnston      F  42     7  9 10 10
#> 7   Barbara Scott      ?  29     5  8  9  7
#> 8    Benjamin Eng      M  36     9  7  8  8
```


``` r
actuary.3 <- na.omit(actuary)
actuary.3
#>              name gender age exams Q1 Q2 Q3
#> 1      Embryo Luo      M  -1    10 10  9  9
#> 3     Peter Smith      M  22     0  4  5  5
#> 5 Angela Peterson      F  30     6  8  8 10
#> 6  Emily Johnston      F  42     7  9 10 10
#> 7   Barbara Scott      ?  29     5  8  9  7
#> 8    Benjamin Eng      M  36     9  7  8  8
```


``` r
actuary.n <- actuary.3 # cleansed dataset
actuary.n
#>              name gender age exams Q1 Q2 Q3
#> 1      Embryo Luo      M  -1    10 10  9  9
#> 3     Peter Smith      M  22     0  4  5  5
#> 5 Angela Peterson      F  30     6  8  8 10
#> 6  Emily Johnston      F  42     7  9 10 10
#> 7   Barbara Scott      ?  29     5  8  9  7
#> 8    Benjamin Eng      M  36     9  7  8  8

# Number of rows with missing values
nrow(actuary) - nrow(actuary.n)
#> [1] 2
```

While we have gotten rid of missing values, some entries in the new dataset are clearly amiss.

-   First, the age of the first actuary, Embryo Luo, is -1, which is not possible and is likely the result of a data entry error.

-   Second, the actuary called Peter Smith has no exams passed. While this may not be an error, it is highly questionable -- in this day and age, it is difficult to land a full-time actuarial job with no exams passed. In general, abormal values cannot be easily detected by built-in R functions and often have to be identified with the aid of human input.

How should we deal with these two observations? Peter Smith is not as problematic since we are not completely sure whether his `exams` entry is an error or not. It is judicious to retain the entry, but discuss its potential inaccuracy in your response, if this was a real PA exam and you were asked to discuss any concerns with the data you might have.

The `age` entry of Embryo Luo is more troublesome. For now, we will keep it and proceed. However, if you are going to fit a predictive model using `age` as a predictor, then it makes sense to exclude Embryo Luo from your analysis or make an educated guess of his age, e.g., imput his age using the average age of the other actuaries.

### Task 3: Adding New Variables

The opposite of removing an existing variable (Task 1) is to create a new variable of interest, which may serve as predictors in a predictive model.

To add a new variable to a data frame, we can use the dollar sign `$` notation to name and define the new variable. The generic syntax is:

```         
DATA_FRAME$NEW_VARIABLE <- DEFINITION
```

Even if the new variable does not exist in the original data frame, R will automatically expland the data frame to accomodate the new variable.

As an illustration run the following code to create a new variable, called `S` and added to the `actuary.n` data, that measure the avaerage of the three evaluation ratings for each actuary.


``` r
actuary.n$S <- (actuary.n$Q1 + actuary.n$Q2 + actuary.n$Q3) / 3
actuary.n
#>              name gender age exams Q1 Q2 Q3     S
#> 1      Embryo Luo      M  -1    10 10  9  9 9.333
#> 3     Peter Smith      M  22     0  4  5  5 4.667
#> 5 Angela Peterson      F  30     6  8  8 10 8.667
#> 6  Emily Johnston      F  42     7  9 10 10 9.667
#> 7   Barbara Scott      ?  29     5  8  9  7 8.000
#> 8    Benjamin Eng      M  36     9  7  8  8 7.667
```

As in Task 1, it is crucial that we specify the name of the dataset that should host the new variable. If you drop `"actuary.n"` on the left and use the command:

```         
S <- (actuary.n$Q1 + actuary.n$Q2 + actuary.n$Q3) / 3
```

Then the new variable `S` will exist in the current workspace, but not as a new variable in the `actuary.n` data frame.

In the previous code, we manually averaged the three evaluation ratings for each actuary. However, it would be cumbersome to type the ratings variable one by one if there were more than three periods. In this case, the `apply()` function can make our work a lot easier and is a powerful function in general.

The `apply()` function allows us to "apply" an arbitrary function to any dimension of a matrix or a data frame, provided that its columns are of the same data structure. Its general syntax is:

  $$
  \begin{equation} 
  \boxed{\begin{align*}apply(DATA_FRAME, MARGIN, FUNCTION)\end{align*}}
  \end{equation}
  $$

where `MARGIN = 1` indciates that the function will act on the rows of the data frame, while `MARGIN = 2` indicates that the function will act on its columns.

The next code chunk calculates the means for Q1, Q2, and Q3 using the `apply()` function.


``` r
actuary.n$S <- apply(actuary.n[, c("Q1", "Q2", "Q3")], 1, mean)
actuary.n
#>              name gender age exams Q1 Q2 Q3     S
#> 1      Embryo Luo      M  -1    10 10  9  9 9.333
#> 3     Peter Smith      M  22     0  4  5  5 4.667
#> 5 Angela Peterson      F  30     6  8  8 10 8.667
#> 6  Emily Johnston      F  42     7  9 10 10 9.667
#> 7   Barbara Scott      ?  29     5  8  9  7 8.000
#> 8    Benjamin Eng      M  36     9  7  8  8 7.667
```

### Task 4: Using Logical Tests to Identify Observations with Certain Characteristics

Under the SOA exam curriculum, an Associate is identified as an individual having passed seven to nine exams and a Fellow should have passed ten exams. To single out associates and fellows , we can again apply logical subsetting with carefully formulated logical tests. For a small dataset like `actuary.n`, it is easy to spot which actuaries are an associate or a fellow However, the subsetting techniques we introduce will generalize well to large datasets encounted in the practice; these datasets call for more systematic way to search through.

Fellows are easier to identify; they have passed exactly ten exams. Using this criterion to form a logical index vector for the row subscript, we can "extract" fellows and save their information to a new data frame called actuary.FSA:


``` r
actuary.FSA <- actuary.n[actuary.n$exams == 10, ]
actuary.FSA
#>         name gender age exams Q1 Q2 Q3     S
#> 1 Embryo Luo      M  -1    10 10  9  9 9.333
```

Similarly, for associates, we can subset on greater or equal to seven exams and less than or equal to 9 exams:


``` r
actuary.ASA <- actuary.n[actuary.n$exams >= 7 & actuary.n$exams <= 9, ]
actuary.ASA
#>             name gender age exams Q1 Q2 Q3     S
#> 6 Emily Johnston      F  42     7  9 10 10 9.667
#> 8   Benjamin Eng      M  36     9  7  8  8 7.667
```

### End of Chapter 1 Practice Problems

#### Exercise 1.5.2: Writing a Function to Calculate Loglikelihood

For $i = 1, ..., n$, let $Y_{i}$ be a Poisson random variable with mean $\mu_{i}$ and fitted mean $\widehat{\mu}_{i}$ based on a given predictive model (e.g., Poisson regression model, to be studied in Chapter 4) and the method of maximum likelihood estimation.

**(a)** Show that the maximum loglikelihood function is:

$\boxed{l(\widehat{\mu}_{1},...,\widehat{\mu}_{n}) = {\sum_{n=1}^{n}\widehat{\mu}_{i}} +  constants}$

provided that the $\widehat{\mu}_{i}$'s are well-defined.

**(b)** Write an R function called LL to compute the maximum loglikelihood function that takes the following two arguments:

  -   `observed` is a vector of observed values of the $Y_{i}$'s
  -   `predicted' is a vector of fitted values of the $Y_{i}$'s

**(c)** Use the function in part (b) to calculate the maximized loglikelihood function for the following data:


``` r
observed <- c(2, 3, 6, 7, 8, 9, 10, 12, 15) 
predicted <- c(2.516332, 2.516332, 7.451633, 7.451633, 7.451633, 7.451633, 12.386934, 12.386934, 12.386934)
```

_**Solution:**_

**(a)** The log-likelihood function is:

  $$
  \boxed{
  \begin{equation} 
  L(\mu_{1}, ..., \mu_{n}) \propto {\prod_{i=1}^{n}e^{-\mu_{i}}\mu_{i}^{y_{i}}} = e^{-\sum_{i=1}^{n}\mu_{i}}\prod_{i=1}^{n}\mu_{i}^{y_{i}},
  \end{equation}
  }
  $$

so the log-likelihood function at the fitted means $\widehat{\mu}_{1}, ..., \widehat{\mu}_{n}$ is:

  $$
  \boxed{
  \begin{equation} 
  l(\mu_{1}, ..., \mu_{n}) = LnL(\widehat{\mu}_{1}, ..., \widehat{\mu}_{n}) = \sum_{i=1}^{n}y_{i}ln\widehat{\mu}_{i} - \sum_{i=1}^{n}\widehat{\mu}_{i} + constants
  \end{equation}
  }
  $$ 
**(b)** The log-likelihood function involves $ln\widehat{\mu}_{i}$, which is not defined when $\widehat{\mu}_{i} \le 0$. To sidestep the calculation of $ln\widehat{\mu}_{i}$ for non-positive $\widehat{\mu}_{i}$, we need to design the function in such a way that those $\widehat{\mu}_{i}$'s will be converted to a small number such as 0.000001 and $ln0.000001$ is computed instead. This is accomplished by the `ifelse()` construct. Here is how the function is defined:

  
  ``` r
  LL <- function(observed, predicted) {
    predicted_pos <- ifelse(predicted <= 0, 0.000001, predicted)
    return(sum(observed*log(predicted_pos) - predicted))
  }
  
  ```

**(c)** For the given `observed` and `predicted` vectors, the maximized log-likelihood function equals 85.98277.

    
    ``` r
    observed <- c(2, 3, 6, 7, 8, 9, 10, 12, 15) 
    predicted <- c(2.516332, 2.516332, 7.451633, 7.451633, 7.451633, 7.451633, 12.386934, 12.386934, 12.386934)
    
    LL(observed, predicted)
    #> [1] 85.98
    ```

#### Exercise 1.5.3 (Based on new performance measure, how to create a new categorical variable that classifies each actuary as "Excellent", "Good", "Unsatisfactory")

Consider the `actuary.n` dataset in Section 1.3. If needed, run the following code to get it set up again:


``` r
x <- 1:8
name <- c("Embryo Luo", "", "Peter Smith", NA, "Angela Peterson", "Emily Johnston", "Barbara Scott", "Benjamin Eng")
gender <- c("M", "F", "M", "F", "F", "F", "?", "M")
age <- c(-1, 25, 22, 50, 30, 42, 29, 36)
exams <- c(10, 3, 0, 4, 6, 7, 5, 9)
Q1 <- c(10, NA, 4, 7, 8, 9, 8, 7)
Q2 <- c(9, 9, 5, 7, 8, 10, 9, 8)
Q3 <- c(9 ,7, 5, 8, 10, 10, 7, 8)
#salary <- c(300000, NA, 80000, NA, NA, NA, NA, NA)
actuary <- data.frame(x, name, gender, age, exams, Q1, Q2, Q3)
actuary.n <- na.omit(actuary)
actuary.n$S <- (actuary.n$Q1 + actuary.n$Q2 + actuary.n$Q3) / 3
actuary.n
#>   x            name gender age exams Q1 Q2 Q3     S
#> 1 1      Embryo Luo      M  -1    10 10  9  9 9.333
#> 3 3     Peter Smith      M  22     0  4  5  5 4.667
#> 5 5 Angela Peterson      F  30     6  8  8 10 8.667
#> 6 6  Emily Johnston      F  42     7  9 10 10 9.667
#> 7 7   Barbara Scott      ?  29     5  8  9  7 8.000
#> 8 8    Benjamin Eng      M  36     9  7  8  8 7.667
```

Suppose that as the boss of the six actuaries, you would like to classify them according to the following scheme:

| Criterion    |
|--------------|
| S \<= 7      |
| 7 \< S \<= 9 |
| S \>= 9      |

Write R commands to perform these classifications and save the classifications as a new variable called `classify`.

***Solution:*** Similar to how we accomplished Task 4 (b) in Section 1.3, we use `ifelse()` to make the classifications:


``` r
actuary.n$classify <- ifelse(actuary.n$S >= 9, "Excellent", 
                             ifelse(actuary.n$S > 7, "Good", "Unsatisfactory"))
actuary.n
#>   x            name gender age exams Q1 Q2 Q3     S
#> 1 1      Embryo Luo      M  -1    10 10  9  9 9.333
#> 3 3     Peter Smith      M  22     0  4  5  5 4.667
#> 5 5 Angela Peterson      F  30     6  8  8 10 8.667
#> 6 6  Emily Johnston      F  42     7  9 10 10 9.667
#> 7 7   Barbara Scott      ?  29     5  8  9  7 8.000
#> 8 8    Benjamin Eng      M  36     9  7  8  8 7.667
#>         classify
#> 1      Excellent
#> 3 Unsatisfactory
#> 5           Good
#> 6      Excellent
#> 7           Good
#> 8           Good
```
