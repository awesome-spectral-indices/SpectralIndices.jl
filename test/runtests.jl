using SafeTestsets
using Test

@testset "Axioms" begin
    @safetestset "Axioms" begin include("axioms.jl") end
end