
#Return the intra group variance of a matrix by rows
intra_var = function(mtx, emtx) {
  intra_var = 0
  for (i in 1:nrow(mtx)) {
    for (j in 1:ncol(mtx)) {
      intra_var = intra_var + (emtx[i, j] - emtx[i, ncol(emtx)])^2
    }
  }
  return(intra_var)
}

#Return the criteria for te inter-group variability
inter_var = function(emtx) {
  avg = mean(emtx[,ncol(emtx)])
  res = 0
  for (i in range(1:nrow(emtx))){
    res = res + (((emtx[i, ncol(emtx)] - avg)^2)*(ncol(emtx) - 1))
  }
  return(res)
}

#Return test criteria for the anova variabilty test based on the given parameters
test_crit_anova = function(inter_var, intra_var, k, n) {
  return((inter_var/(k-1)) / (intra_var/(n-k)))
}

#Return result of anova dependency analysis of two variables on significance level alpha
#One cathegorical and second continous
#Input matrix has continous variables in rows and cathegorical are devided by individual rows 
#Return determination rate 
anova =function(mtx, alpha){
  emtx = cbind(mtx, rowMeans(mtx))
  intra_var = intra_var(mtx, emtx)
  inter_var = inter_var(emtx)
  n = nrow(mtx)*ncol(mtx)
  k = nrow(mtx)
  test_crit = test_crit_anova(inter_var, intra_var, k, n)
  borderline=df(alpha,df1 = k-1,df2 = n-1)
  if (test_crit > borderline) {
    return(inter_var/(intra_var + inter_var))
  }
  return(0)
}


test_data = matrix(c(5,4,4,6,4,5,7,3,4,2,2,2,3,4,2,2,1,1,0,2,1), nrow=3, ncol=7, byrow=TRUE)

anova(test_data, 0.95)

