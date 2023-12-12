using SpectralIndices

# Test correctness
@test SpectralIndices._load_json("spectral-indices-dict.json") isa Dict
# Test missing
@test_throws ErrorException SpectralIndices._load_json("non_existing_file.json")

# Test offline
@test SpectralIndices._get_indices() isa Dict
# Test online
@test SpectralIndices._get_indices(true) isa Dict

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
