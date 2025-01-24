using SpectralIndices
using Aqua: Aqua
using Documenter: Documenter
#using JET: JET

Aqua.test_all(SpectralIndices; ambiguities=false, deps_compat=(check_extras = false))
#JET.test_package(SpectralIndices)
Documenter.doctest(SpectralIndices)
