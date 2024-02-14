using Test
using SpectralIndices
using YAXArrays
using Random
Random.seed!(17)

@testset "YAXArray Tests" begin
    # Setup YAXArrays
    axes = (Dim{:Lon}(1:5), Dim{:Lat}(1:5), Dim{:Time}(1:10))
    nds = YAXArray(axes, fill(0.643, (5, 5, 10)))
    rds = YAXArray(axes, fill(0.175, (5, 5, 10)))
    lds = YAXArray(axes, fill(0.5, (5, 5, 10)))

    @testset "Single Index Tests" begin
        nr_ds = concatenatecubes([nds, rds], Dim{:Variables}(["N", "R"]))
        result_yaxa_single = compute_index("NDVI", nr_ds)
        @test result_yaxa_single isa YAXArray
        @test size(result_yaxa_single) == size(rds) == size(nds)
    end
    @testset "Multiple Indices Tests" begin
        nrl_ds = concatenatecubes([nds, rds, lds], Dim{:Variables}(["N", "R", "L"]))
        result_yaxa_multiple = compute_index(["NDVI", "SAVI"], nrl_ds)
        @test result_yaxa_multiple isa YAXArray
        @test size(result_yaxa_multiple)[1:(end - 1)] == size(rds) == size(nds) == size(lds)
    end
end