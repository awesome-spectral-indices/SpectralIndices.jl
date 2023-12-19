using SpectralIndices
using DataFrames
using YAXArrays

@testset "Tests for linear function" begin
    # Test with numbers
    @test linear(2, 3) == 6

    # Test with arrays
    @test all(linear([1, 2, 3], [4, 5, 6]) .== [4, 10, 18])
end

@testset "Tests for poly function" begin
    # Test with numbers
    @test poly(2, 3, 1, 2) == 49

    # Test with arrays
    a, b, c, p = [1, 2, 3], [4, 5, 6], [1, 1, 1], [2, 2, 2]
    expected_result = [(1*4 + 1)^2, (2*5 + 1)^2, (3*6 + 1)^2]
    @test all(poly(a, b, c, p) .== expected_result)
end

@testset "Tests for RBF function" begin
    # Test with numbers
    @test RBF(1, 2, 5) ≈ 0.9801986733067553

    # Test with arrays
    #a, b, sigma = [1, 2, 3], [4, 5, 6], [0.5, 0.5, 0.5] ## TODO extend function to hadle different types
    a, b, sigma = [1, 2, 3], [4, 5, 6], [5, 5, 5]
    expected_result = exp.((-1.0 .* ((a .- b) .^ 2.0)) ./ (2.0 .* (sigma .^ 2.0)))
    @test all(RBF(a, b, sigma) .≈ expected_result)
end