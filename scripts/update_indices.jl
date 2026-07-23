using Downloads: Downloads
using JSON: parsefile
using SpectralIndices

const INDICES_URL = "https://raw.githubusercontent.com/awesome-spectral-indices/awesome-spectral-indices/main/output/spectral-indices-dict.json"
const ROOT = normpath(joinpath(@__DIR__, ".."))
const INDICES_FILE = joinpath(ROOT, "data", "spectral-indices-dict.json")
const FUNCTIONS_FILE = joinpath(ROOT, "src", "indices_funcs.jl")
const PROJECT_FILE = joinpath(ROOT, "Project.toml")

function bumped_project(contents)
    version_match = match(r"(?m)^version = \"(\d+)\.(\d+)\.(\d+)\"$", contents)
    isnothing(version_match) &&
        error("Could not find a semantic package version in Project.toml")

    major, minor, patch = parse.(Int, version_match.captures)
    old_version = "$(major).$(minor).$(patch)"
    new_version = "$(major).$(minor).$(patch + 1)"
    updated = replace(
        contents,
        version_match.match => "version = \"$new_version\"";
        count=1
    )
    return updated, old_version, new_version
end

function validate_catalogue(path)
    catalogue = parsefile(
        path;
        null=missing,
        allownan=true,
        dicttype=Dict{String, Any}
    )
    haskey(catalogue, "SpectralIndices") ||
        error("Downloaded catalogue has no `SpectralIndices` object")

    index_dict = catalogue["SpectralIndices"]
    index_dict isa Dict{String, Any} ||
        error("Downloaded `SpectralIndices` entry is not an object")
    isempty(index_dict) && error("Downloaded catalogue contains no spectral indices")

    short_names = Set{String}()
    for (name, index) in index_dict
        index isa Dict{String, Any} || error("Index `$name` is not an object")
        for field in ("short_name", "formula", "bands")
            haskey(index, field) || error("Index `$name` has no `$field` field")
        end
        index["short_name"] isa String ||
            error("Index `$name` has a non-string `short_name`")
        index["formula"] isa String || error("Index `$name` has a non-string `formula`")
        index["bands"] isa Vector ||
            error("Index `$name` has a non-array `bands` field")
        all(band -> band isa String, index["bands"]) ||
            error("Index `$name` contains a non-string band")
        index["short_name"] in short_names &&
            error("Duplicate short name `$(index["short_name"])`")
        push!(short_names, index["short_name"])
    end

    return index_dict
end

function update_indices()
    mktempdir() do staging_dir
        downloaded_file = joinpath(staging_dir, basename(INDICES_FILE))
        generated_file = joinpath(staging_dir, basename(FUNCTIONS_FILE))
        Downloads.download(INDICES_URL, downloaded_file)
        index_dict = validate_catalogue(downloaded_file)

        if read(downloaded_file) == read(INDICES_FILE)
            println("The bundled spectral-index catalogue is already current.")
            return false
        end

        SpectralIndices.create_indexfun(index_dict; fileloc=generated_file)
        Meta.parseall(read(generated_file, String))
        updated_project, old_version,
        new_version = bumped_project(
            read(PROJECT_FILE, String),
        )

        cp(downloaded_file, INDICES_FILE; force=true)
        cp(generated_file, FUNCTIONS_FILE; force=true)
        write(PROJECT_FILE, updated_project)

        println("Updated the spectral-index catalogue and regenerated index functions.")
        println("Bumped the package version from $old_version to $new_version.")
        return true
    end
end

if abspath(PROGRAM_FILE) == @__FILE__
    update_indices()
end
