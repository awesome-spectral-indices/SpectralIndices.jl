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
    formula = index["formula"]
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
    println(io, "reference: ", index.reference)
end