#=
struct SpectralIndices{T <: Dict{String, AbstractSpectralIndex}, O}
    indices::T
    origin::O
end
=#

struct SpectralIndex{S<:String,B,D<:Date,P,F} <: AbstractSpectralIndex
    short_name::S
    long_name::S
    bands::B
    application_domain::S
    reference::S
    formula::S
    date_of_addition::D
    contributor::S
    platforms::P
    compute::F
end

"""
    SpectralIndex(index::Dict{String, Any})

This object allows interaction with specific Spectral Indices in the
Awesome Spectral Indices list. Attributes of the Spectral Index can be accessed
and the index itself can be computed.

# Arguments

  - `index::Dict{String, Any}`: A dictionary with the following keys:

      + `"short_name"`: Short name of the spectral index.
      + `"long_name"`: Long name or description of the spectral index.
      + `"bands"`: List of bands or wavelengths used in the index calculation.
      + `"application_domain"`: Application domain or use case of the spectral index.
      + `"reference"`: Reference or source of the spectral index formula.
      + `"formula"`: Mathematical formula of the spectral index.
      + `"date_of_addition"`: Date when the spectral index was added (in "yyyy-mm-dd" format).
      + `"contributor"`: Contributor or source of the spectral index information.
      + `"platforms"`: Platforms or sensors for which the index is applicable.

# Returns

A `SpectralIndex` object containing the specified index information.

# Examples

```julia-repl
julia> indices["NIRv"]

```

Or, accessing directly the provided Dict of spectral indices:

```julia-repl
NIRv
```
"""
function SpectralIndex(index::Dict, func::Function)
    short_name = index["short_name"]
    long_name = index["long_name"]
    bands = index["bands"]
    application_domain = index["application_domain"]
    reference = index["reference"]

    formula = filter(x -> !isspace(x), index["formula"])
    formula = replace(formula, "**" => "^")
    date_of_addition = Date(index["date_of_addition"], dateformat"y-m-d")
    contributor = index["contributor"]
    platforms = index["platforms"]

    return SpectralIndex(
        short_name,
        long_name,
        bands,
        application_domain,
        reference,
        formula,
        date_of_addition,
        contributor,
        platforms,
        func,
    )
end

function (si::SpectralIndex)(args...)
    return si.compute(args...)
end

# Machine-readable output
function Base.show(io::IO, si::SpectralIndex)
    print(io, "SpectralIndex(")
    println(io, "short_name: $(si.short_name),")
    println(io, "long_name: $(si.long_name),")
    println(io, "application_domain: $(si.application_domain),")
    println(io, "bands: $(si.bands),")
    println(io, "formula: $(si.formula),")
    println(io, "reference: $(si.reference)")
    return println(io, ")")
end

# Human-readable output
function Base.show(io::IO, ::MIME"text/plain", si::SpectralIndex)
    println(io, "$(si.short_name): $(si.long_name)")
    println(io, "* Application Domain: $(si.application_domain)")
    println(io, "* Bands/Parameters: $(si.bands)")
    println(io, "* Formula: $(si.formula)")
    return println(io, "* Reference: $(si.reference)")
end

"""
    compute(si::SpectralIndex, params::Dict=Dict(); kwargs...) -> Any

Computes a Spectral Index based on the provided `SpectralIndex` instance,
parameters, and optional keyword arguments.

# Parameters

  - `si`: An instance of `SpectralIndex` which includes the name and details
    of the spectral index to be computed.
  - `params`: (Optional) Dictionary of parameters used as inputs for the
    computation. If not provided, parameters can be passed using keyword arguments.
  - `kwargs`: Additional parameters used as inputs for the computation,
    provided as keyword pairs. These are used if `params` is empty.

# Returns

  - The computed Spectral Index, the type of return value depends on
    the input parameters and the specific spectral index being computed.

# Examples

```julia-repl
julia> compute(NDVI; N=0.643, R=0.175)

```

```julia-repl
julia> compute(NDVI; N=fill(0.643, (5, 5)), R=fill(0.175, (5, 5)))

```
"""
function compute(si::SpectralIndex, params::Dict=Dict(); kwargs...)
    if isempty(params)
        return compute_index(si.short_name; kwargs...)
    else
        return compute_index(si.short_name, params; kwargs...)
    end
end

function _spectral_indices(
    indices_dict::Dict{String,Any},
    indices_funcs=indices_funcs;
    origin="SpectralIndices"
)
    indices = Dict{String,AbstractSpectralIndex}()
    for (key, value) in indices_dict
        indices[key] = SpectralIndex(value, indices_funcs[key])
    end
    return indices
end

function _create_indices(online::Bool=false)
    indices_dict = _get_indices(online)
    return _spectral_indices(indices_dict)
end
