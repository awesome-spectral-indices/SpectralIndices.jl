using Test
using SpectralIndices
using DataFrames
using YAXArrays

@testset "Input Validation" begin
    @test_throws AssertionError compute_index("InvalidIndex", N=0.5, R=0.5)
end

# @testset "Corner Cases" begin
#     @test compute_index("NDVI"; N=0.0, R=0.0) == NaN
# end

@testset "Input Validation" begin
    @test_throws AssertionError compute_index("InvalidIndex"; N=0.5, R=0.5)
end

#dfn_single = DataFrame(; N=[0.643, 0.56])
#dfr_single = DataFrame(; R=[0.175, 0.22])
#dfl_single = DataFrame(; L=[0.5, 0.4])

@testset "DataFrame Tests" begin
    @testset "Single Index as Params" begin
        df_single = DataFrame(; N=[0.643, 0.56], R=[0.175, 0.22])
        result_single = compute_index("NDVI", df_single)
        @test size(result_single, 1) == 2
        @test size(result_single, 2) == 1
        @test names(result_single) == ["NDVI"]
        @test typeof(result_single[!, "NDVI"][1]) == Float64
    end

    @testset "Single Index as kwargs" begin
        dfn_single = DataFrame(; N=[0.643, 0.56])
        dfr_single = DataFrame(; R=[0.175, 0.22])
        result_single2 = compute_index("NDVI"; N=dfn_single, R=dfr_single)
        @test size(result_single2, 1) == 2
        @test size(result_single2, 2) == 1
        @test names(result_single2) == ["NDVI"]
        @test typeof(result_single2[!, "NDVI"][1]) == Float64
    end

    @testset "Multiple Indices as Params" begin
        df_multiple = DataFrame(; N=[0.643, 0.56], R=[0.175, 0.22], L=[0.5, 0.4])
        result_multiple = compute_index(["NDVI", "SAVI"], df_multiple)
        @test size(result_multiple, 1) == 2
        @test size(result_multiple, 2) == 2
        @test names(result_multiple) == ["NDVI", "SAVI"]
        @test typeof(result_multiple[!, "NDVI"][1]) == Float64
        @test typeof(result_multiple[!, "SAVI"][1]) == Float64
    end
end

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
