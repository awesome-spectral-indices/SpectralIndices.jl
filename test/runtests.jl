using SafeTestsets
using Test

@safetestset "Quality Assurance" begin
    include("qa.jl")
end

@safetestset "Axioms" begin
    include("axioms.jl")
end

@safetestset "Compute Indices" begin
    include("compute_index.jl")
end

@safetestset "Compute Kernels" begin
    include("compute_kernel.jl")
end

@safetestset "Utils" begin
    include("utils.jl")
end
