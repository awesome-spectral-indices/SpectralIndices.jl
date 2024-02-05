# Built-in types

This tutorial is a showcase of the basic use of SpectralIndices.jl. It shows how to use the package on the built-in types and data structures in Julia. This will help gain a basic understanding of the inner workings of the package.

## Int

Suppose we have two data points, for near infrared and red reflectances of vegetation, represented by and `Int`:

```@example basic
nir = 6723
red = 1243
```

We want to try and compute the NDVI. There are different ways to do this. First let us explore what the NDVI is. This can be simply done by calling it directly:

```@example basic
using SpectralIndices
NDVI
```

As you can see, we have all the information we need in the struct. Furthermore, the struct also acts as a function, actually computing the NDVI:

```@example basic
NDVI(nir, red)
```

This is not a suggested way for computing indices, but it is still possible to do it. The order of the parameters follows the order in which they appear in the `bands` field of the `SpectralIndex`. In this case:

```@example basic
NDVI.bands
```

we first need to pass the nir band and then the red band, as we did. 

The second way is to use the `compute` function. This function takes as input the `SpectralIndex` struct itself and either a `Dict` of the parameters to be computed, or kwargs of them. We will axplore both possibilities.

```@example basic
params = Dict(
    "N" => nir,
    "R" => red
)
ndvi = compute(NDVI, params)
```

Please be careful: the keys in the dict *must* be the same name of the bands as the one that is spelled out in `bands`. 

Additionally you can pass the values as kwargs as follows:

```@example basic
ndvi = compute(NDVI; N=nir, R=red)
```

Note that for kwargs the position does not matter:

```@example basic
ndvi1 = compute(NDVI; N=nir, R=red)
ndvi2 = compute(NDVI; R=red, N=nir)
ndvi1 == ndvi2
```

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

## Float

For `Float`s the procedure is similar. We will illustrate the example with the `SAVI` index

```@example basic
SAVI
```

This index needs the following bands:

```@example basic
SAVI.bands
```

The `L` parameter is new in this example. Thankfully SpectralIndices.jl provides a list of constant values handy that we can leverage in this situation:

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


In both examples we see that the returned value is a `Float64`, since this is what we gave the function as input:

```@example basic
savi1 = compute_index("SAVI", params)
savi2 = compute_index("SAVI"; N=nir, R=red, L=0.5)

eltype(savi1) == eltype(savi2) == Float64
```

We can also compute spectral indices with other float types, such as `Float32` or `Float16`. All it needs is to feed the `compute` or the `compute_index` function input points of the chosen `Float` type. This is specifically helpful for machine learning applications, where `Float32` are the default:

```@example basic
T = Float32
params = Dict(
    "N" => T(nir),
    "R" => T(red),
    "L" => 0.5f0
)

savi1 = compute_index("SAVI", params)
savi2 = compute_index("SAVI"; N=T(nir), R=T(red), L=0.5f0)

eltype(savi1) == eltype(savi2) == Float32
```

The same also holds for `Float16`:

```@example basic
T = Float16
params = Dict(
    "N" => T(nir),
    "R" => T(red),
    "L" => T(0.5)
)

savi1 = compute_index("SAVI", params)
savi2 = compute_index("SAVI"; N=T(nir), R=T(red), L=T(0.5))

eltype(savi1) == eltype(savi2) == Float16
```

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

## Vectors

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