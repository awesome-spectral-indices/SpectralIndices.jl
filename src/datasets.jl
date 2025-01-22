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

# Example

First we show how to load the "sentinel" dataset with `YAXArrays`:

```jldoctest loaddata
julia> using SpectralIndices

julia> using YAXArrays

julia> yax_ds = load_dataset("sentinel", YAXArray)
╭─────────────────────────────╮
│ 300×300×4 YAXArray{Int64,3} │
├─────────────────────────────┴───────────────────────────────────── dims ┐
  ↓ x     Sampled{Int64} 1:300 ForwardOrdered Regular Points,
  → y     Sampled{Int64} 1:300 ForwardOrdered Regular Points,
  ↗ bands Categorical{String} ["B02", "B03", "B04", "B08"] ForwardOrdered
├─────────────────────────────────────────────────────────────── metadata ┤
  Dict{String, Any}()
├─────────────────────────────────────────────────────── loaded in memory ┤
  data size: 2.75 MB
└─────────────────────────────────────────────────────────────────────────┘

```

Additionally we can also load "Spectral" with `DataFrames`:

```jldoctest loaddata
julia> using DataFrames

julia> df_ds = load_dataset("spectral", DataFrame)
120×9 DataFrame
 Row │ SR_B5     ST_B10   SR_B2      SR_B6      class       SR_B4      SR_B7   ⋯
     │ Float64   Float64  Float64    Float64    String      Float64    Float64 ⋯
─────┼──────────────────────────────────────────────────────────────────────────
   1 │ 0.269054  297.328  0.100795   0.306206   Urban       0.165764   0.25194 ⋯
   2 │ 0.281264  297.108  0.08699    0.267596   Urban       0.160979   0.21791
   3 │ 0.28422   297.436  0.0860275  0.258384   Urban       0.140203   0.20009
   4 │ 0.254479  297.204  0.103916   0.25958    Urban       0.163976   0.21673
   5 │ 0.269535  297.098  0.109306   0.273234   Urban       0.18126    0.21955 ⋯
   6 │ 0.277153  298.212  0.107148   0.32954    Urban       0.19754    0.25392
   7 │ 0.26563   298.402  0.100396   0.271721   Urban       0.170026   0.22233
   8 │ 0.294478  298.448  0.102032   0.318224   Urban       0.186224   0.23851
  ⋮  │    ⋮         ⋮         ⋮          ⋮          ⋮           ⋮          ⋮   ⋱
 114 │ 0.247342  289.282  0.0157925  0.07357    Vegetation  0.0270675  0.03534 ⋯
 115 │ 0.29819   289.532  0.0252525  0.118615   Vegetation  0.0344375  0.05652
 116 │ 0.287822  289.624  0.02154    0.113253   Vegetation  0.0344375  0.05374
 117 │ 0.281608  289.108  0.0192025  0.10151    Vegetation  0.0299     0.04832
 118 │ 0.239615  288.975  0.01846    0.0889425  Vegetation  0.0262425  0.04084 ⋯
 119 │ 0.167703  289.597  0.0174975  0.0710125  Vegetation  0.02803    0.03399
 120 │ 0.19424   289.375  0.0195875  0.0739275  Vegetation  0.0255825  0.03325
                                                  3 columns and 105 rows omitted

```
"""
function load_dataset() end
