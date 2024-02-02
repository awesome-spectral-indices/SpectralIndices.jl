"""
gets the indices from spyndex
"""
function get_datasets(;
    datasets=["S2_10m.json", "spectral.json"],
    data_loc=joinpath(dirname(@__FILE__), "..", "data"),
)
    for ds in datasets
        file_dest = joinpath(data_loc, ds)
        Downloads.download(
            "https://raw.githubusercontent.com/awesome-spectral-indices/spyndex/main/spyndex/data/S2_10m.json",
            file_dest,
        )
    end
end

"""
"""
function open_dataset()
    dfext = Base.get_extension(SpectralIndices, :SpectralIndicesDataFramesExt)
    yaxaxext = Base.get_extension(SpectralIndices, :SpectralIndicesYAXArraysExt)

    if isnothing(dfext) && isnothing(yaxaxext)
        error("Load a library (DataFrames, YAXArrays) to use this function")
    end
end
