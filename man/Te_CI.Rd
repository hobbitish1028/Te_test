\name{Te_CI}
\alias{Te_CI}
\title{Te_CI}
\usage{
x,y are two numeric vectors to be analyzed.

Alpha is the significance level, ususlly alpha=0.05.
}
\description{
Give confidence interval based on Te test, where two groups' variance can be unequal and the type one error is exactly alpha. It achieves the maximal degree of freedom and has better power than simple paired t test.
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
