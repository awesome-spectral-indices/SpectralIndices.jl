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
        if isa(platform_info, PlatformBand)
            platforms[platform] = platform_info
        else
            platforms[platform] = PlatformBand(platform_info)
        end
    end

    return Band(
        short_name, long_name, common_name, min_wavelength, max_wavelength, platforms
    )
end

# Machine-readable output
function Base.show(io::IO, b::Band)
    return println(io, "Band($(b.short_name): $(b.long_name))")
end

# Human-readable output
function Base.show(io::IO, ::MIME"text/plain", b::Band)
    return println(io, "$(b.short_name): $(b.long_name)")
end

function create_bands()
    bands_dict = load_json("bands.json")
    bands_class = Dict{String,Band}()

    for (key, value) in bands_dict
        bands_class[key] = Band(value)
    end

    return bands_class
end
