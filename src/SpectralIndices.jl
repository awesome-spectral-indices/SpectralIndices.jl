module SpectralIndices

using Dates
using Downloads
using JSON

abstract type AbstractSpectralIndex end
abstract type AbstractPlatformBand end

indices_funcs = Dict()
include("utils.jl")
_create_indexfun()
include("indices_funcs.jl")
include("indices.jl")
include("platforms.jl")
include("bands.jl")
include("constants.jl")
include("compute_index.jl")
include("compute_kernel.jl")
include("datasets.jl")

if !isdefined(Base, :get_extension)
    include("../ext/SpectralIndicesDataFramesExt.jl")
    include("../ext/SpectralIndicesYAXArraysExt.jl")
end

indices = _create_indices()
bands = _create_bands()
constants = _create_constants()

export get_datasets, load_dataset
export SpectralIndex, indices, compute
export PlatformBand, Band
export Constant
export compute_index
export compute_kernel, linear, poly, RBF
export bands
export constants

function _export_index(si::SpectralIndex)
    @eval begin
        export $(Symbol(si.short_name))
        const $(Symbol(si.short_name)) = $si
    end
end

for (name, instance) in indices
    _export_index(indices[name])
end

end #module
