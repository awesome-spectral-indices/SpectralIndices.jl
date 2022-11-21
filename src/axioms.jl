struct SpectralIndex <: AbstractSpectralIndex
    short_name::S
    long_name::S
    bands::B
    application_domain::S
    formula::F
    date_of_addition::Date
    contributor::S
    platforms::S
end
