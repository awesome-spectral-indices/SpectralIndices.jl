"""
```julia
_get_indices(online::Bool = false)
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
function _get_indices(online::Bool = false)
    if online
        indices_loc = Downloads.download(
            "https://raw.githubusercontent.com/awesome-spectral-indices/awesome-spectral-indices/main/output/spectral-indices-dict.json", string(pwd(),  "spectral-indices-dict.json")
            )
        indices = JSON.parsefile(indices_loc)
    else
        indices = _load_json()
    end

    return indices["SpectralIndices"]
end

"""
```julia
_load_json(file::String = "spectral-indices-dict.json")
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
function _load_json(filename::String = "spectral-indices-dict.json")
    fileloc = joinpath(dirname(@__FILE__), "..", "data", filename)
    if isfile(fileloc)
        return JSON.parsefile(fileloc)
    else
        error("The JSON file is not in the SpectralIndices/data folder")
    end
end

"""
```
_check_params(index, params, indices)
```
Checks if the parameters dictionary contains all required bands for the index
computation.
Parameters
----------
index : str
    Index to check.
params : dict
    Parameters dictionary to check.
indices : dict
    Indices dictionary to check.
Returns
-------
None
"""
function _check_params(index, params, indices)

end