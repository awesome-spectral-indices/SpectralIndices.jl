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

julia> compute_index(
           ["NDVI", "SAVI"]; N=fill(0.643, (5, 5)), R=fill(0.175, (5, 5)), L=fill(0.5, (5, 5))
       )

```
"""
function compute_index(index::AbstractSpectralIndex, params=nothing, online::Bool=false;
        indices=indices, kwargs...)
    if isnothing(params)
        params = create_params(kwargs...)
    end

    return compute_index(index, params; indices=indices)
end

function compute_index(index::String, params=nothing, online::Bool=false;
        indices=indices, kwargs...)
    names = keys(indices)
    @assert index in names "$index is not a valid Spectral Index!"
    results = compute_index(indices[index], params; indices=indices, kwargs...)
    return results
end

function compute_index(index::Vector{<:AbstractSpectralIndex}, params=nothing,
        online::Bool=false; indices=_create_indices(online), kwargs...)
    if isnothing(params)
        params = create_params(kwargs...)
    end

    return compute_index(index, params; indices=indices)
end

function compute_index(index::Vector{String}, params=nothing, online::Bool=false;
        indices=create_indices(online), kwargs...)
    names = keys(indices)
    for idx in index
        @assert idx in names "$index is not a valid Spectral Index!"
    end
    idxs = [indices[idx] for idx in index]
    results = compute_index(idxs, params; indices=indices, kwargs...)
    return results
end

function compute_index(index::AbstractSpectralIndex, params::Dict; indices=indices)
    check_params(index, params)
    params = order_params(index, params)
    T = eltype(first(values(params)))
    result = _compute_index(T, index, params...)

    return result
end

# TODO: return results in a matrix columnswise
#multi_result = compute_index(["NDVI", "SAVI"], N = fill(0.643, 5), R = fill(0.175, 5), L = fill(0.5, 5))
function compute_index(index::Vector{<:AbstractSpectralIndex}, params::Dict;
        indices=indices)
    results = []
    for (nidx, idx) in enumerate(index)
        result = compute_index(idx, params; indices=indices)
        push!(results, result)
    end

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

function compute_index(index::AbstractSpectralIndex, params::NamedTuple; indices=indices)
    check_params(index, params)
    params = order_params(index, params)
    T = eltype(first(values(params)))
    result = _compute_index(T, index, params...)
    result_nt = (; Dict(Symbol(index.short_name) => result)...)
    return result_nt
end

function compute_index(index::Vector{<:AbstractSpectralIndex}, params::NamedTuple;
        indices=indices)
    results_dict = Dict{Symbol, Any}()
    for idx in index
        result_nt = compute_index(idx, params; indices=indices)
        # TODO @MartinuzziFrancesco: there has to be a better way
        results_dict[fieldnames(typeof(result_nt))[1]] = first(result_nt)
    end

    # Convert the dictionary to a named tuple
    return (; results_dict...)
end

"""
    check_params(index::String, params::Dict, indices::Dict)

Check if the parameters dictionary contains all required bands for spectral index computation.

# Arguments

  - `index::String`: The name of the spectral index to check.
  - `params::Dict`: The parameters dictionary to check for required bands.
  - `indices::Dict`: The dictionary containing information about spectral indices.
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

function order_params(index::AbstractSpectralIndex, params)
    T = eltype(params)
    new_params = T[]
    for (bidx, band) in enumerate(index.bands)
        push!(new_params, params[band])
    end

    return new_params
end

function order_params(index::AbstractSpectralIndex, params::Dict)
    T = eltype(values(params))
    new_params = T[]
    for (bidx, band) in enumerate(index.bands)
        push!(new_params, params[band])
    end

    return new_params
end

function create_params(kw_args...)
    params = Dict(String(k) => v for (k, v) in kw_args)
    return params
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

function order_params(index::AbstractSpectralIndex, params::NamedTuple)
    T = eltype(values(params))
    new_params = T[]
    for (bidx, band) in enumerate(index.bands)
        band_symbol = Symbol(band)
        push!(new_params, params[band_symbol])
    end

    return new_params
end
