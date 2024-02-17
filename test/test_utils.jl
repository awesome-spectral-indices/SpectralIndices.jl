function custom_key_combinations(dict::Dict{String,SpectralIndices.AbstractSpectralIndex},
    combo_size::Int,
    num_combos::Int
)
    keys_list = collect(keys(dict))
    all_combos = combinations(keys_list, combo_size)
    selected_combos = sample(collect(all_combos), num_combos, replace=false)
    return selected_combos
end
