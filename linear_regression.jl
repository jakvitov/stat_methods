module RegrModel
using Plots
#Simple linear regression model for one independant variable
#Generalized version optimalization can be found in my other repository at
#https://github.com/jakvitov/math_simulations
mutable struct RegresssionModel
    slope::Real
    intercept::Real
    in_x::Vector{Float64}
    in_y::Vector{Float64}
    #Empty constructor
    RegresssionModel() = new()
end

#Get mean of vector values
function vector_mean(input::Vector{Float64})
    return sum(input)/length(input)
end

#Calculate slope of a regression model 
function get_slope(model::RegresssionModel)
    a = vector_mean(model.in_x.* model.in_y)-(vector_mean(model.in_x)*vector_mean(model.in_y))
    b = vector_mean(model.in_x.^2) - vector_mean(model.in_x)^2
    return a/b
end

function get_intercept(model::RegresssionModel)
    if model.slope == undef
        @warn("Model slope not calculated. Calculating slope.")
        model.slope = get_slope(model)
    end
    return vector_mean(model.in_y)-model.slope*vector_mean(model.in_x)
end

#Enter prediction of the x value based on the given model
function predict(model::RegresssionModel, x::Float64)
    if model.slope == undef || model.intercept == undef
        throw("Intercept and slope missing!")
    end

    return model.slope*x + model.intercept
end

#Init function for a regression model
function create_regression_model(in_x::Vector{Float64}, in_y::Vector{Float64})
    res::RegresssionModel = RegresssionModel()
    res.in_x = deepcopy(in_x)
    res.in_y = deepcopy(in_y)
    res.slope = get_slope(res)
    res.intercept = get_intercept(res)
    return res
end

export create_regression_model,RegresssionModel, predict

end