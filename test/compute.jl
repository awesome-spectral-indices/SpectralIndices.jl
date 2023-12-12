using SpectralIndices

expected_ndvi_value_f64 = 0.5721271393643031
expected_savi_value_f64 = 0.5326251896813354

# Basics
@test compute_index("NDVI"; N=0.643, R=0.175) == expected_ndvi_value_f64
# Type handling
@test compute_index("NDVI"; N=fill(0.643, 5), R=fill(0.175, 5)) isa Array
# Corner cases
#@test compute_index("NDVI"; N=0.0, R=0.0) == NaN
#Input validation
@test_throws AssertionError compute_index("InvalidIndex"; N=0.5, R=0.5)
# Multiple indices
results = compute_index(["NDVI", "SAVI"]; N=0.643, R=0.175, L=0.5)
@test length(results) == 2
@test results[1] == expected_ndvi_value_f64 # Replace with correct value
@test results[2] == expected_savi_value_f64 # Replace with correct value
