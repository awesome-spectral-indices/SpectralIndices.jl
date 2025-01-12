"""
    load_json(file::String = "spectral-indices-dict.json")

Load a specified JSON file from the `data` folder.

# Arguments

  - `file::String = "spectral-indices-dict.json"`: The name of the JSON file to be loaded.

# Returns

  - `object`: The parsed JSON content from the specified file.

# Examples

```julia
# Load the default JSON file
data = load_json()

# Load a specific JSON file
data = load_json("my-custom-indices.json")
```
"""
function load_json(filename::String="spectral-indices-dict.json")
    fileloc = joinpath(dirname(@__FILE__), "..", "data", filename)
    if isfile(fileloc)
        return parsefile(fileloc)
    else
        error("The JSON file is not in the SpectralIndices/data folder")
    end
end

"""
    get_indices(online::Bool = false)

Retrieve the JSON data of spectral indices.

# Arguments

  - `online::Bool = false`: Whether to retrieve the most recent list of indices directly from the GitHub repository (online) or from the local copy (offline).

# Returns

  - `dict`: A dictionary containing the spectral indices data.

# Examples

```julia
# Retrieve the spectral indices from the local copy (offline)
indices = get_indices()

# Retrieve the most recent spectral indices from the online repository
indices = get_indices(true)
'''
```
"""
function get_indices(online::Bool=false; filename::String="spectral-indices-dict.json",
        fileloc::String=joinpath(dirname(@__FILE__), "..", "data"))
    final_file = joinpath(fileloc, filename)
    if online
        indices_loc = Downloads.download(
            "https://raw.githubusercontent.com/awesome-spectral-indices/awesome-spectral-indices/main/output/spectral-indices-dict.json",
            final_file
        )
        indices = parsefile(indices_loc)
    else
        indices = load_json()
    end

    return indices["SpectralIndices"]
end

function create_indexfun(index_dict::Dict{String, Any}=_get_indices();
        filename::String="indices_funcs.jl",
        fileloc::String=joinpath(dirname(@__FILE__), filename))
    open(fileloc, "w") do file
        write(file, "indices_funcs = Dict()\n\n")

        for (index_name, index_info) in index_dict
            short_name = index_info["short_name"]
            formula = index_info["formula"]
            formula = replace(formula, "**" => "^")

            counter = 1
            const_defs = []
            untyped_const_defs = []
            default_values = []
            formula = replace(
                formula,
                r"\b\d+(\.\d+)?\b" => match -> begin
                    const_name = "const$(counter)"
                    default_value = match
                    push!(const_defs, "$const_name::Number=TFL($default_value)")
                    push!(untyped_const_defs, "$const_name=$const_name")
                    push!(default_values, default_value)
                    counter += 1
                    return const_name
                end
            )

            bands = index_info["bands"]
            bands_args = join(bands, ", ")

            kwargs = join(const_defs, ", ")
            untyped_kwargs = join(untyped_const_defs, ", ")
            func_signature = if isempty(const_defs)
                "function $(short_name)_func(::Type{TFL}, $bands_args) where {TFL <: Number}"
            else
                "function $(short_name)_func(::Type{TFL}, $bands_args; $kwargs) where {TFL <: Number}"
            end

            #untyped_func_signature = isempty(const_defs) ? 
            #    "function $(short_name)_func($bands_args)" :
            #    "function $(short_name)_func($bands_args; $kwargs)"

            #untyped_fun_call = isempty(const_defs) ?
            #    "$(short_name)_func(Float64, $bands_args)" :
            #    "$(short_name)_func(Float64, $bands_args; $untyped_kwargs)"

            write(file, "$func_signature\n    return $formula\nend\n\n")
            #write(file, "$untyped_func_signature\n    return $untyped_fun_call\nend\n\n")

            write(file, "indices_funcs[\"$index_name\"] = $(short_name)_func\n\n")
        end
    end
end
