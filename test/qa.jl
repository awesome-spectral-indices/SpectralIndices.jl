using SpectralIndices
using Aqua: Aqua
using Documenter: Documenter
#using JET
using Downloads

@static if VERSION >= v"1.12"
    using JET
    JET.test_package(
        SpectralIndices; ignored_modules=(Downloads,), target_modules=(SpectralIndices,))

else
    @info "Skipping JET tests on Julia $(VERSION): Jet 0.10 requires ≥ 1.12"
end

Aqua.test_all(SpectralIndices; ambiguities=false, deps_compat=(check_extras = false))

Documenter.doctest(SpectralIndices)
