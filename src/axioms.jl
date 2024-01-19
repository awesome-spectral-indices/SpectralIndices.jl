#=
struct SpectralIndices{T <: Dict{String, AbstractSpectralIndex}, O}
    indices::T
    origin::O
end
=#

function spectral_indices(indices_dict::Dict{String,Any}; origin="SpectralIndices")
    indices = Dict{String,AbstractSpectralIndex}()
    for (key, value) in indices_dict
        indices[key] = SpectralIndex(value)
    end
    return indices
end

## SpectralIndex
struct SpectralIndex{S<:String,B,D<:Date,P} <: AbstractSpectralIndex
    short_name::S
    long_name::S
    bands::B
    application_domain::S
    reference::S
    formula::S
    date_of_addition::D
    contributor::S
    platforms::P
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
function SpectralIndex(index::Dict)
    short_name = index["short_name"]
    long_name = index["long_name"]
    bands = index["bands"]
    application_domain = index["application_domain"]
    reference = index["reference"]

    formula = filter(x -> !isspace(x), index["formula"])
    formula = replace(formula, r"\*\*" => "^")
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
    )
end

function (si::SpectralIndex)(args::Number...)
    arg_type = typeof(first(args))
    parsed_formula = Meta.parse(si.formula)
    expr = _build_function(si.short_name, parsed_formula, Symbol.(si.bands)...)
    result = Base.invokelatest(expr, args...) ## to deal with for performance
    return arg_type(result)
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
    println(io, ")")
end

# Human-readable output
function Base.show(io::IO, ::MIME"text/plain", si::SpectralIndex)
    println(io, "$(si.short_name): $(si.long_name)")
    println(io, "* Application Domain: $(si.application_domain)")
    println(io, "* Bands/Parameters: $(si.bands)")
    println(io, "* Formula: $(si.formula)")
    println(io, "* Reference: $(si.reference)")
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
        return compute_index(si.short_name; params=params)
    end
end

function _create_indices(online::Bool=false)
    indices = _get_indices(online)
    return spectral_indices(indices)
end

struct PlatformBand{S<:String,W<:Number,B<:Number} <: AbstractPlatformBand
    platform::S
    band::S
    name::S
    wavelength::W
    bandwidth::B
end

"""
    PlatformBand(platform_band::Dict{String, Any})

This struct provides information about a specific band for a specific sensor or
platform.

# Arguments

  - `platform_band::Dict{String, Any}`: A dictionary with the following keys:

      + `"platform"`: Name of the platform or sensor.
      + `"band"`: Band number or name for the specific platform.
      + `"name"`: Description or name of the band for the specific platform.
      + `"wavelength"`: Center wavelength of the band (in nm) for the specific platform.
      + `"bandwidth"`: Bandwidth of the band (in nm) for the specific platform.

# Returns

A `PlatformBand` object containing the specified band information.

# Examples

```julia-repl
platform_band_dict = Dict(
    "platform" => "Sentinel-2A",
    "band" => "B2",
    "name" => "Blue",
    "wavelength" => 492.4,
    "bandwidth" => 66.0,
)

platform_band = PlatformBand(platform_band_dict)
```

Or, accessing directly the provided Dict of platforms:

```julia-repl
julia> bands["B"].platforms["sentinel2a"]

```

```julia-repl
julia> bands["B"].platforms["sentinel2a"].wavelength

```
"""
function PlatformBand(platform_band::Dict)
    platform = platform_band["platform"]
    band = platform_band["band"]
    name = platform_band["name"]
    wavelength = platform_band["wavelength"]
    bandwidth = platform_band["bandwidth"]
    return PlatformBand(platform, band, name, wavelength, bandwidth)
end

function Base.show(io::IO, pb::PlatformBand)
    println(io, "PlatformBand(Platform: $(pb.platform), Band: $(pb.name))")
    println(io, "* Band: $(pb.band)")
    println(io, "* Center Wavelength (nm): $(pb.wavelength)")
    return println(io, "* Bandwidth (nm): $(pb.bandwidth)")
end

Base.show(io::IO, mime::MIME{Symbol("text/plain")}, pb::PlatformBand) = Base.show(io, pb)

