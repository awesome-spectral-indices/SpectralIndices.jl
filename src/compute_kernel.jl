"""
    compute_kernel(kernel, params=nothing; kwargs...)

Compute a specified kernel using either provided parameters or keyword arguments.

# Arguments

  - `kernel`: The kernel function to use. Should be one of `linear`, `poly`, or `RBF`.
  - `params`: (Optional) A `Dict`, `DataFrame`, or `YAXArray` containing parameters for the kernel computation.
  - `kwargs...`: Keyword arguments that will be converted to parameters if `params` is not provided.

# Returns

  - The result of the kernel computation, the type of which depends on the input type.

# Examples

```julia
result = compute_kernel(linear; params=Dict("a" => 1, "b" => 2))
```
"""
function compute_kernel(kernel, params=nothing; kwargs...)
    if params === nothing
        params = _create_params(kwargs...)
    end

    results = kernel(params)
    return results
end

"""
    linear(a::Number, b::Number)
    linear(a::AbstractArray, b::AbstractArray)
    linear(params::Dict{String, T})
    linear(params::DataFrame)
    linear(params::YAXArray)

Compute the linear kernel `a * b`. This function supports various input types,
including numbers, arrays, dictionaries, data frames, and YAXArrays.

# Arguments

  - `a`: First parameter for the linear kernel. Can be a number or an array.
  - `b`: Second parameter for the linear kernel. Can be a number or an array.
  - `params`: A dictionary, data frame, or YAXArray containing the parameters "a" and "b".

# Returns

  - The result of `a * b`. The output type depends on the input types:

      + If `a` and `b` are numbers, the result is a number.
      + If `a` and `b` are arrays, the result is an array with element-wise multiplication.
      + If `params` is used, the result is in the same format as `params` (either a dictionary,
        DataFrame, or YAXArray).

# Examples

```julia
# Using numbers
result = linear(2, 3)

# Using arrays
result = linear([1, 2, 3], [4, 5, 6])

# Using a dictionary
result = linear(Dict("a" => 2, "b" => 3))

# Using a DataFrame
df = DataFrame(; a=[1, 2, 3], b=[4, 5, 6])
result = linear(df)
```
"""
linear(a::Number, b::Number) = a * b
linear(a::AbstractArray, b::AbstractArray) = a .* b

function linear(params::Dict{String,T}) where {T<:Union{<:Number,<:AbstractArray}}
    result = linear(params["a"], params["b"])
    return result
end

function linear(params::DataFrame)
    result = linear(params[!, "a"], params[!, "b"])
    result_df = DataFrame(; linear=result)
    return result_df
end

function linear(params::YAXArray)
    result = linear(params[Variable=At("a")], params[Variable=At("b")])
    return result
end

"""
    poly(a::T, b::T, c::T, p::T) where T <: Number
    poly(a::T, b::T, c::T, p::T) where T <: AbstractArray
    poly(params::Dict{String, T})
    poly(params::DataFrame)
    poly(params::YAXArray)

Compute the polynomial kernel `(a * b + c) ^ p`. This function supports various input types,
including numbers, arrays, dictionaries, data frames, and YAXArrays.

# Arguments

  - `a`: First parameter for the polynomial kernel. Can be a number or an array.
  - `b`: Second parameter for the polynomial kernel. Can be a number or an array.
  - `c`: Coefficient added to the product of `a` and `b`. Can be a number or an array.
  - `p`: Exponent to which the sum of the product and coefficient is raised. Can be a number or an array.
  - `params`: A dictionary, data frame, or YAXArray containing the parameters "a", "b", "c", and "p".

# Returns

  - The result of `(a * b + c) ^ p`. The output type depends on the input types:

      + If `a`, `b`, `c`, and `p` are numbers, the result is a number.
      + If `a`, `b`, `c`, and `p` are arrays, the result is an array with the operation applied element-wise.
      + If `params` is used, the result matches the format of `params` (either a dictionary,
        DataFrame, or YAXArray).

# Examples

```julia
# Using numbers
result = poly(2, 3, 1, 2)

# Using arrays
result = poly([1, 2, 3], [4, 5, 6], [1, 1, 1], [2, 2, 2])

# Using a dictionary
result = poly(Dict("a" => 2, "b" => 3, "c" => 1, "p" => 2))

# Using a DataFrame
df = DataFrame(; a=[1, 2, 3], b=[4, 5, 6], c=[1, 1, 1], p=[2, 2, 2])
result = poly(df)
```
"""
function poly(a::T, b::T, c::T, p::T) where {T<:Number}
    return (a * b + c)^p
