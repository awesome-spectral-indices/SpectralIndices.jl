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

"""
    parse_eval_dict(ex::AbstractString, locals::Dict{String, Any})

Parse and evaluate a Julia expression `ex` with local variable assignments from the `locals` dictionary.

# Arguments

  - `ex::AbstractString`: The expression to be parsed and evaluated.
  - `locals::Dict{String, Any}`: A dictionary of local variables, where keys are variable names (as strings) and values are their corresponding values.

# Returns

  - `Any`: The result of evaluating the parsed expression.

# Examples

```julia
# Define a dictionary of local variables
local_variables = Dict("x" => 2, "y" => 3)

# Define an expression to evaluate with local variables
expression = "x + y"

# Evaluate the expression with local variable assignments
result = parse_eval_dict(expression, local_variables)

# The result should be 5
```
"""
function parse_eval_dict(ex::AbstractString, locals::Dict)
    ex = Meta.parse(ex)
    assignments = Expr[]

    for (key, val) in locals
        push!(assignments, :($(Symbol(key)) = $val))
    end

    return eval(
        quote
            let
                $(assignments...)
                $ex
            end
        end,
    )
end

#=
function _build_function(name::String, expr::Expr, args::Symbol...)
    function_name = Symbol(name, args...)
    inner_function_expr = quote
        function $function_name($(args...))
            return $expr
        end
    end

    eval(inner_function_expr)

    return eval(function_name)
end
=#

function _build_function(name::String, expr::Expr, args::Symbol...)
    return eval(:(($(args...),) -> $expr))
end

function _create_params(kw_args...)
    params = Dict(String(k) => v for (k, v) in kw_args)
    return params
end
