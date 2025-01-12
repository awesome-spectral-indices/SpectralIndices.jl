module SpectralIndicesDataFramesExt

using SpectralIndices
using DataFrames
import SpectralIndices:
                        create_params,
                        AbstractSpectralIndex,
                        compute_index,
                        create_indices,
                        linear,
                        poly,
                        RBF,
                        load_dataset,
                        load_json

function create_params(kw_args::Pair{Symbol, DataFrame}...)
    combined_df = DataFrame()

    for pair in kw_args
        df = copy(pair.second)
        rename!(df, names(df) .=> Symbol.(pair.first))
        combined_df = hcat(combined_df, df; makeunique=true)
    end
    return combined_df
end

function compute_index(
        index::AbstractSpectralIndex, params::DataFrame; indices=create_indices()
)
    # Convert DataFrame to a dictionary for each row and compute the index
    results = [compute_index(index, Dict(zip(names(params), row)); indices=indices)
               for
               row in eachrow(params)]

    # Return the results as a DataFrame with the column named after the index
    return DataFrame(Symbol(index.short_name) => results)
end

function compute_index(
        index::Vector{<:AbstractSpectralIndex}, params::DataFrame; indices=create_indices()
)
    # Similar conversion and computation for a vector of indices
    result_dfs = DataFrame()
    for idx in index
        result_df = compute_index(idx, params; indices=indices)
        result_dfs[!, Symbol(idx.short_name)] = result_df[!, 1]
    end
    # Return the combined DataFrame with columns named after each index
    return result_dfs
end

function linear(params::DataFrame)
    result = linear(params[!, "a"], params[!, "b"])
    result_df = DataFrame(; linear=result)
    return result_df
end

function poly(params::DataFrame)
    result = poly(params[!, "a"], params[!, "b"], params[!, "c"], params[!, "p"])
    result_df = DataFrame(; poly=result)
    return result_df
end

function RBF(params::DataFrame)
    result = RBF(params[!, "a"], params[!, "b"], params[!, "sigma"])
    result_df = DataFrame(; RBF=result)
    return result_df
end

function load_dataset(dataset::String, ::Type{T}) where {T <: DataFrame}
    datasets = Dict("spectral" => "spectral.json")

    if dataset in keys(datasets)
        nothing
    else
        error("Dataset name not valid. Datasets available for DataFrames: spectral")
    end

    ds = load_json(datasets[dataset])
    all_indices = Set{Int}()
    for val in values(ds)
        for idx in keys(val)
            push!(all_indices, parse(Int, idx))
        end
    end
    all_indices = sort(collect(all_indices))
    df = DataFrame(; index=all_indices)

    for col_name in keys(ds)
        df[!, col_name] = Vector{Union{Missing, Any}}(missing, length(all_indices))
    end

    for (col_name, col_data) in ds
        for (idx, value) in col_data
            row_idx = findfirst(==(parse(Int, idx)), all_indices)
            df[row_idx, col_name] = value
        end
    end

    for col_name in names(df)
        first_non_missing = findfirst(x -> !ismissing(x), df[!, col_name])
        if !isnothing(first_non_missing)
            target_type = typeof(df[first_non_missing, col_name])
            df[!, col_name] = convert(Vector{target_type}, df[!, col_name])
        end
    end

    select!(df, Not(:index))

    return df
end

end #module
