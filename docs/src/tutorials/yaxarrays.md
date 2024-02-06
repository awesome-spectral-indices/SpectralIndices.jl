# YAXArrays.jl

This tutorial will illustrate how to use SpectralIndices.jl using YAXArrays.jl as input data.

First of all we need to download the data like in the previous tutorial. Only this time the data is going to be higher dimensional and slighly more complex, hence the need for YAXArrays.jl. In order to do so we are going to use the `load_dataset` function:

```@example yaxarrays
using YAXArrays, DimensionalData
using SpectralIndices
yaxa = load_dataset("sentinel")
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

