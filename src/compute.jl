"""
    compute_index(index::String, params::Dict=Dict(), online::Bool=false; kwargs...) -> Any

Computes one or more Spectral Indices from a predefined list,
based on the provided index name, parameters, and optional keyword arguments.

# Parameters

  - `index`: Name of the spectral index or a list of index names to compute.
  - `params`: (Optional) Dictionary of parameters used as inputs for the
    computation. If not provided, parameters can be passed using keyword arguments.
  - `online`: (Optional) Flag indicating whether to retrieve the most recent
    list of indices online.
  - `kwargs`: Additional parameters used as inputs for the computation,
    provided as keyword pairs.

# Returns

  - Computed Spectral Indices, the type of return value depends on the input
    parameters.

# Examples

```julia-repl
julia> compute_index("NDVI"; N=0.643, R=0.175)

```

```julia-repl
julia> compute_index("NDVI"; N=fill(0.643, (5, 5)), R=fill(0.175, (5, 5)))

```

```julia-repl
julia> compute_index("NDVI"; N=fill(0.643, 5), R=fill(0.175, 5))

```

```julia-repl
julia> compute_index(["NDVI", "SAVI"]; N=fill(0.643, 5), R=fill(0.175, 5), L=fill(0.5, 5))

```

```julia-repl
julia> compute_index(["NDVI", "SAVI"]; N=0.643, R=0.175, L=0.5)

```

```julia-repl
julia> compute_index(
           ["NDVI", "SAVI"]; N=fill(0.643, (5, 5)), R=fill(0.175, (5, 5)), L=fill(0.5, (5, 5))
       )

```
"""
function compute_index(index::String, params::Dict=Dict(), online::Bool=false; kwargs...)

    indices = _create_indices(online)
    names = keys(indices)
    #for idx in index
    #    @assert idx in names "$index is not a valid Spectral Index!"
    #end

    @assert index in names "$index is not a valid Spectral Index!"


    if isempty(params)
        params = Dict(String(k) => v for (k, v) in pairs(kwargs))
    end

    _check_params(indices[index], params)
    params = _order_params(indices[index], params)
    result = _compute_index(indices[index], params...)

    return result
end

function compute_index(
    index::Vector{String},
    params::Dict=Dict(),
    online::Bool=false;
    kwargs...,
)

    indices = _create_indices(online)
    names = keys(indices)
    for idx in index
        @assert idx in names "$index is not a valid Spectral Index!"
    end
    #@assert all(i in names for i in index) "$index contains invalid Spectral Indices!"

    if isempty(params)
        params = Dict(String(k) => v for (k, v) in pairs(kwargs))
    end

    results = []

    for (nidx, idx) in enumerate(index)
        _check_params(indices[idx], params)
        local_params = _order_params(indices[idx], params)
        push!(results, _compute_index(indices[idx], local_params...))
    end

    return results
end

function compute_index(index::String, params::DataFrame, online::Bool=false; kwargs...)
    # Convert DataFrame to a dictionary for each row and compute the index
    results = [
        compute_index(index, Dict(zip(names(params), row)), online; kwargs...) for
        row in eachrow(params)
    ]

    # Return the results as a DataFrame with the column named after the index
    return DataFrame(Symbol(index) => results)
end

function compute_index(
    index::Vector{String}, params::DataFrame, online::Bool=false; kwargs...
)
    # Similar conversion and computation for a vector of indices
    result_dfs = DataFrame()
    for idx in index
        result_df = compute_index(idx, params, online; kwargs...)
        result_dfs[!, Symbol(idx)] = result_df[!, 1]
    end

    # Return the combined DataFrame with columns named after each index
    return result_dfs
end

# extend to YAXArrays
function compute_index(index::String, params::YAXArray, online::Bool=false; kwargs...)
    indices = _create_indices(online)
    names = keys(indices)
    #for idx in index
    #    @assert idx in names "$index is not a valid Spectral Index!"
    #end

    @assert index in names "$index is not a valid Spectral Index!"

    if isempty(params)
        params_yaxa = []
        names_yaxa = []
        for (key, value) in kwargs
            push!(params_yaxa, value)
            push!(names_yaxa, key)
        end
        params = concatenatecubes(names_yaxa, Dim{:Variables}(params_yaxa))
    end

    _check_params(indices[index], params)
    params = _order_params(indices[index], params)
    result = _compute_index(indices[index], params...)

    return result
end

function _compute_index(index, params::Number...)
    result = index(params...)
    return result
end

function _compute_index(index, params::AbstractArray...)
    result = index.(params...)
    return result
end

function _compute_index(index, params::YAXArray...)
    result = index.(params...)
    return result
end
