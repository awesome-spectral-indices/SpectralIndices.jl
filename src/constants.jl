
struct Constant{S <: String, V}
    description::S
    short_name::S
    default::V
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
* Default value: 299792458
```
"""
function Constant(constant::Dict{String, Any})
    description = constant["description"]
    short_name = constant["short_name"]
    default = constant["default"]

    return Constant(description, short_name, default)
end

# Machine-readable output
function Base.show(io::IO, c::Constant)
    println(io, "Constant: $(c.short_name)")
    println(io, "Description: $(c.description)")
    return print(io, "Default value: $(c.default)")
end

# Human-readable output
function Base.show(io::IO, ::MIME"text/plain", c::Constant)
    println(io, "$(c.short_name): $(c.description)")
    println(io, "* Description: $(c.description)")
    return print(io, "* Default value: $(c.default)")
end

function create_constants()
    constants = load_json("constants.json")
    constants_class = Dict{String, Constant}()

    for (key, value) in constants
        constants_class[key] = Constant(value)
    end

    return constants_class
end
