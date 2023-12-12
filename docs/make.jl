using SpectralIndices
using Documenter

include("pages.jl")

makedocs(;
    modules=[SpectralIndices],
    sitename="SpectralIndices.jl",
    clean=true,
    doctest=true,
    linkcheck=true,
    warnonly=[:missing_docs],
    pages=pages,
)

deploydocs(;
    repo="github.com/awesome-spectral-indices/SpectralIndices.jl.git", push_preview=true
)
