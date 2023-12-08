function compute_index(
    index::String,
    params::Dict=Dict(),
    online::Bool=false;
    kwargs...
)

    #isempty(params) ? params = kwargs

    if isempty(params)
        params = Dict(String(k)=>v for (k,v) in pairs(kwargs))
    end

    indices = _create_indices(online)
    names = keys(indices)
    @assert index in names "$index is not a valid Spectral Index!"
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

function _compute_index(params::Dict, index)
    result = parse_eval_dict(index.formula, params)
    return result
end


function compute_index(
    index::Vector{String},
    params::Dict=Dict(),
    online::Bool=false,
    return_origin::Bool=true,
    coordinate::String="index";
    kwargs...
)
    if isempty(params)
        params = Dict(String(k)=>v for (k,v) in pairs(kwargs))
    end

    indices = _create_indices(online)
    names = keys(indices)

    result = zeros(length(index))

    for (nidx,idx) in enumerate(index)
        @assert idx in names "$idx is not a valid Spectral Index!"
        _check_params(idx, params, indices)
        result[nidx] = parse_eval_dict(indices[idx].formula, params)
    end

    return result
end