function Base.show(io::IO, mime::MIME{Symbol("text/html")}, pb::PlatformBand)
    println(io, "<div style=\"background-color:#F9F9F9; padding:10px;\">")
    println(
        io,
        "<strong>Platform:</strong> $(pb.platform), <strong>Band:</strong> $(pb.name)<br>",
    )
    println(io, "<strong>Band:</strong> $(pb.band)<br>")
    println(io, "<strong>Center Wavelength (nm):</strong> $(pb.wavelength)<br>")
    println(io, "<strong>Bandwidth (nm):</strong> $(pb.bandwidth)<br>")
    return println(io, "</div>")
end

struct Band{S<:String,F<:Number,P<:Dict{String,PlatformBand}}
    short_name::S
    long_name::S
    common_name::S
    min_wavelength::F
    max_wavelength::F
    platforms::P
end

"""
    Band(band::Dict{String, Any})

Constructs a `Band` object to interact with specific bands in the list of required bands for Spectral Indices in the Awesome Spectral Indices list.

# Arguments

  - `band::Dict{String, Any}`: A dictionary containing band information with the following keys:

      + `"short_name"`: Short name of the band.
      + `"long_name"`: Description or name of the band.
      + `"common_name"`: Common name of the band according to the Electro-Optical Extension Specification for STAC.
      + `"min_wavelength"`: Minimum wavelength of the spectral range of the band (in nm).
      + `"max_wavelength"`: Maximum wavelength of the spectral range of the band (in nm).
      + `"platforms"`: A dictionary of platform information associated with this band.

# Returns

A `Band` object representing the specified band.

# Examples

```julia-repl
julia> bands["B"]
band_dict = Dict{String, Any}(
    "short_name" => "B",
    "long_name" => "Blue",
    "common_name" => "Blue",
    "min_wavelength" => 450.0,
    "max_wavelength" => 495.0,
    "platforms" => Dict{String, Any}(
        "sentinel2a" => PlatformBand(...),  # PlatformBand constructor details here
        "sentinel2b" => PlatformBand(...),  # PlatformBand constructor details here
        # Add other platforms as needed
    )
)

band = Band(band_dict)
```

Or, using the provided bands

```julia-repl
julia> bands["B"].long_name

```
"""
function Band(band::Dict{String,Any})
    short_name = band["short_name"]
    long_name = band["long_name"]
    common_name = band["common_name"]
    min_wavelength = band["min_wavelength"]
    max_wavelength = band["max_wavelength"]

    platforms = Dict{String,PlatformBand}()

    for (platform, platform_info) in band["platforms"]
        platforms[platform] = PlatformBand(platform_info)
    end

    return Band(
        short_name, long_name, common_name, min_wavelength, max_wavelength, platforms
    )
end

Base.show(io::IO, b::Band) = begin
    println(io, "Band($(b.short_name): $(b.long_name))")
end

Base.show(io::IO, mime::MIME{Symbol("text/plain")}, b::Band) = Base.show(io, b)

function Base.show(io::IO, mime::MIME{Symbol("text/html")}, b::Band)
    println(io, "<div style=\"background-color:#F9F9F9; padding:10px;\">")
    println(io, "<strong>Band:</strong> $(b.short_name): $(b.long_name)<br>")
    println(io, "<strong>Common Name:</strong> $(b.common_name)<br>")
    println(io, "<strong>Min Wavelength (nm):</strong> $(b.min_wavelength)<br>")
    println(io, "<strong>Max Wavelength (nm):</strong> $(b.max_wavelength)<br>")
    return println(io, "</div>")
end

function _create_bands()
    bands_dict = _load_json("bands.json")
    bands_class = Dict{String,Band}()

    for (key, value) in bands_dict
        bands_class[key] = Band(value)
    end

    return bands_class
end

bands = _create_bands()

struct Constant{S<:String,D,V}
    description::S
    long_name::S
    short_name::S
    standard::S
    default::D
    value::V
end

function Constant(constant::Dict{String,Any})
    description = constant["description"]
    short_name = constant["short_name"]
    default = constant["default"]

    return Constant(description, description, short_name, short_name, default, default)
end

function Base.show(io::IO, c::Constant)
    return print(
        io, "Constant($(c.short_name): $(c.long_name))\n  * Default value: $(c.default)"
    )
end

function _create_constants()
    constants = _load_json("constants.json")
    constants_class = Dict{String,Constant}()

    for (key, value) in constants
        constants_class[key] = Constant(value)
    end

    return constants_class
end

constants = _create_constants()
