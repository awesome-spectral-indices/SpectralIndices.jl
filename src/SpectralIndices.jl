module SpectralIndices

using Dates
using Downloads
using JSON

export SpectralIndex, indices, compute, compute_index

function compute_index(
    index::Union{String, Vector{String}},
    params::Dict=Dict(),
    online::Bool=false,
    return_origin::Bool=true,
    coordinate::String="index";
    kwargs...
)
    if isempty(params)
        params = kwargs
    end

    if isa(index, String)
        index = [index]
    end

    indices = _create_indices(online)
    names = keys(indices)

    result = Any[]

    for idx in index
        if !(idx in names)
            throw(ArgumentError("$idx is not a valid Spectral Index!"))
        else
            _check_params(idx, params, indices)
            push!(result, parse_eval_dict(indices[idx].formula, params))
        end
    end

    if length(result) == 1
        result = result[1]
    else
        if return_origin
            if isa(result[1], AbstractArray)
                result = hcat(result...)
            elseif isa(result[1], DataFrame)
                result = DataFrame(result)
            elseif isa(result[1], DataArray)
                result = [x for x in result]
                result = vcat(result...)
            elseif isa(result[1], Image)
                result = Image(hcat(result...))
            elseif isa(result[1], Number)
                result = [x for x in result]
            elseif isa(result[1], AbstractArray)
                result = hcat(result...)
            elseif isa(result[1], AbstractDataArray)
                result = [x for x in result]
                result = vcat(result...)
            elseif isa(result[1], Series)
                result = DataFrame(result)
            end
        end
    end

    return result
end


abstract type AbstractSpectralIndex end

include("utils.jl")
include("axioms.jl")
#include("datasets.jl")
indices = _create_indices()

end #module
