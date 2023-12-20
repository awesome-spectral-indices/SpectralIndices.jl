using SpectralIndices
using Aqua

@testset "Aqua" begin
    Aqua.find_persistent_tasks_deps(SpectralIndices)
    Aqua.test_ambiguities(SpectralIndices, recursive = false)
    Aqua.test_deps_compat(SpectralIndices)
    Aqua.test_piracies(SpectralIndices)
    Aqua.test_project_extras(SpectralIndices)
    Aqua.test_stale_deps(SpectralIndices)
    Aqua.test_unbound_args(SpectralIndices)
    Aqua.test_undefined_exports(SpectralIndices)
end
