"""
    _load_json(file::String = "spectral-indices-dict.json")

Load a specified JSON file from the data folder.

# Arguments

  - `file::String = "spectral-indices-dict.json"`: The name of the JSON file to be loaded.

# Returns

  - `object`: The parsed JSON content from the specified file.

# Examples

```julia
# Load the default JSON file
data = _load_json()

# Load a specific JSON file
data = _load_json("my-custom-indices.json")
```
"""
function _load_json(filename::String="spectral-indices-dict.json")
    fileloc = joinpath(dirname(@__FILE__), "..", "data", filename)
    if isfile(fileloc)
        return JSON.parsefile(fileloc)
    else
        error("The JSON file is not in the SpectralIndices/data folder")
    end
end

"""
    _get_indices(online::Bool = false)

Retrieve the JSON data of spectral indices.

# Arguments

  - `online::Bool = false`: Whether to retrieve the most recent list of indices directly from the GitHub repository (online) or from the local copy (offline).

# Returns

  - `dict`: A dictionary containing the spectral indices data.

# Examples

```julia
# Retrieve the spectral indices from the local copy (offline)
indices = _get_indices()

# Retrieve the most recent spectral indices from the online repository
indices = _get_indices(true)
'''
```
"""
function _get_indices(
    online::Bool=false;
    filename="spectral-indices-dict.json",
    fileloc=joinpath(dirname(@__FILE__), "..", "data", filename),
)
    if online
        indices_loc = Downloads.download(
            "https://raw.githubusercontent.com/awesome-spectral-indices/awesome-spectral-indices/main/output/spectral-indices-dict.json",
            fileloc,
        )
        indices = JSON.parsefile(indices_loc)
    else
        indices = _load_json()
    end

    return indices["SpectralIndices"]
end

"""
    _check_params(index::String, params::Dict, indices::Dict)

Check if the parameters dictionary contains all required bands for spectral index computation.

# Arguments

  - `index::String`: The name of the spectral index to check.
  - `params::Dict`: The parameters dictionary to check for required bands.
  - `indices::Dict`: The dictionary containing information about spectral indices.

# Returns

  - `None`

# Examples

```julia
# Check parameters for the NDVI index
index_name = "NDVI"
parameters = Dict("N" => 0.6, "R" => 0.3, "G" => 0.7)
indices = _get_indices()

# Check if parameters contain required bands
_check_params(index_name, parameters, indices)
```
"""
function _check_params(index, params::Dict)
    for band in index.bands
        if !(band in keys(params))
            throw(
                ArgumentError(
                    "'$band' is missing in the parameters for $index computation!"
                ),
            )
        end
    end
end

function _order_params(index, params)
    new_params = []
    for (bidx, band) in enumerate(index.bands)
        push!(new_params, params[band])
    end

    return new_params
end

function _create_params(kw_args...)
    params = Dict(String(k) => v for (k, v) in kw_args)
    return params
end

function _create_indexfun(
    index_dict::Dict{String,Any}=_get_indices();
    filename::String="indices_funcs.jl",
    fileloc=joinpath(dirname(@__FILE__), filename),
)
    open(fileloc, "w") do file
        for (index_name, index_info) in index_dict
            short_name = index_info["short_name"]
            formula = index_info["formula"]
            formula = replace(formula, "**" => "^")
            bands = index_info["bands"]
            bands_args = join(bands, "::Number, ") * "::Number"

            write(file, "\n$(short_name)_func($(bands_args)) = $formula\n")
        end

        for (index_name, index_info) in index_dict
            short_name = index_info["short_name"]
            write(file, "indices_funcs[\"$index_name\"] = $(short_name)_func\n")
        end
    end
end
