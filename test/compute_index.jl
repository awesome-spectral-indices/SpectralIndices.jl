using Test
using SpectralIndices
using YAXArrays
using Random
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
    
    if idxs[1] in ["AVI", "TVI"] && length(idxs) > 1
        for i in 2:length(idxs)
            if !(idxs[i] in ["AVI", "TVI"])
                idxs[1], idxs[i] = idxs[i], idxs[1]
                break
            end
        end
    end

    @testset "Single Values as Params" begin
        params = Dict()
        for idx_name in idxs
            idx = indices[idx_name]
            if idx_name == "AVI" || idx_name == "TVI"
                params = Dict("N" => 0.2, "R"=>0.1)
            else
                params = Dict(band => rand() for band in idx.bands)
            end
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