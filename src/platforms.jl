abstract type AbstractPlatformBand end

struct PlatformBand{S <: String, W <: Number, B <: Number} <: AbstractPlatformBand
    platform::S
    band::S
    name::S
    wavelength::W
    bandwidth::B
end

"""
    PlatformBand(platform_band::Dict{String, Any})

This struct provides information about a specific band for a
specific sensor or platform.

# Arguments

  - `platform_band::Dict{String, Any}`: A dictionary with the following keys:

      + `"platform"`: Name of the platform or sensor.
      + `"band"`: Band number or name for the specific platform.
      + `"name"`: Description or name of the band for the specific platform.
      + `"wavelength"`: Center wavelength of the band (in nm) for the
        specific platform.
      + `"bandwidth"`: Bandwidth of the band (in nm) for the specific platform.

# Examples

```jldoctest platforms
julia> using SpectralIndices

julia> platform_band_dict = Dict(
           "platform" => "Sentinel-2A",
           "band" => "B2",
           "name" => "Blue",
           "wavelength" => 492.4,
           "bandwidth" => 66.0
       )
Dict{String, Any} with 5 entries:
  "name"       => "Blue"
  "wavelength" => 492.4
  "platform"   => "Sentinel-2A"
  "bandwidth"  => 66.0
  "band"       => "B2"

julia> platform_band = PlatformBand(platform_band_dict)
Platform: Sentinel-2A, Band: Blue
* Band: B2
* Center Wavelength (nm): 492.4
* Bandwidth (nm): 66.0

```

Additionally, SpectralIndices.jl provides already computed platforms as a `Dict`:

```jldoctest platforms
julia> bands["B"].platforms["sentinel2a"]
Platform: Sentinel-2A, Band: Blue
* Band: B2
* Center Wavelength (nm): 492.4
* Bandwidth (nm): 66.0

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
