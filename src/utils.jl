"""
```julia
_get_indices(online=false)
```
Retrieves the JSON of indices.

Parameters
----------
online : boolean
    Wheter to retrieve the most recent list of indices directly from the GitHub
    repository and not from the local copy.
Returns
-------
dict
    Indices.
"""
function _get_indices(online=false)
    if online
        indices_loc = Downloads.download(
            "https://raw.githubusercontent.com/awesome-spectral-indices/awesome-spectral-indices/main/output/spectral-indices-dict.json", string(pwd(),  )
            )
        indices = JSON.parsefile(indices_loc)
    else
        indices = _load_json()
    end

    return indices["SpectralIndices"]
end

"""
```julia
_load_json(file="spectral-indices-dict.json")
```
Loads the specified JSON file from the data folder.
Parameters
----------
file : str
    File name.
Returns
-------
object
    JSON file.
"""
function _load_json(file="spectral-indices-dict.json")
    filename = joinpath(dirname(@__FILE__), "..", "data", "spectral-indices-dict.json")
    JSON.parsefile(filename)
end
