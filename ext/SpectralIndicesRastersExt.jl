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


function SpectralIndices.load_dataset(
    dataset::String, ::Type{T}
) where {T<:Raster}
    datasets = Dict("sentinel" => "S2_10m.json")

    if dataset in keys(datasets)
        nothing
    else
        error("Dataset name not valid. Datasets available for YAXArrays: sentinel")
    end

    ds = SpectralIndices._load_json(datasets[dataset])
    matrices = [hcat(ds[i]...) for i in 1:length(ds)]
    data_3d = cat(matrices...; dims=3)
    x_dim = Dim{:x}(1:300)
    y_dim = Dim{:y}(1:300)
    bands = Dim{:bands}(["B02", "B03", "B04", "B08"])
    yax_ds = Raster(data_3d, (x_dim, y_dim, bands))

end #module
