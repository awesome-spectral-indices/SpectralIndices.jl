module SpectralIndicesYAXArraysExt

using SpectralIndices
using YAXArrays
using DimensionalData
import SpectralIndices:
    _check_params,
    _create_params,
    _order_params,
    AbstractSpectralIndex,
    compute_index,
    _create_indices,
    linear,
    poly,
    RBF,
    load_dataset,
    _load_json

function _check_params(index::AbstractSpectralIndex, params::YAXArray)
    for band in index.bands
        if !(band in params.Variables)
            throw(
                ArgumentError(
                    "'$band' is missing in the parameters for $index computation!"
                ),
            )
        end
    end
end

function _order_params(index::AbstractSpectralIndex, params::YAXArray)
    new_params = []
    for (bidx, band) in enumerate(index.bands)
        push!(new_params, params[Variable=At(band)])
    end

    return new_params
end

function _create_params(kw_args::Pair{Symbol,<:YAXArray}...)
    params_yaxa = []
    names_yaxa = []
    for (key, value) in kw_args
        push!(params_yaxa, value)
        push!(names_yaxa, String(key))
    end

    params = concatenatecubes(params_yaxa, Dim{:Variables}(names_yaxa))
    return params
end

## TODO: simplify even further
# this is same function contente as dispatch on Dict
function compute_index(
    index::AbstractSpectralIndex, params::YAXArray; indices=_create_indices()
)
    _check_params(index, params)
    params = _order_params(index, params)
    T = eltype(first(params))
    result = _compute_index(T, index, params...)
    return result
end

function compute_index(
    index::Vector{<:AbstractSpectralIndex}, params::YAXArray; indices=_create_indices()
)
    results = []
    for (nidx, idx) in enumerate(index)
        res_tmp = compute_index(idx, params; indices=indices)
        push!(results, res_tmp)
    end
    result = concatenatecubes(results, Dim{:Variables}(index))

    return result
end

function _compute_index(
    ::Type{T}, idx::AbstractSpectralIndex, prms::YAXArray...
) where {T<:Number}
    return idx.(T, prms...)
end

function linear(params::YAXArray)
    return linear(params[Variable=At("a")], params[Variable=At("b")])
end

function poly(params::YAXArray)
    return poly(
        params[Variable=At("a")],
        params[Variable=At("b")],
        params[Variable=At("c")],
        params[Variable=At("p")],
    )
end

function RBF(params::YAXArray)
    return RBF(
        params[Variable=At("a")], params[Variable=At("b")], params[Variable=At("sigma")]
    )
end

function load_dataset(dataset::String, ::Type{T}) where {T<:YAXArray}
    datasets = Dict("sentinel" => "S2_10m.json")

    if dataset in keys(datasets)
        nothing
    else
        error("Dataset name not valid. Datasets available for YAXArrays: sentinel")
    end

    ds = _load_json(datasets[dataset])
    matrices = [hcat(ds[i]...) for i in 1:length(ds)]
    data_3d = cat(matrices...; dims=3)
    x_dim = Dim{:x}(1:300)
    y_dim = Dim{:y}(1:300)
    bands = Dim{:bands}(["B02", "B03", "B04", "B08"])
    yax_ds = YAXArray((x_dim, y_dim, bands), data_3d)

    return yax_ds
end

end #module
