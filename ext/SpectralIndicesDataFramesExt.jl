module SpectralIndicesDataFramesExt

using SpectralIndices
using DataFrames

function SpectralIndices._create_params(kw_args::Pair{Symbol,DataFrame}...)
    dfs = [pair.second for pair in kw_args]
    params = hcat(dfs...)
    return params
end

function SpectralIndices.compute_index(
    index::String, params::DataFrame; indices=SpectralIndices._create_indices()
)
    # Convert DataFrame to a dictionary for each row and compute the index
    results = [
        compute_index(index, Dict(zip(names(params), row)); indices=indices) for
        row in eachrow(params)
    ]

    # Return the results as a DataFrame with the column named after the index
    return DataFrame(Symbol(index) => results)
end

function SpectralIndices.compute_index(
    index::Vector{String}, params::DataFrame; indices=SpectralIndices._create_indices()
)
    # Similar conversion and computation for a vector of indices
    result_dfs = DataFrame()
    for idx in index
        result_df = compute_index(idx, params; indices=indices)
        result_dfs[!, Symbol(idx)] = result_df[!, 1]
    end

    # Return the combined DataFrame with columns named after each index
    return result_dfs
end

function SpectralIndices.linear(params::DataFrame)
    result = linear(params[!, "a"], params[!, "b"])
    result_df = DataFrame(; linear=result)
    return result_df
end

function SpectralIndices.poly(params::DataFrame)
    result = poly(params[!, "a"], params[!, "b"], params[!, "c"], params[!, "p"])
    result_df = DataFrame(; poly=result)
    return result_df
end

function SpectralIndices.RBF(params::DataFrame)
    result = RBF(params[!, "a"], params[!, "b"], params[!, "sigma"])
    result_df = DataFrame(; RBF=result)
    return result_df
end

function SpectralIndices.load_dataset(dataset::String, ::Type{T}=DataFrame) where {T<:DataFrame}
    datasets = Dict("sentinel" => "S2_10m.json", "spectral" => "spectral.json")

    if dataset in keys(datasets)
        nothing
    else
        error("Dataset name not valid. Datasets available: sentinel and spectral")
    end

    ds = SpectralIndices._load_json(datasets[dataset])
    all_indices = Set{Int}()
    for val in values(ds)
        for idx in keys(val)
            push!(all_indices, parse(Int, idx))
        end
    end
    all_indices = sort(collect(all_indices)) # Convert to sorted list
    
    # Prepare a DataFrame with a specific row for each unique index
    df = DataFrame(index = all_indices)
    
    # Initialize columns based on the keys in `ds`
    for col_name in keys(ds)
        df[!, col_name] = Vector{Union{Missing, Any}}(missing, length(all_indices))
    end

    # Populate the DataFrame with actual values
    for (col_name, col_data) in ds
        for (idx, value) in col_data
            row_idx = findfirst(==(parse(Int, idx)), all_indices)
            df[row_idx, col_name] = value
        end
    end

    # Optionally, remove the index column if it's not needed
    select!(df, Not(:index))

    return df
end

end #module
