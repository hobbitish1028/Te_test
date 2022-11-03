\name{Te_test}
\alias{Te_test}
\title{Te_test}
\usage{
x,y are two numeric vectors to be analyzed.

When print=TRUE, the function will give mean, sd, statistics, p value and degree of freedom;

When print=FALSE, the function will only give p value.
}
\description{
Perform exact/non-asymptotic two sample t test, where two groups' variance can be unequal and the type one error is exactly alpha. It achieves the maximal degree of freedom and has better power than simple paired t test.
}
\examples{
n1<-5
n2<-50
mu1<-0
mu2<-0
sigma1<-1
sigma2<-2
x<-rnorm(n1,mu1,sigma1)
y<-rnorm(n2,mu2,sigma2)

Te_test(x,y)
Te_CI(x,y,0.05)
}
