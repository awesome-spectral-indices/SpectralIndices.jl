module SpectralIndices

using Compat: @compat
using Dates: Date, @dateformat_str
using Downloads: Downloads
using JSON: parsefile

indices_funcs = Dict()
include("utils.jl")
#_create_indexfun()
include("indices_funcs.jl")
include("indices.jl")
include("platforms.jl")
include("bands.jl")
include("constants.jl")
include("compute_index.jl")
include("compute_kernel.jl")
include("datasets.jl")

indices = create_indices()
bands = create_bands()
constants = create_constants()

@compat(public, (create_indices,
    create_bands,
    create_constants,
    load_json,
    check_params,
    create_params,
    order_params))

export get_indices, create_indexfun
export get_datasets, load_dataset
export SpectralIndex, indices, compute
export PlatformBand, Band
export Constant
export compute_index
export compute_kernel, linear, poly, RBF
export bands
export constants

function export_index(si::SpectralIndex)
    @eval begin
        export $(Symbol(si.short_name))
        const $(Symbol(si.short_name)) = $si
    end
end

for (name, instance) in indices
    export_index(indices[name])
end

end #module
