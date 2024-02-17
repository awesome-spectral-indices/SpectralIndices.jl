using Test
using SpectralIndices
using DataFrames
using Random
using Combinatorics
using StatsBase
include("../test_utils.jl")
Random.seed!(17)

function convert_to_kwargs(df::DataFrame)
    kwargs = [(Symbol(band) => DataFrame(band => df[:, band])) for band in names(df)]
    return kwargs
end

@testset "DataFrames compute_index single index tests: $idx_name" for (idx_name, idx) in indices
    @testset "as Params" begin
        if idx_name == "AVI" || idx_name == "TVI"
            params = DataFrame(; N=[0.2, 0.2], R=[0.1, 0.1])
        else
            params = DataFrame([band => rand(10) for band in idx.bands])
        end
        result = compute_index(idx_name, params)
        @test eltype(result) isa Float64
        @test result isa DataFrame
        @test names(result_single) == [idx_name]
    end

    @testset "as Kwargs" begin
        if idx_name == "AVI" || idx_name == "TVI"
            params = DataFrame(; N=[0.2, 0.2], R=[0.1, 0.1])
        else
            params = DataFrame([band => rand(10) for band in idx.bands])
        end
        result = compute_index(idx_name; convert_to_kwargs(params)...)
        @test eltype(result) isa Float64
        @test result isa DataFrame
        @test names(result_single) == [idx_name]
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

msi = custom_key_combinations(indices, 2, 200)

@testset "DataFrames compute_index multiple indices tests: $idxs" for idxs in msi

    if idxs[1] in ["AVI", "TVI"] && length(idxs) > 1
        for i in 2:length(idxs)
            if !(idxs[i] in ["AVI", "TVI"])
                idxs[1], idxs[i] = idxs[i], idxs[1]
                break
            end
        end
    end

    @testset "as Params" begin
        params = DataFrame()
        for idx_name in idxs
            idx = indices[idx_name]
            if idx_name == "AVI" || idx_name == "TVI"
                params[!, "N"] = fill(0.2, 10)
                params[!, "R"] = fill(0.1, 10)
            else
                for band in idx.bands
                    params[!, band] = rand(10)
                end
            end
        end
        result = compute_index(idxs, params)
        #@test eltype(result) isa Float64 #TODO fix this
        @test result isa DataFrame
        @test names(result) == idxs
    end

    @testset "as Kwargs" begin
        params = DataFrame()
        for idx_name in idxs
            idx = indices[idx_name]
            if idx_name == "AVI" || idx_name == "TVI"
                params[!, "N"] = fill(0.2, 10)
                params[!, "R"] = fill(0.1, 10)
            else
                for band in idx.bands
                    params[!, band] = rand(10)
                end
            end
        end
        result = compute_index(idxs; convert_to_kwargs(params)...)
        @test result isa DataFrame
        @test names(result) == idxs
    end
end
