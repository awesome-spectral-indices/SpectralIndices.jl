using Test
using SpectralIndices
using YAXArrays
using Random
include("test_utils.jl")
Random.seed!(17)

floats = [Float64, Float32, Float16]

convert_to_kwargs(dict) = Dict(Symbol(k) => v for (k, v) in dict)

@testset "Input Validation: Invalid Index" begin
    @test_throws ArgumentError compute_index("InvalidIndex", N=0.5, R=0.5)
end

# A) Full index coverage, Float64 only — tests every concrete type once.
# This is the expensive compile path (263 concrete types × ~20s total).
@testset "Built-in types compute_index Float64 single index: $idx_name" for (
    idx_name, idx
) in indices

    @testset "Scalar Dict" begin
        bands = SpectralIndices._band_names(idx)
        band_strs = Tuple(string(b) for b in bands)
        params = Dict(band_strs .=> Float64(0.5))
        result = compute_index(idx, params)
        @test result isa Float64
        @test length(result) == 1
    end

    @testset "NamedTuple" begin
        bands = SpectralIndices._band_names(idx)
        vals = Float64[0.5 for _ in bands]
        result = compute_index(idx, NamedTuple{bands}(vals))
        @test eltype(values(result)[1]) == Float64
    end
end

# B) Full input-variant coverage with representative index sample.
# Covers: dict, kwargs, named tuple, array, matrix — across all float types.
# Uses a representative set of 8 indices covering simple and complex formulas.
sample_indices = [
    "NDVI", "EVI", "GEMI", "MTVI2", "TCARIOSAVI", "IRGBVI", "MCARI2", "SAVI4RE",
]

@testset "Built-in types compute_index $T input variants" for T in floats,
    idx_name in sample_indices

    idx = indices[idx_name]
    bands = SpectralIndices._band_names(idx)
    band_strs = Tuple(string(b) for b in bands)

    @testset "Scalar Dict" begin
        params = Dict(band_strs .=> T(0.5))
        result = compute_index(idx, params)
        @test result isa T
    end

    @testset "Scalar Kwargs" begin
        params = Dict(Symbol(string(band)) => T(0.5) for band in bands)
        result = compute_index(idx_name; params...)
        @test result isa T
    end

    @testset "Array Dict" begin
        params = Dict(band => T[0.5 for _ in 1:10] for band in band_strs)
        result = compute_index(idx, params)
        @test eltype(result) == T
        @test length(result) == 10
    end

    @testset "Array Kwargs" begin
        params = Dict(Symbol(string(band)) => T[0.5 for _ in 1:10] for band in bands)
        result = compute_index(idx_name; params...)
        @test eltype(result) == T
    end

    @testset "Matrix Dict" begin
        params = Dict(band => reshape(T[0.5 for _ in 1:100], 10, 10) for band in band_strs)
        result = compute_index(idx, params)
        @test size(result) == (10, 10)
    end

    @testset "Matrix Kwargs" begin
        params = Dict(Symbol(string(band)) => reshape(T[0.5 for _ in 1:100], 10, 10) for band in bands)
        result = compute_index(idx_name; params...)
        @test size(result) == (10, 10)
    end

    @testset "NamedTuple" begin
        vals = T[0.5 for _ in bands]
        result = compute_index(idx, NamedTuple{bands}(vals))
        @test eltype(values(result)[1]) == T
    end

    @testset "NamedTuple Matrix" begin
        params = (;
            (band => reshape(T[0.5 for _ in 1:100], 10, 10) for band in band_strs)...)
        result = compute_index(idx, params)
        @test size(result) == (10, 10)
    end
end

# C) Multi-index tests: hand-picked pairs covering different band overlap
#    scenarios. The full test suite used 200 random pairs; 5 is sufficient
#    to exercise the aggregation path.
multi_index_samples = [
    ["NDVI", "EVI"],        # 2 + 7 bands, overlapping
    ["GEMI", "MTVI2"],      # complex formulas, overlapping
    ["NDVI", "NDWI"],       # simple, completely overlapping
    ["TCARIOSAVI", "IRGBVI"], # 4 + 5 bands, mostly unique
    ["LSWI", "S2WI"],       # simple, 1-band overlap
]

@testset "Built-in types compute_index $T multiple indices tests: $idxs" for idxs in multi_index_samples,
    T in floats

    @testset "Scalar Dict" begin
        params = Dict{String, T}()
        for idx_name in idxs
            idx = indices[idx_name]
            for band in SpectralIndices._band_names(idx)
                params[string(band)] = T(0.5)
            end
        end
        result = compute_index(idxs, params)
        @test length(result) == 2
        @test eltype(first(result)) == T
    end

    @testset "Scalar Kwargs" begin
        params = Dict{Symbol, T}()
        for idx_name in idxs
            idx = indices[idx_name]
            for band in SpectralIndices._band_names(idx)
                params[Symbol(string(band))] = T(0.5)
            end
        end
        result = compute_index(idxs; params...)
        @test length(result) == 2
    end

    @testset "Array Dict" begin
        params = Dict{String, Vector{T}}()
        for idx_name in idxs
            idx = indices[idx_name]
            for band in SpectralIndices._band_names(idx)
                params[string(band)] = T[0.5 for _ in 1:10]
            end
        end
        result = compute_index(idxs, params)
        @test length(result) == 2
        @test length(first(result)) == 10
        @test eltype(first(result)) == T
    end
end
