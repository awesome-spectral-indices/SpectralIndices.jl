using SafeTestsets
using Test
using SpectralIndices
using JuliaFormatter: JuliaFormatter
#using JET: JET
using Aqua: Aqua

@testset "Quality Assurance" begin
    Aqua.test_all(SpectralIndices; ambiguities=false, deps_compat=(check_extras=false,))
    @test JuliaFormatter.format(SpectralIndices; verbose=false, overwrite=false)
    #JET.test_package(SpectralIndices; target_defined_modules=true)
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
