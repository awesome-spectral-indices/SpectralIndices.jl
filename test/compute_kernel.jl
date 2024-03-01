using Test
using SpectralIndices

floats = [Float64, Float32, Float16]

@testset "Tests for linear, poly, and RBF functions for $T" for T in floats
    a, b, c, p, sigma = T(2), T(3), T(1), T(2), T(5)
    a_v, b_v, c_v, p_v, sigma_v = T.([1, 2, 3]),
    T.([4, 5, 6]), T.([1, 1, 1]), T.([2, 2, 2]),
    T.([5, 5, 5])

    @testset "Tests for linear function with type $T" begin
        @test linear(T, a, b) == T(6)
        @test eltype(linear(T, a, b)) == T
        @test all(linear(T, a_v, b_v) .== T.([4, 10, 18]))
        @test eltype(linear(T, a_v, b_v)) == T
    end

    @testset "Tests for poly function with type $T" begin
        @test poly(T, a, b, c, p) == T(49)
        @test eltype(poly(T, a, b, c, p)) == T

        expected_result = T.([(1 * 4 + 1)^2, (2 * 5 + 1)^2, (3 * 6 + 1)^2])
        @test all(poly(T, a_v, b_v, c_v, p_v) .== expected_result)
        @test eltype(poly(T, a_v, b_v, c_v, p_v)) == T
    end

    @testset "Tests for RBF function with type $T" begin
        expected_number_result = T(exp((-1.0 * (a - b)^2.0) / (2.0 * sigma^2.0)))
        @test RBF(T, a, b, sigma) ≈ expected_number_result
        @test eltype(RBF(T, a, b, sigma)) == T

        expected_array_result =
            T.(exp.((-1.0 .* ((a_v .- b_v) .^ 2.0)) ./ (2.0 .* (sigma_v .^ 2.0))))
        @test all(RBF(T, a_v, b_v, sigma_v) .≈ expected_array_result)
        @test eltype(RBF(T, a_v, b_v, sigma_v)) == T
    end
    GC.gc()
end

@testset "Compute Kernel Tests for $T" for T in floats
    # Test linear kernel
    @testset "Linear Kernel" begin
        params = Dict("a" => T(2), "b" => T(3))
        @test compute_kernel(T, linear, params) == T(6)
        @test eltype(compute_kernel(T, linear, params)) == T

        params = Dict("a" => T.([1, 2]), "b" => T.([3, 4]))
        @test compute_kernel(T, linear, params) == T.([3, 8])
        @test eltype(compute_kernel(T, linear, params)) == T

        params = (a=T(2), b=T(3))
        @test compute_kernel(T, linear, params) == T(6)
        @test eltype(compute_kernel(T, linear, params)) == T
    end

    # Test polynomial kernel
    @testset "Polynomial Kernel" begin
        params = Dict("a" => T(2), "b" => T(3), "c" => T(1), "p" => T(2))
        @test compute_kernel(T, poly, params) == 49
        @test eltype(compute_kernel(T, poly, params)) == T

        params = Dict(
            "a" => T.([1, 2]), "b" => T.([2, 3]), "c" => T.([1, 1]), "p" => T.([2, 3])
        )
        @test compute_kernel(T, poly, params) == T.([9, 343])
        @test eltype(compute_kernel(T, poly, params)) == T

        params = (a=T(2), b=T(3), c=T(1), p=T(2))
        @test compute_kernel(T, poly, params) == T(49)
        @test eltype(compute_kernel(T, poly, params)) == T
    end

    # Test RBF kernel
    @testset "RBF Kernel" begin
        params = Dict("a" => T(1), "b" => T(2), "sigma" => T(1))
        @test compute_kernel(T, RBF, params) ≈ T(exp(-0.5))

        params = Dict("a" => T.([1, 2]), "b" => T.([2, 1]), "sigma" => T.([1, 2]))
        @test compute_kernel(T, RBF, params) ≈ T.([exp(-0.5), exp(-0.125)])

        params = (a=T(1), b=T(2), sigma=T(1))
        @test compute_kernel(T, RBF, params) ≈ T(exp(-0.5))
    end
    GC.gc()
end
