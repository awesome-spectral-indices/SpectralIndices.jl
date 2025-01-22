
struct Constant{S <: String, D, V}
    description::S
    long_name::S
    short_name::S
    standard::S
    default::D
    value::V
end

"""
    Constant(constant::Dict{String, Any}) -> Constant

Create a `Constant` object from a dictionary.

# Arguments

  - `constant::Dict{String, Any}`: A dictionary containing the following keys:

      + `"description"`: Description of the constant.
      + `"short_name"`: Short name of the constant.
      + `"default"`: Default value of the constant.

# Returns

  - `Constant`: An instance of the `Constant` struct with fields populated based on the provided dictionary.

# Example

```jldoctest
julia> using SpectralIndices

julia> constant_dict = Dict(
           "description" => "Speed of light in vacuum",
           "short_name" => "c",
           "default" => 299792458
       )
Dict{String, Any} with 3 entries:
  "short_name"  => "c"
  "default"     => 299792458
  "description" => "Speed of light in vacuum"

julia> constant = Constant(constant_dict)
c: Speed of light in vacuum
* Description: Speed of light in vacuum
* Standard: c
* Default value: 299792458
* Current value: 299792458

```
"""
function Constant(constant::Dict{String, Any})
    description = constant["description"]
    short_name = constant["short_name"]
    default = constant["default"]

    return Constant(description, description, short_name, short_name, default, default)
end

# Machine-readable output
function Base.show(io::IO, c::Constant)
    println(io, "Constant: $(c.short_name) - $(c.long_name)")
    println(io, "Description: $(c.description)")
    println(io, "Standard: $(c.standard)")
    println(io, "Default value: $(c.default)")
    return println(io, "Current value: $(c.value)")
end

# Human-readable output
function Base.show(io::IO, ::MIME"text/plain", c::Constant)
    println(io, "$(c.short_name): $(c.long_name)")
    println(io, "* Description: $(c.description)")
    println(io, "* Standard: $(c.standard)")
    println(io, "* Default value: $(c.default)")
    return println(io, "* Current value: $(c.value)")
end

function create_constants()
    constants = load_json("constants.json")
    constants_class = Dict{String, Constant}()

    for (key, value) in constants
        constants_class[key] = Constant(value)
    end

    return constants_class
end
