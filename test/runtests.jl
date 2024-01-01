using SafeTestsets
using Test

@safetestset "Quality Assurance" begin
    include("qa.jl")
end

@safetestset "Axioms" begin
    include("axioms.jl")
end

@safetestset "Compute" begin
    include("compute_index.jl")
    include("compute_kernel.jl")
end

@safetestset "Utils" begin
    include("utils.jl")
end
