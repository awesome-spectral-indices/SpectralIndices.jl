using SafeTestsets
using Test

@safetestset "Quality Assurance" begin
    include("qa.jl")
end

@testset "Utils" begin
    @safetestset "General utils" include("utils.jl")
    @safetestset "DataFrames datasets" include("DataFrames/datasets.jl")
    @safetestset "YAXArrays datasets" include("YAXArrays/datasets.jl")
    @safetestset "Rasters datasets" include("Rasters/datasets.jl")
end

@testset "Axioms" begin
    @safetestset "Indices" include("indices.jl")
    @safetestset "Platforms" include("platforms.jl")
    @safetestset "Bands" include("bands.jl")
    @safetestset "Constants" include("constants.jl")
end

@testset "Compute Indices" begin
    @safetestset "Built-in types" include("compute_index.jl")
    @safetestset "DataFrames" include("DataFrames/compute_index.jl")
    @safetestset "YAXArrays" include("YAXArrays/compute_index.jl")
    @safetestset "Rasters" include("Rasters/compute_index.jl")
end

@testset "Compute Kernels" begin
    @safetestset "Built-in types" include("compute_kernel.jl")
    @safetestset "DataFrames" include("DataFrames/compute_kernel.jl")
    @safetestset "YAXArrays" include("YAXArrays/compute_kernel.jl")
    @safetestset "Rasters" include("Rasters/compute_kernel.jl")
end
