
#Return matrix of theoretical distributions from the given matrix
theor_dist_matrix = function(mtx){
  res = matrix(NA, nrow=nrow(mtx) - 1, ncol=ncol(mtx) - 1)
  n = mtx[nrow(mtx), ncol(mtx)]
  for (i in 1:(nrow(mtx)-1)) {
    for (j in 1:(ncol(mtx)-1)) {
      res[i,j] = (mtx[i, ncol(mtx)] * mtx[nrow(mtx), j])/n
      if (res[i, j] < 5) {
        stop("Cannot use Chi-quadrat because of small number of theoretical distributions. Need at least five of each.")
      }
    }
  }
  return(res)
}

#Return test criteria mased on the given matrices used for chi quadrat
test_criteria = function(real, theoretical){
  tc = 0
  for (i in 1:(nrow(real)-1)) {
    for (j in 1:(ncol(real)-1)) {
      tc = tc + ((real[i, j] - theoretical[i, j])^2 / theoretical[i, j])
    }
  }
  
  return(tc)
}

#Return value of pearson dependency coefficient for the given values
pearson_dependence_coefficient = function(G, n) {
  return(sqrt(G/(n+G)))
}

#Return value of Cramer dependency coefficient for the given values
cramer_dependence_coefficient = function(G, n, m) {
  return(sqrt(G/(n*(m-1))))
}

#Given matrix representing values of two categorical variables calculate on the given 
# significance level alpha if they are dependent or not
#In case of dependece, return vector with pearson and cramer dependency coefficient
#Else return vector of nulls
categorical_dependence = function(mtx, alpha) {
  res = c(0,0)
  #First we calculate hypothetical distribution matrix
  r_sum=rowSums(mtx)
  emtx = cbind(mtx, r_sum)
  c_sum=colSums(emtx)
  emtx = rbind(emtx, c_sum)
  theor_dist = theor_dist_matrix(emtx)
  
  tc = test_criteria(emtx, theor_dist)
  
  crit_int=qchisq(alpha, (nrow(mtx) - 1) *(ncol(mtx) - 1))
  # H0 is rejected (dependecy exists on alpha significance level)
  if (tc > crit_int) {
      res[1] = pearson_dependence_coefficient(tc, emtx[nrow(emtx), ncol(emtx)])
      res[2] = cramer_dependence_coefficient(tc, emtx[nrow(emtx), ncol(emtx)], ncol(mtx))
      return(res)
  }
  return(res)
}



test_data = matrix(c(22, 11, 37, 42, 10, 8), nrow=2, ncol=3, byrow=TRUE)
print(categorical_dependence(test_data, 0.95))
