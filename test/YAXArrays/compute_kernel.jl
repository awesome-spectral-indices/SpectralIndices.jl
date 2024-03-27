using Test
using SpectralIndices
using YAXArrays

function convert_to_kwargs(yaxarr::YAXArray)
    var_names = lookup(yaxarr, :Variables)
    kwargs = [(Symbol(var_name) => yaxarr[Variable=At(var_name)]) for var_name in var_names]
    return kwargs
end

axlist = (Dim{:Lon}(1:5), Dim{:Lat}(1:5), Dim{:Variables}(["a", "b", "c", "p", "sigma"]))

floats = [Float64, Float32, Float16]
@testset "YAXArrays tests for linear, poly, and RBF functions for $T" for T in floats
    data = rand(T, 5, 5, 5)
    params = YAXArray(axlist, data)

    @testset "linear test" begin
        result = linear(params)
        @test result isa YAXArray
        @test eltype(result) == T
    end

    @testset "poly test" begin
        result = poly(params)
        @test result isa YAXArray
        @test eltype(result) == T
    end

    @testset "RBF test" begin
        result = RBF(params)
        @test result isa YAXArray
        @test eltype(result) == T
    end
    GC.gc()
end

@testset "YAXArrays compute_kernel tests for $T" for T in floats
    data = rand(T, 5, 5, 5)
    params = YAXArray(axlist, data)
    @testset "as Params" begin
        lr = compute_kernel(linear, params)
        @test lr isa YAXArray
        @test eltype(lr) == T
        pr = compute_kernel(poly, params)
        @test pr isa YAXArray
        @test eltype(pr) == T
        rr = compute_kernel(RBF, params)
        @test rr isa YAXArray
        @test eltype(rr) == T
    end

    @testset "as Kwargs" begin
        lr = compute_kernel(linear; convert_to_kwargs(params)...)
        @test lr isa YAXArray
        @test eltype(lr) == T
        pr = compute_kernel(poly; convert_to_kwargs(params)...)
        @test pr isa YAXArray
        @test eltype(pr) == T
        rr = compute_kernel(RBF; convert_to_kwargs(params)...)
        @test rr isa YAXArray
        @test eltype(rr) == T
    end
    GC.gc()
end
