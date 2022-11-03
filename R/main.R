Pmat = function(n) ### this is t(P) in the paper
{
  P = matrix(nrow = n,ncol=n)
  P[1,]= 1/sqrt(n)

  for(i in 2:n){
    P[i,] = 1/sqrt( (n-i+2)*(n-i+1) )
    P[i,n-i+2] = -(n-i+1)/sqrt( (n-i+2)*(n-i+1) )
    if(i>=3){P[i,(n-i+3):n] = 0}
  }
  P
}


Qmat = function(m,n) ## m must be >=  n ; this is t(Q) in the paper
{
  if(m<n) stop("m must be >= n")
  Qmat = Pmat(m)
  Qmat[1:n,]
}


Te_test0 = function(x,y,given=FALSE,P=NULL,Q=NULL,print=TRUE)
{
  m = length(x)
  n = length(y)
  if(m<n) stop("m must be >= n")
  if(given==FALSE){
    P = Pmat(n)
    Q = Qmat(m,n)
  }

  Z<-Q%*%x/sqrt(m)-P%*%y/sqrt(n)

  Te = Z[1] / sqrt( (sum(Z^2) - Z[1]^2)/(n-1)  )

  pvalue = pt(-abs(Te),df=n-1)*2

  if(print==TRUE){
    res<-c(mean(x),mean(y),sd(x),sd(y),Te,pvalue,min(m,n))
    names(res)<-c("mean_x","mean_y","sd_x","sd_y","Te statistics","p_value","df")
    return(res)
  }else{
    return(pvalue)
  }
}


##====== Te test
Te_test = function(x,y,given=FALSE,P=NULL,Q=NULL,print=TRUE)
{
  m = length(x)
  n = length(y)
  if(m<n) pvalue = Te_test0(y,x,given,P,Q,print)
  else pvalue = Te_test0(x,y,given,P,Q,print)
  pvalue
}

####### Te CI

Te_CI0 = function(x,y,alpha)
{
  m = length(x)
  n = length(y)
  if(m<n) stop("m must be >= n")
  P = Pmat(n)
  Q = Qmat(m,n)

  Z<-Q%*%x/sqrt(m)-P%*%y/sqrt(n)

  Te = Z[1] / sqrt( (sum(Z^2) - Z[1]^2)/(n-1)  )

  return(  c(Z[1] - qt(1-alpha/2,n-1)*sqrt( (sum(Z^2) - Z[1]^2)/(n-1)  ),
           Z[1] + qt(1-alpha/2,n-1)*sqrt( (sum(Z^2) - Z[1]^2)/(n-1)  )) )
}

Te_CI = function(x,y,alpha=0.05)
{
  m = length(x)
  n = length(y)
  if(m<n) pvalue = Te_CI0(y,x,alpha)
  else pvalue = Te_CI0(x,y,alpha)
  pvalue
}





################    TN

TN_test= function(x,y){
  m = length(x)
  n = length(y)
  mean1<-mean(x)
  mean2<-mean(y)
  s1<-var(x)
  s2<-var(y)
  TN = (mean1-mean2)/sqrt(s1/m+s2/n)
  pvalue = pnorm(-abs(TN))*2
  pvalue
}


########### T1
T1_test= function(x,y){
  m = length(x)
  n = length(y)
  mean1<-mean(x)
  mean2<-mean(y)
  s1<-var(x)
  s2<-var(y)
  TN = (mean1-mean2)/sqrt(s1/m+s2/n)
  f = (s1/m+s2/n)^2/( s1^2/m^2/(m-1) + s2^2/n^2/(n-1) )
  pvalue = pt(-abs(TN),df=f)*2
  pvalue
}



#############    paired t test #######


paired_t_test0 = function(x,y){

  m = length(x)
  n = length(y)
  if(m<n) stop("m must be >= n")

  zz<-x[1:n] - y

  pvalue = t.test(zz)$p.value
  pvalue
}

paired_t_test = function(x,y){
  m = length(x)
  n = length(y)
  if(m<n) pvalue = paired_t_test0(y,x)
  else pvalue = paired_t_test0(x,y)
  pvalue
}


All_test<- function(x,y,given=FALSE,P=NULL,Q=NULL){
  result<- c(Te_test(x,y,given,P,Q,print = FALSE),
             T1_test(x,y),
             TN_test(x,y))
  names(result) <- c("Te","Welch","Z")
  return(result)
}


sim_Te<-function(mu1,mu2,sigma1,sigma2,n1,n2,rpt=1e4){
  result<-matrix(0,rpt,3)
  n<-min(n1,n2)
  m<-max(n1,n2)
  P = Pmat(n)
  Q = Qmat(m,n)

  for(ii in 1:rpt){
    x<-rnorm(n1,mu1,sigma1)
    y<-rnorm(n2,mu2,sigma2)
    m<-n1
    n<-n2

    m = length(x)
    n = length(y)
    if(m<n){
      a<-x
      x<-y
      y<-a
      m<-length(x)
      n<-length(y)
    }

    result[ii,] <- All_test(x,y,given = TRUE,P=P,Q=Q)
  }

  type_one_error<- colMeans(result<0.05)

  error_CI<-matrix(round(
    c(type_one_error,
      type_one_error -1.96 * sqrt(type_one_error*(1-type_one_error)/1e5),
      type_one_error +1.96 * sqrt(type_one_error*(1-type_one_error)/1e5)),4),3,3)
  colnames(error_CI)<-c("type_one_error","lower bound","upper bound")
  rownames(error_CI)<-c("Te","Welch","Z")

  result<-list(record = result,type_one_error = error_CI)
  return(result)
}


res<-sim_Te(mu1=0,mu2=0,sigma1=1,sigma2=2,n1=5,n2=50,rpt=1e5)

res$type_one_error
res$record


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
#
# rpt<-1e4
# res<-matrix(0,rpt,2)
# for (ii in 1:rpt) {
#   x<-rnorm(n1,mu1,sigma1)
#   y<-rnorm(n2,mu2,sigma2)
#   res[ii,] <- Te_CI(x,y,0.05)
# }
#
# mean(res[,1]<0 & res[,2]>0)
