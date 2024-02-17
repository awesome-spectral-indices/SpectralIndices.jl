function custom_key_combinations(dict::Dict{String,SpectralIndices.AbstractSpectralIndex},
    combo_size::Int,
    num_combos::Int
)
    keys_list = collect(keys(dict))
    all_combos = combinations(keys_list, combo_size)
    selected_combos = sample(collect(all_combos), num_combos, replace=false)
    return selected_combos
end

function convert_to_kwargs(yaxarr::YAXArray)
    var_names = lookup(yaxarr, :Variables)
    kwargs = [(Symbol(var_name) => yaxarr[Variable=At(var_name)]) for var_name in var_names]
    return kwargs
end

function convert_to_kwargs(df::DataFrame)
    kwargs = [(Symbol(band) => DataFrame(band => df[:, band])) for band in names(df)]
    return kwargs
end