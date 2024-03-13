include("linear_regression.jl")

using .RegrModel
using Plots


in_x = [x for x in 1.:50]
transform = [rand(0.:10) for x in in_x]
in_y = in_x.* transform

a = RegrModel.create_regression_model(in_x, in_y)
dump(a)

test_x = 0.
test_y = RegrModel.predict(a, test_x)

test_x2 = 50.
test_y2 = RegrModel.predict(a, test_x2)

scatter(in_x, in_y, label="Randomly generated values for regression.")
plot!([test_x, test_x2], [test_y, test_y2], label="Result regression line")
