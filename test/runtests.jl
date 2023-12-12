using SafeTestsets
using Test

@testset "Axioms" begin
    @safetestset "Axioms" begin
        include("axioms.jl")
    end
    @safetestset "Compute" begin
        include("compute.jl")
    end
    @safetestset "Utils" begin
        include("utils.jl")
    end
end
