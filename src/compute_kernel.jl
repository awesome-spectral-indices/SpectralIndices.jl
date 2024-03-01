"""
    compute_kernel([Float64], kernel, params=nothing; kwargs...)

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
function compute_kernel(::Type{T}, kernel, params=nothing; kwargs...) where {T<:Number}
    if isnothing(params)
        params = _create_params(kwargs...)
    end

    results = kernel(T, params)
    return results
end

function compute_kernel(kernel, params=nothing; kwargs...)
    return compute_kernel(Float64, kernel, params; kwargs...)
end

"""
    linear([Float64], a::Number, b::Number)
    linear([Float64], a::AbstractArray, b::AbstractArray)
    linear([Float64], params::Dict{String, T})
    linear([Float64], params::DataFrame)
    linear([Float64], params::YAXArray)

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
linear(::Type{T}, a::Number, b::Number) where {T<:Number} = a * b
linear(a::Number, b::Number) = linear(Float64, a, b)
linear(::Type{T}, a::AbstractArray, b::AbstractArray) where {T<:Number} = a .* b
linear(a::AbstractArray, b::AbstractArray) = linear(Float64, a, b)

function linear(::Type{T}, params::Dict{String,U}) where {T<:Number, U<:Union{<:Number,<:AbstractArray}}
    result = linear(T, params["a"], params["b"])
    return result
end

function linear(params::Dict{String,U}) where {U<:Union{<:Number,<:AbstractArray}}
  return linear(Float64, params)
end

function linear(::Type{T}, params::NamedTuple) where {T<:Number}
    result = linear(T, params.a, params.b)
    return result
end

linear(params::NamedTuple) = linear(Float64, params)

"""
    poly([Float64], a::T, b::T, c::T, p::T) where T <: Number
    poly([Float64], a::T, b::T, c::T, p::T) where T <: AbstractArray
    poly([Float64], params::Dict{String, T})
    poly([Float64], params::DataFrame)
    poly([Float64], params::YAXArray)

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
function poly(::Type{T}, a::Number, b::Number, c::Number, p::Number) where {T<:Number}
    return (a * b + c)^p
end

function poly(a::Number, b::Number, c::Number, p::Number)
    return poly(Float64, a, b, c, p)
end

function poly(::Type{T}, a::V, b::V, c::V, p::V) where {T<:Number, V<:AbstractArray}
    return @. (a * b + c)^p
end

function poly(a::T, b::T, c::T, p::T) where {T<:AbstractArray}
    return poly(Float64, a, b, c, p)
end

function poly(::Type{T}, params::Dict{String,P}) where {T<:Number, P<:Union{<:Number,<:AbstractArray}}
    result = poly(params["a"], params["b"], params["c"], params["p"])
    return result
end

function poly(params::Dict{String,T}) where {T<:Union{<:Number,<:AbstractArray}}
    return poly(Float64, params)
end

function poly(::Type{T}, params::NamedTuple) where {T<:Number}
    result = poly(params.a, params.b, params.c, params.p)
    return result
end

function poly(params::NamedTuple)
    return poly(Float64, params)
end

"""
    RBF([Float64], a::T, b::T, sigma::T) where T <: Number
    RBF([Float64], a::T, b::T, sigma::T) where T <: AbstractArray
    RBF([Float64], params::Dict{String, T})
    RBF([Float64], params::DataFrame)
    RBF([Float64], params::YAXArray)

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
function RBF(::Type{T}, a::Number, b::Number, sigma::Number;
    const1::Number = T(-1.0),
    const2::Number = T(2.0)) where {T<:Number}
    return exp((const1 * (a - b)^const2) / (const2 * sigma^const2))
end

function RBF(a::Number, b::Number, sigma::Number)
    return RBF(Float64, a, b, sigma)
end

function RBF(::Type{T}, a::V, b::V, sigma::V;
    const1::Number = T(-1.0),
    const2::Number = T(2.0)) where {T<:Number, V<:AbstractArray}
    return @. exp((const1 * (a - b)^const2) / (const2 * sigma^const2))
end

function RBF(a::T, b::T, sigma::T) where {T<:AbstractArray}
    return RBF(Float64, a, b, sigma)
end

function RBF(::Type{T},
    params::Dict{String,V}) where {T<:Number, V<:Union{<:Number,<:AbstractArray}}
    return RBF(T, params["a"], params["b"], params["sigma"])
end

function RBF(params::Dict{String,T}) where {T<:Union{<:Number,<:AbstractArray}}
    return RBF(Float64, params)
end

function RBF(::Type{T}, params::NamedTuple) where {T<:Number}
    return RBF(T, params.a, params.b, params.sigma)
end

function RBF(params::NamedTuple)
    return RBF(Float64, params)
end
