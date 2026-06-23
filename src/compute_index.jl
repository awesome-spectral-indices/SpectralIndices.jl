function _default_indices(online::Bool=false)
    online ? create_indices(online) : SpectralIndices.indices
end

"""
    compute_index(index, params, [online]; kwargs...) -> Any

Computes one or more Spectral Indices.

# Arguments

  - `index`: Name of the spectral index or a list of index names to compute.
  - `params`: (Optional) Dictionary of parameters used as inputs for the
    computation. If not provided, parameters can be passed using keyword arguments.
  - `online`: (Optional) Flag indicating whether to retrieve the most recent
    list of indices online. Default is `false`.
  - `kwargs`: Additional parameters used as inputs for the computation,
    provided as keyword pairs.

# Examples

```jldoctest
julia> using SpectralIndices

julia> compute_index("NDVI"; N=0.643, R=0.175)
0.5721271393643031

julia> compute_index("NDVI"; N=fill(0.643, (5, 5)), R=fill(0.175, (5, 5)))
5×5 Matrix{Float64}:
 0.572127  0.572127  0.572127  0.572127  0.572127
 0.572127  0.572127  0.572127  0.572127  0.572127
 0.572127  0.572127  0.572127  0.572127  0.572127
 0.572127  0.572127  0.572127  0.572127  0.572127
 0.572127  0.572127  0.572127  0.572127  0.572127

julia> compute_index("NDVI"; N=fill(0.643, 5), R=fill(0.175, 5))
5-element Vector{Float64}:
 0.5721271393643031
 0.5721271393643031
 0.5721271393643031
 0.5721271393643031
 0.5721271393643031

julia> compute_index(["NDVI", "SAVI"]; N=0.643, R=0.175, L=0.5)
2-element Vector{Any}:
 0.5721271393643031
 0.5326251896813354

julia> compute_index(["NDVI", "SAVI"]; N=fill(0.643, (2, 2)), R=fill(0.175, (2, 2)), L=fill(0.5, (2,2)))
2-element Vector{Any}:
 [0.5721271393643031 0.5721271393643031; 0.5721271393643031 0.5721271393643031]
 [0.5326251896813354 0.5326251896813354; 0.5326251896813354 0.5326251896813354]
```
"""
function compute_index(index::AbstractSpectralIndex, params=nothing, online::Bool=false;
        indices=_default_indices(online), kwargs...)
    if isnothing(params)
        params = create_params(kwargs...)
    end

    check_params(index, params)
    return compute_index(index, params; indices=indices)
end

function compute_index(index::AbstractSpectralIndex, params::NamedTuple,
        online::Bool=false; indices=_default_indices(online))
    check_params(index, params)
    params = order_params(index, params)
    T = _infer_type(params)
    result = _compute_index(T, index, params...)

    return (; Dict(Symbol(index.short_name) => result)...)
end

function compute_index(index::AbstractSpectralIndex, params::Dict,
        online::Bool=false; indices=_default_indices(online))
    check_params(index, params)
    params = order_params(index, params)
    T = _infer_type(params)

    return _compute_index(T, index, params...)
end

### multiple indices

function compute_index(index::Vector{<:AbstractSpectralIndex}, params=nothing,
        online::Bool=false; indices=_default_indices(online), kwargs...)
    if isnothing(params)
        params = create_params(kwargs...)
    end

    return compute_index(index, params; indices=indices)
end

function compute_index(
        index::Vector{<:AbstractSpectralIndex}, params::NamedTuple, online::Bool=false;
        indices=_default_indices(online))
    results_dict = Dict{Symbol, Any}()
    for idx in index
        result_nt = compute_index(idx, params; indices=indices)
        results_dict[fieldnames(typeof(result_nt))[1]] = first(result_nt)
    end

    return (; results_dict...)
end

function compute_index(
        index::Vector{<:AbstractSpectralIndex}, params::Dict, online::Bool=false;
        indices=_default_indices(online))
    results = Any[]
    for idx in index
        result = compute_index(idx, params; indices=indices)
        push!(results, result)
    end

    return results
end

### strings

function compute_index(index::String, params=nothing, online::Bool=false;
        indices=_default_indices(online), kwargs...)
    check_index_name(index, indices)

    return compute_index(indices[index], params; indices=indices, kwargs...)
end

function compute_index(index::Vector{String}, params=nothing, online::Bool=false;
        indices=_default_indices(online), kwargs...)
    names = keys(indices)
    for idx in index
        if !(idx in names)
            throw(ArgumentError("$idx is not a valid Spectral Index!"))
        end
    end
    idxs = [indices[idx] for idx in index]
    results = compute_index(idxs, params; indices=indices, kwargs...)
    return results
end

#_compute_index(idx::AbstractSpectralIndex, prms::Number...) = idx(prms...)
function _compute_index(::Type{T}, idx::AbstractSpectralIndex,
        prms::Number...) where {T <: Number}
    return idx(T, prms...)
end

#_compute_index(idx::AbstractSpectralIndex, prms::AbstractArray...) = idx.(prms...)
function _compute_index(::Type{T}, idx::AbstractSpectralIndex,
        prms::AbstractArray...) where {T <: Number}
    return idx.(T, prms...)
end

"""
    check_params(index::String, params::Dict, indices::Dict)

Check if the parameters dictionary contains all required bands for spectral index computation.

# Arguments

  - `index::String`: The name of the spectral index to check.
  - `params::Dict`: The parameters dictionary to check for required bands.
  - `indices::Dict`: The dictionary containing information about spectral indices.

```
```
"""
function check_params(index::AbstractSpectralIndex, params::Dict)
    for band in index.bands
        if !(band in keys(params))
            throw(
                ArgumentError(
                "'$band' is missing in the parameters for $index computation!"
            ),
            )
        end
    end
end

function check_params(index::AbstractSpectralIndex, params::NamedTuple)
    for band in index.bands
        if !(Symbol(band) in keys(params))
            throw(
                ArgumentError(
                "'$band' is missing in the parameters for $index computation!"
            ),
            )
        end
    end
end

function check_params(index::AbstractSpectralIndex, params)
    throw(ArgumentError(
        "Unsupported params type $(typeof(params)) for $(index.short_name) computation. " *
        "Expected Dict, NamedTuple, DataFrame, or YAXArray."
    ))
end

function order_params(index::AbstractSpectralIndex, params::Dict)
    return tuple((params[band] for band in index.bands)...)
end

function order_params(index::AbstractSpectralIndex, params::NamedTuple)
    return tuple((getfield(params, Symbol(band)) for band in index.bands)...)
end

function create_params(kw_args...)
    return Dict(String(k) => v for (k, v) in kw_args)
end

function _infer_type(prms)
    ts = _gen_eltype(prms)
    T = promote_type(float.(ts)...)
    return T
end

_gen_eltype(params) = eltype.(params)
function _gen_eltype(params::Union{NamedTuple, Dict})
    mapreduce(eltype, promote_type, values(params))
end

function check_index_name(index, indices)
    if !(index in keys(indices))
        throw(ArgumentError("$index is not a valid Spectral Index!"))
    end
end
