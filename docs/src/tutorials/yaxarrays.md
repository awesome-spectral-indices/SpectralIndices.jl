## YAXArrays.jl

This tutorial will illustrate how to use SpectralIndices.jl using YAXArrays.jl as input data.

First we need to download the data, like in the previous tutorial. Only this time the data is going to be higher dimensional and slightly more complex, hence the need for YAXArrays.jl. In order to do so we are going to use the `load_dataset` function:

```@example yaxarrays
using YAXArrays, DimensionalData
using SpectralIndices
```

```@ansi yaxarrays
yaxa = load_dataset("sentinel", YAXArray)
```

As it is possible to observe we have a `YAXArray` object with three dimensions: `bands`, `x` and `y`. Each band is one of the 10 m spectral bands of a Sentinel-2 image.

The data is stored as `Int64`, so let us convert it to `Float` and rescale it:

```@ansi yaxarrays
yaxa = yaxa./10000
```

Now let's compute the NDVI for this dataset!

First, let's define the bands to be used:
```@example yaxarrays
b8 = yaxa[bands = At("B08")]
b4 = yaxa[bands = At("B04")]
nothing # hide
```

now, let's compute the index

```@ansi yaxarrays
ndvi_compute = compute_index("NDVI"; N=b8, R=b4)
```

### map

Due to the `type` design, in order to use `map` we will use the `PartialFunctions` package to specify the first initial `type` on each function, namely

```@example yaxarrays
using PartialFunctions
ndvi_p = NDVI.compute $Float64
```
now, we can compute the index

```@ansi yaxarrays
ndvi_map = map(ndvi_p, b8, b4)
```
Let's check that we have the same output:

```@example yaxarrays
ndvi_compute.data == ndvi_map.data
```

### mapCube
For out of memory calculations then using `mapCube` is the way to go. This can be implemented as follows. First, we wrap our function of interest into a function compatible with `mapCube`, namely

```@example yaxarrays
function ndvi_out(xout, x1, x2)
    xout .= NDVI.(Float64, x1, x2) # note the .
end
```
next, define the input and output dimensions of your `YAXArray`'s.
```@example yaxarrays
in_dims = InDims("x") # the second one will be inferred
out_dims = OutDims("x") # dito
nothing # hide
```

```@ansi yaxarrays
ndvi_cube = mapCube(ndvi_out, (b8, b4), indims=(in_dims, in_dims),
    outdims=OutDims("x", outtype=Float64))
```

and we check again the data output matches

```@example yaxarrays
ndvi_compute.data == ndvi_cube.data
```

## compute index by named dims

As usual we can also just feed a properly constructed `YAXArray` to the `compute_index` function. Let's built the array:

```@example yaxarrays
index_R = findfirst(yaxa.bands.val .== "B04")
index_N = findfirst(yaxa.bands.val .== "B08")
new_bands_dim = Dim{:Variables}(["R", "N"])

nr_data = cat(yaxa[:, :, index_R], yaxa[:, :, index_N], dims=3)
nothing # hide
```
```@ansi yaxarrays
new_yaxa = YAXArray((yaxa.x, yaxa.y, new_bands_dim), nr_data)
```

!!! warning
    Please notice how the `Dim` is called `Variables`. This is needed for the internal computation to work properly. Also, note that this does not work for out of memory datasets.

Now that we have our `YAXArray` with the correctly names `Dim`s we can use it direcly into `compute_index`:

```@ansi yaxarrays
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

```@ansi yaxarrays
knn = YAXArray((yaxa.x, yaxa.y), fill(1.0, 300, 300));
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
nothing # hide
```

```@ansi yaxarrays
knr = compute_kernel(RBF, params)
```

We can finally compute the kNDVI:

```@ansi yaxarrays
kndvi = compute_index("kNDVI"; kNN = knn, kNR=knr)
```

Let's plot it!

```@example yaxarrays
using CairoMakie
fig, ax, plt = heatmap(kndvi; colormap=:haline,
    axis = (; aspect=DataAspect()),
    figure = (; size=(600, 400)))
Colorbar(fig[1,2], plt)
colsize!(fig.layout, 1, Aspect(1, 1.0))
fig
```