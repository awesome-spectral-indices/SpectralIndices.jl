using SpectralIndices
using DataFrames
using YAXArrays

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
@test results[1] == expected_ndvi_value_f64
@test results[2] == expected_savi_value_f64

# test dataframes
# single index
df_single = DataFrame(; N=[0.643, 0.56], R=[0.175, 0.22])
result_single = compute_index("NDVI", df_single)
@test size(result_single, 1) == 2
@test size(result_single, 2) == 1
@test names(result_single) == ["NDVI"]

# multiple indices
df_multiple = DataFrame(; N=[0.643, 0.56], R=[0.175, 0.22], L=[0.5, 0.4])
result_multiple = compute_index(["NDVI", "SAVI"], df_multiple)
@test size(result_multiple, 1) == 2
@test size(result_multiple, 2) == 2
@test names(result_multiple) == ["NDVI", "SAVI"]

# test Yaxarrays
axes = (Dim{:Lon}(1:5), Dim{:Lat}(1:5), Dim{:Time}(1:10))
N_data = fill(0.643, (5, 5, 10))
R_data = fill(0.175, (5, 5, 10))
L_data = fill(0.5, (5, 5, 10))

nds = YAXArray((Dim{:Lon}(1:5), Dim{:Lat}(1:5), Dim{:Time}(1:10)),N_data)
rds = YAXArray((Dim{:Lon}(1:5), Dim{:Lat}(1:5), Dim{:Time}(1:10)),R_data)

lds = YAXArray(
    (Dim{:Lon}(1:5), Dim{:Lat}(1:5), Dim{:Time}(1:10)),
    L_data
)

nr_ds = concatenatecubes([nds, rds], Dim{:Variables}(["N", "R"]))
# single index
# as params
result_yaxa_single = compute_index("NDVI", nr_ds)
@test size(result_yaxa_single) == size(rds) == size(nds)
# as kwargs
result_yaxa_single2 = compute_index("NDVI"; N=nds, R=rds)
@test size(result_yaxa_single2) == size(rds) == size(nds)
@test result_yaxa_single == result_yaxa_single2