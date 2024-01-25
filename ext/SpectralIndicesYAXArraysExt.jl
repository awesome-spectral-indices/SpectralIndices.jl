module SpectralIndicesYAXArraysExt

using SpectralIndices
using YAXArrays
using DimensionalData

function SpectralIndices._check_params(index, params::YAXArray)
    for band in index.bands
        if !(band in params.Variables)
            throw(
                ArgumentError(
                    "'$band' is missing in the parameters for $index computation!"
                ),
            )
        end
    end
end

function SpectralIndices._order_params(index, params::YAXArray)
    new_params = []
    for (bidx, band) in enumerate(index.bands)
        push!(new_params, params[Variable=At(band)])
    end

    return new_params
end

function SpectralIndices._create_params(kw_args::Pair{Symbol,<:YAXArray}...)
    params_yaxa = []
    names_yaxa = []
    for (key, value) in kw_args
        push!(params_yaxa, value)
        push!(names_yaxa, String(key))
    end

    params = concatenatecubes(params_yaxa, Dim{:Variables}(names_yaxa))
    return params
end

## TODO: simplify even further
# this is same function contente as dispatch on Dict
function SpectralIndices.compute_index(
    index::String, params::YAXArray; indices=SpectralIndices._create_indices()
)
    SpectralIndices._check_params(indices[index], params)
    params = SpectralIndices._order_params(indices[index], params)
    result = SpectralIndices._compute_index(indices[index], params...)
    return result
end

function SpectralIndices.compute_index(
    index::Vector{String}, params::YAXArray; indices=SpectralIndices._create_indices()
)
    results = []
    for (nidx, idx) in enumerate(index)
        res_tmp = compute_index(idx, params; indices=indices)
        push!(results, res_tmp)
    end
    result = concatenatecubes(results, Dim{:Variables}(index))

    return result
end

function SpectralIndices._compute_index(
    idx::SpectralIndices.AbstractSpectralIndex, prms::YAXArray...
)
    return idx.(prms...)
end

function SpectralIndices.linear(params::YAXArray)
    result = linear(params[Variable=At("a")], params[Variable=At("b")])
    return result
end

function SpectralIndices.poly(params::YAXArray)
    result = poly(
        params[Variable=At("a")],
        params[Variable=At("b")],
        params[Variable=At("c")],
        params[Variable=At("p")],
    )
    return result
end

function SpectralIndices.RBF(params::YAXArray)
    result = RBF(
        params[Variable=At("a")], params[Variable=At("b")], params[Variable=At("sigma")]
    )
    return result
end

end #module