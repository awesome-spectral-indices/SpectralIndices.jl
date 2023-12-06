#=
struct SpectralIndices{T <: Dict{String, AbstractSpectralIndex}, O}
    indices::T
    origin::O
end
=#

function spectral_indices(indices_dict::Dict{String, Any}; origin="SpectralIndices")
    indices = Dict{String, AbstractSpectralIndex}()
    for (key, value) in indices_dict
        indices[key] = SpectralIndex(value)
    end
    return indices
end

struct SpectralIndex{B,S} <: AbstractSpectralIndex
    short_name::String
    long_name::String
    bands::B
    application_domain::String
    reference::String
    formula::String
    date_of_addition::Date
    contributor::String
    platforms::S
end

function SpectralIndex(index::Dict)
    short_name = index["short_name"]
    long_name = index["long_name"]
    bands = index["bands"]
    application_domain = index["application_domain"]
    reference = index["reference"]
    formula = filter(x -> !isspace(x), index["formula"])
    date_of_addition = Date(index["date_of_addition"], dateformat"y-m-d")
    contributor = index["contributor"]
    platforms = index["platforms"]

    SpectralIndex(short_name, long_name, bands, application_domain, reference,
                  formula, date_of_addition, contributor, platforms)
end

function Base.show(io::IO, index::SpectralIndex)
    println(io, index.short_name, ": ", index.long_name)
    println(io, "Application domain: ", index.application_domain)
    println(io, "Bands/Parameters: ", index.bands)
    println(io, "Formula: ", index.formula)
    println(io, "Reference: ", index.reference)
end

#function compute(si::AbstractSpectralIndex, params=nothing; kwargs...)
#    params == nothing ? parameters = kwargs : parameters = params
#    return compute_index(si.short_name; parameters...)
#end

function compute(self::SpectralIndex, params::Dict{String, Any}=Dict(); kwargs...)
    if isempty(params)
        parameters = kwargs
    else
        parameters = params
    end

    return computeIndex(self.short_name; parameters...)
end

function _create_indices(
    online::Bool = false
)
    indices = _get_indices(online)
    return spectral_indices(indices)
end