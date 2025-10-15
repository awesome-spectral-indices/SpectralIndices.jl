"""
    get_datasets(; datasets=["S2_10m.json", "spectral.json"],
        data_loc=joinpath(dirname(@__FILE__), "..", "data"))

Download predefined datasets from a specified remote location
and save them to a local directory.

# Keyword Arguments

  - `datasets::Array{String,1}`: A list of dataset filenames to download.
    Defaults to `["S2_10m.json", "spectral.json"]`.
  - `data_loc::String`: The local directory path where the downloaded
    datasets will be saved. Defaults to a `data` directory
    located one level up from the script's directory.

"""
function get_datasets(; datasets=["S2_10m.json", "spectral.json"],
        data_loc=joinpath(dirname(@__FILE__), "..", "data"))
    for ds in datasets
        file_dest = joinpath(data_loc, ds)
        try
            Downloads.download(
                "https://raw.githubusercontent.com/awesome-spectral-indices/spyndex/main/spyndex/data/" *
                ds,
                file_dest
            )
        catch e
            @warn "Failed to download dataset $ds: $e"
        end
    end
end

"""
    load_dataset(dataset::String, T) -> YAXArray
    load_dataset(dataset::String, T) -> DataFrame

Load a specified dataset and convert it into either a
YAXArray or a DataFrame, depending on the loaded packages.

# Arguments

  - `dataset::String`: The name of the dataset to load.
    Currently supports `"sentinel"` and `"spectral"`.
  - `T`: type of the dataset. To be set as `YAXArray` for "sentinel",
    and `DataFrame` for "spectral".

# Returns

  - If YAXArrays is loaded in the namespace, returns a `YAXArray` object
    containing the loaded dataset, with dimensions labeled as `:x`, `:y`,
    and `:bands`. The spatial dimensions (`:x` and `:y`) are assumed to
    have a size of 300 each, and the `:bands` dimension includes
    ["B02", "B03", "B04", "B08"] bands.
  - If DataFrames is loaded in the namespace, returns a `DataFrame`
    with the dataset loaded into it.
"""
function load_dataset() end
