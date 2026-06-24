using SpectralIndices

@testset "Constant Show Methods Tests" begin
    # Create a sample Constant instance
    sample_constant = Constant(
        "Sample Description",
        "Sample Short Name",
        "Sample Default"
    )

    # Test Machine-readable Output
    @test begin
        io_buffer = IOBuffer()
        show(io_buffer, sample_constant)
        output = String(take!(io_buffer))
        expected_output = "Constant: Sample Short Name\nDescription: Sample Description\nDefault value: Sample Default"
        output == expected_output
    end

    # Test Human-readable Output
    @test begin
        io_buffer = IOBuffer()
        show(io_buffer, MIME("text/plain"), sample_constant)
        output = String(take!(io_buffer))
        expected_output = "Sample Short Name: Sample Description\n* Description: Sample Description\n* Default value: Sample Default"
        output == expected_output
    end
end
