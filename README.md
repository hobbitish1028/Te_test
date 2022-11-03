
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Te

<!-- badges: start -->
<!-- badges: end -->

The goal of Te is to perform exact/non-asymptotical two sample test with
unequal variance.

# History

Welch test is frequently used for two sample t test, when two groups’
variances are unequal. However it is a asymptotic method, which means
the type one error is not exactly alpha.

Te test (e for exact) performs exact/non-asymptotic two sample t test,
where two groups’ variance can be unequal and the type one error is
exactly alpha. It achieves the maximal degree of freedom and has better
power than simple paired t test.

Go to <https://arxiv.org/pdf/2210.16473.pdf> for more details.

## Installation

You can install the development version of Te like so:

``` r
library(devtools)
#> Loading required package: usethis
install_github("hobbitish1028/Te_test")
#> Downloading GitHub repo hobbitish1028/Te_test@HEAD
#>      checking for file ‘/private/var/folders/t9/xnj_n8410l1_xx0k9r8q2hdw0000gn/T/Rtmp1tZOUe/remotes101d61a3e93/hobbitish1028-Te_test-c4ecd80/DESCRIPTION’ ...  ✔  checking for file ‘/private/var/folders/t9/xnj_n8410l1_xx0k9r8q2hdw0000gn/T/Rtmp1tZOUe/remotes101d61a3e93/hobbitish1028-Te_test-c4ecd80/DESCRIPTION’
#>   ─  preparing ‘Te’:
#>      checking DESCRIPTION meta-information ...  ✔  checking DESCRIPTION meta-information
#>   ─  checking for LF line-endings in source and make files and shell scripts
#>   ─  checking for empty or unneeded directories
#>    Omitted ‘LazyData’ from DESCRIPTION
#>   ─  building ‘Te_0.1.0.tar.gz’
#>      
#> 
library(Te)
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(Te)
n1<-5
n2<-50
mu1<-0
mu2<-0
sigma1<-1
sigma2<-2
x<-rnorm(n1,mu1,sigma1)
y<-rnorm(n2,mu2,sigma2)
Te_test(x,y)
#>        mean_x        mean_y          sd_x          sd_y Te statistics 
#>    0.03109351    0.11360028    1.90547256    0.61129425   -0.19968611 
#>       p_value            df 
#>    0.85146666    5.00000000
Te_CI(x,y,alpha=0.05)
#> [1] -1.229685  1.064671
```

## Simulation

Here we also show a quick simulation to compare the performance between
Te test, Welch test and Z test. We can see Welch’s type one error is
biased from 0.05, which means it is not an exact test. Te has a type one
error close to alpha = 0.05 bacause it is an exact test.

``` r
set.seed(123)
res<-sim_Te(mu1=0,mu2=0,sigma1=1,sigma2=2,n1=5,n2=50,rpt=1e5)
res$type_one_error
#>       type_one_error lower bound upper bound
#> Te            0.0499      0.0486      0.0513
#> Welch         0.0563      0.0549      0.0577
#> Z             0.0825      0.0808      0.0842
```
