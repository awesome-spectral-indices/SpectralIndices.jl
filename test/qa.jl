using SpectralIndices
using JuliaFormatter: JuliaFormatter
using JET: JET
using Aqua: Aqua

Aqua.test_all(SpectralIndices; ambiguities=false, deps_compat=(check_extras = false))
@test JuliaFormatter.format(SpectralIndices; verbose=false, overwrite=false)
JET.test_package(SpectralIndices; target_defined_modules=true)
