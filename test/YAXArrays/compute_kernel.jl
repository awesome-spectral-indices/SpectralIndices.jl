using Test
using SpectralIndices
using YAXArrays

function convert_to_kwargs(yaxarr::YAXArray)
    var_names = lookup(yaxarr, :Variables)
    kwargs = [(Symbol(var_name) => yaxarr[Variable=At(var_name)]) for var_name in var_names]
    return kwargs
end

axlist = (
    Dim{:Lon}(1:5),
    Dim{:Lat}(1:5),
    Dim{:Variables}(["a", "b", "c", "p", "sigma"]),
)
data = rand(5, 5, 5)

params = YAXArray(axlist, data)

@testset "linear test" begin
    result = linear(params)
    @test result isa YAXArray
end

@testset "poly test" begin
    result = poly(params)
    @test result isa YAXArray
end

@testset "RBF test" begin
    result = RBF(params)
    @test result isa YAXArray
end

@testset "YAXArrays compute_kernel tests" begin
    @testset "as Params" begin
        lr = compute_kernel(linear, params)
        @test lr isa YAXArray
        pr = compute_kernel(poly, params)
        @test pr isa YAXArray
        rr = compute_kernel(RBF, params)
        @test rr isa YAXArray
    end

    @testset "as Kwargs" begin
        lr = compute_kernel(linear; convert_to_kwargs(params)...)
        @test lr isa YAXArray
        pr = compute_kernel(poly; convert_to_kwargs(params)...)
        @test pr isa YAXArray
        rr = compute_kernel(RBF; convert_to_kwargs(params)...)
        @test rr isa YAXArray
    end
end

