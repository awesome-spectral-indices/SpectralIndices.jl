using Test
using SpectralIndices
using DataFrames
using Random
include("../test_utils.jl")
Random.seed!(17)

floats = [Float64, Float32, Float16]

function convert_to_kwargs(df::DataFrame)
    kwargs = [(Symbol(band) => DataFrame(band => df[:, band])) for band in names(df)]
    return kwargs
end

# A) Full index coverage, Float64 only
@testset "DataFrames compute_index Float64 single index: $idx_name" for (
    idx_name, idx
) in indices

    @testset "as Params" begin
        params = DataFrame([band => [Float64(0.5) for _ in 1:10] for band in SpectralIndices._band_names(idx)])
        result = compute_index(idx_name, params)
        @test result isa DataFrame
        @test names(result) == [idx_name]
    end

    @testset "as Kwargs" begin
        params = DataFrame([band => [Float64(0.5) for _ in 1:10] for band in SpectralIndices._band_names(idx)])
        result = compute_index(idx_name; convert_to_kwargs(params)...)
        @test result isa DataFrame
        @test names(result) == [idx_name]
    end
end

# B) Full float variant coverage with representative index sample
sample_indices = [
    "NDVI", "EVI", "GEMI", "MTVI2", "TCARIOSAVI", "IRGBVI", "MCARI2", "SAVI4RE",
]

@testset "DataFrames compute_index $T input variants" for T in floats,
    idx_name in sample_indices

    idx = indices[idx_name]
    params = DataFrame([band => T[0.5 for _ in 1:10] for band in SpectralIndices._band_names(idx)])

    @testset "as Params" begin
        result = compute_index(idx_name, params)
        @test result isa DataFrame
        @test first(eltype.(eachcol(result))) == T
    end

    @testset "as Kwargs" begin
        result = compute_index(idx_name; convert_to_kwargs(params)...)
        @test result isa DataFrame
        @test first(eltype.(eachcol(result))) == T
    end
end

# C) Multi-index: hand-picked pairs
multi_index_samples = [
    ["NDVI", "EVI"],
    ["GEMI", "MTVI2"],
    ["NDVI", "NDWI"],
    ["TCARIOSAVI", "IRGBVI"],
    ["LSWI", "S2WI"],
]

@testset "DataFrames compute_index $T multi-index: $idxs" for idxs in multi_index_samples,
    T in floats

    @testset "as Params" begin
        params = DataFrame()
        for idx_name in idxs
            for band in SpectralIndices._band_names(indices[idx_name])
                params[!, band] = T[0.5 for _ in 1:10]
            end
        end
        result = compute_index(idxs, params)
        @test names(result) == idxs
        @test first(eltype.(eachcol(result))) == T
    end

    @testset "as Kwargs" begin
        params = DataFrame()
        for idx_name in idxs
            for band in SpectralIndices._band_names(indices[idx_name])
                params[!, band] = T[0.5 for _ in 1:10]
            end
        end
        result = compute_index(idxs; convert_to_kwargs(params)...)
        @test names(result) == idxs
        @test first(eltype.(eachcol(result))) == T
    end
end
