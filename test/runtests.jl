using SafeTestsets
using Test

@safetestset "Quality Assurance" begin
    include("qa.jl")
end

@safetestset "Utils" begin
    include("utils.jl")
    include("DataFrames/datasets.jl")
    include("YAXArrays/datasets.jl")
end

@safetestset "Axioms" begin
    include("indices.jl")
    include("platforms.jl")
    include("bands.jl")
    include("constants.jl")
end

@safetestset "Compute Indices" begin
    include("test_utils.jl")
    include("compute_index.jl")
    include("DataFrames/compute_index.jl")
    include("YAXArrays/compute_index.jl")
end

@safetestset "Compute Kernels" begin
    include("compute_kernel.jl")
    include("DataFrames/compute_kernel.jl")
    include("YAXArrays/compute_kernel.jl")
end
