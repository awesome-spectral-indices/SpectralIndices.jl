using Test
using SpectralIndices
using DataFrames
using Random
using Combinatorics
using StatsBase
include("../test_utils.jl")
Random.seed!(17)

floats = [Float64, Float32, Float16]

function convert_to_kwargs(df::DataFrame)
    kwargs = [(Symbol(band) => DataFrame(band => df[:, band])) for band in names(df)]
    return kwargs
end

@testset "DataFrames compute_index $T single index tests: $idx_name" for (idx_name, idx) in
                                                                         indices,
    T in floats

    @testset "as Params" begin
        if idx_name == "AVI" || idx_name == "TVI"
            params = DataFrame(; N=T.([0.2, 0.2]), R=T.([0.1, 0.1]))
        else
            params = DataFrame([band => rand(T, 10) for band in idx.bands])
        end
        result = compute_index(idx_name, params)
        @test result isa DataFrame
        @test names(result) == [idx_name]
        result = compute_index(T, idx_name, params)
        @test result isa DataFrame
        @test names(result) == [idx_name]
        @test first(eltype.(eachcol(result))) == T
    end

    @testset "as Kwargs" begin
        if idx_name == "AVI" || idx_name == "TVI"
            params = DataFrame(; N=T.([0.2, 0.2]), R=T.([0.1, 0.1]))
        else
            params = DataFrame([band => rand(T, 10) for band in idx.bands])
        end
        result = compute_index(idx_name; convert_to_kwargs(params)...)
        @test result isa DataFrame
        @test names(result) == [idx_name]
        result = compute_index(T, idx_name; convert_to_kwargs(params)...)
        @test result isa DataFrame
        @test names(result) == [idx_name]
        @test first(eltype.(eachcol(result))) == T
    end
    GC.gc()
end

msi = custom_key_combinations(indices, 2, 200)

@testset "DataFrames compute_index $T multiple indices tests: $idxs" for idxs in msi,
    T in floats

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
                params[!, "N"] = fill(T(0.2), 10)
                params[!, "R"] = fill(T(0.1), 10)
            else
                for band in idx.bands
                    params[!, band] = rand(T, 10)
                end
            end
        end
        result = compute_index(idxs, params)
        @test result isa DataFrame
        @test names(result) == idxs
        result = compute_index(T, idxs, params)
        @test result isa DataFrame
        @test names(result) == idxs
        @test first(eltype.(eachcol(result))) == T
    end

    @testset "as Kwargs" begin
        params = DataFrame()
        for idx_name in idxs
            idx = indices[idx_name]
            if idx_name == "AVI" || idx_name == "TVI"
                params[!, "N"] = fill(T(0.2), 10)
                params[!, "R"] = fill(T(0.1), 10)
            else
                for band in idx.bands
                    params[!, band] = rand(T, 10)
                end
            end
        end
        result = compute_index(idxs; convert_to_kwargs(params)...)
        @test result isa DataFrame
        @test names(result) == idxs
        result = compute_index(T, idxs; convert_to_kwargs(params)...)
        @test result isa DataFrame
        @test names(result) == idxs
        @test first(eltype.(eachcol(result))) == T
    end
    GC.gc()
end
