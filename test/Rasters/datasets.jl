using Test
using SpectralIndices
using Rasters

@testset "load_dataset: Valid Dataset Name Test" begin
    df = load_dataset("sentinel", Raster)
    @test df isa Raster
    @test !isempty(df)
end

@testset "load_dataset: Invalid Dataset Name Test" begin
    @test_throws ErrorException load_dataset("invalidDatasetName", Raster)
end
