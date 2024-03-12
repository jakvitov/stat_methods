using Plots

#This implementation uses general statistic formula for two vaiable linear regression
#Genearalization for any Float64 of parameters can be found in my different repository here 
#https://github.com/jakvitov/math_simulations/blob/main/gradient_descend.ipynb
#That features full jupyter notebook with both math and algorithm explanation in Czech

#Julia implementation of simple linear regression model 
mutable struct RegressionModel
    #Parameters of the given model, parameter at ith position represents (i-1)th variable direction, position 1 is for constant
    parameters::Array{Real}
    x_in::Array{Float64}
    y_in::Array{Float64}
end

#Avoiding Statistics package 
function Array_mean(vec::Array{Float64})::Real
    return (sum(vec)//length(vec))
end

#Get direction parameter of b1
function get_first_direction(x_in::Array{Float64}, y_in::Array{Float64})::Real
    return (Array_mean(x_in.* y_in)-(Array_mean(x_in)*Array_mean(y_in)))//(Array_mean(x_in.^2)-(Array_mean(x_in).^2))
end

#Get coefficient b0
function get_coeficient(x_in::Array{Float64}, y_in::Array{Float64}, b1::Real)::Real
    return (Array_mean(y_in) - (Array_mean(x_in).* b1))
end

function model_init(x_in::Array{Float64}, y_in::Array{Float64})
    model::RegressionModel = RegressionModel()
    model.x_in = deepcopy(x_in)
    model.y_in = deepcopy(y_in)
    b1 = get_first_direction(x_in, y_in)
    b0 = get_coeficient(x_in, y_in, b1)
    model.parameters = [b0, b1]
    return model
end

#Predict y value based on the given model
function predict(model::RegressionModel, x_val::Float64)
    return model.parameters[1]*x_val + model.parameters[0]
end

#Plot model with input parameters and given output 
function plot_model(model::RegressionModel)
    y1 = predict(model, 0)
    y2, predict(model, 1)
    scatter(model.x_in, model.y_in, label="Plot for regression model.")
    plot!([0, 1], [y1, y2])
    display(plot)
end

test_data_x = reshape(1:50, 50, 1)
test_data_y = test_data_x.* rand(0:10, length(test_data_x))
typeof(test_data_x)
#model = model_init(test_data_x, test_data_y)
#plot_model(model)