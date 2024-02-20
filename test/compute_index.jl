using Test
using SpectralIndices
using YAXArrays
using Random
using Combinatorics
using StatsBase
Random.seed!(17)

convert_to_kwargs(dict) = Dict(Symbol(k) => v for (k, v) in dict)

@testset "Input Validation" begin
    @test_throws AssertionError compute_index("InvalidIndex", N=0.5, R=0.5)
end

@testset "Built-in types compute_index single index tests: $idx_name" for (idx_name, idx) in indices
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

msi = custom_key_combinations(indices, 2, 200)
  
@testset "Built-in types compute_index multiple indices tests: $idxs" for idxs in msi

    # Preprocessing to avoid "AVI" or "TVI" being the first index if there are multiple indices
    if idxs[1] in ["AVI", "TVI"] && length(idxs) > 1
        for i in 2:length(idxs)
            if !(idxs[i] in ["AVI", "TVI"])
                idxs[1], idxs[i] = idxs[i], idxs[1]
                break
            end
        end
    end

    @testset "Single Values as Params for $idxs" begin
        params = Dict()
        for idx_name in idxs
            idx = indices[idx_name]
            if idx_name == "AVI" || idx_name == "TVI"
                params["N"] = 0.2
                params["R"] = 0.1
            else
                for band in idx.bands
                    params[band] = rand()
                end
            end
        end
        result = compute_index(idxs, params)
        @test first(result) isa Float64
        @test length(result) == 2
    end

    @testset "Single Values as Kwargs for $idxs" begin
        params = Dict()
        for idx_name in idxs
            idx = indices[idx_name]
            if idx_name == "AVI" || idx_name == "TVI"
                params["N"] = 0.2
                params["R"] = 0.1
            else
                for band in idx.bands
                    params[band] = rand()
                end
            end
        end
        result = compute_index(idxs; convert_to_kwargs(params)...)
        @test first(result) isa Float64
        @test length(result) == 2
    end

    @testset "Arrays as Params for $idxs" begin
        params = Dict()
        for idx_name in idxs
            idx = indices[idx_name]
            if idx_name == "AVI" || idx_name == "TVI"
                params["N"] = fill(0.2, 10)
                params["R"] = fill(0.1, 10)
            else
                for band in idx.bands
                    params[band] = rand(10)
                end
            end
        end
        result = compute_index(idxs, params)
        @test result isa AbstractArray
        @test length(result) == 2
        @test length(first(result)) == 10
    end

    @testset "Arrays as Kwargs for $idxs" begin
        params = Dict()
        for idx_name in idxs
            idx = indices[idx_name]
            if idx_name == "AVI" || idx_name == "TVI"
                params["N"] = fill(0.2, 10)
                params["R"] = fill(0.1, 10)
            else
                for band in idx.bands
                    params[band] = rand(10)
                end
            end
        end
        result = compute_index(idxs; convert_to_kwargs(params)...)
        @test result isa AbstractArray
        @test length(result) == 2
        @test length(first(result)) == 10
    end

    @testset "Matrices as Params for $idxs" begin
        params = Dict()
        for idx_name in idxs
            idx = indices[idx_name]
            if idx_name == "AVI" || idx_name == "TVI"
                params["N"] = fill(0.2, 10, 10)
                params["R"] = fill(0.1, 10, 10)
            else
                for band in idx.bands
                    params[band] = rand(10, 10)
                end
            end
        end
        result = compute_index(idxs, params)
        @test first(result) isa Matrix
        @test length(result) == 2
        @test size(first(result)) == (10, 10)
    end

    @testset "Matrices as Kwargs for $idxs" begin
        params = Dict()
        for idx_name in idxs
            idx = indices[idx_name]
            if idx_name == "AVI" || idx_name == "TVI"
                params["N"] = fill(0.2, 10, 10)
                params["R"] = fill(0.1, 10, 10)
            else
                for band in idx.bands
                    params[band] = rand(10, 10)
                end
            end
        end
        result = compute_index(idxs; convert_to_kwargs(params)...)
        @test first(result) isa Matrix
        @test length(result) == 2
        @test size(first(result)) == (10, 10)
    end

    @testset "NamedTuples as Params for $idxs" begin
        dict_params = Dict()
        for idx_name in idxs
            idx = indices[idx_name]
            if idx_name == "AVI" || idx_name == "TVI"
                dict_params["N"] = fill(0.2, 10)
                dict_params["R"] = fill(0.1, 10)
            else
                for band in idx.bands
                    dict_params[band] = rand(10)
                end
            end
        end
        # Convert the aggregated dict to NamedTuple
        params = NamedTuple{Tuple(Symbol.(keys(dict_params)))}(values(dict_params))
        result = compute_index(idxs, params)
        @test result isa NamedTuple
        @test size(first(values(result))) == (10,)
    end
    
    @testset "NamedTuples as Kwargs for $idxs" begin
        dict_params = Dict()
        for idx_name in idxs
            idx = indices[idx_name]
            if idx_name == "AVI" || idx_name == "TVI"
                dict_params["N"] = fill(0.2, 10)
                dict_params["R"] = fill(0.1, 10)
            else
                for band in idx.bands
                    dict_params[band] = rand(10)
                end
            end
        end
        # Convert the aggregated dict to NamedTuple for kwargs
        params = NamedTuple{Tuple(Symbol.(keys(dict_params)))}(values(dict_params))
        result = compute_index(idxs; params...)
        @test result isa AbstractArray
        @test size(first(result)) == (10,)
    end
end
