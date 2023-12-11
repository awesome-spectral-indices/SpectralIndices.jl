using SpectralIndices, Dates

custom_index = Dict(
        "short_name" => "CI",
        "long_name" => "Custom Index",
        "bands" => ["C", "I"],
        "application_domain" => "Vegetation",
        "reference" => "Doe et al., 1984",
        "formula" => "(C - I) / (C + I)",
        "date_of_addition" => "1984-01-01",
        "contributor" => "John Doe",
        "platforms" => ["Landsat 8", "MODIS"]
    )
si = SpectralIndex(custom_index)
@test si.short_name == "CI"
@test si.long_name == "Custom Index"
@test si.bands == ["C", "I"]
@test si.application_domain == "Vegetation"
@test si.reference == "Doe et al., 1984"
@test si.formula == "(C-I)/(C+I)"
@test si.date_of_addition == Dates.Date("1984-01-01")
@test si.contributor == "John Doe"
@test si.platforms == ["Landsat 8", "MODIS"]

computed_index = si(0.6, 0.2)
@test computed_index ≈ 0.5 atol=0.01

C_vals = fill(0.6, 5)
I_vals = fill(0.2, 5)
computed_array_index = si.(C_vals, I_vals)
@test all(computed_array_index .≈ 0.5)