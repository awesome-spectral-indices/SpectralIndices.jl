module SpectralIndices

using Dates
using Downloads
using JSON
using YAXArrays
using DimensionalData

abstract type AbstractSpectralIndex end
abstract type AbstractPlatformBand end

include("utils.jl")
include("axioms.jl")
include("compute_index.jl")
include("compute_kernel.jl")
#include("datasets.jl")

if !isdefined(Base, :get_extension)
    include("../ext/SpectralIndicesDataFramesExt.jl")
end

indices = _create_indices()

export SpectralIndex, indices, compute
export PlatformBand, Band, bands
export Constant, constants
export compute_index
export compute_kernel, linear, poly, RBF

for (name, instance) in indices
    @eval begin
        $(Symbol(name)) = $instance
        export $(Symbol(name))
    end
end

end #module
