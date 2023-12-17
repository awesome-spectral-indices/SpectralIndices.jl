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

end

linear(params::Dict{String, <:Number}) = params["a"]*params["b"]
linear(params::Dict{String, AbstractArray}) = params["a"] .* params["b"]


function poly(params::Dict{String, <:Number})
    a, b, c, p = params["a"], params["b"],params["c"], params["p"]
    result = (a * b + c) ^ p
    return result
end

function poly(params::Dict{String, <:AbstractArray})
    a, b, c, p = params["a"], params["b"],params["c"], params["p"]
    result = @. (a * b + c) ^ p
    return result
end

function RBF(params::Dict{String, <:Number})
    a, b, sigma = params["a"], params["b"],params["sigma"]
    result = exp((-1.0 * (a - b) ^ 2.0) / (2.0 * sigma ^ 2.0))
    return result
end

function RBF(params::Dict{String, <:AbstractArray})
    a, b, sigma = params["a"], params["b"],params["sigma"]
    result = @. exp((-1.0 * (a - b) ^ 2.0) / (2.0 * sigma ^ 2.0))
    return result
end

