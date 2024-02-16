using Test
using SpectralIndices

types = [Float64, Float32, Float16]

@testset "Tests for linear, poly, and RBF functions" begin
    for T in types
        a, b, c, p, sigma = T(2), T(3), T(1), T(2), T(5)
        a_v, b_v, c_v, p_v, sigma_v = T.([1, 2, 3]),
        T.([4, 5, 6]), T.([1, 1, 1]), T.([2, 2, 2]),
        T.([5, 5, 5])
        

        @testset "Tests for linear function with type $T" begin
            @test linear(a, b) == T(6)
            @test all(linear(a_v, b_v) .== T.([4, 10, 18]))

        end

        @testset "Tests for poly function with type $T" begin
            @test poly(a, b, c, p) == T(49)

            expected_result = T.([(1 * 4 + 1)^2, (2 * 5 + 1)^2, (3 * 6 + 1)^2])
            @test all(poly(a_v, b_v, c_v, p_v) .== expected_result)
        end

        @testset "Tests for RBF function with type $T" begin
            expected_number_result = exp((-1.0 * (a - b)^2.0) / (2.0 * sigma^2.0))
            @test RBF(a, b, sigma) ≈ expected_number_result

            expected_array_result =
                exp.((-1.0 .* ((a_v .- b_v) .^ 2.0)) ./ (2.0 .* (sigma_v .^ 2.0)))
            @test all(RBF(a_v, b_v, sigma_v) .≈ expected_array_result)

        end
    end
end

@testset "Compute Kernel Tests" begin
    # Test linear kernel
    @testset "Linear Kernel" begin
        params = Dict("a" => 2, "b" => 3)
        @test compute_kernel(linear, params) == 6

        params = Dict("a" => [1, 2], "b" => [3, 4])
        @test compute_kernel(linear, params) == [3, 8]
    end

    # Test polynomial kernel
    @testset "Polynomial Kernel" begin
        params = Dict("a" => 2, "b" => 3, "c" => 1, "p" => 2)
        @test compute_kernel(poly, params) == 49

        params = Dict("a" => [1, 2], "b" => [2, 3], "c" => [1, 1], "p" => [2, 3])
        @test compute_kernel(poly, params) == [9, 343]
    end

    # Test RBF kernel
    @testset "RBF Kernel" begin
        params = Dict("a" => 1, "b" => 2, "sigma" => 1)
        @test compute_kernel(RBF, params) ≈ exp(-0.5)

        params = Dict("a" => [1, 2], "b" => [2, 1], "sigma" => [1, 2])
        @test compute_kernel(RBF, params) ≈ [exp(-0.5), exp(-0.125)]
    end
end

@testset "SpectralIndices Kernel Functions with YAXArrays" begin
    # Create dimensions and data for testing
    axlist = (
        Dim{:time}(range(1, 20; length=20)),
        Dim{:Lon}(1:5),
        Dim{:Lat}(1:5),
        Dim{:Variable}(["a", "b", "c", "p", "sigma"]),
    )
    data = rand(20, 5, 5, 5)

    # Create YAXArray instances
    yax = YAXArray(axlist, data)

    # Test SpectralIndices.linear
    @testset "SpectralIndices.linear" begin
        result = SpectralIndices.linear(yax)
        @test result isa YAXArray
    end

    # Test SpectralIndices.poly
    @testset "SpectralIndices.poly" begin
        result = SpectralIndices.poly(yax)
        @test result isa YAXArray
    end

    # Test SpectralIndices.RBF
    @testset "SpectralIndices.RBF" begin
        result = SpectralIndices.RBF(yax)
        @test result isa YAXArray
    end
end
