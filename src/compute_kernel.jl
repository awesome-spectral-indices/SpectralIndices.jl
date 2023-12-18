function compute_kernel(
    kernel,
    params=nothing;
    kwargs...
)
    if params === nothing
        params = _create_params(kwargs...)
    end

    results = compute_kernel(kernel, params)
    return results
end

function compute_kernel(
    kernel,
    params::Dict
)
    results = kernel(params)
    return results
end

function compute_kernel(
    kernel,
    params::DataFrame
)
    results = kernel(params)
    return results
end

linear(a::Number, b::Number) = a*b
linear(a::AbstractArray, b::AbstractArray) = a .*b

function linear(params::Dict{String, T}) where T <: Union{<:Number, <:AbstractArray}
    result = linear(params["a"], params["b"])
    return result
end

function linear(params::DataFrame)
    result = linear(params[!, "a"], params[!, "b"])
    result_df = DataFrame(linear = result)
    return result_df
end

function poly(a::T, b::T, c::T, p::T) where T <: Number
    return (a * b + c) ^ p
end

function poly(a::T, b::T, c::T, p::T) where T <: AbstractArray
    return @. (a * b + c) ^ p
end

function poly(params::Dict{String, T}) where T <: Union{<:Number, <:AbstractArray}
    result = poly(params["a"], params["b"], params["c"], params["p"])
    return result
end

function poly(params::DataFrame)
    result = poly(params[!, "a"], params[!, "b"], params[!, "c"], params[!, "p"])
    result_df = DataFrame(poly = result)
    return result_df
end

function RBF(a::T, b::T, sigma::T) where T <: Number
    return exp((-1.0 * (a - b) ^ 2.0) / (2.0 * sigma ^ 2.0))
end

function RBF(a::T, b::T, sigma::T) where T <: AbstractArray
    return @. exp((-1.0 * (a - b) ^ 2.0) / (2.0 * sigma ^ 2.0))
end

function RBF(params::Dict{String, T}) where T <: Union{<:Number, <:AbstractArray}
    result = RBF(params["a"], params["b"], params["sigma"])
    return result
end

function RBF(params::DataFrame)
    result = RBF(params[!, "a"], params[!, "b"], params[!, "sigma"])
    result_df = DataFrame(RBF = result)
    return result_df
end