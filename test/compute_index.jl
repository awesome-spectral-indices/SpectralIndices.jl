using Test
using SpectralIndices
using DataFrames
using YAXArrays
using Random
Random.seed!(17)

convert_to_kwargs(dict) = Dict(Symbol(k) => v for (k, v) in dict)

@testset "Input Validation" begin
    @test_throws AssertionError compute_index("InvalidIndex", N=0.5, R=0.5)
end

@testset "Built-in types compute_index tests: $idx_name" for (idx_name, idx) in indices
    @testset "Single Values as Params" begin
        if idx_name == "AVI" || idx_name == "TVI"
            params = Dict("N" => 0.2, "R"=>0.1)
        else
            params = Dict(band => rand() for band in idx.bands)
        end
        result = compute_index(idx_name, params)
        @test result isa Float64
        @test length(result) == 1
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

    @testset "Arrays as Params" begin
        if idx_name == "AVI" || idx_name == "TVI"
            params = Dict("N" => fill(0.2, 10), "R"=>fill(0.1, 10))
        else
            params = Dict(band => rand(10) for band in idx.bands)
        end
        result = compute_index(idx_name, params)
        @test result isa AbstractArray
        @test length(result) == 10
    end
    @testset "Arrays as Kwargs" begin
        if idx_name == "AVI" || idx_name == "TVI"
            params = Dict("N" => fill(0.2, 10), "R"=>fill(0.1, 10))
        else
            params = Dict(band => rand(10) for band in idx.bands)
        end
        result = compute_index(idx_name; convert_to_kwargs(params)...)
        @test result isa AbstractArray
        @test length(result) == 10
    end

    @testset "Matrices as Params" begin
        if idx_name == "AVI" || idx_name == "TVI"
            params = Dict("N" => fill(0.2, 10, 10), "R"=>fill(0.1, 10, 10))
        else
            params = Dict(band => rand(10, 10) for band in idx.bands)
        end
        result = compute_index(idx_name, params)
        @test result isa Matrix
        @test size(result) == (10,10)
    end
    @testset "Matrices as Kwargs" begin
        if idx_name == "AVI" || idx_name == "TVI"
            params = Dict("N" => fill(0.2, 10, 10), "R"=>fill(0.1, 10, 10))
        else
            params = Dict(band => rand(10, 10) for band in idx.bands)
        end
        result = compute_index(idx_name; convert_to_kwargs(params)...)
        @test result isa Matrix
        @test size(result) == (10,10)
    end

    @testset "NamedTuples as Params" begin
        if idx_name == "AVI" || idx_name == "TVI"
            params = (N = fill(0.2, 10), R=fill(0.1, 10))
        else
            band_tuples = [(Symbol(band) => rand(10)) for band in idx.bands]
            params = NamedTuple(band_tuples)
        end
        result = compute_index(idx_name, params)
        @test result isa NamedTuple
        @test size(first(result)) == (10,)
    end
    @testset "NamedTuples as Kwargs" begin
        if idx_name == "AVI" || idx_name == "TVI"
            params = (N = fill(0.2, 10), R=fill(0.1, 10))
        else
            band_tuples = [(Symbol(band) => rand(10)) for band in idx.bands]
            params = NamedTuple(band_tuples)
        end
        result = compute_index(idx_name; params...)
        @test result isa AbstractArray
        @test size(result) == (10,)
    end
end

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
