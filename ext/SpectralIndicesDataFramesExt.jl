module SpectralIndicesDataFramesExt

using SpectralIndices
using DataFrames

function SpectralIndices._create_params(kw_args::Pair{Symbol,DataFrame}...)
    combined_df = DataFrame()

    for pair in kw_args
        df = copy(pair.second)
        rename!(df, names(df) .=> Symbol.(pair.first))
        combined_df = hcat(combined_df, df; makeunique=true)
    end
    return combined_df
end

function SpectralIndices.compute_index(
    ::Type{T}, index::String, params::DataFrame; indices=SpectralIndices._create_indices()
) where {T<:Number}
    # Convert DataFrame to a dictionary for each row and compute the index
    results = [
        SpectralIndices.compute_index(
            T, index, Dict(zip(names(params), row)); indices=indices
        ) for row in eachrow(params)
    ]

    # Return the results as a DataFrame with the column named after the index
    return DataFrame(Symbol(index) => results)
end

function SpectralIndices.compute_index(
    index::String, params::DataFrame; indices=SpectralIndices._create_indices()
)
    return SpectralIndices.compute_index(Float64, index, params; indices=indices)
end

function SpectralIndices.compute_index(
    ::Type{T},
    index::Vector{String},
    params::DataFrame;
    indices=SpectralIndices._create_indices(),
) where {T<:Number}
    # Similar conversion and computation for a vector of indices
    result_dfs = DataFrame()
    for idx in index
        result_df = SpectralIndices.compute_index(T, idx, params; indices=indices)
        result_dfs[!, Symbol(idx)] = result_df[!, 1]
    end
    # Return the combined DataFrame with columns named after each index
    return result_dfs
end

function SpectralIndices.compute_index(
    index::Vector{String}, params::DataFrame; indices=SpectralIndices._create_indices()
)
    return SpectralIndices.compute_index(Float64, index, params; indices=indices)
end

function SpectralIndices.linear(::Type{T}, params::DataFrame) where {T<:Number}
    result = linear(T, params[!, "a"], params[!, "b"])
    result_df = DataFrame(; linear=result)
    return result_df
end

function SpectralIndices.linear(params::DataFrame)
    return linear(Float64, params)
end

function SpectralIndices.poly(::Type{T}, params::DataFrame) where {T<:Number}
    result = poly(T, params[!, "a"], params[!, "b"], params[!, "c"], params[!, "p"])
    result_df = DataFrame(; poly=result)
    return result_df
end

function SpectralIndices.poly(params::DataFrame)
    return poly(Float64, params)
end

function SpectralIndices.RBF(::Type{T}, params::DataFrame) where {T<:Number}
    result = RBF(T, params[!, "a"], params[!, "b"], params[!, "sigma"])
    result_df = DataFrame(; RBF=result)
    return result_df
end

function SpectralIndices.RBF(params::DataFrame)
    return RBF(Float64, params)
end

function SpectralIndices.load_dataset(dataset::String, ::Type{T}) where {T<:DataFrame}
    datasets = Dict("spectral" => "spectral.json")

    if dataset in keys(datasets)
        nothing
    else
        error("Dataset name not valid. Datasets available for DataFrames: spectral")
    end

    ds = SpectralIndices._load_json(datasets[dataset])
    all_indices = Set{Int}()
    for val in values(ds)
        for idx in keys(val)
            push!(all_indices, parse(Int, idx))
        end
    end
    all_indices = sort(collect(all_indices))
    df = DataFrame(; index=all_indices)

    for col_name in keys(ds)
        df[!, col_name] = Vector{Union{Missing,Any}}(missing, length(all_indices))
    end

    for (col_name, col_data) in ds
        for (idx, value) in col_data
            row_idx = findfirst(==(parse(Int, idx)), all_indices)
            df[row_idx, col_name] = value
        end
    end

    select!(df, Not(:index))

    return df
end

end #module
