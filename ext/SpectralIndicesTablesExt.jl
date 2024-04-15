module SpectralIndicesTablesExt

using SpectralIndices
using Tables
import Tables: Table
import SpectralIndices:
    _create_params,
    AbstractSpectralIndex,
    compute_index,
    _create_indices,
    linear,
    poly,
    RBF,
    load_dataset,
    _load_json


function _check_params(index::AbstractSpectralIndex, params::Tables.AbstractColumns)
    column_names = Tables.columnnames(params)
    for band in index.bands
        if !(band in column_names)
            throw(
                ArgumentError(
                    "'$band' is missing in the parameters for $index computation!"
                )
            )
        end
    end
end


function _order_params(index::AbstractSpectralIndex, params::Tables.AbstractColumns)
    new_params = []
    for (bidx, band) in enumerate(index.bands)
        if hasproperty(params, band)
            push!(new_params, getproperty(params, band))
        else
            throw(ArgumentError("'$band' is missing in the parameters for $index computation!"))
        end
    end

    return new_params
end

function _create_params(kw_args::Pair{Symbol,<:Tables.AbstractColumns}...)
    column_data = []
    column_names = []

    for (key, value) in kw_args
        push!(column_data, value)
        push!(column_names, String(key))
    end
    new_params = Tables.columntable(Dict(column_names .=> column_data))

    return new_params
end

end #module