using Test
using SpectralIndices
using DataFrames

@testset "load_dataset: Valid Dataset Name Test" begin
    df = load_dataset("spectral", DataFrame)
    @test df isa DataFrame
    @test !isempty(df)
end

@testset "load_dataset: Invalid Dataset Name Test" begin
    @test_throws ErrorException load_dataset("invalidDatasetName", DataFrame)
end
