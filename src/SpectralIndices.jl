module SpectralIndices

using Dates
using Downloads
using JSON

export SpectralIndex, indices, compute, compute_index
export PlatformBand, Band, bands
export Constant, constants
export compute_index

abstract type AbstractSpectralIndex end
abstract type AbstractPlatformBand end

include("utils.jl")
include("axioms.jl")
include("compute.jl")
#include("datasets.jl")
indices = _create_indices()

end #module
