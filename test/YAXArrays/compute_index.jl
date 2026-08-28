using Test
using SpectralIndices
using YAXArrays
using DimensionalData
using Random
include("../test_utils.jl")
Random.seed!(17)

floats = [Float64, Float32, Float16]

function convert_to_kwargs(yaxarr::YAXArray)
    var_names = lookup(yaxarr, :Variables)
    kwargs = [(Symbol(var_name) => yaxarr[Variable=At(var_name)])
              for var_name in var_names]
    return kwargs
end

xdim = Dim{:x}(range(1, 10; length=10))
ydim = Dim{:y}(range(1, 10; length=15))

# A) Full index coverage, Float64 only
@testset "YAXArrays compute_index Float64 single index: $idx_name" for (
    idx_name, idx
) in indices

    @testset "as Params" begin
        bands_names = collect(string.(SpectralIndices._band_names(idx)))
        bands_dim = Dim{:Variables}(bands_names)
        data = cat(
            [fill(Float64(0.5), 10, 15, 1) for _ in bands_names]...; dims=3)
        params = YAXArray((xdim, ydim, bands_dim), data)
        result = compute_index(idx_name, params)
        @test result isa YAXArray
        @test size(result) == (length(xdim), length(ydim))
        @test eltype(result) == Float64
    end

    @testset "as Kwargs" begin
        bands_names = collect(string.(SpectralIndices._band_names(idx)))
        bands_dim = Dim{:Variables}(bands_names)
        data = cat(
            [fill(Float64(0.5), 10, 15, 1) for _ in bands_names]...; dims=3)
        params = YAXArray((xdim, ydim, bands_dim), data)
        result = compute_index(idx_name; convert_to_kwargs(params)...)
        @test result isa YAXArray
        @test size(result) == (length(xdim), length(ydim))
        @test eltype(result) == Float64
    end
end

# B) Full float variant coverage with representative index sample
sample_indices = [
    "NDVI", "EVI", "GEMI", "MTVI2", "TCARIOSAVI", "IRGBVI", "MCARI2", "SAVI4RE",
]

@testset "YAXArrays compute_index $T input variants" for T in floats,
    idx_name in sample_indices

    idx = indices[idx_name]
    bands_names = collect(string.(SpectralIndices._band_names(idx)))
    bands_dim = Dim{:Variables}(bands_names)
    data = cat(
        [fill(T(0.5), 10, 15, 1) for _ in bands_names]...; dims=3)
    params = YAXArray((xdim, ydim, bands_dim), data)

    @testset "as Params" begin
        result = compute_index(idx_name, params)
        @test result isa YAXArray
        @test size(result) == (length(xdim), length(ydim))
        @test eltype(result) == T
    end

    @testset "as Kwargs" begin
        result = compute_index(idx_name; convert_to_kwargs(params)...)
        @test result isa YAXArray
        @test size(result) == (length(xdim), length(ydim))
        @test eltype(result) == T
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

@testset "YAXArrays compute_index $T multi-index: $idxs" for idxs in multi_index_samples,
    T in floats

    @testset "as Params" begin
        yaxa_tmp = []
        yaxa_names = String[]
        for idx_name in idxs
            idx = indices[idx_name]
            for band in SpectralIndices._band_names(idx)
                push!(yaxa_names, string(band))
                data = fill(T(0.5), 10, 15)
                push!(yaxa_tmp, YAXArray((xdim, ydim), data))
            end
        end
        unique_band_names = unique(yaxa_names)
        unique_yaxas = yaxa_tmp[1:length(unique_band_names)]
        params = concatenatecubes(unique_yaxas, Dim{:Variables}(unique_band_names))
        result = compute_index(idxs, params)
        @test result isa YAXArray
        @test size(result) == (length(xdim), length(ydim), 2)
        @test eltype(result) == T
    end

    @testset "as Kwargs" begin
        yaxa_tmp = []
        yaxa_names = String[]
        for idx_name in idxs
            idx = indices[idx_name]
            for band in SpectralIndices._band_names(idx)
                push!(yaxa_names, string(band))
                data = fill(T(0.5), 10, 15)
                push!(yaxa_tmp, YAXArray((xdim, ydim), data))
            end
        end
        unique_band_names = unique(yaxa_names)
        unique_yaxas = yaxa_tmp[1:length(unique_band_names)]
        params = concatenatecubes(unique_yaxas, Dim{:Variables}(unique_band_names))
        result = compute_index(idxs; convert_to_kwargs(params)...)
        @test result isa YAXArray
        @test size(result) == (length(xdim), length(ydim), 2)
        @test eltype(result) == T
    end
end
