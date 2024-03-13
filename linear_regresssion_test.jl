include("linear_regression.jl")

using .RegrModel
using Plots

function

in_x = [x for x in 1.:50]
transform = [rand(0.:10) for x in in_x]
in_y = in_x.* transform

a = RegrModel.create_regression_model(in_x, in_y)
dump(a)



scatter(in_x, in_y, label="Randomly generated values for regression.")