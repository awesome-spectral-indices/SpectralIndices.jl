using Test
using SpectralIndices
using DataFrames
using YAXArrays

expected_ndvi_value_f64 = 0.5721271393643031
expected_savi_value_f64 = 0.5326251896813354

@testset "Basic Functionality" begin
    @test compute_index("NDVI"; N=0.643, R=0.175) == expected_ndvi_value_f64
end

@testset "Type Handling" begin
    @test compute_index("NDVI"; N=fill(0.643, 5), R=fill(0.175, 5)) isa Array
end

# @testset "Corner Cases" begin
#     @test compute_index("NDVI"; N=0.0, R=0.0) == NaN
# end

@testset "Input Validation" begin
    @test_throws AssertionError compute_index("InvalidIndex"; N=0.5, R=0.5)
end

@testset "Multiple Indices" begin
    results = compute_index(["NDVI", "SAVI"]; N=0.643, R=0.175, L=0.5)
    @test length(results) == 2
    @test results[1] == expected_ndvi_value_f64
    @test results[2] == expected_savi_value_f64
end

dfn_single = DataFrame(; N=[0.643, 0.56])
dfr_single = DataFrame(; R=[0.175, 0.22])
dfl_single = DataFrame(; L=[0.5, 0.4])

@testset "DataFrame Tests" begin
    @testset "Single Index as Params" begin
        df_single = DataFrame(; N=[0.643, 0.56], R=[0.175, 0.22])
        result_single = compute_index("NDVI", df_single)
        @test size(result_single, 1) == 2
        @test size(result_single, 2) == 1
        @test names(result_single) == ["NDVI"]
    end

    @testset "Single Index as kwargs" begin
        result_single2 = compute_index("NDVI"; N=dfn_single, R=dfr_single)
        @test size(result_single2, 1) == 2
        @test size(result_single2, 2) == 1
        @test names(result_single2) == ["NDVI"]
    end

    @testset "Multiple Indices as Params" begin
        df_multiple = DataFrame(; N=[0.643, 0.56], R=[0.175, 0.22], L=[0.5, 0.4])
        result_multiple = compute_index(["NDVI", "SAVI"], df_multiple)
        @test size(result_multiple, 1) == 2
        @test size(result_multiple, 2) == 2
        @test names(result_multiple) == ["NDVI", "SAVI"]
    end

    @testset "Multiple Indices as kwargs" begin
        result_multiple2 = compute_index(
            ["NDVI", "SAVI"]; N=dfn_single, R=dfr_single, L=dfl_single
        )
        @test size(result_multiple2, 1) == 2
        @test size(result_multiple2, 2) == 2
        @test names(result_multiple2) == ["NDVI", "SAVI"]
    end
end

@testset "YAXArray Tests" begin
    # Setup YAXArrays
    axes = (Dim{:Lon}(1:5), Dim{:Lat}(1:5), Dim{:Time}(1:10))
    nds = YAXArray(axes, fill(0.643, (5, 5, 10)))
    rds = YAXArray(axes, fill(0.175, (5, 5, 10)))

    @testset "Single Index Tests" begin
        nr_ds = concatenatecubes([nds, rds], Dim{:Variables}(["N", "R"]))
        result_yaxa_single = compute_index("NDVI", nr_ds)
        @test size(result_yaxa_single) == size(rds) == size(nds)
    end
end

# multiple indices # TODO
# as params
#result_yaxa_single = compute_index(["NDVI", "SAVI"], nrl_ds)
#@test size(result_yaxa_single) == size(rds) == size(nds) == size(lds)
# as kwargs
#result_yaxa_single2 = compute_index(["NDVI", "SAVI"]; N=nds, R=rds, L=lds)
#@test size(result_yaxa_single2) == size(rds) == size(nds) == size(lds)
#@test result_yaxa_single == result_yaxa_single2
