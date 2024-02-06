using SpectralIndices

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