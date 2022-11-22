"""
gets the indices from spyndex
"""
function get_dataset()
    filedest_sentinel = joinpath(dirname(@__FILE__), "..", "data", "S2_10m.json")
    filedest_spectral = joinpath(dirname(@__FILE__), "..", "data", "spectral.json")
    Downloads.download("https://raw.githubusercontent.com/awesome-spectral-indices/spyndex/main/spyndex/data/S2_10m.json", filedest_sentinel)
    Downloads.download("https://raw.githubusercontent.com/awesome-spectral-indices/spyndex/main/spyndex/data/spectral.json", filedest_spectral)
end

"""
"""
function open(dataset::String)
    datasets = Dict("sentinel" => "S2_10m.json", "spectral" => "spectral.json")
    dataset in keys(datasets) ? nothing : error("Dataset name not valid. Datasets available: sentinel and spectral")

    ds = _load_json(datasets[dataset])
    #TODO: finish conversion to array or dataset
end
