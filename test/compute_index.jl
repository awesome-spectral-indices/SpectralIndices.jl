using Test
using SpectralIndices
using YAXArrays
using Random
using Combinatorics
using StatsBase
Random.seed!(17)

floats = [Float64, Float32, Float16]

convert_to_kwargs(dict) = Dict(Symbol(k) => v for (k, v) in dict)

@testset "Input Validation: Invalid Index" begin
    @test_throws AssertionError compute_index("InvalidIndex", N=0.5, R=0.5)
end

#@testset "Input Validation: Missing Band" begin
#    @test_throws AssertionError compute_index("InvalidIndex", N=0.5, R=0.5)
#end

@testset "Built-in types compute_index $T single index tests: $idx_name" for (idx_name, idx) in indices, T in floats
    @testset "Single Values as Params" begin
        if idx_name == "AVI" || idx_name == "TVI"
            params = Dict("N" => T(0.2), "R"=>T(0.1))
        else
            params = Dict(band => rand(T) for band in idx.bands)
        end
        #default
        result = compute_index(idx_name, params)
        @test length(result) == 1
        #type extension
        result = compute_index(T, idx_name, params)
        @test result isa T
        @test length(result) == 1
    end
    @testset "Single Values as Kwargs" begin
        if idx_name == "AVI" || idx_name == "TVI"
            params = Dict("N" => T(0.2), "R"=>T(0.1))
        else
            params = Dict(band => rand(T) for band in idx.bands)
        end
        result = compute_index(idx_name; convert_to_kwargs(params)...)
        @test length(result) == 1
        result = compute_index(T, idx_name; convert_to_kwargs(params)...)
        @test result isa T
        @test length(result) == 1
    end

    @testset "Arrays as Params" begin
        if idx_name == "AVI" || idx_name == "TVI"
            params = Dict("N" => fill(T(0.2), 10), "R"=>fill(T(0.1), 10))
        else
            params = Dict(band => rand(T, 10) for band in idx.bands)
        end
        result = compute_index(idx_name, params)
        @test result isa AbstractArray
        @test length(result) == 10
        result = compute_index(T, idx_name, params)
        @test result isa AbstractArray
        @test eltype(result) == T
        @test length(result) == 10
    end

    @testset "Arrays as Kwargs" begin
        if idx_name == "AVI" || idx_name == "TVI"
            params = Dict("N" => fill(T(0.2), 10), "R"=>fill(T(0.1), 10))
        else
            params = Dict(band => rand(T, 10) for band in idx.bands)
        end
        result = compute_index(idx_name; convert_to_kwargs(params)...)
        @test result isa AbstractArray
        @test length(result) == 10
        result = compute_index(T, idx_name; convert_to_kwargs(params)...)
        @test result isa AbstractArray
        @test eltype(result) == T
        @test length(result) == 10
    end

    @testset "Matrices as Params" begin
        if idx_name == "AVI" || idx_name == "TVI"
            params = Dict("N" => fill(T(0.2), 10, 10), "R"=>fill(T(0.1), 10, 10))
        else
            params = Dict(band => rand(T, 10, 10) for band in idx.bands)
        end
        result = compute_index(idx_name, params)
        @test result isa Matrix
        @test size(result) == (10,10)
        result = compute_index(T, idx_name, params)
        @test result isa Matrix
        @test eltype(result) == T
        @test size(result) == (10,10)
    end
    @testset "Matrices as Kwargs" begin
        if idx_name == "AVI" || idx_name == "TVI"
            params = Dict("N" => fill(T(0.2), 10, 10), "R"=>fill(T(0.1), 10, 10))
        else
            params = Dict(band => rand(T, 10, 10) for band in idx.bands)
        end
        result = compute_index(idx_name; convert_to_kwargs(params)...)
        @test result isa Matrix
        @test size(result) == (10,10)
        result = compute_index(T, idx_name; convert_to_kwargs(params)...)
        @test result isa Matrix
        @test eltype(result) == T
        @test size(result) == (10,10)
    end

    @testset "NamedTuples as Params" begin
        if idx_name == "AVI" || idx_name == "TVI"
            params = (N = fill(T(0.2), 10), R=fill(T(0.1), 10))
        else
            band_tuples = [(Symbol(band) => rand(T, 10)) for band in idx.bands]
            params = NamedTuple(band_tuples)
        end
        result = compute_index(idx_name, params)
        @test result isa NamedTuple
        @test size(first(result)) == (10,)
        result = compute_index(T, idx_name, params)
        @test result isa NamedTuple
        @test eltype(values(result)[1]) == T
        @test size(first(result)) == (10,)
    end
    @testset "NamedTuples as Kwargs" begin
        if idx_name == "AVI" || idx_name == "TVI"
            params = (N = fill(T(0.2), 10), R=fill(T(0.1), 10))
        else
            band_tuples = [(Symbol(band) => rand(T, 10)) for band in idx.bands]
            params = NamedTuple(band_tuples)
        end
        result = compute_index(idx_name; params...)
        @test result isa AbstractArray
        @test size(result) == (10,)
        result = compute_index(T, idx_name; params...)
        @test result isa AbstractArray
        @test eltype(values(result)[1]) == T
        @test size(result) == (10,)
    end
    GC.gc()
end

msi = custom_key_combinations(indices, 2, 200)
  
