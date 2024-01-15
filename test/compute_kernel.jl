using Test
using SpectralIndices
using DataFrames
using YAXArrays

types = [Float64, Float32, Float16]

@testset "Tests for linear, poly, and RBF functions" begin
    for T in types
        a, b, c, p, sigma = T(2), T(3), T(1), T(2), T(5)
        a_v, b_v, c_v, p_v, sigma_v = T.([1, 2, 3]),
        T.([4, 5, 6]), T.([1, 1, 1]), T.([2, 2, 2]),
        T.([5, 5, 5])
        df = DataFrame(;
            a=T.([1, 2]), b=T.([3, 4]), c=T.([1, 1]), p=T.([2, 2]), sigma=T.([5, 5])
        )

        @testset "Tests for linear function with type $T" begin
            @test linear(a, b) == T(6)

            @test all(linear(a_v, b_v) .== T.([4, 10, 18]))

            @test eachcol(linear(df)) == eachcol(DataFrame(; linear=T.([3, 8])))
        end

        @testset "Tests for poly function with type $T" begin
            @test poly(a, b, c, p) == T(49)

            expected_result = T.([(1 * 4 + 1)^2, (2 * 5 + 1)^2, (3 * 6 + 1)^2])
            @test all(poly(a_v, b_v, c_v, p_v) .== expected_result)

            df_expected = DataFrame(; poly=T.([(1 * 3 + 1)^2, (2 * 4 + 1)^2]))
            @test eachcol(poly(df)) == eachcol(df_expected)
        end

        @testset "Tests for RBF function with type $T" begin
            expected_number_result = exp((-1.0 * (a - b)^2.0) / (2.0 * sigma^2.0))
            @test RBF(a, b, sigma) ≈ expected_number_result

            expected_array_result =
                exp.((-1.0 .* ((a_v .- b_v) .^ 2.0)) ./ (2.0 .* (sigma_v .^ 2.0)))
            @test all(RBF(a_v, b_v, sigma_v) .≈ expected_array_result)

            df_expected = DataFrame(;
                RBF=exp.((-1.0 .* ((df.a .- df.b) .^ 2.0)) ./ (2.0 .* (df.sigma .^ 2.0)))
            )
            @test eachcol(RBF(df)) == eachcol(df_expected)
        end
    end
end
