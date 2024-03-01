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

# Machine-readable output
function Base.show(io::IO, pb::PlatformBand)
    println(io, "PlatformBand(Platform: $(pb.platform), Band: $(pb.name))")
    println(io, "* Band: $(pb.band)")
    println(io, "* Center Wavelength (nm): $(pb.wavelength)")
    return println(io, "* Bandwidth (nm): $(pb.bandwidth)")
end

# Human-readable output
function Base.show(io::IO, ::MIME"text/plain", pb::PlatformBand)
    println(io, "Platform: $(pb.platform), Band: $(pb.name)")
    println(io, "* Band: $(pb.band)")
    println(io, "* Center Wavelength (nm): $(pb.wavelength)")
    return println(io, "* Bandwidth (nm): $(pb.bandwidth)")
end
