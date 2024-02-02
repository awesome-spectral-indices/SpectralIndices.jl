using SpectralIndices

# Test correctness
@test SpectralIndices._load_json("spectral-indices-dict.json") isa Dict
# Test missing
@test_throws ErrorException SpectralIndices._load_json("non_existing_file.json")

# Test offline
@test SpectralIndices._get_indices() isa Dict
# Test online
@testset "Download Indices Test" begin
    test_dir = mktempdir()
    try
        # Define the file location within the test directory
        test_fileloc = joinpath(test_dir, "spectral-indices-dict.json")

        # Run the _get_indices function with online = true
        indices = SpectralIndices._get_indices(true; fileloc=test_fileloc)

        # Test if the file was downloaded and parsed successfully
        @test isfile(test_fileloc)
        @test !isempty(indices)
        @test indices isa Dict

    finally
        # Clean up: Delete the test file and directory
        rm(test_dir; recursive=true)
    end
end

@testset "Download Datasets Test" begin
    temp_dir = mktempdir() # Temporary directory for testing
    try
        expected_files = ["test_S2_10m.json", "test_spectral.json"]
        get_datasets(; datasets=expected_files, data_loc=temp_dir)
        for expected_file in expected_files
            @test isfile(joinpath(temp_dir, expected_file))
        end

    finally
        rm(temp_dir; recursive=true) # Clean up
    end
end

params = Dict("N" => 0.6, "R" => 0.3)
# Test correctness
@test SpectralIndices._check_params(NDVI, params) === nothing
# Test missing
@test_throws ArgumentError SpectralIndices._check_params(NDVI, Dict("N" => 0.6))

locals = Dict("x" => 2, "y" => 3)
expression = "x + y"

# Test correct evaluation
@test SpectralIndices.parse_eval_dict(expression, locals) == 5

name = "test_func"
expr = :(x + y)
args = (:x, :y)

# Create a test function
test_func = SpectralIndices._build_function(name, expr, args...)

# Test the created function
@test test_func(2, 3) == 5