@testset "Built-in types compute_index $T multiple indices tests: $idxs" for idxs in msi, T in floats

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
                params["N"] = T(0.2)
                params["R"] = T(0.1)
            else
                for band in idx.bands
                    params[band] = rand(T)
                end
            end
        end
        result = compute_index(idxs, params)
        @test length(result) == 2
        result = compute_index(T, idxs, params)
        @test eltype(first(result)) == T
        @test length(result) == 2
    end

    @testset "Single Values as Kwargs for $idxs" begin
        params = Dict()
        for idx_name in idxs
            idx = indices[idx_name]
            if idx_name == "AVI" || idx_name == "TVI"
                params["N"] = T(0.2)
                params["R"] = T(0.1)
            else
                for band in idx.bands
                    params[band] = rand(T)
                end
            end
        end
        result = compute_index(idxs; convert_to_kwargs(params)...)
        @test length(result) == 2
        result = compute_index(T, idxs; convert_to_kwargs(params)...)
        @test eltype(first(result)) == T
        @test length(result) == 2
    end

    @testset "Arrays as Params for $idxs" begin
        params = Dict()
        for idx_name in idxs
            idx = indices[idx_name]
            if idx_name == "AVI" || idx_name == "TVI"
                params["N"] = fill(T(0.2), 10)
                params["R"] = fill(T(0.1), 10)
            else
                for band in idx.bands
                    params[band] = rand(T, 10)
                end
            end
        end
        result = compute_index(idxs, params)
        @test result isa AbstractArray
        @test length(result) == 2
        @test length(first(result)) == 10
        result = compute_index(T, idxs, params)
        @test result isa AbstractArray
        @test length(result) == 2
        @test length(first(result)) == 10
        @test eltype(first(result)) == T
    end

    @testset "Arrays as Kwargs for $idxs" begin
        params = Dict()
        for idx_name in idxs
            idx = indices[idx_name]
            if idx_name == "AVI" || idx_name == "TVI"
                params["N"] = fill(T(0.2), 10)
                params["R"] = fill(T(0.1), 10)
            else
                for band in idx.bands
                    params[band] = rand(T, 10)
                end
            end
        end
        result = compute_index(idxs; convert_to_kwargs(params)...)
        @test result isa AbstractArray
        @test length(result) == 2
        @test length(first(result)) == 10
        result = compute_index(T, idxs; convert_to_kwargs(params)...)
        @test result isa AbstractArray
        @test length(result) == 2
        @test length(first(result)) == 10
        @test eltype(first(result)) == T
    end

    @testset "Matrices as Params for $idxs" begin
        params = Dict()
        for idx_name in idxs
            idx = indices[idx_name]
            if idx_name == "AVI" || idx_name == "TVI"
                params["N"] = fill(T(0.2), 10, 10)
                params["R"] = fill(T(0.1), 10, 10)
            else
                for band in idx.bands
                    params[band] = rand(T, 10, 10)
                end
            end
        end
        result = compute_index(idxs, params)
        @test first(result) isa Matrix
        @test length(result) == 2
        @test size(first(result)) == (10, 10)
        result = compute_index(T, idxs, params)
        @test first(result) isa Matrix
        @test length(result) == 2
        @test size(first(result)) == (10, 10)
        @test eltype(first(result)) == T
    end

    @testset "Matrices as Kwargs for $idxs" begin
        params = Dict()
        for idx_name in idxs
            idx = indices[idx_name]
            if idx_name == "AVI" || idx_name == "TVI"
                params["N"] = fill(T(0.2), 10, 10)
                params["R"] = fill(T(0.1), 10, 10)
            else
                for band in idx.bands
                    params[band] = rand(T, 10, 10)
                end
            end
        end
        result = compute_index(idxs; convert_to_kwargs(params)...)
        @test first(result) isa Matrix
        @test length(result) == 2
        @test size(first(result)) == (10, 10)
        result = compute_index(T, idxs; convert_to_kwargs(params)...)
        @test first(result) isa Matrix
        @test length(result) == 2
        @test size(first(result)) == (10, 10)
        @test eltype(first(result)) == T
    end

    @testset "NamedTuples as Params for $idxs" begin
        dict_params = Dict()
        for idx_name in idxs
            idx = indices[idx_name]
            if idx_name == "AVI" || idx_name == "TVI"
                dict_params["N"] = fill(T(0.2), 10)
                dict_params["R"] = fill(T(0.1), 10)
            else
                for band in idx.bands
                    dict_params[band] = rand(T, 10)
                end
            end
        end
        # Convert the aggregated dict to NamedTuple
        params = NamedTuple{Tuple(Symbol.(keys(dict_params)))}(values(dict_params))
        result = compute_index(idxs, params)
        @test result isa NamedTuple
        @test size(first(values(result))) == (10,)
        result = compute_index(T, idxs, params)
        @test result isa NamedTuple
        @test size(first(values(result))) == (10,)
        @test eltype(first(values(result))) == T
    end
    
    @testset "NamedTuples as Kwargs for $idxs" begin
        dict_params = Dict()
        for idx_name in idxs
            idx = indices[idx_name]
            if idx_name == "AVI" || idx_name == "TVI"
                dict_params["N"] = fill(T(0.2), 10)
                dict_params["R"] = fill(T(0.1), 10)
            else
                for band in idx.bands
                    dict_params[band] = rand(T, 10)
                end
            end
        end
        # Convert the aggregated dict to NamedTuple for kwargs
        params = NamedTuple{Tuple(Symbol.(keys(dict_params)))}(values(dict_params))
        result = compute_index(idxs; params...)
        @test result isa AbstractArray
        @test size(first(result)) == (10,)
        result = compute_index(T, idxs; params...)
        @test result isa AbstractArray
        @test size(first(result)) == (10,)
        @test eltype(first(values(result))) == T
    end
    GC.gc()
end
