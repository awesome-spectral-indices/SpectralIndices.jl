# Built-in types

This guide provides a comprehensive overview of utilizing SpectralIndices.jl with Julia's built-in types and data structures. By exploring these foundational elements, you'll gain valuable insights into the package's functionality and its application in calculating spectral indices like NDVI and SAVI.

## Introduction to Indices Calculation

Let's begin with an example involving two data points representing the near-infrared (NIR) and red reflectances of vegetation, stored as `Int` values:

```@example basic
nir = 6723
red = 1243
```

Our goal is to calculate the Normalized Difference Vegetation Index (NDVI). NDVI is a widely used spectral index for monitoring vegetation health, calculated using NIR and red reflectances. The formula for NDVI is:

```math
NDVI = \frac{NIR-Red}{NIR+Red}
```

### Direct Calculation with NDVI Struct

SpectralIndices.jl provides a straightforward method for computing NDVI:

```@example basic
using SpectralIndices
NDVI
```

This outputs the NDVI struct, containing all necessary information. The struct can also be used as a function to compute NDVI:

```@example basic
NDVI(Float64, nir, red)
```

This method is direct but not the recommended approach for computing indices. When using this method, ensure the parameter order matches the `bands` field of the `SpectralIndex`:

```@example basic
NDVI.bands
```

### Using the `compute` Function


A more flexible way to calculate indices is through the `compute` function. This function accepts the `SpectralIndex` struct and parameters as either a dictionary or keyword arguments:

```@example basic
params = Dict(
    "N" => nir,
    "R" => red
)
ndvi = compute(NDVI, params)
```

!!! warn Please ensure dictionary keys match the band names specified in the `bands` field.

Additionally you can pass the values as kwargs as follows:

```@example basic
ndvi = compute(NDVI; N=nir, R=red)
```

Order of keyword arguments does not affect the outcome:

```@example basic
ndvi1 = compute(NDVI; N=nir, R=red)
ndvi2 = compute(NDVI; R=red, N=nir)
ndvi1 == ndvi2
```

### Using `compute_index`

Lastly, you can use `compute_index` to compute it. The precedure is identical to what has been shown so far for `compute`, but the specification of the index is done by passing its name in a `String`:

```@example basic
params = Dict(
    "N" => nir,
    "R" => red
)
ndvi = compute_index("NDVI", params)
```

Or, using the kwargs:

```@example basic
ndvi = compute_index("NDVI"; N=nir, R=red)
```

## Handling Floats

For `Float`s the procedure is similar. We will illustrate the example with the `SAVI` index

```@example basic
SAVI
```

This index needs the following bands:

```@example basic
SAVI.bands
```

The `L` parameter is new in this example. Thankfully, SpectralIndices.jl provides a list of constant values handy that we can leverage in this situation:

```@example basic
constants["L"]
```

So now that we know what `L` is or does, we can use it in our calculation of the SAVI index. But first we are going to redefine the values to be `Float`s since we want to showcase some properties of SpectralIndices.jl with that data type. Additionally, SAVI needs imput values to be between -1 and 1:

```@example basic
nir /= 10000
red /= 10000
```

Now we can proceed as before. Either using a `Dict` to built our parameters:

```@example basic
params = Dict(
    "N" => nir,
    "R" => red,
    "L" => 0.5
)
savi = compute(SAVI, params)
```

or by passing them as kwargs:

```@example basic
savi = compute(SAVI; N=nir, R=red, L=0.5)
```

And the same holds true for `compute_index` as well:

```@example basic
params = Dict(
    "N" => nir,
    "R" => red,
    "L" => 0.5
)
savi = compute_index("SAVI", params)
```

```@example basic
savi = compute_index("SAVI"; N=nir, R=red, L=0.5)
```

## Float32, Float16
The package can compute indices at custom precision

```@example basic
T = Float32
savi = compute_index(T, "SAVI"; N=T(nir), R=T(red), L=T(0.5))
```
```@example basic
T = Float16
savi = compute_index(T, "SAVI"; N=T(nir), R=T(red), L=T(0.5))
```

## Computing Multiple Indices

Now that we have added more indices we can explore how to compute multiple indices at the same time. All is needed is to pass a Vector of `String`s to the `compute_index` function with the chosen spectral indices inside, as well as the chosen parameters of course:

```@example basic
params = Dict(
    "N" => nir,
    "R" => red,
    "L" => 0.5
)
ndvi, savi = compute_index(["NDVI", "SAVI"], params)
```

Alternatively, using kwargs:

```@example basic
ndvi, savi = compute_index(["NDVI", "SAVI"]; N=nir, R=red, L=0.5)
```

## Extension to Vectors

The extension to `Vector`s is relatively straightforward. We follow the same procedure as before, defining our parameters, only this time they are arrays:

```@example basic
params = Dict(
    "N" => fill(nir, 10),
    "R" => fill(red, 10),
    "L" => fill(0.5, 10)
)
```

After that we can compute either one, or both indices:

```@example basic
ndvi, savi = compute_index(["NDVI", "SAVI"], params)
```

We can use the same params to calculate single indices. The additional bands are just going to be ignored:

```@example basic
ndvi = compute_index("NDVI", params)
```
```@example basic
savi = compute_index("SAVI", params)
```

And as always, we can also pass them as kwargs:

```@example basic
ndvi, savi = compute_index(["NDVI", "SAVI"];
    N=fill(nir, 10),
    R=fill(red, 10),
    L=fill(0.5, 10))
```
```@example basic
ndvi = compute_index("NDVI";
    N=fill(nir, 10),
    R=fill(red, 10),
    L=fill(0.5, 10))
```
```@example basic
savi = compute_index("SAVI";
    N=fill(nir, 10),
    R=fill(red, 10),
    L=fill(0.5, 10))
```

## Extension to NamedTuples

SpectralIndices.jl allows you to also create indices from `NamedTuples`:

```@example basic
params = (N=fill(0.2, 10), R=fill(0.1, 10), L=fill(0.5, 10))
compute_index("NDVI", params)
```
```@example basic
compute_index(["NDVI", "SAVI"], params)
```

You can also pass the `NamedTuple` as kwargs splatting them, but the output will not be a `NamedTuple`

```@example basic
compute_index("NDVI"; params...)
```
```@example basic
compute_index(["NDVI", "SAVI"]; params...)
```