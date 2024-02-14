using Test
using SpectralIndices
using DataFrames
using Random
Random.seed!(17)

@testset "Built-in types compute_index tests: $idx_name" for (idx_name, idx) in indices
    @testset "DataFrames as Params" begin
        if idx_name == "AVI" || idx_name == "TVI"
            df_single = DataFrame(; N=[0.2, 0.2], R=[0.1, 0.1])
        else
            df_single = DataFrame(; band = rand(10) for band in idx.bands)
        end
        result = compute_index(idx_name, params)
        @test eltype(result) isa Float64
        @test result isa DataFrame
    end

    @testset "Single Values as Kwargs" begin
        if idx_name == "AVI" || idx_name == "TVI"
            params = Dict("N" => 0.2, "R"=>0.1)
        else
            params = Dict(band => rand() for band in idx.bands)
        end
        result = compute_index(idx_name; convert_to_kwargs(params)...)
        @test result isa Float64
        @test length(result) == 1
    end

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