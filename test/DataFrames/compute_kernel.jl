using Test
using SpectralIndices
using DataFrames

df = DataFrame(;
            a=T.([1, 2]), b=T.([3, 4]), c=T.([1, 1]), p=T.([2, 2]), sigma=T.([5, 5])
        )
@testset "Kernel functions for Dataframes" begin
    @test eachcol(linear(df)) == eachcol(DataFrame(; linear=T.([3, 8])))
    df_expected = DataFrame(; poly=T.([(1 * 3 + 1)^2, (2 * 4 + 1)^2]))
            @test eachcol(poly(df)) == eachcol(df_expected)

    df_expected = DataFrame(;
            RBF=exp.((-1.0 .* ((df.a .- df.b) .^ 2.0)) ./ (2.0 .* (df.sigma .^ 2.0)))
        )
    @test eachcol(RBF(df)) == eachcol(df_expected)
end