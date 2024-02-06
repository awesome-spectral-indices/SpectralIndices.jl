# YAXArrays.jl

This tutorial will illustrate how to use SpectralIndices.jl using YAXArrays.jl as input data.

First of all we need to download the data like in the previous tutorial. Only this time the data is going to be higher dimensional and slighly more complex, hence the need for YAXArrays.jl. In order to do so we are going to use the `load_dataset` function:

```@example yaxarrays
using YAXArrays, DimensionalData
using SpectralIndices
yaxa = load_dataset("sentinel", YAXArray)
```

As it is possible to observe we have a `YAXArray` object with three dimensions: `bands`, `x` and `y`. Each band is one of the 10 m spectral bands of a Sentinel-2 image.

The data is stored as `Int64`, so let us convert it to `Float` and rescale it:

```@example yaxarrays
yaxa = yaxa./10000
```

Now let's compute the NDVI for this dataset!

```@example yaxarrays
ndvi = compute_index("NDVI";
    N=yaxa[bands = At("B08")],
    R=yaxa[bands = At("B04")])
```

As usual we can also just feed a properly constructed `YAXArray` to the `compute_index` function. Let's built the array:

```@example yaxarrays
index_R = findfirst(yaxa.bands.val .== "B04")
index_N = findfirst(yaxa.bands.val .== "B08")
new_bands_dim = Dim{:Variables}(["R", "N"])

nr_data = cat(yaxa[:, :, index_R], yaxa[:, :, index_N], dims=3)
new_yaxa = YAXArray((yaxa.x, yaxa.y, new_bands_dim), nr_data)
```

!!!warn Please notice how the `Dim` is called `Variables`. This is needed for the internal computation to work properly.

Now that we have our `YAXArray` with the correctly names `Dim`s we can use it direcly into `compute_index`:

```@example yaxarrays
ndvi = compute_index(
    "NDVI", new_yaxa
)
```

## Computing Kernels for kNDVI

We want to compute the kNDVI for a `YAXArray`. 

```@example yaxarrays
kNDVI
```

As we see from `bands` we need the `kNN` and `kNR`. In order to compute these values SpectralIndices.jl provides a `compute_kernel` function. If you are curious about the `kNDVI` remember that you always have the source of the index in the `reference` field:

```@example yaxarrays
kNDVI.reference
```

Onto the calculations:

```@example yaxarrays
knn = YAXArray((yaxa.x, yaxa.y), fill(1.0, 300, 300))
knr = compute_kernel(
    RBF;
    a = Float64.(yaxa[bands = At("B08")]),
    b = Float64.(yaxa[bands = At("B04")]),
    sigma = yaxa[bands = At("B08")].+yaxa[bands = At("B04")] ./ 2
)
```

As always, you can decide to build an `YAXArray` and feed that to the `compute_kernel` function if you prefer:

```@example yaxarrays
a = Float64.(yaxa[bands = At("B08")])
b = Float64.(yaxa[bands = At("B04")])
sigma = yaxa[bands = At("B08")].+yaxa[bands = At("B04")] ./ 2
kernel_dims = Dim{:Variables}(["a", "b", "sigma"])

params = concatenatecubes([a, b, sigma], kernel_dims)

knr = compute_kernel(RBF, params)
```

We can finally compute the kNDVI:

```@example yaxarrays
kndvi = compute_index("kNDVI"; kNN = knn, kNR=knr)
```