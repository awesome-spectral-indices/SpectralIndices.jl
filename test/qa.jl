using SpectralIndices
using Aqua: Aqua
using Documenter: Documenter
using JET
using Downloads

Aqua.test_all(SpectralIndices; ambiguities=false, deps_compat=(check_extras = false))
JET.test_package(
    SpectralIndices; ignored_modules=(Downloads,), target_modules=(SpectralIndices,))
Documenter.doctest(SpectralIndices)