end

function poly(a::T, b::T, c::T, p::T) where {T<:AbstractArray}
    return @. (a * b + c)^p
end

function poly(params::Dict{String,T}) where {T<:Union{<:Number,<:AbstractArray}}
    result = poly(params["a"], params["b"], params["c"], params["p"])
    return result
end

function poly(params::DataFrame)
    result = poly(params[!, "a"], params[!, "b"], params[!, "c"], params[!, "p"])
    result_df = DataFrame(; poly=result)
    return result_df
end

function poly(params::YAXArray)
    result = poly(
        params[Variable=At("a")],
        params[Variable=At("b")],
        params[Variable=At("c")],
        params[Variable=At("p")],
    )
    return result
end

"""
    RBF(a::T, b::T, sigma::T) where T <: Number
    RBF(a::T, b::T, sigma::T) where T <: AbstractArray
    RBF(params::Dict{String, T})
    RBF(params::DataFrame)
    RBF(params::YAXArray)

Compute the Radial Basis Function (RBF) kernel `exp((-1.0 * (a - b) ^ 2.0) / (2.0 * sigma ^ 2.0))`.
This function supports various input types, including numbers, arrays, dictionaries, data frames,
and YAXArrays.

# Arguments

  - `a`: First parameter for the RBF kernel. Can be a number or an array.
  - `b`: Second parameter for the RBF kernel. Can be a number or an array.
  - `sigma`: Length-scale parameter for the RBF kernel. Can be a number or an array.
  - `params`: A dictionary, data frame, or YAXArray containing the parameters "a", "b", and "sigma".

# Returns

  - The result of the RBF kernel. The output type depends on the input types:

      + If `a`, `b`, and `sigma` are numbers, the result is a number.
      + If `a`, `b`, and `sigma` are arrays, the result is an array with the operation applied element-wise.
      + If `params` is used, the result matches the format of `params` (either a dictionary,
        DataFrame, or YAXArray).

# Examples

```julia
# Using numbers
result = RBF(1, 2, 0.5)

# Using arrays
result = RBF([1, 2, 3], [4, 5, 6], [0.5, 0.5, 0.5])

# Using a dictionary
result = RBF(Dict("a" => 1, "b" => 2, "sigma" => 0.5))

# Using a DataFrame
df = DataFrame(; a=[1, 2, 3], b=[4, 5, 6], sigma=[0.5, 0.5, 0.5])
result = RBF(df)
```
"""
function RBF(a::T, b::T, sigma::T) where {T<:Number}
    return exp((-1.0 * (a - b)^2.0) / (2.0 * sigma^2.0))
end

function RBF(a::T, b::T, sigma::T) where {T<:AbstractArray}
    return @. exp((-1.0 * (a - b)^2.0) / (2.0 * sigma^2.0))
end

function RBF(params::Dict{String,T}) where {T<:Union{<:Number,<:AbstractArray}}
    result = RBF(params["a"], params["b"], params["sigma"])
    return result
end

function RBF(params::DataFrame)
    result = RBF(params[!, "a"], params[!, "b"], params[!, "sigma"])
    result_df = DataFrame(; RBF=result)
    return result_df
end

function RBF(params::YAXArray)
    result = RBF(
        params[Variable=At("a")], params[Variable=At("b")], params[Variable=At("sigma")]
    )
    return result
end
