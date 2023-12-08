module SpectralIndices

using Dates
using Downloads
using JSON
#using Symbolics

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

for (name, instance) in indices
    @eval begin
        $(Symbol(name)) = $instance
        export $(Symbol(name))
    end
end

end #module