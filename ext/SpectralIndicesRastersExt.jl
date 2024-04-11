module SpectralIndicesRastersExt

using SpectralIndices
using Rasters
using DimensionalData

function SpectralIndices._check_params(index, params::Raster)
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

function SpectralIndices._order_params(index, params::Raster)
    new_params = []
    for (bidx, band) in enumerate(index.bands)
        push!(new_params, params[Variable=At(band)])
    end

    return new_params
end

function SpectralIndices._create_params(kw_args::Pair{Symbol,<:Raster}...)
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
function SpectralIndices.compute_index(
    ::Type{T}, index::String, params::Raster; indices=SpectralIndices._create_indices()
) where {T<:Number}
    SpectralIndices._check_params(indices[index], params)
    params = SpectralIndices._order_params(indices[index], params)
    result = SpectralIndices._compute_index(T, indices[index], params...)
    return result
end

function SpectralIndices.compute_index(
    index::String, params::Raster; indices=SpectralIndices._create_indices()
)
    return SpectralIndices.compute_index(Float64, index, params; indices=indices)
end

function SpectralIndices.compute_index(
    ::Type{T},
    index::Vector{String},
    params::Raster;
    indices=SpectralIndices._create_indices(),
) where {T<:Number}
    results = []
    for (nidx, idx) in enumerate(index)
        res_tmp = compute_index(T, idx, params; indices=indices)
        push!(results, res_tmp)
    end
    result = RasterStack(results...; name=index)

    return result
end

function SpectralIndices.compute_index(
    index::Vector{String}, params::Raster; indices=SpectralIndices._create_indices()
)
    return SpectralIndices.compute_index(Float64, index, params; indices=indices)
end

function SpectralIndices._compute_index(
    ::Type{T}, idx::SpectralIndices.AbstractSpectralIndex, prms::Raster...
) where {T<:Number}
    return idx.(T, prms...)
end

function SpectralIndices.linear(::Type{T}, params::Raster) where {T<:Number}
    return SpectralIndices.linear(T, params[Variable=At("a")], params[Variable=At("b")])
end

function SpectralIndices.linear(params::Raster)
    return SpectralIndices.linear(
        Float64, params[Variable=At("a")], params[Variable=At("b")]
    )
end

function SpectralIndices.poly(::Type{T}, params::Raster) where {T<:Number}
    return SpectralIndices.poly(
        T,
        params[Variable=At("a")],
        params[Variable=At("b")],
        params[Variable=At("c")],
        params[Variable=At("p")],
    )
end

function SpectralIndices.poly(params::Raster)
    return SpectralIndices.poly(Float64, params)
end

function SpectralIndices.RBF(::Type{T}, params::Raster) where {T<:Number}
    return SpectralIndices.RBF(
        T, params[Variable=At("a")], params[Variable=At("b")], params[Variable=At("sigma")]
    )
end

function SpectralIndices.RBF(params::Raster)
    return SpectralIndices.RBF(Float64, params)
end


function SpectralIndices.load_dataset(
    dataset::String, ::Type{T}
) where {T<:Raster}
    datasets = Dict("sentinel" => "S2_10m.json")

    if dataset in keys(datasets)
        nothing
    else
        error("Dataset name not valid. Datasets available for Rasters: sentinel")
    end

    ds = SpectralIndices._load_json(datasets[dataset])
    matrices = [hcat(ds[i]...) for i in 1:length(ds)]
    data_3d = cat(matrices...; dims=3)
    x_dim = Dim{:x}(1:300)
    y_dim = Dim{:y}(1:300)
    bands = Dim{:bands}(["B02", "B03", "B04", "B08"])
    yax_ds = Raster(data_3d, (x_dim, y_dim, bands))
end

end #module
