"""
    get_datasets(; datasets=["S2_10m.json", "spectral.json"], data_loc=joinpath(dirname(@__FILE__), "..", "data"))

Download predefined datasets from a specified remote location and save them to a local directory.

# Keyword Arguments

  - `datasets::Array{String,1}`: A list of dataset filenames to download. Defaults to `["S2_10m.json", "spectral.json"]`.
  - `data_loc::String`: The local directory path where the downloaded datasets will be saved. Defaults to a `data` directory located one level up from the script's directory.

# Description

This function iterates over a list of dataset filenames, downloads each dataset from a predefined remote URL, and saves them into a specified local directory. The remote URL is currently hardcoded to download specifically the "S2_10m.json" file for any given dataset in the list. Adjust the function or its usage accordingly if different URLs are needed for different datasets.

# Example

```julia
get_datasets()  # Downloads the default datasets to the default location

get_datasets(; datasets=["custom_dataset.json"], data_loc="path/to/custom/directory")
```

This is particularly useful for setting up local environments with necessary data files for further processing or analysis.
"""
function get_datasets(;
    datasets = ["S2_10m.json", "spectral.json"],
    data_loc = joinpath(dirname(@__FILE__), "..", "data"),
)
    for ds in datasets
        file_dest = joinpath(data_loc, ds)
        try
            Downloads.download(
                "https://raw.githubusercontent.com/awesome-spectral-indices/spyndex/main/spyndex/data/" *
                ds,
                file_dest,
            )
        catch e
            @warn "Failed to download dataset $ds: $e"
        end
    end
end

"""
    load_dataset(dataset::String) -> YAXArray
    load_dataset(dataset::String) -> DataFrame

Load a specified dataset and convert it into either a YAXArray or a DataFrame, depending on the loaded packages.

# Arguments

  - `dataset::String`: The name of the dataset to load. Currently supports `"sentinel"` and `"spectral"`.

# Returns

  - If YAXArrays is loaded in the namespace, returns a `YAXArray` object containing the loaded dataset, with dimensions labeled as `:x`, `:y`, and `:bands`. The spatial dimensions (`:x` and `:y`) are assumed to have a size of 300 each, and the `:bands` dimension includes ["B02", "B03", "B04", "B08"] bands.
  - If DataFrames is loaded in the namespace, returns a `DataFrame` with the dataset loaded into it.

# Errors

Throws an error if the `dataset` argument does not match one of the predefined dataset names.

# Example

```julia
# Load dataset as YAXArray
yax_ds = SpectralIndices.load_dataset("sentinel")

# Load dataset as DataFrame
df_ds = SpectralIndices.load_dataset("spectral")
```

The current implementation expects the JSON files ("S2_10m.json" for "sentinel" and "spectral.json" for "spectral") to follow a specific format: a vector of vectors where each inner vector represents a band's data in a 300x300 spatial grid for the YAXArray version, or a suitable structure that can be directly converted into a DataFrame for the DataFrame version.
The files are already provided for examples in the package in the folder `data`.
"""
function load_dataset() end
