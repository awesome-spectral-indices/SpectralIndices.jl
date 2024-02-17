using Test
using SpectralIndices
using DataFrames

function convert_to_kwargs(df::DataFrame)
    kwargs = [(Symbol(band) => DataFrame(band => df[:, band])) for band in names(df)]
    return kwargs
end

params = DataFrame(;
    a=[1, 2], b=[3, 4], c=[1, 1], p=[2, 2], sigma=[5, 5]
)

@testset "linear test" begin
    result = linear(params)
    @test result isa DataFrame
end

@testset "poly test" begin
    result = poly(params)
    @test result isa DataFrame
end

@testset "RBF test" begin
    result = RBF(params)
    @test result isa DataFrame
end

@testset "DataFrames compute_kernel tests" begin
    @testset "as Params" begin
        lr = compute_kernel(linear, params)
        @test lr isa DataFrame
        pr = compute_kernel(poly, params)
        @test pr isa DataFrame
        rr = compute_kernel(RBF, params)
        @test rr isa DataFrame
    end

    @testset "as Kwargs" begin
        lr = compute_kernel(linear; convert_to_kwargs(params)...)
        @test lr isa DataFrame
        pr = compute_kernel(poly; convert_to_kwargs(params)...)
        @test pr isa DataFrame
        rr = compute_kernel(RBF; convert_to_kwargs(params)...)
        @test rr isa DataFrame
    end
end
