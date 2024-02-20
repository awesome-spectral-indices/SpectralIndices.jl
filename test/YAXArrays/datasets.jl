using Test
using SpectralIndices
using YAXArrays

@testset "load_dataset: Valid Dataset Name Test" begin
    df = load_dataset("sentinel", YAXArray)
    @test df isa YAXArray
    @test !isempty(df)
end

@testset "load_dataset: Invalid Dataset Name Test" begin
    @test_throws ErrorException load_dataset("invalidDatasetName", YAXArray)
end