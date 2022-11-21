"""
"""
function open(dataset::String)
    datasets = Dict("sentinel" => "S2_10m.json", "spectral" => "spectral.json")
    dataset in keys(datasets) ? nothing : error("Dataset name not valid. Datasets available: sentinel and spectral")

    ds = _load_json(datasets[dataset])
    #TODO: finish conversion to array or dataset
end
