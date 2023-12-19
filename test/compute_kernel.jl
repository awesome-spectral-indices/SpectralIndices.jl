using SpectralIndices
using DataFrames
using YAXArrays

# define data structures
# Number
a, b, c, p, sigma = 2, 3, 1, 2, 5

# Array
a_v, b_v, c_v, p_v, sigma_v = [1, 2, 3], [4, 5, 6], [1, 1, 1], [2, 2, 2], [5, 5, 5]

# Dataframe
df = DataFrame(; a=[1, 2], b=[3, 4], c=[1, 1], p=[2, 2], sigma=[5, 5])

# YAXArray
axes = (Dim{:Lon}(1:5), Dim{:Lat}(1:5), Dim{:Time}(1:10))
a_yaxa = fill(0.643, (5, 5, 10))
b_yaxa = fill(0.175, (5, 5, 10))
c_yaxa = fill(0.5, (5, 5, 10))
p_yaxa = fill(0.5, (5, 5, 10))
sigma_yaxa = fill(0.5, (5, 5, 10))

ads = YAXArray(axes, a_yaxa)
bds = YAXArray(axes, b_yaxa)
cds = YAXArray(axes, c_yaxa)
pds = YAXArray(axes, p_yaxa)
sigmads = YAXArray(axes, sigma_yaxa)

yaxa = concatenatecubes(
    [ads, bds, cds, pds, sigmads], Dim{:Variables}(["a", "b", "c", "p", "sigma"])
)

# testing
@testset "Tests for linear function" begin
    # Test with numbers
    @test linear(a, b) == 6

    # Test with arrays
    @test all(linear(a_v, b_v) .== [4, 10, 18])

    # test with dataframes
    @test eachcol(linear(df)) == eachcol(DataFrame(; linear=[3, 8]))

    # test with yaxarrays
    @test all(linear(yaxa) .== YAXArray(axes, fill(0.112525, 5, 5, 10)))
end

@testset "Tests for poly function" begin
    # Test with numbers
    @test poly(a, b, c, p) == 49

    # Test with arrays
    expected_result = [(1 * 4 + 1)^2, (2 * 5 + 1)^2, (3 * 6 + 1)^2]
    @test all(poly(a_v, b_v, c_v, p_v) .== expected_result)

    # test with dataframes
    df_expected = DataFrame(; poly=[(1 * 3 + 1)^2, (2 * 4 + 1)^2])
    @test eachcol(poly(df)) == eachcol(df_expected)

    # Test with yaxarrays
    yaxa_expected = fill((0.643 * 0.175 + 0.5)^0.5, (5, 5, 10))
    @test all(poly(yaxa) .== YAXArray(axes, yaxa_expected))
end

@testset "Tests for RBF function" begin
    # Test with numbers
    expected_number_result = exp((-1.0 * (a - b)^2.0) / (2.0 * sigma^2.0))
    @test RBF(a, b, sigma) ≈ expected_number_result

    # Test with arrays
    expected_array_result =
        exp.((-1.0 .* ((a_v .- b_v) .^ 2.0)) ./ (2.0 .* (sigma_v .^ 2.0)))
    @test all(RBF(a_v, b_v, sigma_v) .≈ expected_array_result)

    # Test with dataframes
    df_expected = DataFrame(;
        RBF=exp.((-1.0 .* ((df.a .- df.b) .^ 2.0)) ./ (2.0 .* (df.sigma .^ 2.0)))
    )
    @test eachcol(RBF(df)) == eachcol(df_expected)

    # Test with yaxarrays
    yaxa_expected =
        exp.((-1.0 .* ((a_yaxa .- b_yaxa) .^ 2.0)) ./ (2.0 .* (sigma_yaxa .^ 2.0)))
    @test all(RBF(yaxa) .== YAXArray(axes, yaxa_expected))
end
