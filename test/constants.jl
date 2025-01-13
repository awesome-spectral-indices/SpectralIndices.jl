using SpectralIndices

@testset "Constant Show Methods Tests" begin
    # Create a sample Constant instance
    sample_constant = Constant(
        "Sample Description",
        "Sample Long Name",
        "Sample Short Name",
        "Sample Standard",
        "Sample Default",
        "Sample Value"
    )

    # Test Machine-readable Output
    @test begin
        io_buffer = IOBuffer()
        show(io_buffer, sample_constant)
        output = String(take!(io_buffer))
        expected_output = """
        Constant: Sample Short Name - Sample Long Name
        Description: Sample Description
        Standard: Sample Standard
        Default value: Sample Default
        Current value: Sample Value
        """
        output == expected_output
    end

    # Test Human-readable Output
    @test begin
        io_buffer = IOBuffer()
        show(io_buffer, MIME("text/plain"), sample_constant)
        output = String(take!(io_buffer))
        expected_output = """
        Sample Short Name: Sample Long Name
        * Description: Sample Description
        * Standard: Sample Standard
        * Default value: Sample Default
        * Current value: Sample Value
        """
        output == expected_output
    end
end
