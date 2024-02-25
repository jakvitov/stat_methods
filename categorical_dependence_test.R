
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

#Given matrix representing values of two categorical variables calculate on the given 
# significance level alpha if they are dependent or not
# Return false if H0 is accepted (they are not dependent)
# Return true if H0 is not accepted in favour of H1
categorical_dependence = function(mtx, alpha) {
  #First we calculate hypothetical distribution matrix
  r_sum=rowSums(mtx)
  emtx = cbind(mtx, r_sum)
  c_sum=colSums(emtx)
  emtx = rbind(emtx, c_sum)
  theor_dist = theor_dist_matrix(emtx)
  
  tc = test_criteria(emtx, theor_dist)
  
  crit_int=qchisq(1-alpha, (nrow(mtx) - 1) *(ncol(mtx) - 1))
  print(tc)
  return(FALSE)
  
}

test_data = matrix(c(22, 11, 37, 42, 10, 8), nrow=2, ncol=3, byrow=TRUE)
categorical_dependence(test_data, 0.95)
