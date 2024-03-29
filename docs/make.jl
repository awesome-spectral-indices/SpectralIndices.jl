using SpectralIndices
using Documenter
using DocumenterVitepress

include("pages.jl")

makedocs(;
    modules=[SpectralIndices],
    sitename="SpectralIndices.jl",
    clean=true,
    doctest=true,
    linkcheck=true,
    warnonly=[:missing_docs],
    format=DocumenterVitepress.MarkdownVitepress(;
        repo="github.com/awesome-spectral-indices/SpectralIndices.jl", # this must be the full URL!
        devbranch="main",
        devurl="dev",
    ),
    draft=false,
    source="src",
    build="build",
    pages=pages,
)

deploydocs(;
    repo="github.com/awesome-spectral-indices/SpectralIndices.jl",
    target="build", # this is where Vitepress stores its output
    branch="gh-pages",
    devbranch="main",
    push_preview=true,
)
