using Test
using SpectralIndices
using YAXArrays
using DimensionalData
using Random
using Combinatorics
using StatsBase
Random.seed!(17)

floats = [Float64, Float32, Float16]

function convert_to_kwargs(yaxarr::YAXArray)
    var_names = lookup(yaxarr, :Variables)
    kwargs = [(Symbol(var_name) => yaxarr[Variable=At(var_name)]) for var_name in var_names]
    return kwargs
end

xdim = Dim{:x}(range(1, 10; length=10))
ydim = Dim{:x}(range(1, 10; length=15))

@testset "YAXArrays compute_index $T single index tests: $idx_name" for (idx_name, idx) in
                                                                        indices,
    T in floats

    @testset "as Params" begin
        if idx_name == "AVI" || idx_name == "TVI"
            nyx = YAXArray((xdim, ydim), fill(T(0.2), 10, 15))
            ryx = YAXArray((xdim, ydim), fill(T(0.1), 10, 15))
            bandsnames = Dim{:Variables}(["N", "R"])
            params = concatenatecubes([nyx, ryx], bandsnames)
        else
            bands_dim = Dim{:Variables}(idx.bands)
            data = cat([fill(rand(T), 10, 15, 1) for _ in idx.bands]...; dims=3)
            params = YAXArray((xdim, ydim, bands_dim), data)
        end
        result = compute_index(idx_name, params)
        @test result isa YAXArray
        @test size(result) == (length(xdim), length(ydim))
        result = compute_index(T, idx_name, params)
        @test result isa YAXArray
        @test size(result) == (length(xdim), length(ydim))
        @test eltype(result) == T
    end

    @testset "as Kwargs" begin
        if idx_name == "AVI" || idx_name == "TVI"
            nyx = YAXArray((xdim, ydim), fill(T(0.2), 10, 15))
            ryx = YAXArray((xdim, ydim), fill(T(0.1), 10, 15))
            bandsnames = Dim{:Variables}(["N", "R"])
            params = concatenatecubes([nyx, ryx], bandsnames)
        else
            bands_dim = Dim{:Variables}(idx.bands)
            data = cat([fill(rand(T), 10, 15, 1) for _ in idx.bands]...; dims=3)
            params = YAXArray((xdim, ydim, bands_dim), data)
        end
        result = compute_index(idx_name; convert_to_kwargs(params)...)
        @test result isa YAXArray
        @test size(result) == (length(xdim), length(ydim))
        result = compute_index(T, idx_name; convert_to_kwargs(params)...)
        @test result isa YAXArray
        @test size(result) == (length(xdim), length(ydim))
        @test eltype(result) == T
    end
    GC.gc()
end

msi = custom_key_combinations(indices, 2, 200)

@testset "YAXArrays compute_index $T multiple indices tests: $idxs" for idxs in msi,
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
        yaxa_tmp = []
        yaxa_names = String[]

        for idx_name in idxs
            idx = indices[idx_name]
            if idx_name == "AVI" || idx_name == "TVI"
                for band in ["N", "R"]
                    value = band == "N" ? T(0.2) : T(0.1)
                    push!(yaxa_names, string(band))
                    data = fill(value, 10, 15)
                    push!(yaxa_tmp, YAXArray((xdim, ydim), data))
                end
            else
                for band in idx.bands
                    append!(yaxa_names, [string(band)])
                    data = fill(rand(T), 10, 15)
                    push!(yaxa_tmp, YAXArray((xdim, ydim), data))
                end
            end
        end
        unique_band_names = unique(yaxa_names)
        unique_yaxas = yaxa_tmp[1:length(unique_band_names)] #sheesh, more elegant pls
        params = concatenatecubes(unique_yaxas, Dim{:Variables}(unique_band_names))
        if T == Float64
            result = compute_index(idxs, params)
            @test result isa YAXArray
            @test size(result) == (length(xdim), length(ydim), 2)
        else
            result = compute_index(T, idxs, params)
            @test result isa YAXArray
            @test size(result) == (length(xdim), length(ydim), 2)
            @test eltype(result) == T
        end
    end

    @testset "as Kwargs" begin
        yaxa_tmp = []
        yaxa_names = String[]

        for idx_name in idxs
            idx = indices[idx_name]
            if idx_name == "AVI" || idx_name == "TVI"
                for band in ["N", "R"]
                    value = band == "N" ? T(0.2) : T(0.1)
                    push!(yaxa_names, string(band))
                    data = fill(value, 10, 15)
                    push!(yaxa_tmp, YAXArray((xdim, ydim), data))
                end
            else
                for band in idx.bands
                    append!(yaxa_names, [string(band)])
                    data = fill(rand(T), 10, 15)
                    push!(yaxa_tmp, YAXArray((xdim, ydim), data))
                end
            end
        end
        unique_band_names = unique(yaxa_names)
        unique_yaxas = yaxa_tmp[1:length(unique_band_names)] #sheesh, more elegant pls
        params = concatenatecubes(unique_yaxas, Dim{:Variables}(unique_band_names))
        if T == Float64
            result = compute_index(idxs; convert_to_kwargs(params)...)
            @test result isa YAXArray
            @test size(result) == (length(xdim), length(ydim), 2)
        else
            result = compute_index(T, idxs; convert_to_kwargs(params)...)
            @test result isa YAXArray
            @test size(result) == (length(xdim), length(ydim), 2)
            @test eltype(result) == T
        end
    end
    GC.gc()
end
