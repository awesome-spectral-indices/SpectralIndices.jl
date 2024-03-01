using Test
using SpectralIndices
using DataFrames

function convert_to_kwargs(df::DataFrame)
    kwargs = [(Symbol(band) => DataFrame(band => df[:, band])) for band in names(df)]
    return kwargs
end

@testset "YAXArrays tests for linear, poly, and RBF functions for $T" for T in floats
    params = DataFrame(;
        a=T.([1, 2]), b=T.([3, 4]), c=T.([1, 1]), p=T.([2, 2]), sigma=T.([5, 5])
    )

    @testset "linear test" begin
        result = linear(T, params)
        @test result isa DataFrame
        @test eltype(first(eachcol(result))) == T
    end

    @testset "poly test" begin
        result = poly(T, params)
        @test result isa DataFrame
        @test eltype(first(eachcol(result))) == T
    end

    @testset "RBF test" begin
        result = RBF(T, params)
        @test result isa DataFrame
        @test eltype(first(eachcol(result))) == T
    end
end

@testset "DataFrames compute_kernel tests for $T" for T in floats
    params = DataFrame(;
        a=T.([1, 2]), b=T.([3, 4]), c=T.([1, 1]), p=T.([2, 2]), sigma=T.([5, 5])
    )
    @testset "as Params" begin
        lr = compute_kernel(T, linear, params)
        @test lr isa DataFrame
        @test eltype(first(eachcol(lr))) == T
        pr = compute_kernel(T, poly, params)
        @test pr isa DataFrame
        @test eltype(first(eachcol(pr))) == T
        rr = compute_kernel(T, RBF, params)
        @test rr isa DataFrame
        @test eltype(first(eachcol(rr))) == T
    end

    @testset "as Kwargs" begin
        lr = compute_kernel(T, linear; convert_to_kwargs(params)...)
        @test lr isa DataFrame
        @test eltype(first(eachcol(lr))) == T
        pr = compute_kernel(T, poly; convert_to_kwargs(params)...)
        @test pr isa DataFrame
        @test eltype(first(eachcol(pr))) == T
        rr = compute_kernel(T, RBF; convert_to_kwargs(params)...)
        @test rr isa DataFrame
        @test eltype(first(eachcol(rr))) == T
    end
end
