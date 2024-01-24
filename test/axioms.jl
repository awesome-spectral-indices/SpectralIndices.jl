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
    "platforms" => ["Landsat 8", "MODIS"],
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
@test computed_index ≈ 0.5 atol = 0.01

C_vals = fill(0.6, 5)
I_vals = fill(0.2, 5)
computed_array_index = si.(C_vals, I_vals)
@test all(computed_array_index .≈ 0.5)

@testset "SpectralIndex Show Methods Tests" begin
    # Test Human-readable Output
    @test begin
        io_buffer = IOBuffer()
        show(io_buffer, MIME("text/plain"), si)
        human_readable_output = String(take!(io_buffer))
        expected_human_readable_output = """
        CI: Custom Index
        * Application Domain: Vegetation
        * Bands/Parameters: ["C", "I"]
        * Formula: (C-I)/(C+I)
        * Reference: Doe et al., 1984
        """
        human_readable_output == expected_human_readable_output
    end

    # Test Machine-readable Output
    @test begin
        io_buffer = IOBuffer()
        show(io_buffer, si)
        machine_readable_output = String(take!(io_buffer))
        expected_machine_readable_output = "SpectralIndex(short_name: CI,\nlong_name: Custom Index,\napplication_domain: Vegetation,\nbands: [\"C\", \"I\"],\nformula: (C-I)/(C+I),\nreference: Doe et al., 1984\n)\n"
        machine_readable_output == expected_machine_readable_output
    end
end

@testset "PlatformBand Show Methods Tests" begin
    # Create a sample PlatformBand instance
    sample_band = PlatformBand("Sentinel-2A", "B2", "Blue", 492.4, 66.0)

    # Test Human-readable Output
    @test begin
        io_buffer = IOBuffer()
        show(io_buffer, MIME("text/plain"), sample_band)
        output = String(take!(io_buffer))
        expected_output = """
        Platform: Sentinel-2A, Band: Blue
        * Band: B2
        * Center Wavelength (nm): 492.4
        * Bandwidth (nm): 66.0
        """
        output == expected_output
    end

    # Test Machine-readable Output
    @test begin
        io_buffer = IOBuffer()
        show(io_buffer, sample_band)
        output = String(take!(io_buffer))
        expected_output = """
        PlatformBand(Platform: Sentinel-2A, Band: Blue)
        * Band: B2
        * Center Wavelength (nm): 492.4
        * Bandwidth (nm): 66.0
        """
        output == expected_output
    end
end

@testset "Band Show Methods Tests" begin
    # Create a dummy PlatformBand instance with minimal data
    dummy_platform_band = PlatformBand("DummyPlatform", "DummyBand", "DummyName", 0.0, 0.0)

    # Create a sample Band instance
    sample_band_dict = Dict(
        "short_name" => "B",
        "long_name" => "Blue",
        "common_name" => "Blue",
        "min_wavelength" => 450.0,
        "max_wavelength" => 495.0,
        "platforms" =>
            Dict("sentinel2a" => dummy_platform_band, "sentinel2b" => dummy_platform_band),
    )
    sample_band = Band(sample_band_dict)

    # Test Machine-readable Output
    @test begin
        io_buffer = IOBuffer()
        show(io_buffer, sample_band)
        output = String(take!(io_buffer))
        expected_output = "Band(B: Blue)\n"
        output == expected_output
    end

    # Test Human-readable Output
    @test begin
        io_buffer = IOBuffer()
        show(io_buffer, MIME("text/plain"), sample_band)
        output = String(take!(io_buffer))
        expected_output = "B: Blue\n"
        output == expected_output
    end
end
