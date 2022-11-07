
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Te

<!-- badges: start -->
<!-- badges: end -->

The goal of Te test is to perform “exact” two sample test with unequal
variance.

*X*<sub>*i*</sub> ∼ *N*(*μ*<sub>1</sub>,*σ*<sub>1</sub><sup>2</sup>), *i* = 1, 2, ..., *n*<sub>1</sub>

*Y*<sub>*i*</sub> ∼ *N*(*μ*<sub>2</sub>,*σ*<sub>2</sub><sup>2</sup>), *i* = 1, 2, ..., *n*<sub>2</sub>

Hypothesis testing of
*H*<sub>0</sub> : *μ*<sub>1</sub> = *μ*<sub>2</sub> when
*σ*<sub>1</sub><sup>2</sup> ≠ *σ*<sub>2</sub><sup>2</sup>:

# Other avaible methods

Welch test is frequently used for two sample t test, when two groups’
variances are unequal. However it is an asymptotic method, which means
the type one error is not exactly alpha.

Z test, which uses normal statistics and is less accurate then Welch
test.

Paired t test, only works when sample sizes are equal.

Other non-conventional methods like two-stage test.

# Feature

Te test (e for exact) performs exact/non-asymptotic two sample t test:

-   two groups’ variance can be unequal.

-   the type one error is exactly alpha.

-   It achieves the maximal degree of freedom and has better power than
    simple paired t test.

-   Significantly outperform Welch t test when sample size is small
    (e.g. 5-50).

Go to <https://arxiv.org/pdf/2210.16473.pdf> for more details.

## Installation

You can install the development version of Te like so:

``` r
library(devtools)
#> Loading required package: usethis
install_github("hobbitish1028/Te_test",force=TRUE)
#> Downloading GitHub repo hobbitish1028/Te_test@HEAD
#>      checking for file ‘/private/var/folders/t9/xnj_n8410l1_xx0k9r8q2hdw0000gn/T/Rtmp4wfzhE/remotes1633707aee32/hobbitish1028-Te_test-7f84a04/DESCRIPTION’ ...  ✔  checking for file ‘/private/var/folders/t9/xnj_n8410l1_xx0k9r8q2hdw0000gn/T/Rtmp4wfzhE/remotes1633707aee32/hobbitish1028-Te_test-7f84a04/DESCRIPTION’
#>   ─  preparing ‘Te’:
#>      checking DESCRIPTION meta-information ...  ✔  checking DESCRIPTION meta-information
#>   ─  checking for LF line-endings in source and make files and shell scripts
#>   ─  checking for empty or unneeded directories
#>    Omitted ‘LazyData’ from DESCRIPTION
#>   ─  building ‘Te_0.1.0.tar.gz’
#>      
#> 
#> Warning in i.p(...): installation of package '/var/folders/t9/
#> xnj_n8410l1_xx0k9r8q2hdw0000gn/T//Rtmp4wfzhE/file163316ac4e4f/Te_0.1.0.tar.gz'
#> had non-zero exit status
library(Te)
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(Te)
n1<-15
n2<-50
mu1<-0
mu2<-0
sigma1<-1
sigma2<-2
x<-rnorm(n1,mu1,sigma1)
y<-rnorm(n2,mu2,sigma2)
Te_test(x,y)
#>        mean_x        mean_y          sd_x          sd_y Te statistics 
#>    0.02574839    0.18371837    2.19035241    0.71592575   -0.42162697 
#>       p_value            df 
#>    0.67969951   15.00000000
```

Find confidence interval for *μ*<sub>1</sub> − *μ*<sub>2</sub>

``` r
Te_CI(x,y,alpha=0.05)
#> [1] -0.6456122  0.9615521
```

## Simulation

Here we also show a quick simulation to compare the performance between
Te test, Welch test and Z test. We can see Welch’s type one error is
biased from 0.05, which means it is not an exact test. Te has a type one
error close to alpha = 0.05 bacause it is an exact test.

Although Welch t test is a robust one, we can see that Te test
outperforms it significantly when sample sizes are relative small
(\<100) and two size differs a lot (e.g. 5 and 50).

``` r
set.seed(123)
res<-sim_Te(mu1=0,mu2=0,sigma1=1,sigma2=2,n1=5,n2=50,rpt=1e5)
res$type_one_error
#>       type_one_error lower bound upper bound
#> Te            0.0499      0.0486      0.0513
#> Welch         0.0563      0.0549      0.0577
#> Z             0.0825      0.0808      0.0842

res<-sim_Te(mu1=0,mu2=0,sigma1=1,sigma2=2,n1=5,n2=7,rpt=1e5)
res$type_one_error
#>       type_one_error lower bound upper bound
#> Te            0.0496      0.0482      0.0509
#> Welch         0.0464      0.0451      0.0478
#> Z             0.0799      0.0782      0.0816
```
