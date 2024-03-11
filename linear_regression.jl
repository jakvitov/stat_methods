using Plots

#This implementation uses general statistic formula for two vaiable linear regression
#Genearalization for any number of parameters can be found in my different repository here 
#https://github.com/jakvitov/math_simulations/blob/main/gradient_descend.ipynb
#That features full jupyter notebook with both math and algorithm explanation in Czech

#Julia implementation of simple linear regression model 
mutable struct RegressionModel
    #Parameters of the given model, parameter at ith position represents (i-1)th variable direction, position 1 is for constant
    parameters::Vector{Real}
    x_in::Vector{Float64}
    y_in::Vector{Float64}
end

#Avoiding Statistics package 
function vector_mean(vec::Vector{Number})::Real
    return (sum(vec)//length(vec))
end

#Get direction parameter of b1
function get_first_direction(x_in::Vector{Number}, y_in::Number{Float64})::Real
    return (vector_mean(x_in.* y_in)-(vector_mean(x_in)*vector_mean(y_in)))//(vector_mean(x_in.^2)-(vector_mean(x_in)^2))
end

#Get coefficient b0
function get_coeficient(x_in::Vector{Number}, y_in::Vector{Number}, b1::Real)::Real
    return (vector_mean(y_in) - (vector_mean(x_in).* b1))
end

function model_init(x_in::Vector{Number}, y_in::Vector{Number})
    model::RegressionModel = RegressionModel
    model.x_in = deepcopy(x_in)
    model.y_in = deepcopy(y_in)
    b1 = get_first_direction(x_in, y_in)
    b0 = get_coeficient(x_in, y_in, b1)
    model.parameters = [b0, b1]
    return model
end

#Predict y value based on the given model
function predict(model::RegressionModel, x_val::Number)
    return model.parameters[1]*x_val + model.parameters[0]
end

#Plot model with input parameters and given output 
function plot_model(model::RegressionModel)
    y1 = predict(model, 0)
    y2, predict(model, 1)
    scatter(model.x_in, model.y_in, label="Plot for regression model.")
    plot!([0, 1], [y1, v2])
    display(plot)
end

test_data_x = reshape(1:50, 50, 1)
test_data_y = test_data_x.* rand(0:10, length(test_data_x))
model = model_init(test_data_x, test_data_y)
plot_model(model)