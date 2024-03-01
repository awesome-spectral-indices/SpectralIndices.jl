using SpectralIndices

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
