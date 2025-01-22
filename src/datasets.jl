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
├────────────────────────────────────────────────────────────── file size ┤ 
  file size: 2.75 MB
└─────────────────────────────────────────────────────────────────────────┘

```

Additionally we can also load "Spectral" with `DataFrames`:

```jldoctest loaddata
julia> using DataFrames

julia> df_ds = load_dataset("spectral", DataFrame)
120×9 DataFrame
 Row │ SR_B5     ST_B10   SR_B2      SR_B6      class       SR_B4      SR_B7      SR_B3      SR_B1     
     │ Float64   Float64  Float64    Float64    String      Float64    Float64    Float64    Float64   
─────┼─────────────────────────────────────────────────────────────────────────────────────────────────
   1 │ 0.269054  297.328  0.100795   0.306206   Urban       0.165764   0.251949   0.132227   0.08985
   2 │ 0.281264  297.108  0.08699    0.267596   Urban       0.160979   0.217917   0.124404   0.0738588
   3 │ 0.28422   297.436  0.0860275  0.258384   Urban       0.140203   0.200098   0.120994   0.0729375
   4 │ 0.254479  297.204  0.103916   0.25958    Urban       0.163976   0.216735   0.135981   0.0877325
   5 │ 0.269535  297.098  0.109306   0.273234   Urban       0.18126    0.219554   0.15035    0.0905925
   6 │ 0.277153  298.212  0.107148   0.32954    Urban       0.19754    0.253929   0.152303   0.0927237
   7 │ 0.26563   298.402  0.100396   0.271721   Urban       0.170026   0.222331   0.135885   0.087375
   8 │ 0.294478  298.448  0.102032   0.318224   Urban       0.186224   0.238515   0.139749   0.0901113
   9 │ 0.293446  297.604  0.146239   0.29753    Urban       0.210094   0.237649   0.179624   0.132846
  10 │ 0.275874  299.456  0.102995   0.258645   Urban       0.159411   0.202669   0.134785   0.0882688
  11 │ 0.31733   298.668  0.124184   0.314731   Urban       0.202229   0.237525   0.166369   0.109801
  12 │ 0.313301  298.202  0.135775   0.387757   Urban       0.239285   0.307774   0.189675   0.120677
  13 │ 0.304721  297.87   0.114022   0.325195   Urban       0.193731   0.246339   0.150652   0.10041
  14 │ 0.244359  299.471  0.0746425  0.208347   Urban       0.133314   0.171332   0.108055   0.0624875
  15 │ 0.241169  299.181  0.0871825  0.24121    Urban       0.157101   0.186045   0.12483    0.0679325
  16 │ 0.253984  297.183  0.0946763  0.292058   Urban       0.176888   0.238075   0.133548   0.0811875
  17 │ 0.274251  296.834  0.109512   0.304102   Urban       0.185921   0.235655   0.141825   0.0968625
  18 │ 0.276602  296.175  0.104164   0.293281   Urban       0.175334   0.227089   0.137343   0.0905375
  19 │ 0.269508  295.76   0.0825488  0.2543     Urban       0.136971   0.187035   0.11328    0.07082
  20 │ 0.307897  297.036  0.118491   0.302851   Urban       0.196426   0.260556   0.161969   0.098925
  ⋮  │    ⋮         ⋮         ⋮          ⋮          ⋮           ⋮          ⋮          ⋮          ⋮
 102 │ 0.270058  291.424  0.024345   0.118175   Vegetation  0.0343412  0.0523537  0.050635   0.0218563
 103 │ 0.267816  291.588  0.03364    0.135775   Vegetation  0.0516662  0.0771037  0.0525325  0.0280025
 104 │ 0.265245  291.771  0.0289788  0.115576   Vegetation  0.0416837  0.0579913  0.055805   0.0234512
 105 │ 0.370652  289.231  0.028305   0.156785   Vegetation  0.035125   0.065595   0.0499475  0.0247575
 106 │ 0.366225  289.194  0.0292125  0.138085   Vegetation  0.0392775  0.062075   0.04849    0.0249775
 107 │ 0.336085  289.012  0.0270125  0.126865   Vegetation  0.0386175  0.05916    0.04794    0.0238225
 108 │ 0.286942  289.006  0.0332     0.096505   Vegetation  0.053825   0.07225    0.058885   0.02363
 109 │ 0.284963  288.756  0.0277275  0.103435   Vegetation  0.0407625  0.0704075  0.047555   0.0222825
 110 │ 0.335342  289.399  0.0269025  0.149525   Vegetation  0.03683    0.0626525  0.0490675  0.0233825
 111 │ 0.316422  289.686  0.0233825  0.113748   Vegetation  0.033145   0.048105   0.0411475  0.0211
 112 │ 0.280782  289.423  0.021045   0.102087   Vegetation  0.029405   0.046015   0.03925    0.01967
 113 │ 0.292168  289.621  0.0273975  0.122768   Vegetation  0.039525   0.060645   0.048985   0.02319
 114 │ 0.247342  289.282  0.0157925  0.07357    Vegetation  0.0270675  0.035345   0.03188    0.00988
 115 │ 0.29819   289.532  0.0252525  0.118615   Vegetation  0.0344375  0.05652    0.04277    0.02022
 116 │ 0.287822  289.624  0.02154    0.113253   Vegetation  0.0344375  0.0537425  0.0409275  0.0180475

```
"""
function load_dataset() end
