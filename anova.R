
#Return result of anova dependency analysis of two variables
#One cathegorical and second continous
#Input matrix has continous variables in rows and cathegorical are devided by individual rows 
#Return determination rate 
anova =function(mtx){
  res = 0
  emtx = cbind(mtx, rowMeans(mtx))
  inter_var = 0
  for (i in 1:nrow(mtx)) {
    for (j in 1:ncol(mtx)) {
      print(inter_var)
      inter_var = inter_var + (emtx[i, j] - emtx[i, ncol(emtx)])^2
    }
  }
  print(inter_var)
  return(res)
}


test_data = matrix(c(5,4,4,6,4,5,7,3,4,2,2,2,3,4,2,2,1,1,0,2,1), nrow=3, ncol=7, byrow=TRUE)

anova(test_data)