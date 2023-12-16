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
function compute_index(
    index::String,
    params=nothing,
    online::Bool=false;
    kwargs...
)

    indices = _create_indices(online)
    names = keys(indices)
    @assert index in names "$index is not a valid Spectral Index!"

    if params == nothing
        params = _create_params(kwargs...)
    end

    results = compute_index(index, params)
    return results
end

function compute_index(
    index::String,
    params::Dict
)
    indices = _create_indices()
    _check_params(indices[index], params)
    params = _order_params(indices[index], params)
    result = _compute_index(indices[index], params...)

    return result
end

function compute_index(
    index::String,
    params::DataFrame
)
    # Convert DataFrame to a dictionary for each row and compute the index
    results = [
        compute_index(index, Dict(zip(names(params), row))) for
        row in eachrow(params)
    ]

    # Return the results as a DataFrame with the column named after the index
    return DataFrame(Symbol(index) => results)
end

## TODO: simplify even further
# this is same function contente as dispatch on Dict
function compute_index(index::String, params::YAXArray)
    indices = _create_indices()
    _check_params(indices[index], params)
    params = _order_params(indices[index], params)
    result = _compute_index(indices[index], params...)
    return result
end

function compute_index(
    index::Vector{String},
    params=nothing,
    online::Bool=false;
    kwargs...,
)

    indices = _create_indices(online)
    names = keys(indices)
    for idx in index
        @assert idx in names "$index is not a valid Spectral Index!"
    end

    if params == nothing
        params = _create_params(kwargs...)
    end

    results = compute_index(index, params)

    return results
end

# TODO: return results in a matrix columnswise
#multi_result = compute_index(["NDVI", "SAVI"], N = fill(0.643, 5), R = fill(0.175, 5), L = fill(0.5, 5))
function compute_index(
    index::Vector{String},
    params::Dict
)

    indices = _create_indices()
    results = []

    for (nidx, idx) in enumerate(index)
        _check_params(indices[idx], params)
        local_params = _order_params(indices[idx], params)
        push!(results, _compute_index(indices[idx], local_params...))
    end

    return results
end

function compute_index(
    index::Vector{String},
    params::DataFrame
)
    # Similar conversion and computation for a vector of indices
    result_dfs = DataFrame()
    for idx in index
        result_df = compute_index(idx, params)
        result_dfs[!, Symbol(idx)] = result_df[!, 1]
    end

    # Return the combined DataFrame with columns named after each index
    return result_dfs
end


function compute_index(
    index::Vector{String},
    params::YAXArray
)

    results = []
    for (nidx, idx) in enumerate(index)
        res_tmp = compute_index(idx, params)
        push!(results, res_tmp)
    end
    result = concatenatecubes(results, Dim{:Variables}(index))

    return result
end

_compute_index(idx::AbstractSpectralIndex, prms::Number...) = idx(prms...)
_compute_index(idx::AbstractSpectralIndex, prms::AbstractArray...) = idx.(prms...)
_compute_index(idx::AbstractSpectralIndex, prms::YAXArray...) = idx.(prms...)