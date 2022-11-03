
---
output: github_document
---

<!-- README.md is generated from README.Rmd. Please edit that file -->

```{r, include = FALSE}
knitr::opts_chunk$set(
  collapse = TRUE,
  eval = FALSE,
  comment = "#>",
  fig.path = "man/figures/README-",
  out.width = "100%"
)
library(knitr)
```


# Te_test
Exact/non-asymptotical two sample test with unequal variance

Welch test is frequently used for two sample t test, when two groups' variances are unequal. However it is a asymptotic method, which means the type one error is not exactly alpha. Te test (e for exact) performs exact/non-asymptotic two sample t test, where two groups' variance can be unequal and the type one error is exactly alpha. It achieves the maximal degree of freedom and has better power than simple paired t test.

Go to https://arxiv.org/pdf/2210.16473.pdf for more details.


Here is an example for the use of this package: (?Te_test)

```{r, include = FALSE}
n1<-5
n2<-50
mu1<-0
mu2<-0
sigma1<-1
sigma2<-2
x<-rnorm(n1,mu1,sigma1)
y<-rnorm(n2,mu2,sigma2)
```

Perform Te test and get statistics:
Te_test(x,y)
       mean_x        mean_y          sd_x          sd_y Te statistics 
 -0.005319838  -0.097103586   2.093702543   0.766032594   0.453422894 
      p_value            df 
  0.673753449   5.000000000 
  
Perform Te test and get confidence interval:  
Te_CI(x,y,alpha=0.05)
-0.4702358  0.6538033


Here we also show a quick simulation to compare the performance between Te test, Welch test and Z test. We can see welch's type one error is biased from 0.05, which means it is not an exact test.

res<-sim_Te(mu1=0,mu2=0,sigma1=1,sigma2=2,n1=5,n2=50,rpt=1e5)


