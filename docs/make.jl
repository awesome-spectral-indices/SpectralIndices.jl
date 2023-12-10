using SpectralIndices
using Documenter

include("pages.jl")

makedocs(;
    modules=[SpectralIndices],
    sitename="SpectralIndices.jl",
    clean=true,
    doctest=false,
    linkcheck=true,
    warnonly=[:missing_docs],
    pages=pages,
)

deploydocs(;
    repo="https://github.com/awesome-spectral-indices/SpectralIndices.jl.git",
    push_preview=true,
)