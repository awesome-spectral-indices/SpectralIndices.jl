using SpectralIndices
using Aqua: Aqua
using Documenter: Documenter
using JET
using Downloads

JET.test_package(
    SpectralIndices; ignored_modules=(Downloads,), target_modules=(SpectralIndices,))

Aqua.test_all(SpectralIndices; ambiguities=false, deps_compat=(check_extras = false))

Documenter.doctest(SpectralIndices)
